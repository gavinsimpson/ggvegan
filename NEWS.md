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

* `geom_ordi_text()` and `geom_ordi_label()` accept `vegan::envfit()`
  result as an argument `data=` to draw locations of centroids of
  factor levels in an `ordiggplot()` layer.

* `geom_ordi_arrow()` accepts `vegan::envfit()` result as an argument
  `data=` for labelled (optionally) arrows of fitted vectors in an
  `ordiggplot()` layer.

## Bug fixes

* Fisher and Preston plots use one-unit bars even when bins are empty.
  Preston plots also label the full range and hide fitted annotations
  when `show.fitted = FALSE`.

* ANOSIM plots say that significance was not assessed when no permutations
  were run.

* Biplot arrows now scale to both axes and keep their original lengths when
  there are no other scores to scale to. `ordiggplot()` again accepts
  `arrow.mul` to set arrow lengths manually.

* Ordination layers now accept arguments from the calling environment and keep
  their required coordinates when custom aesthetics are added. Surface layers
  use their own aesthetics, and repelled labels respect the requested size.

* RDA and dbRDA plots and score tables now use the requested scaling constant.
  CCA, RDA and dbRDA plots handle a single axis and draw factor centroids once.

* dbRDA plots show species scores when available. Requesting just biplot,
  regression or centroid scores now works.

* `tidy()` respects the selected NMDS axes. Both `fortify()` and `tidy()`
  respect axis selection for isomap site scores.

* PRC plots accept numeric species selections and label their scores on the
  right. The vertical axis describes the effect and the legend identifies
  treatments.

* Rank-abundance plots handle unnamed species and sites with the same number
  of species. Combined plots draw the observations once and keep fitted
  lines separate when they share a colour.

* `stat_vectorfit()` matches environmental data to site labels, even when rows
  are reordered or sites are omitted. Unweighted fits no longer require a
  weight mapping.

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
