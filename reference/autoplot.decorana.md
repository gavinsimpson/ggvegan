# ggplot-based plot for objects of class `"decorana"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::decorana()`](https://vegandevs.github.io/vegan/reference/decorana.html).

## Usage

``` r
# S3 method for class 'decorana'
autoplot(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  layers = c("sites", "species"),
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

  an object of class `"decorana"`, the result of a call to
  [`vegan::decorana()`](https://vegandevs.github.io/vegan/reference/decorana.html).

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

- ...:

  Additional arguments passed to
  [`fortify.decorana()`](https://gavinsimpson.github.io/ggvegan/reference/fortify.decorana.md).

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

sol <- decorana(dune)
autoplot(sol)

autoplot(sol, layers = "species", geom = "text")
```
