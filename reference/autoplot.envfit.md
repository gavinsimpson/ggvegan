# ggplot-based plot for `envfit` objects

Produces a multi-layer ggplot object representing the output of objects
produced by
[`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html).

## Usage

``` r
# S3 method for class 'envfit'
autoplot(
  object,
  geom = c("label", "text", "label_repel", "text_repel"),
  line.col = "black",
  xlab = NULL,
  ylab = NULL,
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ...
)
```

## Arguments

- object:

  an object of class `"envfit"`, the result of a call to
  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html).

- geom:

  character; which geom to use to label vectors and factor centroids.

- line.col:

  colour with which to draw vectors.

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

  additional arguments passed to
  [`ggplot2::fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html).

## Value

A ggplot object.

## Author

Gavin L. Simpson

## Examples

``` r

library("vegan")
data(varespec, varechem)
ord1 <- metaMDS(varespec)
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.1843196 
#> Run 1 stress 0.1955836 
#> Run 2 stress 0.1967393 
#> Run 3 stress 0.1967393 
#> Run 4 stress 0.1976151 
#> Run 5 stress 0.2426846 
#> Run 6 stress 0.2154149 
#> Run 7 stress 0.1948413 
#> Run 8 stress 0.2109006 
#> Run 9 stress 0.2175654 
#> Run 10 stress 0.2493007 
#> Run 11 stress 0.196245 
#> Run 12 stress 0.2370314 
#> Run 13 stress 0.2096851 
#> Run 14 stress 0.2301606 
#> Run 15 stress 0.2409076 
#> Run 16 stress 0.1974409 
#> Run 17 stress 0.1869637 
#> Run 18 stress 0.2360867 
#> Run 19 stress 0.18458 
#> ... Procrustes: rmse 0.04934599  max resid 0.1574658 
#> Run 20 stress 0.18458 
#> ... Procrustes: rmse 0.04935325  max resid 0.157505 
#> *** Best solution was not repeated -- monoMDS stopping criteria:
#>     18: stress ratio > sratmax
#>      2: scale factor of the gradient < sfgrmin
fit1 <- envfit(ord1, varechem, perm = 199)

autoplot(fit1, geom = 'label_repel')


data(dune, dune.env)
ord2 <- cca(dune)
fit2 <- envfit(ord2 ~ Moisture + A1, dune.env, perm = 199)

autoplot(fit2)
```
