#' @title ggplot-based plot for objects of class `'rda'`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects
#'   produced by [vegan::rda()].
#'
#' @details
#' TODO
#'
#' @param object an object of class `"rda"`, the result of a call to
#'   [vegan::rda()]
#' @param arrows logical; represent species (variables) using vectors?
#' @param const General scaling constant to `rda` scores. See
#'   [vegan::scores.rda()] for details.
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
#' data(dune)
#'
#' pca <- rda(dune)
#' autoplot(pca)
#'
#' ## Just the species scores
#' autoplot(pca, layers = "species")
`autoplot.rda` <- function(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  layers = c("species", "sites", "biplot", "centroids"),
  arrows = TRUE,
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
    object, axes, unique(match.arg(geom, several.ok = TRUE)), layers,
    arrows, legend.position, title, subtitle, caption, ylab, xlab,
    arrow.col, ..., const = const
  )
}
