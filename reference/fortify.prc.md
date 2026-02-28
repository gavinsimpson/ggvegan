# Fortify a `"prc"` object

Fortifies an object of class `"prc"` to produce a data frame of the
selected axis scores in long format, suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'prc'
fortify(model, data, scaling = "symmetric", axis = 1, ...)

# S3 method for class 'prc'
tidy(x, data, scaling = "symmetric", axis = 1, ...)
```

## Arguments

- model, x:

  an object of class `"prc"`, the result of a call to
  [`vegan::prc()`](https://vegandevs.github.io/vegan/reference/prc.html).

- data:

  currently ignored.

- scaling:

  the desired scaling. See
  [`vegan::scores.cca()`](https://vegandevs.github.io/vegan/reference/plot.cca.html)
  for details.

- axis:

  numeric; which PRC axis to extract. Default is `axis = 1`, which is
  the most generally useful choice.

- ...:

  additional arguments currently ignored.

## Value

A data frame in long format containing the ordination scores. The first
three components are the `Time`, `Treatment`, and associated `Response`.
The last two components, `score` and `label` are an indicator factor and
a label for the rows for use in plotting.

## Details

TODO

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")
data(pyrifos)
week <- gl(11, 12, labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24))
dose <- factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6), 11))
ditch <- gl(12, 1, length=132)

pyrifos_prc <- prc(pyrifos, dose, week)
fortify(pyrifos_prc)
#> # A tibble: 222 × 5
#>    score  label   time  treatment response
#>    <fct>  <chr>   <fct> <fct>        <dbl>
#>  1 Sample 0.1|-4  -4    0.1        -0.133 
#>  2 Sample 0.1|-1  -1    0.1        -0.253 
#>  3 Sample 0.1|0.1 0.1   0.1        -0.188 
#>  4 Sample 0.1|1   1     0.1        -0.0748
#>  5 Sample 0.1|2   2     0.1        -0.386 
#>  6 Sample 0.1|4   4     0.1        -0.251 
#>  7 Sample 0.1|8   8     0.1        -0.149 
#>  8 Sample 0.1|12  12    0.1        -0.282 
#>  9 Sample 0.1|15  15    0.1        -0.206 
#> 10 Sample 0.1|19  19    0.1        -0.398 
#> # ℹ 212 more rows
```
