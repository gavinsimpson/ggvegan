# Tests for fortify.anosim()

test_that("fortify works for anosim objects", {
  expect_snapshot(fortify(dune_ano))
  expect_s3_class(fortify(dune_ano), "tbl_df")
})

test_that("tidy works for anosim objects", {
  expect_snapshot(tidy(dune_ano))
  expect_s3_class(tidy(dune_ano), "tbl_df")
})
