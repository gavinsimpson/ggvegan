# Fortify method for `envfit` objects

Produces a tidy data frame from the results of an
[`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html)
object.

## Usage

``` r
# S3 method for class 'envfit'
fortify(model, data, ...)

# S3 method for class 'envfit'
tidy(x, data, ...)
```

## Arguments

- model, x:

  an object of class `envfit`, the result of a call to
  [`vegan::envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html).

- data:

  additional data to augment the `envfit` results. Currently ignored.

- ...:

  arguments passed to
  [`vegan::scores.envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html).

## Value

A data frame with columns `label`, `type`, containing the label for, and
whether each row refers to, the fitted vector or factor. Remaining
variables are coordinates on the respective ordination axes returned by
[`vegan::scores.envfit()`](https://vegandevs.github.io/vegan/reference/envfit.html).

## Author

Gavin L. Simpson

## Examples

``` r

library("vegan")

data(varespec, varechem)
ord <- metaMDS(varespec)
#> Square root transformation
#> Wisconsin double standardization
#> Run 0 stress 0.1843196 
#> Run 1 stress 0.2173475 
#> Run 2 stress 0.1955836 
#> Run 3 stress 0.215148 
#> Run 4 stress 0.2302984 
#> Run 5 stress 0.1955836 
#> Run 6 stress 0.1974409 
#> Run 7 stress 0.2420471 
#> Run 8 stress 0.229138 
#> Run 9 stress 0.3011761 
#> Run 10 stress 0.2104574 
#> Run 11 stress 0.195049 
#> Run 12 stress 0.2085949 
#> Run 13 stress 0.2109004 
#> Run 14 stress 0.1825658 
#> ... New best solution
#> ... Procrustes: rmse 0.04163494  max resid 0.1518448 
#> Run 15 stress 0.1869637 
#> Run 16 stress 0.18584 
#> Run 17 stress 0.1843196 
#> Run 18 stress 0.2120074 
#> Run 19 stress 0.2094754 
#> Run 20 stress 0.2290578 
#> *** Best solution was not repeated -- monoMDS stopping criteria:
#>     20: stress ratio > sratmax
fit <- envfit(ord, varechem, perm = 199)

fortify(fit)
#> # A tibble: 14 × 4
#>    label    type     nmds1  nmds2
#>    <chr>    <chr>    <dbl>  <dbl>
#>  1 N        Vector -0.0288 -0.503
#>  2 P        Vector  0.273   0.346
#>  3 K        Vector  0.326   0.273
#>  4 Ca       Vector  0.440   0.467
#>  5 Mg       Vector  0.413   0.506
#>  6 S        Vector  0.0801  0.411
#>  7 Al       Vector -0.633   0.356
#>  8 Fe       Vector -0.624   0.235
#>  9 Mn       Vector  0.578  -0.435
#> 10 Zn       Vector  0.268   0.341
#> 11 Mo       Vector -0.223   0.106
#> 12 Baresoil Vector  0.463  -0.190
#> 13 Humdepth Vector  0.673  -0.260
#> 14 pH       Vector -0.311   0.366

data(dune, dune.env)
ord <- ca(dune)
fit <- envfit(ord ~ Moisture + A1, dune.env, perm = 199)

fortify(fit)
#> # A tibble: 5 × 4
#>   label     type        ca1     ca2
#>   <chr>     <chr>     <dbl>   <dbl>
#> 1 A1        Vector   -0.556 -0.0338
#> 2 Moisture1 Centroid  0.748  0.142 
#> 3 Moisture2 Centroid  0.465  0.216 
#> 4 Moisture4 Centroid -0.183  0.732 
#> 5 Moisture5 Centroid -1.11  -0.571 
```
