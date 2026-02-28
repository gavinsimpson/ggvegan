# Add a biplot arrow layer to an ordiggplot

Add a biplot arrow layer to an ordiggplot

## Usage

``` r
geom_ordi_arrow(
  score,
  data,
  text = TRUE,
  box = FALSE,
  arrow.params = list(),
  text.params = list(),
  ...
)
```

## Arguments

- score:

  Ordination score to be added to the plot.

- data:

  Alternative data to the function that will be used instead of `score`.

- text:

  Add text labels to the plot.

- box:

  Draw a box behind the text (logical).

- arrow.params, text.params:

  Parameters to modify arrows or their text labels.

- ...:

  other arguments passed to
  [`ggplot2::geom_segment()`](https://ggplot2.tidyverse.org/reference/geom_segment.html),
  [`ggplot2::geom_label()`](https://ggplot2.tidyverse.org/reference/geom_text.html),
  or
  [`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html)

## Value

Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
