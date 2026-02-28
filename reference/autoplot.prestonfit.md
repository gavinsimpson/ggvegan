# Plot Preston's log-normal model of species abundance

Draws a bar plot of species rank abundance with Preston's log-normal
model superimposed.

## Usage

``` r
# S3 method for class 'prestonfit'
autoplot(
  object,
  show.fitted = TRUE,
  xlab = "Abundance",
  ylab = "Number of Species",
  title = "Preston's lognormal distribution",
  subtitle = NULL,
  caption = NULL,
  bar.col = NA,
  bar.fill = "grey35",
  line.col = "red",
  linewidth = 0.7,
  ...
)
```

## Arguments

- object:

  an object of class
  [`vegan::prestonfit()`](https://vegandevs.github.io/vegan/reference/fisherfit.html).

- show.fitted:

  logical; should the estimated distribution also be plotted?

- xlab:

  character; label for the x axis.

- ylab:

  character; label for the y axis.

- title:

  character; title for the plot.

- subtitle:

  character; subtitle for the plot.

- caption:

  character; caption for the plot.

- bar.col:

  colour for the bar outlines. The default, \`NA“, does not draw
  outlines around bars.

- bar.fill:

  fill colour for the bars.

- line.col:

  colour for Preston's log-normal curve.

- linewidth:

  numeric; size aesthetic for the log-normal curve.

- ...:

  additional arguments passed to other methods.

## Value

A ggplot object.

## Author

Gavin L. Simpson

## Examples

``` r
library("vegan")

data(BCI)
pfit <- prestonfit(colSums(BCI))
autoplot(pfit)
```
