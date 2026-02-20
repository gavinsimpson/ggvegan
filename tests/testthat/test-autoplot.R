test_that("autoplot method for cca works", {
  p <- dune_cca |> autoplot()
  expect_doppelganger("cca autoplot", p)
  p <- dune_ca |> autoplot()
  expect_doppelganger("ca autoplot", p)
})

test_that("autoplot method for anosim works", {
  p <- dune_ano |> autoplot(notch = FALSE)
  expect_doppelganger("anosim autoplot", p)
})

test_that("autoplot method for decorana works", {
  p <- dune_dca |> autoplot()
  expect_doppelganger("decorana autoplot", p)
})

test_that("autoplot method for envfit works", {
  p <- dune_envfit |> autoplot()
  expect_doppelganger("envfit autoplot", p)
})

test_that("autoplot method for fisherfit works", {
  p <- m_fisherfit |> autoplot()
  expect_doppelganger("fisherfit autoplot", p)
})

test_that("autoplot method for isomap works", {
  p <- dune_isomap |> autoplot()
  expect_doppelganger("isomap autoplot", p)
})

test_that("autoplot method for metaMDS works", {
  p <- dune_mds |> autoplot()
  expect_doppelganger("mds autoplot", p)
  p <- dune_mds_no_spp |> autoplot()
  expect_doppelganger("mds autoplot no spp", p)
})

test_that("autoplot method for permustats works", {
  p <- permu_adonis |> autoplot()
  expect_doppelganger("permustats autoplot adonis", p)
  p <- permu_ano |> autoplot()
  expect_doppelganger("permustats autoplot anosim", p)
  p <- permu_cca |> autoplot()
  expect_doppelganger("permustats autoplot cca", p)
  p <- permu_prc |> autoplot()
  expect_doppelganger("permustats autoplot prc", p)
  p <- permu_rda |> autoplot()
  expect_doppelganger("permustats autoplot rda", p)
})

test_that("autoplot method for poolaccum works", {
  p <- bci_pool |> autoplot()
  expect_doppelganger("poolaccum autoplot", p)
})

test_that("autoplot method for prc works", {
  skip("skipping: eigenvalue sign diffs")

  p <- pyrifos_prc |> autoplot()
  expect_doppelganger("prc autoplot", p)
})

test_that("autoplot method for prestonfit works", {
  p <- bci_pfit |> autoplot()
  expect_doppelganger("prestonfit autoplot", p)
})

test_that("autoplot method for rda works", {
  p <- dune_rda |> autoplot()
  expect_doppelganger("rda autoplot", p)
  p <- dune_pca |> autoplot()
  expect_doppelganger("pca autoplot", p)
})

test_that("autoplot method for pco works", {
  p <- dune_pco |> autoplot()
  expect_doppelganger("pco autoplot", p)
  #p <- dune_dbrda |> autoplot()
  #expect_doppelganger("dbrda autoplot", p)
})
