# ggplot-based plot for objects of class `"prc"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::prc()`](https://vegandevs.github.io/vegan/reference/prc.html).

## Usage

``` r
# S3 method for class 'prc'
autoplot(
  object,
  select,
  xlab,
  ylab,
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  legend.position = "top",
  ...
)
```

## Arguments

- object:

  an object inheriting from class `"prc"`, the result of a call to
  [`vegan::prc()`](https://vegandevs.github.io/vegan/reference/prc.html).

- select:

  a logical vector where `TRUE` selects and `FALSE` deselects species.
  Alternatively a numeric vector that contains the indices selecting
  species. Note that these are with respect to the original species
  matrix, **not** the fortified object.

- xlab:

  character; label for the x-axis

- ylab:

  character; label for the y-axis

- title:

  character; subtitle for the plot

- subtitle:

  character; subtitle for the plot

- caption:

  character; caption for the plot

- legend.position:

  character; position for the legend grob. See argument
  `legend.position` in function
  [`ggplot2::theme()`](https://ggplot2.tidyverse.org/reference/theme.html).

- ...:

  Additional arguments passed to `\link{fortify.prc}`.

## Value

Returns a ggplot object.

## Details

TODO

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(pyrifos)
week <- gl(11, 12, labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24))
dose <- factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6), 11))

## Fit PRC model
mod <- prc(pyrifos, dose, week)

## plot
want <- colSums(pyrifos) >= 300
autoplot(mod, select = want)
```
