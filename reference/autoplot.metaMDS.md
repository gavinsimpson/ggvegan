# ggplot-based plot for objects of class `"metaMDS"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::metaMDS()`](https://vegandevs.github.io/vegan/reference/metaMDS.html).

## Usage

``` r
# S3 method for class 'metaMDS'
autoplot(
  object,
  geom = c("point", "text"),
  layers = c("species", "sites"),
  legend.position = "right",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab,
  xlab,
  ...
)
```

## Arguments

- object:

  an object of class `"metaMDS"`, the result of a call to
  [`vegan::metaMDS()`](https://vegandevs.github.io/vegan/reference/metaMDS.html).

- geom:

  character; which geom to use for the species (variables) and sites
  (samples) layers. A vector of length 2; if a vector of length 1,
  `geom` is extended to the required length.

- layers:

  character; which scores to plot as layers

- legend.position:

  character or two-element numeric vector; where to position the legend.
  See
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html)
  for details. Use `"none"` to not draw the legend.

- title:

  character; subtitle for the plot.

- subtitle:

  character; subtitle for the plot.

- caption:

  character; caption for the plot.

- ylab:

  character; label for the y-axis.

- xlab:

  character; label for the x-axis.

- ...:

  Additional arguments passed to `\link{fortify.metaMDS}`.

## Value

Returns a ggplot object.

## Details

TODO

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(dune)

sol <- metaMDS(dune)
#> Run 0 stress 0.1192678 
#> Run 1 stress 0.1192679 
#> ... Procrustes: rmse 8.334982e-05  max resid 0.0002500859 
#> ... Similar to previous best
#> Run 2 stress 0.1808911 
#> Run 3 stress 0.119268 
#> ... Procrustes: rmse 0.0002168593  max resid 0.0006648345 
#> ... Similar to previous best
#> Run 4 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 0.02027  max resid 0.06495852 
#> Run 5 stress 0.1192679 
#> Run 6 stress 0.1192678 
#> Run 7 stress 0.1192678 
#> Run 8 stress 0.1886532 
#> Run 9 stress 0.1192678 
#> Run 10 stress 0.1192679 
#> Run 11 stress 0.1192678 
#> Run 12 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 4.231201e-05  max resid 0.0001362627 
#> ... Similar to previous best
#> Run 13 stress 0.1992852 
#> Run 14 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 3.977954e-05  max resid 0.0001292582 
#> ... Similar to previous best
#> Run 15 stress 0.1982888 
#> Run 16 stress 0.1183186 
#> ... Procrustes: rmse 4.966779e-06  max resid 1.575898e-05 
#> ... Similar to previous best
#> Run 17 stress 0.1192679 
#> Run 18 stress 0.1192679 
#> Run 19 stress 0.1183186 
#> ... Procrustes: rmse 8.11016e-06  max resid 2.61696e-05 
#> ... Similar to previous best
#> Run 20 stress 0.1192679 
#> *** Best solution repeated 3 times
autoplot(sol)
```
