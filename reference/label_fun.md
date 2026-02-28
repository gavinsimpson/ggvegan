# Adds a label layer using one of a set of common geoms

Adds labels to a plot using one of
[`ggplot2::geom_label()`](https://ggplot2.tidyverse.org/reference/geom_text.html),
[`ggplot2::geom_text()`](https://ggplot2.tidyverse.org/reference/geom_text.html),
[`ggrepel::geom_label_repel()`](https://ggrepel.slowkow.com/reference/geom_text_repel.html)
or
[`ggrepel::geom_text_repel()`](https://ggrepel.slowkow.com/reference/geom_text_repel.html).

## Usage

``` r
label_fun(data, geom = c("label", "text", "label_repel", "text_repel"), vars)
```

## Arguments

- data:

  data frame; data set to use for the label layer. Must contain a
  variable label containing the strings to use as labels.

- geom:

  character; which geom to use for labelling.

- vars:

  character; vector of names of variables to pass to the `x` and `y`
  aesthetics of the chosen geom.

## Author

Gavin L. Simpson
