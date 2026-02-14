# Tests for fortify.decorana()

test_that("fortify works for decorana objects", {
  expect_snapshot(fortify(dune_dca))
  expect_s3_class(fortify(dune_dca), "tbl_df")
})

test_that("tidy works for decorana objects", {
  expect_snapshot(tidy(dune_dca))
  expect_s3_class(tidy(dune_dca), "tbl_df")
})
