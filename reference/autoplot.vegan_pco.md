# ggplot-based plot for objects of class `"vegan_pco"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::pco()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

## Usage

``` r
# S3 method for class 'vegan_pco'
autoplot(
  object,
  geom = "point",
  legend.position = "right",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab = NULL,
  xlab = NULL,
  ...
)
```

## Arguments

- object:

  an object of class `"vegan_pco"`, the result of a call to
  [`vegan::pco()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

- geom:

  character; which geom to use for the site (sample) scores. One of
  `"point"`, or `"text"`.

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

sol <- pco(dune)
autoplot(sol)
```
