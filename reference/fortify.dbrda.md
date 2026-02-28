# Fortify a `"dbrda"` object.

Fortifies an object of class `"dbrda"` to produce a data frame of the
selected axis scores in long format, suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'dbrda'
fortify(
  model,
  data = NULL,
  axes = 1:6,
  layers = c("wa", "lc", "bp", "reg", "cn"),
  const = NULL,
  ...
)

# S3 method for class 'dbrda'
tidy(
  x,
  data = NULL,
  axes = 1:6,
  layers = c("wa", "lc", "bp", "reg", "cn"),
  const = NULL,
  ...
)
```

## Arguments

- model, x:

  an object of class `"dbrda"`, the result of a call to
  [`vegan::dbrda()`](https://vegandevs.github.io/vegan/reference/dbrda.html).

- data:

  currently ignored.

- axes:

  numeric; which axes to extract scores for.

- layers:

  character; the scores to extract in the fortified object. Passed to
  `display` in the respective
  [`vegan::scores()`](https://vegandevs.github.io/vegan/reference/scores.html)
  method.

- const:

  NULL; General scaling constant to RDA scores. See
  [`vegan::scores.rda()`](https://vegandevs.github.io/vegan/reference/plot.cca.html)
  for the details.

- ...:

  additional arguments passed to
  [`vegan::scores.rda()`](https://vegandevs.github.io/vegan/reference/plot.cca.html).

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

sol <- dbrda(dune ~ A1 + Management, data = dune.env)
head(fortify(sol))
#> # A tibble: 6 × 8
#>   score label dbrda1 dbrda2 dbrda3 dbrda4   mds1   mds2
#>   <fct> <chr>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#> 1 sites 1     -0.894 -0.447  -2.19 -1.92  -1.44   1.51 
#> 2 sites 2     -2.24  -0.664  -2.07  3.03   0.151 -2.37 
#> 3 sites 3     -1.87   1.98   -2.24 -0.589 -0.705 -0.910
#> 4 sites 4     -1.08   2.03   -2.54 -0.448 -0.229 -0.666
#> 5 sites 5     -1.45  -1.24    3.26 -1.18  -1.97  -0.216
#> 6 sites 6     -1.77  -2.09    4.29 -0.632 -1.72   2.31 
```
