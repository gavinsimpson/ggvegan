# Add ordisurf Result as Contours to an Ordination Graph

Function adds
[`vegan::ordisurf()`](https://vegandevs.github.io/vegan/reference/ordisurf.html)
results to an graph.

## Usage

``` r
# S3 method for class 'ordisurf'
autolayer(
  object,
  fill = FALSE,
  contour.params = list(),
  fill.params = list(),
  ...
)
```

## Arguments

- object:

  [`vegan::ordisurf()`](https://vegandevs.github.io/vegan/reference/ordisurf.html)
  result object.

- fill:

  Use filled ordination space where raster colour match the fitted
  values of the surface (logical).

- contour.params, fill.params:

  Arguments passed to
  [`ggplot2::geom_contour()`](https://ggplot2.tidyverse.org/reference/geom_contour.html)
  or to
  [`ggplot2::geom_raster()`](https://ggplot2.tidyverse.org/reference/geom_tile.html),
  respectively.

- ...:

  Other arguments passed both to
  [`ggplot2::geom_contour()`](https://ggplot2.tidyverse.org/reference/geom_contour.html)
  and
  [`ggplot2::geom_raster()`](https://ggplot2.tidyverse.org/reference/geom_tile.html).

## Value

Returns ggplot2 layers `geom_contour` and `geom_raster` (optionally).

## Details

Function draws contours of fitted
[`vegan::ordisurf()`](https://vegandevs.github.io/vegan/reference/ordisurf.html)
surface and (optionally) a raster of the surface using
[`ggplot2::geom_contour()`](https://ggplot2.tidyverse.org/reference/geom_contour.html)
and
[`ggplot2::geom_raster()`](https://ggplot2.tidyverse.org/reference/geom_tile.html).

Function uses gridded values of ordination plane saved within the
[`vegan::ordisurf()`](https://vegandevs.github.io/vegan/reference/ordisurf.html)
result instead of scores data from an ordination object. Therefore its
results can be added to any ordination graph, also from `autoplot`
methods. However, you must be careful with using exactly the same axes
and scaling in
[`vegan::ordisurf()`](https://vegandevs.github.io/vegan/reference/ordisurf.html)
object and ordination.

Surface `fill` is non-transparent and will paint over all previous
layers. Filled surface should be used before other visible layers, or
fill should be made transparent with `alpha` in argument `fill.params`
passed to
[`ggplot2::geom_raster()`](https://ggplot2.tidyverse.org/reference/geom_tile.html).

## Author

Jari Oksanen

## Examples

``` r
library(vegan)
library(ggplot2)
data(mite, mite.env, package="vegan")
mod <- cca(mite)
surf <- ordisurf(mod ~ WatrCont, mite.env, plot = FALSE)
ordiggplot(mod) +
  geom_ordi_point("sites", size = mite.env$WatrCont/100) +
  autolayer(surf) +
  autolayer(envfit(mod ~ WatrCont, mite.env, permutations=0),
    arrow.mul = 1.3)

```
