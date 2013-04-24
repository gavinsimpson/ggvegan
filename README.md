# ggvegan; ggplot2-based plots for vegan

## What is ggvegan?
**ggvegan** is a package for the R statistical software and environment. It aims to implement **ggplot**-based versions of the plots produced by the **vegan** package. Initially, ggvegan will provide `fortify` and `autoplot` methods for objects created in vegan, with the aim of providing full replacement plots via `autoplot`. The `fortify` methods allow the data contained within objects created by vegan to be converted into a format suitable for use with `ggplot` directly.

## Licence
ggvegan is released under the [GNU General Public Licence, version 2](http://www.gnu.org/licenses/gpl-2.0.html).

## Development & contributions
ggvegan uses the **roxygen2** system to document package functions alongside the code itself.

ggvegan is very much alpha code at the moment. Comments and feedback on the approach taken are welcome, as are code contributions. See **Design decisions** below for two important areas for consideration

## Design decisions
### `autoplot`
The `autoplot` concept is somewhat poorly defined at the moment --- at least in public. I have taken it to mean that a full ggplot object is returned, which can then be augmented with additional layers and changes to the scales etc. This means that the aesthetics for the scores are hard-coded in the `autoplot` methods. If you want greater control over these aesthetics, use `fortify` to return the scores in a suitable format and build the plot up yourself. I hope to include at least one example of this, where applicable, in the help pages for each `autoplot` method.

### `fortify`
`fortify` methods are supposed to return a data frame but this is not necessarily the most convenient representation for vegan's ordination objects where several data frames representing the various sets of ordination scores would be more natural. Currently, ggvegan follows the existing `fortify` convention of returning a single data frame so returns the ordination scores in long format with variables `Score` indicating the type of score and `Label` the label/rowname for each score. The first two components of the returned data frame are **always** named `Dim1` and `Dim2`; to which ordination axes/dimensions these refer is recorded in an attribute `dimlabels`, which can be accessed via

    attr(fobj, "dimlabels")

where `fobj` is the object returned by `fortify`.

## Status
The following `autoplot` methods are currently available

 1. `autoplot.cca` --- for objects of classes `"cca"`, `"rda"`, and `"capscale"`
 2. `autoplot.metaMDS` --- for objects of class `"metaMDS"`

The following `fortify` method are currently available

 1. `fortify.cca` --- for objects of classes `"cca"`, `"rda"`, and `"capscale"`
 2. `fortify.metaMDS` --- for objects of class `"metaMDS"`

## Installation
No binary packages are currently available for ggvegan. If you have the correct development tools you can compile the package yourself after downloading the source code from github. Once I work out how to link git with svn I'll start a project on [R-forge](http://r-forge.r-project.org) which will host binary packages of ggvegan.

Finally, if you use Hadley Wickham's **devtools** package then you can install ggvegan directly from github using functions that devtools provides.
