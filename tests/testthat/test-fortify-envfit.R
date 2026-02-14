# Tests for fortify.envfit()

test_that("fortify works for envfit objects", {
  expect_snapshot(fortify(dune_envfit))
  expect_s3_class(fortify(dune_envfit), "tbl_df")
})

test_that("tidy works for envfit objects", {
  expect_snapshot(tidy(dune_envfit))
  expect_s3_class(tidy(dune_envfit), "tbl_df")
})
