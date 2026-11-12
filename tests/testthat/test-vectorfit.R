test_that("vector fitting matches named sites before fitting and scaling", {
  plot <- ordiggplot(dune_ca)
  sites <- plot$data[plot$data$score == "sites", ]
  sites <- sites[-2L, ]
  env <- dune.env[rev(seq_len(nrow(dune.env))), , drop = FALSE]
  fitted <- function(edata, arrow.mul = NULL) {
    layer <- stat_vectorfit(
      ggplot2::aes(weight = weight),
      data = sites, edata = edata, formula = ~ A1, arrow.mul = arrow.mul
    )
    ggplot2::ggplot_build(plot + layer)$data[[1L]][, c("x", "y")]
  }

  expected <- vegan::vectorfit(
    as.matrix(sites[, 3:4]), dune.env[sites$label, "A1", drop = FALSE],
    w = sites$weight
  )
  expect_equal(as.numeric(as.matrix(fitted(env, 1))),
               as.numeric(sqrt(expected$r) * expected$arrows))
  expect_equal(fitted(env), fitted(dune.env[sites$label, , drop = FALSE]))

  sites <- plot$data[plot$data$score == "sites", ]
  expect_equal(fitted(env), fitted(dune.env))
  rownames(env)[1L] <- "unknown site"
  expect_error(fitted(env), "Could not match all ordination labels")
})

test_that("vector fitting works without weights and keeps positional rows in facets", {
  sites <- data.frame(
    x = c(-2, -1, 1, 2, -2, -1, 1, 2, -1, 1, -1, 1, -1, 1, -1, 1),
    y = c(-1, 1, -1, 1, 1, -1, 1, -1, -2, -2, 2, 2, -1, -1, 1, 1),
    label = as.character(16:1),
    facet = rep(c("first", "second"), each = 8L)
  )
  env <- data.frame(gradient = c(sites$x[1:8], sites$y[9:16]))
  plot <- ggplot2::ggplot(sites, ggplot2::aes(x, y, label = label)) +
    ggplot2::facet_wrap(~ facet) +
    stat_vectorfit(edata = env, arrow.mul = 1)

  fit <- ggplot2::ggplot_build(plot)$data[[1L]]
  expect_equal(fit$label, rep("gradient", 2L))
  expect_equal(fit$x, c(1, 0), tolerance = 1e-12)
  expect_equal(fit$y, c(0, 1), tolerance = 1e-12)
})
