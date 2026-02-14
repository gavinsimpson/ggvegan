# Tests for fortify.prestonfit()

test_that("fortify works for prestonfit objects", {
  expect_snapshot(fortify(bci_pfit))
  expect_s3_class(fortify(bci_pfit), "tbl_df")
})

test_that("tidy works for prestonfit objects", {
  expect_snapshot(tidy(bci_pfit))
  expect_s3_class(tidy(bci_pfit), "tbl_df")
})
