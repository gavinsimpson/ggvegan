# Counts from a Zipf-Mandelbrot curve with a finite offset.
rad_counts <- round(10000 / (seq_len(12) + 2)^2)

test_that("rank-abundance methods accept unnamed counts", {
  counts <- rad_counts
  objects <- list(as.rad(counts), radfit(counts), rad.preempt(counts))

  for (object in objects) {
    df <- fortify(object)
    expect_type(df$species, "character")
    expect_true(all(is.na(df$species)))
    expect_equal(unique(df$abundance), counts)
    expect_silent(ggplot2::ggplot_build(autoplot(object)))
  }
})

test_that("rank-abundance methods retain ranks for equal-richness sites", {
  counts <- rad_counts
  communities <- rbind(A = counts, B = 2 * counts)
  objects <- list(as.rad(communities), radfit(communities))

  for (object in objects) {
    df <- fortify(object, order.by = c(2, 1))
    expect_equal(df$rank, rep(seq_along(counts), 2))
    expect_equal(df$abundance, as.vector(t(communities)))
    expect_equal(levels(df$site), c("B", "A"))
    expect_silent(ggplot2::ggplot_build(autoplot(object)))
  }

  unnamed <- fortify(as.rad(unname(communities)))
  expect_equal(as.character(unnamed$site), rep(c("1", "2"), each = length(counts)))
})

test_that("combined rank-abundance plots keep fitted lines separate", {
  counts <- rad_counts
  object <- radfit(counts)
  plot <- autoplot(object, facet = FALSE, line.params = list(colour = "grey"))
  layers <- ggplot2::ggplot_build(plot)$data

  expect_equal(layers[[1]]$x, seq_along(counts))
  expect_equal(layers[[1]]$y, log10(counts))
  expect_equal(
    unname(as.integer(table(layers[[2]]$group))),
    rep(length(counts), length(object$models))
  )
  expect_equal(unique(layers[[2]]$colour), "grey")
})
