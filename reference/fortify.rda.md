# Fortify a `"rda"` object.

Fortifies an object of class `"rda"` to produce a data frame of the
selected axis scores in long format, suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'rda'
fortify(
  model,
  data = NULL,
  axes = 1:6,
  layers = c("sp", "wa", "lc", "bp", "cn"),
  const = NULL,
  ...
)

# S3 method for class 'rda'
tidy(
  x,
  data = NULL,
  axes = 1:6,
  layers = c("sp", "wa", "lc", "bp", "reg", "cn"),
  const = NULL,
  ...
)
```

## Arguments

- model, x:

  an object of class `"rda"`, the result of a call to
  [`vegan::rda()`](https://vegandevs.github.io/vegan/reference/cca.html).

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

sol <- rda(dune ~ A1 + Management, data = dune.env)
head(fortify(sol))
#> # A tibble: 6 × 8
#>   score   label       rda1    rda2    rda3    rda4    pc1     pc2
#>   <fct>   <chr>      <dbl>   <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
#> 1 species Achimill  0.365   0.377   0.0453 -0.147   0.362 -0.0170
#> 2 species Agrostol -0.355  -1.22    0.0240 -0.0755 -1.09   0.165 
#> 3 species Airaprae -0.215   0.169   0.0910  0.186   0.108  0.0954
#> 4 species Alopgeni  0.450  -1.17    0.173   0.0526 -0.591  0.662 
#> 5 species Anthodor  0.0626  0.493  -0.183   0.181   0.604 -0.0857
#> 6 species Bellpere  0.175   0.0832  0.196  -0.158   0.214  0.224 
```
