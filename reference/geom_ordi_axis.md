# Crosshair for Axes in Eigenvector Methods.

The origin (coordinates 0,0) has a special interpretation in eigenvector
methods: sites, species or variables at the centroid are average cases,
and the point is more exceptional the further it is from the origin.
Therefore crosshair of axes through the origin should be added to the
ordination graph with eigenvector methods. Often it is forgotten,
though. See the Example in
[`geom_ordi_arrow()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_arrow.md)
where the length of PCA biplot arrow shows how exceptional the species
is in ordination.

## Usage

``` r
geom_ordi_axis(lty = 3, ...)
```

## Arguments

- lty:

  Linetype.

- ...:

  other arguments passed to
  [`ggplot2::geom_hline()`](https://ggplot2.tidyverse.org/reference/geom_abline.html)
  and
  [`ggplot2::geom_vline()`](https://ggplot2.tidyverse.org/reference/geom_abline.html)

## Value

Returns ggplot2 layers `geom_hline` and `geom_vline`.

## See also

The underlying functions are
[`ggplot2::geom_hline()`](https://ggplot2.tidyverse.org/reference/geom_abline.html)
and
[`ggplot2::geom_vline()`](https://ggplot2.tidyverse.org/reference/geom_abline.html).

## Author

Jari Oksanen

## Examples

``` r
library(vegan)
library(ggplot2)
data(dune, package = "vegan")
mod <- cca(dune)
## simple "autoplot" using ggplot2::geom_text
ordiggplot(mod) +
  geom_ordi_axis() +
  geom_text()

```
