# Tests for fortify.fisherfit()

test_that("fortify works for fisherfit objects", {
  expect_snapshot(fortify(m_fisherfit))
  expect_s3_class(fortify(m_fisherfit), "tbl_df")
})

test_that("tidy works for fisherfit objects", {
  expect_snapshot(tidy(m_fisherfit))
  expect_s3_class(tidy(m_fisherfit), "tbl_df")
})
