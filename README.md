# ggvegan; ggplot2-based plots for vegan

<!-- badges: start -->
[![R build status](https://github.com/gavinsimpson/ggvegan/workflows/R-CMD-check/badge.svg)](https://github.com/gavinsimpson/ggvegan/actions)
[![Travis CI Build Status](https://travis-ci.org/gavinsimpson/ggvegan.svg?branch=master)](https://travis-ci.org/gavinsimpson/ggvegan)
[![Appveyor Build status](https://ci.appveyor.com/api/projects/status/hc8dbxrim2nj3c1i/branch/master)](https://ci.appveyor.com/project/gavinsimpson/ggvegan/branch/master)
[![CRAN version](http://www.r-pkg.org/badges/version/ggvegan)](http://cran.rstudio.com/web/packages/ggvegan/index.html)
[![](http://cranlogs.r-pkg.org/badges/grand-total/ggvegan)](http://cran.rstudio.com/web/packages/ggvegan/index.html)
<!-- badges: end -->

## What is ggvegan?
**ggvegan** is a package for the R statistical software and environment. It aims to implement **ggplot**-based versions of the plots produced by the **vegan** package. Initially, ggvegan will provide `fortify` and `autoplot` methods for objects created in vegan, with the aim of providing full replacement plots via `autoplot`. The `fortify` methods allow the data contained within objects created by vegan to be converted into a format suitable for use with `ggplot` directly.

## Licence
ggvegan is released under the [GNU General Public Licence, version 2](http://www.r-project.org/Licenses/GPL-2).

## Development & contributions
ggvegan uses the **roxygen2** system to document package functions alongside the code itself.

ggvegan is very much alpha code at the moment. Comments and feedback on the approach taken are welcome, as are code contributions. See **Design decisions** below for two important areas for consideration

## Design decisions
### `autoplot`
The `autoplot` concept is somewhat poorly defined at the moment --- at least in public. I have taken it to mean that a full ggplot object is returned, which can then be augmented with additional layers and changes to the scales etc. This means that the aesthetics for the scores are hard-coded in the `autoplot` methods. If you want greater control over these aesthetics, use `fortify` to return the scores in a suitable format and build the plot up yourself. I hope to include at least one example of this, where applicable, in the help pages for each `autoplot` method.

### `fortify`
`fortify` methods are supposed to return a data frame but this is not necessarily the most convenient representation for vegan's ordination objects where several data frames representing the various sets of ordination scores would be more natural. Currently, ggvegan follows the existing `fortify` convention of returning a single data frame so returns the ordination scores in long format with variables `Score` indicating the type of score and `Label` the label/rowname for each score.

#### Standard ordination methods
From version 0.0-9, I changed the representation of *fortified* ordination objects. The first two columns will now be `Score` and `Label`. The remaining columns will be the requested ordination dimensions, named as per the `scores` method from **vegan**. For example, a PCA will have columns named `'PC1'`, `'PC2'`, etc. How many and their numbering depending on the `axes` argument; the default is `1:6`. Consequently, the `'dimLables'` attribute is no longer necessary.

A further design decision is that ggvegan `fortify` methods for ordination objects will return all possible sets of scores and the set returned can not be chosen by the user. Instead, the sets of scores to be plotted should be chosen at the `autoplot` stage.

#### More specialised objects
The components returned for more specialised objects will typically vary as needed for a sensible, tidy data representation. Such `fortify()` methods will return suitable components. For example, `fortify.prc()` returns components `Time`, `Treatment`, and `Response` corresponding to the two-way factors defining the experiment and the regression coefficients on RDA axis 1 respectively.

## Status
The following `autoplot` methods are currently available

 1. `autoplot.cca` --- for objects of classes `"cca"` and `"capscale"`
 2. `autoplot.rda` --- for objects of class `"rda"`
 3. `autoplot.metaMDS` --- for objects of class `"metaMDS"`
 4. `autoplot.prc` --- for objects of class `"prc"`
 5. `autoplot.decorana` --- for objects of class `"decorana"` (AKA DCA)
 6. `autoplot.prestonfit` --- for objects of class `"prestonfit"`
 7. `autoplot.fisherfit` --- for objects of class `"fisherfit"`

The following `fortify` method are currently available

 1. `fortify.cca` --- for objects of classes `"cca"`, `"rda"`, and `"capscale"`
 2. `fortify.metaMDS` --- for objects of class `"metaMDS"`
 3. `fortify.prc` --- for objects of class `"prc"`
 4. `fortify.decorana` --- for objects of class `"decorana"` (AKA DCA)
 5. `autoplot.prestonfit` --- for objects of class `"prestonfit"`
 6. `autoplot.fisherfit` --- for objects of class `"fisherfit"`


## Installation
No binary packages are currently available for ggvegan. If you have the correct development tools you can compile the package yourself after downloading the source code from github.

Finally, if you use Hadley Wickham's **devtools** package then you can install ggvegan directly from github using functions that devtools provides. To do this, install **devtools** from CRAN via

    install.packages("devtools")

then run

    devtools::install_github("gavinsimpson/ggvegan")
