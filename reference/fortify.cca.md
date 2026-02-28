# Fortify a `"cca"` object.

Fortifies an object of class `"cca"` to produce a data frame of the
selected axis scores in long format, suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'cca'
fortify(model, data, axes = 1:6, layers = c("sp", "wa", "lc", "bp", "cn"), ...)

# S3 method for class 'cca'
tidy(x, data, axes = 1:6, layers = c("sp", "wa", "lc", "bp", "cn"), ...)
```

## Arguments

- model, x:

  an object of class `"cca"`, the result of a call to
  [`vegan::cca()`](https://vegandevs.github.io/vegan/reference/cca.html),
  [`vegan::rda()`](https://vegandevs.github.io/vegan/reference/cca.html),
  or
  [`vegan::capscale()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

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
  [`vegan::scores.cca()`](https://vegandevs.github.io/vegan/reference/plot.cca.html).

## Value

A data frame (tibble) in long format containing the ordination scores.
The first two components are `score` (the type of score in each row) and
`label` (the text label to use on plots for this row). The remaining
columns are the extracted ordination axis scores.

## Details

TODO

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(dune)
data(dune.env)

sol <- cca(dune ~ A1 + Management, data = dune.env)
head(fortify(sol))
#> # A tibble: 6 × 8
#>   score   label      cca1   cca2   cca3    cca4    ca1    ca2
#>   <fct>   <chr>     <dbl>  <dbl>  <dbl>   <dbl>  <dbl>  <dbl>
#> 1 species Achimill  0.215  0.679 -0.224  0.369   0.568  0.413
#> 2 species Agrostol -0.121 -0.757  0.278 -0.0352 -0.580 -0.214
#> 3 species Airaprae -1.84   0.888  0.771 -0.608   2.14  -1.59 
#> 4 species Alopgeni  0.538 -0.660  0.465 -0.0737 -0.199 -0.549
#> 5 species Anthodor -0.377  0.581 -0.231 -0.213   1.19  -0.208
#> 6 species Bellpere  0.141  0.228  0.184  0.515   0.235  0.712
```
