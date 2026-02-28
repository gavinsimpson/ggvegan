# Add a point layer to an ordiggplot

Add a point layer to an ordiggplot

## Usage

``` r
geom_ordi_point(score, data, ...)
```

## Arguments

- score:

  Ordination score to be added to the plot.

- data:

  Alternative data to the function that will be used instead of `score`.

- ...:

  other arguments passed to
  [`ggplot2::geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html)

## Value

Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
