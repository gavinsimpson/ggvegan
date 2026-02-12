# Tests for fortify.cca()

test_that("fortify works for cca objects", {
  expect_snapshot(fortify(dune_ca))
  expect_snapshot(fortify(dune_cca))
})