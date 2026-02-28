# Autoplot Graphics for vegan permustats Objects

Alternatives for lattice graphics functions
[`vegan::densityplot.permustats()`](https://vegandevs.github.io/vegan/reference/permustats.html),
[`vegan::densityplot.permustats()`](https://vegandevs.github.io/vegan/reference/permustats.html)
and
[`vegan::boxplot.permustats()`](https://vegandevs.github.io/vegan/reference/permustats.html).

## Usage

``` r
# S3 method for class 'permustats'
autoplot(
  object,
  plot = c("box", "violin", "density", "qqnorm"),
  scale = FALSE,
  facet = FALSE,
  gg.params = list(),
  ...
)
```

## Arguments

- object:

  object from
  [`vegan::permustats()`](https://vegandevs.github.io/vegan/reference/permustats.html).

- plot:

  character; the type of plot, or a geom from ggplot2.

- scale:

  logical; use standardized effect sizes (SES)?

- facet:

  logical; should the plot be faceted by `term`?

- gg.params:

  list; arguments passed to function drawing the box-like object.
  Depending on argument `plot` the parameters are passed to
  [`ggplot2::geom_boxplot()`](https://ggplot2.tidyverse.org/reference/geom_boxplot.html),
  [`ggplot2::geom_violin()`](https://ggplot2.tidyverse.org/reference/geom_violin.html),
  [`ggplot2::geom_density()`](https://ggplot2.tidyverse.org/reference/geom_density.html)
  or
  [`ggplot2::geom_qq()`](https://ggplot2.tidyverse.org/reference/geom_qq.html).

- ...:

  Other parameters passed to functions (ignored).

## Value

Returns a ggplot object.

## Details

Function
[`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
returns a data frame with variables `permutations` (numeric) and `term`
(factor labelling the permutation). The result of
[`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html) can
be used to custom build diagnostic plots.
[`autoplot()`](https://ggplot2.tidyverse.org/reference/autoplot.html)
provides basic plots of
[`vegan::permustats()`](https://vegandevs.github.io/vegan/reference/permustats.html)
objects with limited flexibility.

## Examples

``` r
library("vegan")

data(dune, dune.env)
mod <- cca(dune ~ A1 + Management + Moisture, dune.env)
(ano <- anova(mod, by = "onedf"))
#> Permutation test for cca under reduced model
#> Sequential test for contrasts
#> Permutation: free
#> Number of permutations: 999
#> 
#> Model: cca(formula = dune ~ A1 + Management + Moisture, data = dune.env)
#>              Df ChiSquare      F Pr(>F)    
#> A1            1   0.22476 2.7632  0.009 ** 
#> ManagementHF  1   0.13890 1.7076  0.054 .  
#> ManagementNM  1   0.28099 3.4545  0.001 ***
#> ManagementSF  1   0.13512 1.6612  0.077 .  
#> Moisture.L    1   0.21976 2.7017  0.002 ** 
#> Moisture.Q    1   0.05769 0.7093  0.722    
#> Moisture.C    1   0.08193 1.0073  0.358    
#> Residual     12   0.97610                  
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
pstat <- permustats(ano)
head(fortify(pstat))
#> # A tibble: 6 × 2
#>   term  permutation
#>   <fct>       <dbl>
#> 1 A1          -2.10
#> 2 A1          -2.06
#> 3 A1          -2.21
#> 4 A1          -2.00
#> 5 A1          -2.06
#> 6 A1          -1.74
autoplot(pstat, "box")



if (requireNamespace("ggplot2")) {
  library("ggplot2")

  # avoid overplotting x-axis text
  autoplot(pstat, "violin") +
    scale_x_discrete(guide = guide_axis(n.dodge = 2))

  autoplot(pstat, "qqnorm", facet = TRUE) +
    geom_qq_line()
}


autoplot(pstat, "density", facet = TRUE)
```
