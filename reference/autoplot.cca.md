# ggplot-based plot for objects of class `"cca"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::cca()`](https://vegandevs.github.io/vegan/reference/cca.html)
or
[`vegan::capscale()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

## Usage

``` r
# S3 method for class 'cca'
autoplot(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  layers = c("species", "sites", "biplot", "centroids"),
  legend.position = "right",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab = NULL,
  xlab = NULL,
  arrow.col = "navy",
  ...
)
```

## Arguments

- object:

  an object of class `"cca"`, the result of a call to
  [`vegan::cca()`](https://vegandevs.github.io/vegan/reference/cca.html)
  or
  [`vegan::capscale()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

- axes:

  numeric; which axes to plot, given as a vector of length 2.

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

- arrow.col:

  colour specification for biplot arrows and their labels.

- ...:

  Additional arguments passed to the
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  method.

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
data(dune.env)

sol <- cca(dune ~ A1 + Management, data = dune.env)
autoplot(sol)
```
