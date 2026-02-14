# Tests for fortify.metaMDS()

test_that("fortify works for metaMDS objects", {
  expect_snapshot(fortify(dune_mds))
  expect_s3_class(fortify(dune_mds), "tbl_df")
})

test_that("tidy works for metaMDS objects", {
  expect_snapshot(tidy(dune_mds))
  expect_s3_class(tidy(dune_mds), "tbl_df")
})
