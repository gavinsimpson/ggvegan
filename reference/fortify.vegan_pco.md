# Fortify a `"vegan_pco"` object.

Fortifies an object of class `"vegan_pco"` to produce a data frame of
the selected axis scores in long format, suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'vegan_pco'
fortify(model, data = NULL, axes = 1:6, ...)

# S3 method for class 'vegan_pco'
tidy(x, data = NULL, axes = 1:6, const = NULL, ...)
```

## Arguments

- model, x:

  an object of class `"vegan_pco"`, the result of a call to
  [`vegan::pco()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

- data:

  currently ignored.

- axes:

  numeric; which axes to extract scores for.

- ...:

  additional arguments passed to
  [`vegan::scores.rda()`](https://vegandevs.github.io/vegan/reference/plot.cca.html).

- const:

  NULL; General scaling constant to RDA scores. See
  [`vegan::scores.rda()`](https://vegandevs.github.io/vegan/reference/plot.cca.html)
  for the details.

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

sol <- pco(dune)
head(fortify(sol))
#> # A tibble: 6 × 8
#>   score label    mds1   mds2   mds3   mds4   mds5    mds6
#>   <fct> <chr>   <dbl>  <dbl>  <dbl>  <dbl>  <dbl>   <dbl>
#> 1 sites 1     -0.857   0.172 -2.61   1.13  -0.451  2.49  
#> 2 sites 2     -1.64    1.23  -0.887  0.986 -2.03  -1.81  
#> 3 sites 3     -0.440   2.38  -0.930  0.460  1.03   0.0518
#> 4 sites 4      0.0479  2.05  -1.27   0.974  0.642  0.721 
#> 5 sites 5     -1.62   -0.290  1.59  -1.54  -1.86   2.21  
#> 6 sites 6     -1.97   -1.08   1.15  -3.35   1.52  -0.0313
```
