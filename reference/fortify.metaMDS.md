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
#> Run 1 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 0.02027217  max resid 0.06497049 
#> Run 2 stress 0.1192678 
#> Run 3 stress 0.1192679 
#> Run 4 stress 0.1192678 
#> Run 5 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 2.514381e-05  max resid 7.437405e-05 
#> ... Similar to previous best
#> Run 6 stress 0.1192679 
#> Run 7 stress 0.1192678 
#> Run 8 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 1.507536e-05  max resid 3.726589e-05 
#> ... Similar to previous best
#> Run 9 stress 0.1192679 
#> Run 10 stress 0.1183186 
#> ... New best solution
#> ... Procrustes: rmse 7.701126e-06  max resid 1.83745e-05 
#> ... Similar to previous best
#> Run 11 stress 0.1183186 
#> ... Procrustes: rmse 3.337356e-05  max resid 9.827007e-05 
#> ... Similar to previous best
#> Run 12 stress 0.1192678 
#> Run 13 stress 0.1183186 
#> ... Procrustes: rmse 1.87009e-06  max resid 5.460179e-06 
#> ... Similar to previous best
#> Run 14 stress 0.1183186 
#> ... Procrustes: rmse 4.103449e-06  max resid 1.313481e-05 
#> ... Similar to previous best
#> Run 15 stress 0.1922241 
#> Run 16 stress 0.1889641 
#> Run 17 stress 0.1192678 
#> Run 18 stress 0.1192679 
#> Run 19 stress 0.1183186 
#> ... Procrustes: rmse 1.09579e-05  max resid 3.513228e-05 
#> ... Similar to previous best
#> Run 20 stress 0.1808911 
#> *** Best solution repeated 5 times
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
