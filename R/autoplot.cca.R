#' @title ggplot-based plot for objects of class `"cca"`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects
#'   produced by [vegan::cca()] or [vegan::capscale()].
#'
#' @details
#' TODO
#'
#' @param object an object of class `"cca"`, the result of a call to
#'   [vegan::cca()] or [vegan::capscale()].
#' @param axes numeric; one or two axes to plot. If only one selected axis is
#'   available, the scores are plotted along that axis.
#' @param geom character; which geom to use for the species (variables) and
#'   sites (samples) layers. A vector of length 2; if a vector of length 1,
#'   `geom` is extended to the required length.
#' @param layers character; which scores to plot as layers
#' @param legend.position character or two-element numeric vector; where to
#'   position the legend. See [ggplot2::theme()] for details. Use `"none"`
#'   to not draw the legend.
#' @param xlab character; label for the x-axis.
#' @param ylab character; label for the y-axis.
#' @param title character; subtitle for the plot.
#' @param subtitle character; subtitle for the plot.
#' @param caption character; caption for the plot.
#' @param arrow.col colour specification for biplot arrows and their labels.
#' @param ... Additional arguments passed to the [fortify()] method.
#'
#' @return Returns a ggplot object.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom grid arrow unit
#' @importFrom ggplot2 autoplot ggplot geom_point geom_text geom_segment labs
#'   coord_fixed aes
#'
#' @examples
#'
#' library("vegan")
#' data(dune)
#' data(dune.env)
#'
#' sol <- cca(dune ~ A1 + Management, data = dune.env)
#' autoplot(sol)
`autoplot.cca` <- function(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  layers = c("species", "sites", "biplot", "centroids"),
  legend.position = "right",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab = NULL,
  xlab = NULL,
  arrow.col = "navy",
  ...
) {
  plot_cca_scores(
    object, axes, unique(match.arg(geom, several.ok = TRUE)), layers,
    arrows = FALSE, legend.position, title, subtitle, caption, ylab, xlab,
    arrow.col, ...
  )
}
