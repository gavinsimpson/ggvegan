# Tests for fortify.poolaccum()

test_that("fortify works for poolaccum objects", {
  expect_snapshot(fortify(bci_pool))
  expect_s3_class(fortify(bci_pool), "tbl_df")
})

test_that("tidy works for poolaccum objects", {
  expect_snapshot(tidy(bci_pool))
  expect_s3_class(tidy(bci_pool), "tbl_df")
})
