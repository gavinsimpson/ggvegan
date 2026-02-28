# ggplot-based plot for objects of class `"anosim"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::anosim()`](https://vegandevs.github.io/vegan/reference/anosim.html).

## Usage

``` r
# S3 method for class 'anosim'
autoplot(
  object,
  notch = TRUE,
  varwidth = TRUE,
  xlab = NULL,
  ylab = NULL,
  title = "Analysis of similarities",
  subtitle = NULL,
  caption = bquote(R == .(r) * "," ~ P == .(p)),
  ...
)
```

## Arguments

- object:

  an object of class `"anosim"`, the result of a call to
  [`vegan::anosim()`](https://vegandevs.github.io/vegan/reference/anosim.html).

- notch:

  logical; make notched (default) or standard box plot?

- varwidth:

  logical; make box width proportional to the square-root of the number
  of observations in the group (default)?

- xlab:

  character; label for the x-axis.

- ylab:

  character; label for the y-axis.

- title:

  character; title for the plot.

- subtitle:

  character; subtitle for the plot.

- caption:

  character; caption for the plot.

- ...:

  additional arguments passed to other methods.

## Value

A ggplot object.

## Author

Didzis Elferts. Modifications by Gavin L. Simpson.

## Examples

``` r
library("vegan")
#> Loading required package: permute

data(dune)
data(dune.env)
dune.dist <- vegdist(dune)
dune.ano <- with(dune.env, anosim(dune.dist, Management))

autoplot(dune.ano, notch = FALSE)
```
