# Adds species and site score layers to an existing plot

Adds species and site score layers to an existing plot

## Usage

``` r
add_spp_site_scores(object, plt, vars, geom, draw_list, arrows)
```

## Arguments

- object:

  an ordination object.

- plt:

  a ggplot object.

- vars:

  character; length 2 vector of dimension names.

- geom:

  character; vector of length 1 or 2 indicating which geom will be used
  for the species or site scores.

- draw_list:

  logical; vector of types of scores indicating which are available and
  requested for plotting.

- arrows:

  logical; length 1 vector indicating if species scores should be drawn
  using arrows.
