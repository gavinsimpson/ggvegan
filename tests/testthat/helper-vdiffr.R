# The coverage job sets VDIFFR_RUN_TESTS to "false" to skip visual tests.
# Adapted from https://github.com/tidyverse/ggplot2/blob/main/tests/testthat/helper-vdiffr.R
run_visual_tests <- Sys.getenv("VDIFFR_RUN_TESTS")
if (identical(run_visual_tests, "false")) {
  expect_doppelganger <- function(...) {
    skip("Visual tests disabled by VDIFFR_RUN_TESTS.")
  }
} else if (
  requireNamespace("vdiffr", quietly = TRUE) &&
    utils::packageVersion("testthat") >= "3.0.3"
) {
  expect_doppelganger <- vdiffr::expect_doppelganger
} else {
  # If vdiffr is not available and visual tests are explicitly
  # requested, raise error.
  if (identical(run_visual_tests, "true")) {
    stop("Visual tests require vdiffr and testthat >= 3.0.3.", call. = FALSE)
  }

  # Otherwise, assign a dummy function
  expect_doppelganger <- function(...) skip("Visual test dependencies are unavailable.")
}
