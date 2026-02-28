# ggplot-based plot for objects of class `"isomap"`

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::isomap()`](https://vegandevs.github.io/vegan/reference/isomap.html).

## Usage

``` r
# S3 method for class 'isomap'
autoplot(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  network = TRUE,
  line.col = "grey85",
  linewidth = 0.7,
  xlab = NULL,
  ylab = NULL,
  title = "Isometric feature mapping",
  subtitle = NULL,
  caption = NULL,
  ...
)
```

## Arguments

- object:

  an object of class `"isomap"`, the result of a call to
  [`vegan::isomap()`](https://vegandevs.github.io/vegan/reference/isomap.html).

- axes:

  numeric; which axes to plot, given as a vector of length 2.

- geom:

  character; which geom to use for the MDS scores layer.

- network:

  logical; should the edges of the ISOMAP network be drawn?

- line.col:

  colour with which to draw the network edges.

- linewidth:

  numeric; linewidth aesthetic for the log-series curve.

- xlab:

  character; label for the x-axis.

- ylab:

  character; label for the y-axis.

- title:

  character; subtitle for the plot.

- subtitle:

  character; subtitle for the plot.

- caption:

  character; caption for the plot.

- ...:

  additional arguments passed to other methods.

## Value

A ggplot object.

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(BCI)
dis <- vegdist(BCI)
ord <- isomap(dis, k = 3)

autoplot(ord)


autoplot(ord, geom = "text")
```
