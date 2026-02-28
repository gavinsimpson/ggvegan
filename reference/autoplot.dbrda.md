# ggplot-based plot for objects of class `"dbrda"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::dbrda()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

## Usage

``` r
# S3 method for class 'dbrda'
autoplot(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  layers = c("sites", "biplot", "centroids"),
  legend.position = "none",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab = NULL,
  xlab = NULL,
  const = NULL,
  arrow.col = "navy",
  ...
)
```

## Arguments

- object:

  an object of class `"dbrda"`, the result of a call to
  [`vegan::dbrda()`](https://vegandevs.github.io/vegan/reference/dbrda.html)

- axes:

  numeric; which axes to plot, given as a vector of length 2.

- geom:

  character; which geom to use for the site (sample) scores. One of
  `"point"`, or `"text"`.

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

- const:

  General scaling constant to `dbrda` scores. See
  [`vegan::scores.rda()`](https://vegandevs.github.io/vegan/reference/plot.cca.html)
  for details.

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

data(dune, dune.env)

dune_dbrda <- dbrda(
  dune ~ A1 + Moisture + Use + Management,
  data = dune.env
)
autoplot(dune_dbrda)
```
