# Add Fitted Vectors to Ordination plots

Fits arrows to show the direction of fastest increase in continuous
environmental variables in ordination space.The arrows are scaled
relative to their correlation coefficient, and they can be added to an
ordination plot with
[`geom_ordi_arrow()`](https://gavinsimpson.github.io/ggvegan/reference/geom_ordi_arrow.md).

## Usage

``` r
stat_vectorfit(
  mapping = NULL,
  data = NULL,
  geom = "text",
  position = "identity",
  na.rm = FALSE,
  show.legend = FALSE,
  inherit.aes = TRUE,
  edata = NULL,
  formula = NULL,
  arrow.mul = NULL,
  ...
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html). If
  specified and `inherit.aes = TRUE` (the default), it is combined with
  the default mapping at the top level of the plot. You must supply
  `mapping` if there is no plot mapping.

- data:

  The data to be displayed in this layer. There are three options:

  If `NULL`, the default, the data is inherited from the plot data as
  specified in the call to
  [`ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

  A `data.frame`, or other object, will override the plot data. All
  objects will be fortified to produce a data frame. See
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  for which variables will be created.

  A `function` will be called with a single argument, the plot data. The
  return value must be a `data.frame`, and will be used as the layer
  data. A `function` can be created from a `formula` (e.g.
  `~ head(.x, 10)`).

- geom:

  The geometric object to use to display the data for this layer. When
  using a `stat_*()` function to construct a layer, the `geom` argument
  can be used to override the default coupling between stats and geoms.
  The `geom` argument accepts the following:

  - A `Geom` ggproto subclass, for example `GeomPoint`.

  - A string naming the geom. To give the geom as a string, strip the
    function name of the `geom_` prefix. For example, to use
    [`geom_point()`](https://ggplot2.tidyverse.org/reference/geom_point.html),
    give the geom as `"point"`.

  - For more information and other ways to specify the geom, see the
    [layer
    geom](https://ggplot2.tidyverse.org/reference/layer_geoms.html)
    documentation.

- position:

  A position adjustment to use on the data for this layer. This can be
  used in various ways, including to prevent overplotting and improving
  the display. The `position` argument accepts the following:

  - The result of calling a position function, such as
    [`position_jitter()`](https://ggplot2.tidyverse.org/reference/position_jitter.html).
    This method allows for passing extra arguments to the position.

  - A string naming the position adjustment. To give the position as a
    string, strip the function name of the `position_` prefix. For
    example, to use
    [`position_jitter()`](https://ggplot2.tidyverse.org/reference/position_jitter.html),
    give the position as `"jitter"`.

  - For more information and other ways to specify the position, see the
    [layer
    position](https://ggplot2.tidyverse.org/reference/layer_positions.html)
    documentation.

- na.rm:

  Remove missing values (Not Yet Implemented).

- show.legend:

  logical. Should this layer be included in the legends? `NA`, the
  default, includes if any aesthetics are mapped. `FALSE` never
  includes, and `TRUE` always includes. It can also be a named logical
  vector to finely select the aesthetics to display. To include legend
  keys for all levels, even when no data exists, use `TRUE`. If `NA`,
  all levels are shown in legend, but unobserved levels are omitted.

- inherit.aes:

  If `FALSE`, overrides the default aesthetics, rather than combining
  with them. This is most useful for helper functions that define both
  data and aesthetics and shouldn't inherit behaviour from the default
  plot specification, e.g.
  [`annotation_borders()`](https://ggplot2.tidyverse.org/reference/annotation_borders.html).

- edata:

  Environmental data where the continuous variables are found.

- formula:

  Formula to select variables from `edata`. If missing, all continuos
  variables of `edata` are used.

- arrow.mul:

  Multiplier to arrow length. If missing, the multiplier is selected
  automatically so that arrows fit the current graph.

- ...:

  Other arguments passed to the functions.

## Value

Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.

## Examples

``` r
library("vegan")
library("ggplot2")
data(mite, mite.env)
m <- metaMDS(mite, trace = FALSE, trymax = 100)

## add fitted vectors for continuous variables
ordiggplot(m) +
  geom_ordi_point("sites") +
  geom_ordi_arrow("sites", stat = "vectorfit", edata = mite.env)


## can be faceted
ordiggplot(m) + geom_ordi_point("sites") +
  geom_ordi_arrow("sites", stat = "vectorfit", edata = mite.env) +
  facet_wrap(mite.env$Topo)
```
