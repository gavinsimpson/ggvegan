# Add envfit Results to an ordiggplot Graph

Function adds layers of fitted vectors and centroids of factor levels in
an
[`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
graph.

## Usage

``` r
# S3 method for class 'envfit'
autolayer(
  object,
  text = TRUE,
  box = FALSE,
  arrow.mul = 1,
  arrow.params = list(),
  text.params = list(),
  ...
)
```

## Arguments

- object:

  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
  result object

- text:

  add text to plot (logical).

- box:

  write text on a non-transparent label (logical).

- arrow.mul:

  arrow multiplier.

- arrow.params, text.params:

  List of additional parameters to
  [`ggplot2::geom_segment()`](https://ggplot2.tidyverse.org/reference/geom_segment.html)
  for arrows, and to text labels of both arrows and centroids of factor
  levels
  ([`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html),
  [`ggplot2::geom_label()`](https://ggplot2.tidyverse.org/reference/geom_text.html)).

- ...:

  Other parameters passed to all graphical functions
  [`geom_ordi_arrow()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_arrow.md),
  [`geom_ordi_text()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_text.md)
  and
  [`geom_ordi_label()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_label.md).

## Value

Returns ggplot2 layers `geom_segment` for arrows and `geom_text` or
`geom_label` for their text labels (when appropriate), and another layer
of `geom_text` or `geom_label` for the centroids of factor leves (when
appropriate). The `score` type is called `envfit`.

## Details

Function adds a previosly fitted
[`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
model. This does not adapt to changes in the
[`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
object, for instance in `scaling` or `axes`, but it must re-fitted for a
changed model.

## Author

Jari Oksanen

## Examples

``` r
library(vegan)
#> Loading required package: permute
library(ggplot2)
data(mite, mite.env, package = "vegan")
mod <- cca(mite)
## you must have same scaling in envfit() and ordiggplot()
ef <- envfit(mod ~ Shrub+Topo+WatrCont+SubsDens, mite.env,
  scaling = "sites")
ordiggplot(mod, scaling="sites") +
  geom_ordi_axis() +
  geom_ordi_point("sites") +
  autolayer(ef, arrow.mul=1.3, col="navy", box=TRUE,
    text.params=list(mapping=aes(fontface="bold")))

```
