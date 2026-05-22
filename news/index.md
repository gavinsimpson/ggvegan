# Changelog

## ggvegan (development version)

### New Functions

- `autolayer.envfit` is a new function to add
  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
  results to an
  [`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
  graph.

- `autolayer.ordisurf` is a new function to add
  [`vegan::ordisurf()`](https://vegandevs.github.io/vegan/reference/ordisurf.html)
  contours and raster surface (optional) to any ordination graph.

- `geom_ordi_repel` is a new layer function for
  [`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
  to draw points (optionally) at the ordination scores and repel their
  text labels to avoid over-plotting.

### New features

- `fortify.radfit` and `autoplot.radfit` methods implemented providing
  support for
  [`vegan::radfit()`](https://vegandevs.github.io/vegan/reference/radfit.html)
  and
  [`vegan::as.rad()`](https://vegandevs.github.io/vegan/reference/radfit.html).

- [`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
  adds mapping `score` to `colour` for automatic colouring of layers
  analogously to `autoplot` methods.

- [`geom_ordi_text()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_text.md)
  and
  [`geom_ordi_label()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_label.md)
  accept
  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
  result as an argument `data=` to draw locations of centroids of factor
  levels in an
  [`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
  layer.

- [`geom_ordi_arrow()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_arrow.md)
  accepts
  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
  result as an argument `data=` for labelled (optionally) arrows of
  fitted vectors in an
  [`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
  layer.

### Bug fixes

- *ggplot2* would report a warning about dropped aesthetics when
  `StatVectorfit` was run.
  [\#43](https://github.com/gavinsimpson/ggvegan/issues/43) Fixed by
  [@jarioksa](https://github.com/jarioksa) in
  [\#44](https://github.com/gavinsimpson/ggvegan/issues/44).

- `geom_ordi_arrow` did not pass weights of CCA or other weighted
  ordination methods to `StatVectorfit`.

## ggvegan 0.2.1

CRAN release: 2026-02-27

Patch release to address issued raised by CRAN during manual inspection
of the package upon first submission.

### Bug Fixes

- CRAN requested that the `Description` be lengthened.

- CRAN noted that all exported functions and Rd files of such should
  have `\value` sections.

## ggvegan 0.2

This \[was intended as\] the first release to CRAN. \*ggvegan\*\* is
under active development, and comments and contributions are welcome.

### New features

- Added a `NEWS.md` file to track changes to the package.

- All
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  methods now return a tibble.

- Complementary
  [`tidy()`](https://generics.r-lib.org/reference/tidy.html) method for
  all
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  methods.

### Bug Fixes

- `const` was not being passed to `scores.rda` in `autoplot.rda`.
  [\#26](https://github.com/gavinsimpson/ggvegan/issues/26) Reported by
  Richard Telford
