test_that("PRC plots label species selected by index or logical mask", {
  scores <- fortify(pyrifos_prc)
  species <- scores[scores$score == "Species", ]
  indices <- c(1, 3)
  numeric_plot <- autoplot(pyrifos_prc, select = indices)
  logical_plot <- autoplot(
    pyrifos_prc,
    select = seq_len(nrow(species)) %in% indices
  )
  numeric_axis <- numeric_plot$scales$get_scales("y")$secondary.axis
  logical_axis <- logical_plot$scales$get_scales("y")$secondary.axis

  expect_equal(numeric_axis$breaks, species$response[indices])
  expect_equal(numeric_axis$labels, species$label[indices])
  expect_equal(logical_axis$breaks, numeric_axis$breaks)
  expect_equal(logical_axis$labels, numeric_axis$labels)
  expect_false(numeric_axis$guide$params$check.overlap)
  expect_false(logical_axis$guide$params$check.overlap)
  expect_equal(
    ggplot2::ggplot_build(numeric_plot)$data[[2]]$y,
    numeric_axis$breaks
  )
  expect_silent(ggplot2::ggplotGrob(numeric_plot))
})

test_that("PRC species with identical scores share a right-hand tick", {
  model <- pyrifos_prc
  model$CCA$v[2, ] <- model$CCA$v[1, ]
  scores <- fortify(model)
  species <- scores[scores$score == "Species", ]
  plot <- autoplot(model, select = 1:2)
  axis <- plot$scales$get_scales("y")$secondary.axis

  expect_equal(axis$breaks, species$response[1])
  expect_equal(axis$labels, paste(species$label[1:2], collapse = ", "))
  expect_silent(ggplot2::ggplotGrob(plot))
})

test_that("PRC plots distinguish the effect axis from the treatment legend", {
  plot <- autoplot(pyrifos_prc)
  expect_true(
    plot$scales$get_scales("y")$secondary.axis$guide$params$check.overlap
  )
  expect_equal(plot$labels$y, "Effect")
  expect_equal(plot$labels$colour, "Treatment")
  expect_equal(plot$labels$linetype, "Treatment")

  custom <- autoplot(pyrifos_prc, select = integer(), ylab = "Response")
  expect_equal(custom$labels$y, "Response")
  expect_equal(custom$labels$colour, "Treatment")
  expect_null(custom$scales$get_scales("y"))
})
