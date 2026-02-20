# Tests for fortify.prc()

test_that("fortify works for prc objects", {
  expect_s3_class(fortify(pyrifos_prc), "tbl_df")

  skip("skipping: eigenvalue sign diffs")
  expect_snapshot(fortify(pyrifos_prc))
})

test_that("tidy works for prc objects", {
  expect_s3_class(tidy(pyrifos_prc), "tbl_df")

  skip("skipping: eigenvalue sign diffs")
  expect_snapshot(tidy(pyrifos_prc))
})
