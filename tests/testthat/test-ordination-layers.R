test_that("custom arrow mappings keep both endpoints", {
  width <- 0.7
  plot <- ordiggplot(dune_ca) +
    geom_ordi_arrow(
      "species", text = FALSE, linewidth = width,
      mapping = ggplot2::aes(colour = label)
    )

  arrows <- ggplot2::ggplot_build(plot)$data[[1L]]
  expect_gt(length(unique(arrows$colour)), 1L)
  expect_equal(unique(arrows$linewidth), width)
  expect_true(all(arrows$xend == 0 & arrows$yend == 0))
})

test_that("fitted arrows keep ordination weights when a mapping is supplied", {
  plot <- ordiggplot(dune_ca)
  sites <- plot$data[plot$data$score == "sites", ]
  env <- dune.env[, "A1", drop = FALSE]
  plot <- plot + geom_ordi_arrow(
    "sites", text = FALSE, stat = "vectorfit", edata = env,
    mapping = ggplot2::aes(alpha = I(0.7)), arrow.params = list(arrow.mul = 1)
  )

  arrows <- ggplot2::ggplot_build(plot)$data[[1L]]
  fit <- vegan::vectorfit(as.matrix(sites[, 3:4]), env, w = sites$weight)
  expect_equal(c(arrows$x, arrows$y), as.numeric(sqrt(fit$r) * fit$arrows))
  expect_equal(arrows$alpha, 0.7)
  expect_equal(c(arrows$xend, arrows$yend), c(0, 0))
})

test_that("repelled labels respect shared arguments and text overrides", {
  colour <- "orange"
  size <- 8
  plot <- ordiggplot(dune_ca)
  layers <- ggplot2::ggplot_build(
    plot + geom_ordi_repel("sites", colour = colour, size = size)
  )$data
  expect_equal(lapply(layers, function(layer) unique(layer$colour)), rep(list(colour), 2L))
  expect_equal(lapply(layers, function(layer) unique(layer$size)), rep(list(size), 2L))

  layers <- ggplot2::ggplot_build(
    plot + geom_ordi_repel("sites", size = size, text.params = list(size = 3))
  )$data
  expect_equal(lapply(layers, function(layer) unique(layer$size)), list(size, 3))
})

test_that("envfit layers accept arguments from their caller", {
  colour <- "orange"
  layers <- ggplot2::ggplot_build(
    ordiggplot(dune_ca) + autolayer(dune_envfit, colour = colour)
  )$data
  expect_length(layers, 3L)
  expect_equal(lapply(layers, function(layer) unique(layer$colour)), rep(list(colour), 3L))
})

test_that("surface layers use their own data and aesthetics", {
  surface <- vegan::ordisurf(vegan::rda(dune), dune.env$A1, knots = 0, plot = FALSE)
  sites <- data.frame(x = 1:2, y = 1:2, group = c("a", "b"))
  opacity <- 0.4
  plot <- ggplot2::ggplot(sites, ggplot2::aes(x, y, colour = group)) +
    ggplot2::geom_point() + autolayer(surface, fill = TRUE, alpha = opacity)

  layers <- ggplot2::ggplot_build(plot)$data
  expect_length(layers, 3L)
  expect_true(all(vapply(layers[-1L], nrow, integer(1)) > 0L))
  expect_equal(lapply(layers[-1L], function(layer) unique(layer$alpha)), rep(list(opacity), 2L))
})
