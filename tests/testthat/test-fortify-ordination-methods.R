# Tests for fortify.cca()

test_that("fortify works for cca like objects", {
  expect_snapshot(fortify(dune_pca))
  expect_snapshot(fortify(dune_ca))
  expect_snapshot(fortify(dune_rda))
  expect_snapshot(fortify(dune_cca))
  expect_snapshot(fortify(dune_pco))
  expect_snapshot(fortify(dune_dbrda))

  expect_s3_class(fortify(dune_pca), "tbl_df")
  expect_s3_class(fortify(dune_ca), "tbl_df")
  expect_s3_class(fortify(dune_rda), "tbl_df")
  expect_s3_class(fortify(dune_cca), "tbl_df")
  expect_s3_class(fortify(dune_pco), "tbl_df")
  expect_s3_class(fortify(dune_dbrda), "tbl_df")
})

test_that("tidy works for cca like objects", {
  expect_snapshot(tidy(dune_pca))
  expect_snapshot(tidy(dune_ca))
  expect_snapshot(tidy(dune_rda))
  expect_snapshot(tidy(dune_cca))
  expect_snapshot(tidy(dune_pco))
  expect_snapshot(tidy(dune_dbrda))

  expect_s3_class(tidy(dune_pca), "tbl_df")
  expect_s3_class(tidy(dune_ca), "tbl_df")
  expect_s3_class(tidy(dune_rda), "tbl_df")
  expect_s3_class(tidy(dune_cca), "tbl_df")
  expect_s3_class(tidy(dune_pco), "tbl_df")
  expect_s3_class(tidy(dune_dbrda), "tbl_df")
})

test_that("fortify works for cca with layers length 1", {
  expect_snapshot(fortify(dune_cca, layers = "sites"))
  expect_snapshot(tidy(dune_cca, layers = "sites"))
})
