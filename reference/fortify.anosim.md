# Fortify analysis of similarities (ANOSIM) results

Prepares a fortified version of results from
[`vegan::anosim()`](https://vegandevs.github.io/vegan/reference/anosim.html)
objects.

## Usage

``` r
# S3 method for class 'anosim'
fortify(model, data, ...)

# S3 method for class 'anosim'
tidy(x, data, ...)
```

## Arguments

- model, x:

  an object of class
  [`vegan::anosim()`](https://vegandevs.github.io/vegan/reference/anosim.html).

- data:

  original data set. Currently ignored.

- ...:

  additional arguments for other methods. Currently ignored.

## Value

A data frame with columns `Rank` and `Class` with ranks of
dissimilarity.

## Author

Original implementation by Didzis Elferts. Modification to tibbles by
Gavin L. Simpson.

## Examples

``` r
library("vegan")

library("ggplot2")
data(dune, dune.env)
dune.dist <- vegdist(dune)
dune.ano <- with(dune.env, anosim(dune.dist, Management))

df <- fortify(dune.ano)

ggplot(df, aes(x = class, y = rank)) +
    geom_boxplot(notch = FALSE, varwidth = TRUE)

```
