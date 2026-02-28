# Fortify permutation statistics

Fortify permutation statistics

## Usage

``` r
# S3 method for class 'permustats'
fortify(model, data, scale = FALSE, ...)

# S3 method for class 'permustats'
tidy(x, data, scale = FALSE, ...)
```

## Arguments

- model, x:

  an object of created by
  [`vegan::permustats()`](https://vegandevs.github.io/vegan/reference/permustats.html).

- data:

  original data set. Currently ignored.

- scale:

  logical; return standardized effect sizes (SES)?

- ...:

  Other parameters passed to functions (ignored).

## Value

A tibble with columns `permutations`, and `terms` containing the values
of tests statistics under the null hypothesis, and a factor labelling
the permutation, respectively.

## Examples

``` r
library("vegan")
data(dune, dune.env, package = "vegan")
mod <- adonis2(dune ~ Management + A1, data = dune.env)
## use permustats
perm <- permustats(mod)
```
