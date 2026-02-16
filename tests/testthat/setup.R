# Setup code for tests

# load vegan
library("vegan")
library("permute")

# load data
data(dune, dune.env, BCI, pyrifos, package = "vegan")
# example data from ?vegan::prc
prc_df <- tibble::tibble(
  week = gl(11, 12, labels = c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24)),
  dose = factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6), 11)),
  ditch = gl(12, 1, length = 132)
)
prc_ctrl <- with(
  prc_df,
  how(
    plots = Plots(strata = ditch, type = "free"),
    within = Within(type = "series"),
    nperm = 99
  )
)

# RNG seed for examples
seed <- 20260214

# adonis
dune_adonis <- withr::with_seed(
  seed,
  adonis2(dune ~ Management + A1, data = dune.env)
)

# ANOSIM
dune_dij <- vegdist(dune)
dune_ano <- withr::with_seed(seed, {
  with(
    dune.env,
    anosim(dune_dij, Management)
  )
})

# PCA, CA, RDA, and CCA
dune_pca <- pca(dune)
dune_ca <- ca(dune)
dune_cca <- cca(
  dune ~ A1 + Moisture + Use + Management,
  data = dune.env
)
dune_rda <- rda(
  dune ~ A1 + Moisture + Use + Management,
  data = dune.env
)

# DCA
dune_dca <- decorana(dune)

# envfit
dune_envfit <- withr::with_seed(
  seed,
  envfit(dune_ca ~ Moisture + A1, dune.env, perm = 199)
)

# fisherfit
m_fisherfit <- fisherfit(BCI[5, ])

# isomap
dune_isomap <- isomap(dune_dij, k = 3)

# metaMDS
dune_mds <- withr::with_seed(
  seed,
  metaMDS(dune, trace = FALSE)
)
dune_mds_no_spp <- withr::with_seed(
  seed,
  metaMDS(vegdist(dune), trace = FALSE)
)

# permustats
permu_adonis <- permustats(dune_adonis)
permu_ano <- permustats(dune_ano)
permu_cca <- withr::with_seed(
  seed,
  permustats(anova(dune_cca))
)
permu_rda <- withr::with_seed(
  seed,
  permustats(anova(dune_rda))
)

# poolaccum
bci_pool <- withr::with_seed(
  seed,
  poolaccum(BCI)
)

# prc
pyrifos_prc <- with(
  prc_df,
  prc(pyrifos, dose, week)
)

permu_prc <- withr::with_seed(
  seed,
  {
    anova(pyrifos_prc, permutations = prc_ctrl, first = TRUE) |>
      permustats()
  }
)

# prestonfit
bci_pfit <- prestonfit(colSums(BCI))

# renyiaccum
bci_renyi <- withr::with_seed(
  seed,
  renyiaccum(BCI)
)
bci_renyi_raw <- withr::with_seed(
  seed,
  renyiaccum(BCI, raw = TRUE)
)

# pco
dune_pco <- pco(dune)

# dbrda
dune_dbrda <- dbrda(
  dune ~ A1 + Moisture + Use + Management,
  data = dune.env
)
