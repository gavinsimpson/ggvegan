# Tests for fortify.cca() etc

test_that("fortify works for cca like objects", {
  f_pca <- fortify(dune_pca) |>
    mutate(
      across(matches("^pc"), .fns = abs)
    )
  f_ca <- fortify(dune_ca) |>
    mutate(
      across(matches("^ca"), .fns = abs)
    )
  f_rda <- fortify(dune_rda) |>
    mutate(
      across(matches("^rda"), .fns = abs)
    )
  f_cca <- fortify(dune_cca) |>
    mutate(
      across(matches("^cca"), .fns = abs)
    )
  f_pco <- fortify(dune_pco) |>
    mutate(
      across(matches("^mds"), .fns = abs)
    )
  f_dbrda <- fortify(dune_dbrda) |>
    mutate(
      across(matches("^dbrda"), .fns = abs)
    )

  expect_snapshot(f_pca)
  expect_snapshot(f_ca)
  expect_snapshot(f_rda)
  expect_snapshot(f_cca)
  expect_snapshot(f_pco)
  expect_snapshot(f_dbrda)

  expect_s3_class(f_pca, "tbl_df")
  expect_s3_class(f_ca, "tbl_df")
  expect_s3_class(f_rda, "tbl_df")
  expect_s3_class(f_cca, "tbl_df")
  expect_s3_class(f_pco, "tbl_df")
  expect_s3_class(f_dbrda, "tbl_df")
})

test_that("tidy works for cca like objects", {
  t_pca <- tidy(dune_pca) |>
    mutate(
      across(matches("^pc"), .fns = abs)
    )
  t_ca <- tidy(dune_ca) |>
    mutate(
      across(matches("^ca"), .fns = abs)
    )
  t_rda <- tidy(dune_rda) |>
    mutate(
      across(matches("^rda"), .fns = abs)
    )
  t_cca <- tidy(dune_cca) |>
    mutate(
      across(matches("^cca"), .fns = abs)
    )
  t_pco <- tidy(dune_pco) |>
    mutate(
      across(matches("^mds"), .fns = abs)
    )
  t_dbrda <- tidy(dune_dbrda) |>
    mutate(
      across(matches("^dbrda"), .fns = abs)
    )

  expect_snapshot(t_pca)
  expect_snapshot(t_ca)
  expect_snapshot(t_rda)
  expect_snapshot(t_cca)
  expect_snapshot(t_pco)
  expect_snapshot(t_dbrda)

  expect_s3_class(t_pca, "tbl_df")
  expect_s3_class(t_ca, "tbl_df")
  expect_s3_class(t_rda, "tbl_df")
  expect_s3_class(t_cca, "tbl_df")
  expect_s3_class(t_pco, "tbl_df")
  expect_s3_class(t_dbrda, "tbl_df")
})

test_that("fortify works for cca with layers length 1", {
  f_cca <- fortify(dune_cca, layers = "sites") |>
    mutate(
      across(matches("^cca"), .fns = abs)
    )
  t_cca <- tidy(dune_cca, layers = "sites") |>
    mutate(
      across(matches("^cca"), .fns = abs)
    )
  expect_snapshot(f_cca)
  expect_snapshot(t_cca)
})

test_that("fortify works for dbrda with 1 set of scores", {
  f_dbrda <- fortify(dune_dbrda, layers = "sites") |>
    mutate(
      across(matches("^dbrda"), .fns = abs)
    )
  t_dbrda <- tidy(dune_dbrda, layers = "sites") |>
    mutate(
      across(matches("^dbrda"), .fns = abs)
    )
  expect_snapshot(f_dbrda)
  expect_snapshot(f_dbrda)
})
