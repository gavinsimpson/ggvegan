# Fortify a `"decorana"` object.

Fortifies an object of class `"decorana"` to produce a data frame of the
selected axis scores in long format, suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'decorana'
fortify(model, data, axes = 1:4, layers = c("sites", "species"), ...)

# S3 method for class 'decorana'
tidy(x, data, axes = 1:4, layers = c("sites", "species"), ...)
```

## Arguments

- model, x:

  an object of class `"decorana"`, the result of a call to
  [`vegan::decorana()`](https://vegandevs.github.io/vegan/reference/decorana.html).

- data:

  currently ignored.

- axes:

  numeric; which axis scores are required?

- layers:

  character; the scores to extract in the fortified object.

- ...:

  additional arguments passed to
  [`vegan::scores.decorana()`](https://vegandevs.github.io/vegan/reference/decorana.html).

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

sol <- decorana(dune)
head(fortify(sol))
#> # A tibble: 6 × 6
#>   score label    dca1   dca2    dca3    dca4
#>   <fct> <chr>   <dbl>  <dbl>   <dbl>   <dbl>
#> 1 sites 1     -0.758  -1.34  -0.103  -0.0361
#> 2 sites 2     -0.533  -0.771  0.469  -0.298 
#> 3 sites 3      0.0669 -0.502 -0.0855 -0.479 
#> 4 sites 4      0.0803 -0.280  0.664  -0.0898
#> 5 sites 5     -1.04   -0.438 -0.207  -0.244 
#> 6 sites 6     -0.915  -0.184 -0.637   0.0348
head(fortify(sol, layers = "species"))
#> # A tibble: 6 × 6
#>   score   label      dca1    dca2   dca3   dca4
#>   <fct>   <chr>     <dbl>   <dbl>  <dbl>  <dbl>
#> 1 species Achimill -2.28  -2.20    1.34  -0.765
#> 2 species Agrostol  1.68   0.344   0.868 -0.431
#> 3 species Airaprae -2.65   2.63    0.622 -1.28 
#> 4 species Alopgeni  1.08  -0.0492 -0.995 -2.02 
#> 5 species Anthodor -2.51   1.37    0.858 -0.536
#> 6 species Bellpere -0.919 -0.841   1.61  -1.08 
```
