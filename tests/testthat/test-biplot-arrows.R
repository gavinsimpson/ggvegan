test_that("arrow scaling uses the range of each axis", {
  arrows <- tibble::tibble(x = c(-1, 1), y = c(-1, 1))
  scores <- tibble::tibble(x = c(-1, 1), y = c(-100, 100))

  expect_equal(arrow_mul(arrows, scores), 0.75)
  expect_equal(arrow_mul(arrows, scores[, c("y", "x")]), 0.75)
  expect_equal(arrow_mul(arrows, scores[0, ]), 1)
  expect_equal(arrow_mul(arrows * 0, scores), 1)
})

test_that("biplot-only autoplot keeps finite arrow endpoints", {
  model <- cca(dune ~ A1 + Management, dune.env)
  plot <- autoplot(model, layers = "biplot")
  arrows <- ggplot2::ggplot_build(plot)$data[[1]]

  expect_gt(nrow(arrows), 0)
  expect_true(all(is.finite(arrows$xend) & is.finite(arrows$yend)))
})

test_that("ordiggplot can scale arrows without constraints or use an override", {
  model <- cca(dune ~ A1 + Management, dune.env)
  scores <- fortify(model, axes = 1:2, layers = "bp")

  plot <- ordiggplot(model, layers = c("wa", "bp")) + geom_ordi_arrow("biplot")
  arrows <- ggplot2::ggplot_build(plot)$data[[1]]
  expect_gt(nrow(arrows), 0)
  expect_true(all(is.finite(arrows$xend) & is.finite(arrows$yend)))

  plot <- ordiggplot(model, layers = "bp", arrow.mul = 0.5)
  expect_equal(as.matrix(plot$data[, 3:4]), 0.5 * as.matrix(scores[, 3:4]))
})
