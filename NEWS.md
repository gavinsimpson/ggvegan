# ggvegan (development version)

## New Functions

* `autolayer.envfit` is a new function to add `vegan::envfit()`
  results to an `ordiggplot()` graph.

* `autolayer.ordisurf` is a new function to add `vegan::ordisurf()`
  contours and raster surface (optional) to any ordination graph.

* `geom_ordi_repel` is a new layer function for `ordiggplot()` to draw
  points (optionally) at the ordination scores and repel their text
  labels to avoid over-plotting.

## New features

* `fortify.radfit` and `autoplot.radfit` methods implemented providing
  support for `vegan::radfit()` and `vegan::as.rad()`.

* `ordiggplot()` adds mapping `score` to `colour` for automatic
  colouring of layers analogously to `autoplot` methods.

* `ordiggplot()` accepts directly `fortify` compatible data frames as
  an alternative to an ordination object. Such data frames can be
  generated with `vegan::scores(..., tidy = TRUE)`. This allows using
  ordination results without `ggvegan::fortify` support.

* `geom_ordi_text()` and `geom_ordi_label()` accept `vegan::envfit()`
  result as an argument `data=` to draw locations of centroids of
  factor levels in an `ordiggplot()` layer.

* `geom_ordi_arrow()` accepts `vegan::envfit()` result as an argument
  `data=` for labelled (optionally) arrows of fitted vectors in an
  `ordiggplot()` layer.

## Bug fixes

* *ggplot2* would report a warning about dropped aesthetics when
  `StatVectorfit` was run. #43 Fixed by @jarioksa in #44.

* `geom_ordi_arrow` did not pass weights of CCA or other weighted
  ordination methods to `StatVectorfit`.

# ggvegan 0.2.1

Patch release to address issued raised by CRAN during manual inspection of the
package upon first submission.

## Bug Fixes

* CRAN requested that the `Description` be lengthened.

* CRAN noted that all exported functions and Rd files of such should have
  `\value` sections.

# ggvegan 0.2

This [was intended as] the first release to CRAN. *ggvegan** is under active
development, and comments and contributions are welcome.

## New features

* Added a `NEWS.md` file to track changes to the package.

* All `fortify()` methods now return a tibble.

* Complementary `tidy()` method for all `fortify()` methods.

## Bug Fixes

* `const` was not being passed to `scores.rda` in `autoplot.rda`. #26 Reported
  by Richard Telford
