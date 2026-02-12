# Setup code for tests

# load vegan
library("vegan")

# load data
data(dune, dune.env, package = "vegan")

# CA and CCA
dune_ca <- ca(dune)
dune_cca <- cca(
  dune ~ A1 + Moisture + Use + Management,
  data = dune.env
)
