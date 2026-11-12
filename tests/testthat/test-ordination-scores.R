test_that("RDA and dbRDA respect the scaling constant", {
  for (model in list(dune_rda, dune_dbrda)) {
    const <- c(3, 7)
    expected <- scores(model, display = "sites", const = const)
    df <- fortify(model, axes = 1:2, layers = "sites", const = const)
    expect_equal(as.numeric(as.matrix(df[, 3:4])), as.numeric(expected))
    expect_identical(
      tidy(model, axes = 1:2, layers = "sites", const = const),
      df
    )

    p <- autoplot(model, layers = "sites", const = const)
    expect_equal(ggplot2::layer_data(p)$x, unname(expected[, 1L]))
  }
})

test_that("dbRDA plots single score types and attached species scores", {
  model <- dbrda(dune ~ A1 + Management, data = dune.env)
  biplot <- ggplot2::layer_data(autoplot(model, layers = "biplot"))
  expected <- scores(model, display = "bp")
  expect_equal(biplot$xend, unname(expected[, 1L]))
  expect_equal(biplot$yend, unname(expected[, 2L]))

  centroids <- ggplot2::layer_data(autoplot(model, layers = "centroids"))
  expect_identical(centroids$label, rownames(scores(model, display = "cn")))

  sppscores(model) <- dune
  expected <- scores(model, display = "species")
  species <- ggplot2::layer_data(autoplot(model, layers = "species"))
  expect_equal(species$x, unname(expected[, 1L]))
  expect_equal(species$y, unname(expected[, 2L]))
  expect_equal(nrow(ggplot2::layer_data(autoplot(model))), nrow(dune) + ncol(dune))
})

test_that("constrained ordination plots draw requested arrows and centroids", {
  models <- list(dune_cca, dune_rda, dune_dbrda)
  for (model in models) {
    expected <- scores(model, display = "reg")
    regression <- ggplot2::layer_data(autoplot(model, layers = "regression"))
    expect_equal(regression$xend, unname(expected[, 1L]))
    expect_equal(regression$yend, unname(expected[, 2L]))

    both <- scores(model, display = c("bp", "cn"))
    expect_true(any(rownames(both$biplot) %in% rownames(both$centroids)))
    p <- autoplot(model, layers = c("biplot", "centroids"))
    expect_identical(
      ggplot2::layer_data(p, 2L)$label,
      setdiff(rownames(both$biplot), rownames(both$centroids))
    )
    expect_identical(ggplot2::layer_data(p, 3L)$label, rownames(both$centroids))
  }
})

test_that("rank-one RDA can be plotted with default or explicit axes", {
  model <- rda(dune[, 1L, drop = FALSE])
  expected <- scores(model, choices = 1L, display = "sites")
  for (p in list(autoplot(model), autoplot(model, axes = 1L))) {
    sites <- ggplot2::layer_data(p)
    expect_equal(sites$x, unname(expected[, 1L]))
    expect_equal(sites$y, rep(0, nrow(expected)))
  }
})

test_that("NMDS and isomap extraction preserve selected axes and their order", {
  model <- withr::with_seed(1, metaMDS(dune, k = 3L, trace = FALSE))
  axes <- c(3L, 2L)
  nmds <- tidy(model, axes = axes)
  expect_named(nmds, c("score", "label", "nmds3", "nmds2"))
  expect_identical(fortify(model, axes = axes), nmds)
  expect_identical(tidy(model, choices = axes), nmds)

  iso <- fortify(dune_isomap, axes = axes)
  expect_named(iso, c("label", "dim3", "dim2"))
  expect_identical(tidy(dune_isomap, axes = axes), iso)
  expect_identical(iso, fortify(dune_isomap)[names(iso)])
  expect_equal(ggplot2::layer_data(autoplot(dune_isomap, axes = axes), 2L)$x, iso$dim3)
})
