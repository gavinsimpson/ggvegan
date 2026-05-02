# Fortify results of ranked abundance distribution models

Prepares a fortified version of results from
[`vegan::radfit()`](https://vegandevs.github.io/vegan/reference/radfit.html)
or
[`vegan::as.rad()`](https://vegandevs.github.io/vegan/reference/radfit.html).

## Usage

``` r
# S3 method for class 'radfit'
fortify(model, data, pick = NULL, ...)

# S3 method for class 'radfit.frame'
fortify(model, data, pick = "AIC", order.by = NULL, ...)

# S3 method for class 'radline'
fortify(model, data, ...)

# S3 method for class 'rad'
fortify(model, data, ...)

# S3 method for class 'rad.frame'
fortify(model, data, order.by = NULL, ...)

# S3 method for class 'radfit'
tidy(x, data, pick = NULL, ...)

# S3 method for class 'radfit.frame'
tidy(x, data, pick = "AIC", order.by = NULL, ...)

# S3 method for class 'radline'
tidy(x, data, ...)

# S3 method for class 'rad'
tidy(x, data, ...)

# S3 method for class 'rad.frame'
tidy(x, data, order.by = NULL, ...)
```

## Arguments

- model:

  model or other R object to convert to data frame

- data:

  original dataset, if needed

- pick:

  Pick or several models. Allowed values are `"AIC"` and `"BIC"` for
  selecting the best model by AIC or BIC, or (a vector of) model names
  that can be abbreviated. The default returns all fitted models.

- ...:

  Arguments passed to methods.

- order.by:

  A vector used for ordering site panels.

- x:

  An object to be converted into a tidy
  [`tibble::tibble()`](https://tibble.tidyverse.org/reference/tibble.html).

## Value

A data frame or tibble which in all cases has columns `species`
(character), for species names, with `rank` and `abundance` for data,
and may also have columns `site` (factor) for site names when several
sites were analysed, `fit` of fitted abundances when evaluated, and
`model` (factor) when several models were fitted.

## Author

Jari Oksanen
