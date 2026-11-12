#' @title ggplot-based plot for objects of class `"dbrda"`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects
#'   produced by [vegan::dbrda()].
#'
#' @details
#' TODO
#'
#' @param object an object of class `"dbrda"`, the result of a call to
#'   [vegan::dbrda()]
#' @param geom character; `"point"` or `"text"` for site and species scores.
#' @param const General scaling constant to `dbrda` scores. See
#'   [vegan::scores.rda()] for details.
#' @inheritParams autoplot.vegan_pco
#' @inheritParams autoplot.cca
#' @param ... Additional arguments passed to the [fortify()] method.
#'
#' @return Returns a ggplot object.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 autoplot ggplot geom_point geom_text geom_segment labs
#'   coord_fixed aes
#'
#' @examples
#'
#' library("vegan")
#'
#' data(dune, dune.env)
#'
#' dune_dbrda <- dbrda(
#'   dune ~ A1 + Moisture + Use + Management,
#'   data = dune.env
#' )
#' autoplot(dune_dbrda)
`autoplot.dbrda` <- function(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  layers = c("species", "sites", "biplot", "centroids"),
  legend.position = "none",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab = NULL,
  xlab = NULL,
  const = NULL,
  arrow.col = "navy",
  ...
) {
  plot_cca_scores(
    object, axes, match.arg(geom), layers, arrows = FALSE,
    legend.position, title, subtitle, caption, ylab, xlab, arrow.col,
    ..., const = const
  )
}
