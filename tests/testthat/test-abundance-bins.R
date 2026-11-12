test_that("Fisher bars cover single abundance values", {
  counts <- rep(c(1, 32, 64), c(50, 10, 6))
  plot <- autoplot(fisherfit(counts), show.fitted = FALSE)
  bars <- ggplot2::ggplot_build(plot)$data[[1]]

  expect_equal(bars$xmin, c(1, 32, 64) - 0.5)
  expect_equal(bars$xmax, c(1, 32, 64) + 0.5)
})

test_that("Preston bars cover individual octaves across empty bins", {
  counts <- rep(c(4, 32, 512), c(15, 10, 6))
  object <- prestonfit(counts, tiesplit = FALSE)
  octaves <- fortify(object)$octave
  plot <- autoplot(object, show.fitted = FALSE)
  layers <- ggplot2::ggplot_build(plot)$data
  scale <- plot$scales$get_scales("x")

  expect_equal(layers[[1]]$xmin, octaves - 1)
  expect_equal(layers[[1]]$xmax, octaves)
  expect_equal(scale$breaks, seq(0, max(octaves) + 1))
  expect_equal(scale$labels, 2^scale$breaks)
  expect_length(layers, 1)
  expect_length(autoplot(object)$layers, 3)
})
