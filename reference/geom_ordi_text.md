# Add a Text Layer to an ordiggplot Graph

Function adds a text layer to an
[`ordiggplot()`](https://gavinsimpson.github.io/ggvegan/reference/ordiggplot.md)
graph using
[`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html).

## Usage

``` r
geom_ordi_text(score, data, ...)
```

## Arguments

- score:

  Ordination score to be added to the plot.

- data:

  Alternative data to the function that will be used instead of `score`.
  This can be a
  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
  result object which is used to plot centroids of factor levels.

- ...:

  other arguments passed to
  [`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html)

## Value

Returns a ggplot2 layer `geom_text`.

## See also

[`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html).

## Author

Jari Oksanen

## Examples

``` r
library(vegan)
library(ggplot2)
data(dune, package = "vegan")
mod <- metaMDS(dune, trace = 0)
ordiggplot(mod) +
  geom_ordi_text("sites", size=3) +
  geom_ordi_text("species", mapping=aes(fontface="italic"))

```
