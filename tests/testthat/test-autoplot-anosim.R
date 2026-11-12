test_that("the ANOSIM caption describes whether significance was assessed", {
  without_permutations <- anosim(dune_dij, dune.env$Management, permutations = 0)
  r <- round(without_permutations$statistic, 3)
  expect_identical(
    autoplot(without_permutations)$labels$caption,
    bquote(R == .(r) * "," ~ P == "not assessed")
  )

  r <- round(dune_ano$statistic, 3)
  p <- format.pval(dune_ano$signif)
  expect_identical(autoplot(dune_ano)$labels$caption, bquote(R == .(r) * "," ~ P == .(p)))
})
