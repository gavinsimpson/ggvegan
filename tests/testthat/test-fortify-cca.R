# Tests for fortify.cca()

test_that("fortify works for cca objects", {
  expect_snapshot(fortify(dune_pca))
  expect_snapshot(fortify(dune_ca))
  expect_snapshot(fortify(dune_rda))
  expect_snapshot(fortify(dune_cca))

  expect_s3_class(fortify(dune_pca), "tbl_df")
  expect_s3_class(fortify(dune_ca), "tbl_df")
  expect_s3_class(fortify(dune_rda), "tbl_df")
  expect_s3_class(fortify(dune_cca), "tbl_df")
})

test_that("tidy works for cca objects", {
  expect_snapshot(tidy(dune_pca))
  expect_snapshot(tidy(dune_ca))
  expect_snapshot(tidy(dune_rda))
  expect_snapshot(tidy(dune_cca))

  expect_s3_class(tidy(dune_pca), "tbl_df")
  expect_s3_class(tidy(dune_ca), "tbl_df")
  expect_s3_class(tidy(dune_rda), "tbl_df")
  expect_s3_class(tidy(dune_cca), "tbl_df")
})
