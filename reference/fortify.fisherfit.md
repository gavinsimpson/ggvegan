# Tidied species rank abundance data and estimated Fisher's log-series

Prepares a data frame of results from a
[`vegan::fisherfit()`](https://vegandevs.github.io/vegan/reference/fisherfit.html))
object suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html)).

## Usage

``` r
# S3 method for class 'fisherfit'
fortify(model, data, ...)

# S3 method for class 'fisherfit'
tidy(x, data, ...)
```

## Arguments

- model, x:

  an object of class
  [`vegan::fisherfit()`](https://vegandevs.github.io/vegan/reference/fisherfit.html)).

- data:

  original data set. Currently ignored.

- ...:

  other arguments pass to methods. Currently ignored.

## Value

A data frame with columns `'Rank'` and `'Abundance'`. Additionally,
Fisher's \\\alpha\\ and the nuisance parameter are returned as
attributes `'alpha'` and `'k'` respectively.

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(BCI)
mod <- fisherfit(BCI[5,])
head(fortify(mod))
#> # A tibble: 6 × 2
#>    rank abundance
#>   <dbl>     <int>
#> 1     1        36
#> 2     2        17
#> 3     3        13
#> 4     4         4
#> 5     5         6
#> 6     6         5
```
