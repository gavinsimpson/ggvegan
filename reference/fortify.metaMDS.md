# Fortify a `"mataMDS"` object.

Fortifies an object of class `"metaMDS"` to produce a data frame of the
selected axis scores in long format, suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'metaMDS'
fortify(model, data, axes = 1:2, layers = c("sites", "species"), ...)

# S3 method for class 'metaMDS'
tidy(x, data, layers = c("sites", "species"), ...)
```

## Arguments

- model, x:

  an object of class `"metaMDS"`, the result of a call to
  [`vegan::metaMDS()`](https://vegandevs.github.io/vegan/reference/metaMDS.html).

- data:

  currently ignored.

- axes:

  numeric; which axes to extract scores for.

- layers:

  character; the scores to extract in the fortified object. Passed to
  `display` in the respective
  [`vegan::scores()`](https://vegandevs.github.io/vegan/reference/scores.html)
  method.

- ...:

  additional arguments passed to
  [`vegan::scores.metaMDS()`](https://vegandevs.github.io/vegan/reference/metaMDS.html).
  Note you can't use `display`.

## Value

A data frame in long format containing the ordination scores. The first
two components are the axis scores.

## Details

TODO

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(dune)

ord <- metaMDS(dune)
#> Run 0 stress 0.1192678 
#> Run 1 stress 0.1192678 
#> ... Procrustes: rmse 5.094155e-05  max resid 0.0001578845 
#> ... Similar to previous best
#> Run 2 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 0.02026906  max resid 0.06495659 
#> Run 3 stress 0.1183186 
#> ... Procrustes: rmse 9.852771e-06  max resid 2.93585e-05 
#> ... Similar to previous best
#> Run 4 stress 0.1192679 
#> Run 5 stress 0.1889646 
#> Run 6 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 7.002834e-06  max resid 2.237538e-05 
#> ... Similar to previous best
#> Run 7 stress 0.1183186 
#> ... Procrustes: rmse 6.858588e-06  max resid 2.103068e-05 
#> ... Similar to previous best
#> Run 8 stress 0.1192679 
#> Run 9 stress 0.2066373 
#> Run 10 stress 0.1183186 
#> ... Procrustes: rmse 7.210821e-06  max resid 2.326609e-05 
#> ... Similar to previous best
#> Run 11 stress 0.1808911 
#> Run 12 stress 0.1183186 
#> ... Procrustes: rmse 6.580925e-06  max resid 1.99305e-05 
#> ... Similar to previous best
#> Run 13 stress 0.2045511 
#> Run 14 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 5.478655e-06  max resid 1.740176e-05 
#> ... Similar to previous best
#> Run 15 stress 0.1192678 
#> Run 16 stress 0.1192679 
#> Run 17 stress 0.1192678 
#> Run 18 stress 0.1192678 
#> Run 19 stress 0.1192678 
#> Run 20 stress 0.2407564 
#> *** Best solution repeated 1 times
head(fortify(ord))
#> # A tibble: 6 × 4
#>   score label   nmds1   nmds2
#>   <fct> <chr>   <dbl>   <dbl>
#> 1 sites 1     -0.841  -0.716 
#> 2 sites 2     -0.505  -0.409 
#> 3 sites 3     -0.0827 -0.437 
#> 4 sites 4     -0.116  -0.522 
#> 5 sites 5     -0.627  -0.0867
#> 6 sites 6     -0.543   0.113 
```
