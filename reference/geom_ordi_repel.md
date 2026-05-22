# Add Points and their Replled Labels to an ordiggplot Graph

Function adds points to the exact position of the ordination score with
a label, but labels are repelled from each other to avoid over-plotting.
In very congested areas, the labels are completely omitted.

## Usage

``` r
geom_ordi_repel(
  score,
  data,
  box = FALSE,
  points = TRUE,
  point.params = list(),
  text.params = list(),
  ...
)
```

## Arguments

- score:

  Ordination score added to the plot.

- data:

  Alternative data to the function that will be used instead of `score`.
  This function does *not* handle
  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
  results.

- box:

  Draw a non-transparent box behind the text (logical).

- points:

  Draw points (logical).

- point.params, text.params:

  Parameters to modify points or their repelled text labels.

- ...:

  other arguments passed to
  [`ggrepel::geom_text_repel()`](https://ggrepel.slowkow.com/reference/geom_text_repel.html)
  and
  [`ggrepel::geom_label_repel()`](https://ggrepel.slowkow.com/reference/geom_text_repel.html).

## Value

Returns ggrepel layers `geom_text_repel` or `geom_label_repel` and
ggplot2 layer `geom_point` (optionally).

## Author

Jari Oksanen

## Examples

``` r
library(vegan)
data(mite, mite.env, package = "vegan")
mod <- cca(mite)
ordiggplot(mod) +
  geom_ordi_axis() +
  geom_ordi_point("sites") +
  geom_ordi_repel("species",
    text.params = list(size=3, fontface = "italic"))

```
