# Scale Vectors to Data

Scale vector arrows to `fill` proportion of the data.

## Usage

``` r
arrow_mul(arrows, data, at = c(0, 0), fill = 0.75)
```

## Arguments

- arrows:

  a two-column matrix-like object containing coordinates for the
  arrows/vectors on x and y axes.

- data:

  a two-column matrix-like object containing coordinates of the data on
  the x and y axes.

- at:

  numeric vector of length 2; location of the origin of the arrows.

- fill:

  numeric; what proportion of the range of the data to fill

## Value

a numeric multiplier that will scale the arrows

## Author

Gavin L. Simpson
