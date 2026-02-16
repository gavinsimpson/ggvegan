# ggvegan; ggplot2-based plots for vegan

<!-- badges: start -->
[![R build
status](https://github.com/gavinsimpson/ggvegan/workflows/R-CMD-check/badge.svg)](https://github.com/gavinsimpson/ggvegan/actions)
[![codecov](https://codecov.io/gh/gavinsimpson/ggvegan/branch/main/graph/badge.svg?token=pwoTNmIfOg)](https://app.codecov.io/gh/gavinsimpson/ggvegan)
[![CRAN version](http://www.r-pkg.org/badges/version/ggvegan)](http://cran.rstudio.com/web/packages/ggvegan/index.html)
[![](https://cranlogs.r-pkg.org/badges/grand-total/ggvegan)](https://cran.rstudio.com/web/packages/ggvegan/index.html)
[![r-universe
version](https://gavinsimpson.r-universe.dev/ggvegan/badges/version)](https://gavinsimpson.r-universe.dev/ggvegan)
[![r-universe
status](https://gavinsimpson.r-universe.dev/ggvegan/badges/checks)](https://gavinsimpson.r-universe.dev/ggvegan)
<!-- badges: end -->

## What is ggvegan?

*ggvegan* is a package for the R statistical software and environment. It aims to implement *ggplot*-based versions of the plots produced by the *vegan* package. Initially, *ggvegan*  provides `fortify()` and `autoplot()` methods for objects created in *vegan*, with the aim of providing full replacement plots via `autoplot()`. The `fortify()` methods allow the data contained within objects created by *vegan* to be converted into a format suitable for use with `ggplot()` directly.

## Licence

*ggvegan* is released under the [GNU General Public Licence, version 2](https://www.r-project.org/Licenses/GPL-2).

## Development & contributions

*ggvegan* uses the *roxygen2* system to document package functions alongside the code itself.

*ggvegan* is very much beta code at the moment. Comments and feedback on the approach taken are welcome, as are code contributions. See **Design decisions** below for two important areas for consideration

## Design decisions

### `autoplot()`

The `autoplot()` concept is somewhat poorly defined at the moment --- at least in public. I have taken it to mean that a full ggplot object is returned, which can then be augmented with additional layers and changes to the scales etc. This means that the aesthetics for the scores are hard-coded in the `autoplot()` methods. If you want greater control over these aesthetics, use `fortify()` to return the scores in a suitable format and build the plot up yourself. I hope to include at least one example of this, where applicable, in the help pages for each `autoplot()` method.

### `fortify()`

`fortify()` methods are supposed to return a data frame but this is not necessarily the most convenient representation for vegan's ordination objects where several data frames representing the various sets of ordination scores would be more natural. Currently, *ggvegan* follows the existing `fortify()` convention of returning a single data frame so returns the ordination scores in long format with variables `score` indicating the type of score and `label` the label/rowname for each score.

#### Standard ordination methods

The first two columns will now be `score` and `label`. The remaining columns will be the requested ordination dimensions, named as per the `scores` method from **vegan**. For example, a PCA will have columns named `pc1`, `pc2`, etc. How many and their numbering depending on the `axes` argument; the default is `1:6`. 

A further design decision is that *ggvegan*'s `fortify()` methods for ordination objects will return all possible sets of scores by default, but the set returned can not be chosen by the user using the `layers` argument. Additionally, the sets of scores to be plotted can be chosen at the `autoplot()` stage.

#### More specialised objects

The components returned for more specialised objects will typically vary as needed for a sensible, tidy data representation. Such `fortify()` methods will return suitable components. For example, `fortify.prc()` returns components `time`, `treatment`, and `response` corresponding to the two-way factors defining the experiment and the regression coefficients on RDA axis 1 respectively.

## Status

The following `autoplot` methods are currently available

 1. `autoplot.cca` --- for objects of classes `"cca"` and `"capscale"`
 2. `autoplot.rda` --- for objects of class `"rda"`
 3. `autoplot.metaMDS` --- for objects of class `"metaMDS"`
 4. `autoplot.prc` --- for objects of class `"prc"`
 5. `autoplot.decorana` --- for objects of class `"decorana"` (AKA DCA)
 6. `autoplot.prestonfit` --- for objects of class `"prestonfit"`
 7. `autoplot.fisherfit` --- for objects of class `"fisherfit"`
 8. `autoplot.envfit` --- for objects of class `"envfit"`
 9. `autoplot.isomap` --- for objects of class `"isomap"`
 10. `autoplot.permustats` --- for objects of class `"permustats"`
 11. `autoplot.poolaccum` --- for objects of class `"poolaccum"`
 12. `autoplot.anosim` --- for objects of class `"anosim"`
 13. `autoplot.vegan_pco` --- for objects of class `"vegan_pco"`
 14. `autoplot.dbrda` --- for objects of class `"dbrda"`

The following `fortify` method are currently available

 1. `fortify.cca` --- for objects of classes `"cca"`, and `"capscale"`
 2. `fortify.rda` --- for objects of classes `"rda"`
 3. `fortify.metaMDS` --- for objects of class `"metaMDS"`
 4. `fortify.prc` --- for objects of class `"prc"`
 5. `fortify.decorana` --- for objects of class `"decorana"` (AKA DCA)
 6. `fortify.prestonfit` --- for objects of class `"prestonfit"`
 7. `fortify.fisherfit` --- for objects of class `"fisherfit"`
 8. `fortify.anosim` --- for objects of class `"anosim"`
 9. `fortify.isomap` --- for objects of class `"isomap"`
 10. `fortify.permustats` --- for objects of class `"permustats"`
 11. `fortify.poolaccum` --- for objects of class `"poolaccum"`
 12. `fortify.renyiaccum` --- for objects of class `"renyiaccum"`
 13. `fortify.vegan_pco` --- for objects of class `"vegan_pco"`
 14. `fortify.dbrda` --- for objects of class `"dbrda"`

## Installation

You can install ggvegan directly from GitHub using functions that the **remotes** package provides. To do this, install **remotes** from CRAN via

```r
install.packages("remotes")
```
then run
```r
remotes::install_github("gavinsimpson/ggvegan")
```

If that doesn't work or you prefer to install from binaries, the R Universe service run by rOpenSci now provides binaries. Instruction on how to install ggvegan from that repository are:

```r
# Enable repository from gavinsimpson
options(repos = c(
  gavinsimpson = "https://gavinsimpson.r-universe.dev",
  CRAN = "https://cloud.r-project.org"))
# Download and install ggvegan in R
install.packages("ggvegan")
```
