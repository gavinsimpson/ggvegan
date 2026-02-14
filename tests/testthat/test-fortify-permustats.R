# Tests for fortify.permustats()

test_that("fortify works for permustats objects", {
  expect_snapshot(fortify(permu_adonis))
  expect_snapshot(fortify(permu_ano))
  expect_snapshot(fortify(permu_cca))
  expect_snapshot(fortify(permu_rda))
  expect_snapshot(fortify(permu_prc))

  expect_s3_class(fortify(permu_adonis), "tbl_df")
  expect_s3_class(fortify(permu_ano), "tbl_df")
  expect_s3_class(fortify(permu_cca), "tbl_df")
  expect_s3_class(fortify(permu_rda), "tbl_df")
  expect_s3_class(fortify(permu_prc), "tbl_df")
})

test_that("tidy works for permustats objects", {
  expect_snapshot(tidy(permu_adonis))
  expect_snapshot(tidy(permu_ano))
  expect_snapshot(tidy(permu_cca))
  expect_snapshot(tidy(permu_rda))
  expect_snapshot(tidy(permu_prc))

  expect_s3_class(tidy(permu_adonis), "tbl_df")
  expect_s3_class(tidy(permu_ano), "tbl_df")
  expect_s3_class(tidy(permu_cca), "tbl_df")
  expect_s3_class(tidy(permu_rda), "tbl_df")
  expect_s3_class(tidy(permu_prc), "tbl_df")
})

test_that("tidy works for permustats objects with scale", {
  expect_snapshot(fortify(permu_cca, scale = TRUE))
  expect_s3_class(fortify(permu_cca, scale = TRUE), "tbl_df")
  expect_snapshot(tidy(permu_cca, scale = TRUE))
  expect_s3_class(tidy(permu_cca, scale = TRUE), "tbl_df")
})
