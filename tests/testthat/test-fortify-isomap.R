# Tests for fortify.isomap()

test_that("fortify works for isomap objects", {
  expect_snapshot(fortify(dune_isomap))
  expect_snapshot(fortify(dune_isomap, what = "network"))
  expect_s3_class(fortify(dune_isomap), "tbl_df")
  expect_s3_class(fortify(dune_isomap, what = "network"), "tbl_df")
})

test_that("tidy works for isomap objects", {
  expect_snapshot(tidy(dune_isomap))
  expect_snapshot(tidy(dune_isomap, what = "network"))
  expect_s3_class(tidy(dune_isomap), "tbl_df")
  expect_s3_class(tidy(dune_isomap, what = "network"), "tbl_df")
})
