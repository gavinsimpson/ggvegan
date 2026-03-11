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
#> Run 1 stress 0.1192678 
#> ... New best solution
#> ... Procrustes: rmse 5.475398e-06  max resid 1.631124e-05 
#> ... Similar to previous best
#> Run 2 stress 0.1192679 
#> ... Procrustes: rmse 9.156903e-05  max resid 0.0002801513 
#> ... Similar to previous best
#> Run 3 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 0.02027291  max resid 0.06497703 
#> Run 4 stress 0.1192678 
#> Run 5 stress 0.1183186 
#> ... Procrustes: rmse 1.154542e-06  max resid 2.883052e-06 
#> ... Similar to previous best
#> Run 6 stress 0.1192678 
#> Run 7 stress 0.1192678 
#> Run 8 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 2.730997e-06  max resid 8.755205e-06 
#> ... Similar to previous best
#> Run 9 stress 0.2045511 
#> Run 10 stress 0.1183186 
#> ... Procrustes: rmse 2.864314e-06  max resid 6.507562e-06 
#> ... Similar to previous best
#> Run 11 stress 0.1192679 
#> Run 12 stress 0.1183186 
#> ... Procrustes: rmse 4.75061e-06  max resid 1.483607e-05 
#> ... Similar to previous best
#> Run 13 stress 0.1183186 
#> ... Procrustes: rmse 1.209316e-05  max resid 3.823555e-05 
#> ... Similar to previous best
#> Run 14 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 5.606702e-06  max resid 1.793249e-05 
#> ... Similar to previous best
#> Run 15 stress 0.1192678 
#> Run 16 stress 0.1812933 
#> Run 17 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 1.13932e-06  max resid 2.133106e-06 
#> ... Similar to previous best
#> Run 18 stress 0.1192678 
#> Run 19 stress 0.1192679 
#> Run 20 stress 0.1192679 
#> *** Best solution repeated 1 times
autoplot(sol)
```
