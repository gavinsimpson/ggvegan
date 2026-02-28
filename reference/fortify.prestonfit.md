# Tidied species octave abundance data

Prepares a data frame of results from a
[`vegan::prestonfit()`](https://vegandevs.github.io/vegan/reference/fisherfit.html)
object suitable for plotting with
[`ggplot2::ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

## Usage

``` r
# S3 method for class 'prestonfit'
fortify(model, data, ...)

# S3 method for class 'prestonfit'
tidy(x, data, ...)
```

## Arguments

- model, x:

  an object of class
  [`vegan::prestonfit()`](https://vegandevs.github.io/vegan/reference/fisherfit.html).

- data:

  original data set. Currently ignored.

- ...:

  other arguments pass to methods. Currently ignored.

## Value

A data frame with columns ``` 'Octave'`` and  ```'Abundance'“.

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(BCI)
pfit <- prestonfit(colSums(BCI))
fortify(pfit)
#> # A tibble: 12 × 2
#>    octave abundance
#>     <dbl>     <dbl>
#>  1      0       9.5
#>  2      1      16  
#>  3      2      18  
#>  4      3      19  
#>  5      4      30  
#>  6      5      35  
#>  7      6      31  
#>  8      7      26.5
#>  9      8      18  
#> 10      9      13  
#> 11     10       7  
#> 12     11       2  
```
