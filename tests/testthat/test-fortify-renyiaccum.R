# Tests for fortify.renyiaccum()

test_that("fortify works for renyiaccum objects", {
  expect_snapshot(fortify(bci_renyi))
  expect_s3_class(fortify(bci_renyi), "tbl_df")
})

test_that("tidy works for renyiaccum objects", {
  expect_snapshot(tidy(bci_renyi))
  expect_s3_class(tidy(bci_renyi), "tbl_df")
})
