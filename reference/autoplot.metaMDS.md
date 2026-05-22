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
#> Run 1 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 0.02027012  max resid 0.06496063 
#> Run 2 stress 0.1192679 
#> Run 3 stress 0.1192678 
#> Run 4 stress 0.1192678 
#> Run 5 stress 0.1192679 
#> Run 6 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 1.474997e-06  max resid 4.202898e-06 
#> ... Similar to previous best
#> Run 7 stress 0.1183186 
#> ... Procrustes: rmse 3.438351e-06  max resid 8.87395e-06 
#> ... Similar to previous best
#> Run 8 stress 0.1192678 
#> Run 9 stress 0.1192678 
#> Run 10 stress 0.1192679 
#> Run 11 stress 0.1192679 
#> Run 12 stress 0.1183186 
#> ... Procrustes: rmse 6.034107e-06  max resid 2.025918e-05 
#> ... Similar to previous best
#> Run 13 stress 0.1192679 
#> Run 14 stress 0.2075713 
#> Run 15 stress 0.1183186 
#> ... Procrustes: rmse 6.827239e-06  max resid 2.164304e-05 
#> ... Similar to previous best
#> Run 16 stress 0.1192679 
#> Run 17 stress 0.1192678 
#> Run 18 stress 0.1183186 
#> ... Procrustes: rmse 9.365927e-06  max resid 2.782223e-05 
#> ... Similar to previous best
#> Run 19 stress 0.1192678 
#> Run 20 stress 0.1812932 
#> *** Best solution repeated 5 times
autoplot(sol)
```
