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
#' @param axes numeric; which axes to plot, given as a vector of length 2.
#' @param geom character; which geom to use for the layers. Can be a vector of
#'   up to length 2, in which case, the first element of `geom` will be
#'   used for any site scores (both weighted sum or linear combination scores),
#'   and the second element will be used for species scores. The latter will be
#'   ignored if \code{arrows = TRUE}.
#' @param layers character; which scores to plot as layers
#' @param arrows logical; represent species (variables) using vectors?
#' @param legend.position character or two-element numeric vector; where to
#'   position the legend. See [ggplot2::theme()] for details. Use `"none"` to
#'   not draw the legend.
#' @param xlab character; label for the x-axis
#' @param ylab character; label for the y-axis
#' @param title character; subtitle for the plot
#' @param subtitle character; subtitle for the plot
#' @param caption character; caption for the plot
#' @param const General scaling constant to `rda` scores. See
#'   [vegan::scores.rda()] for details.
#' @param arrow.col colour specification for biplot arrows and their labels.
#' @param ... Additional arguments passed to `\link{fortify.cca}`.
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
  ## determine which layers to plot
  valid <- valid_layers(object) # vector of valid layers
  ok_layers <- check_user_layers(layers, valid, message = TRUE)
  layers <- layers[ok_layers] # subset user-supplied layers
  draw_list <- layer_draw_list(valid, layers) # what are we drawing

  ## fix-up axes needed to plot
  laxes <- length(axes)
  if (laxes != 2L) {
    if (laxes > 2L) {
      axes <- rep(axes, length.out = 2L) # shrink to required length
    } else {
      stop("Need 2 ordination axes to plot; only 1 was given.", call. = FALSE)
    }
  }

  obj <- fortify(object, axes = axes, const = const, ...) # grab some scores
  available <- levels(obj[["score"]])
  draw_list <- layer_draw_list(valid, layers, available) # what are we drawing
  layer_names <- names(draw_list)[draw_list]

  ## sort out x, y aesthetics
  vars <- get_dimension_names(obj)

  ## process geom arg
  geom <- match.arg(geom, several.ok = TRUE)
  geom <- unique(geom) # simplify geom if elements are the same

  ## subset out the layers wanted
  obj <- obj[obj[["score"]] %in% layer_names, , drop = FALSE]

  ## skeleton layer
  plt <- ggplot()

  ## draw sites, species, constraints == lc site scores
  if (any(draw_list[c("species", "sites", "constraints")])) {
    plt <- add_spp_site_scores(obj, plt, vars, geom, draw_list, arrows)
  }

  ## remove biplot arrows for centroids if present
  if (all(draw_list[c("biplot", "centroids")])) {
    want <- obj[["score"]] == "biplot"
    tmp <- obj[want, ]
    obj <- obj[!want, ]
    bnam <- tmp[, "label"]
    cnam <- obj[obj[["score"]] == "centroids", "label"]
    obj <- rbind(obj, tmp[!bnam %in% cnam, , drop = FALSE])
  }

  if (isTRUE(draw_list["biplot"])) {
    plt <- add_biplot_arrows(
      object = obj,
      plt = plt,
      vars = vars,
      arrow.col = arrow.col
    )
  }

  if (isTRUE(draw_list["centroids"])) {
    plt <- add_biplot_centroids(
      object = obj,
      plt = plt,
      vars = vars,
      arrow.col = arrow.col
    )
  }

  if (is.null(xlab)) {
    xlab <- toupper(vars[1])
  }
  if (is.null(ylab)) {
    ylab <- toupper(vars[2])
  }
  plt <- plt +
    labs(
      x = xlab,
      y = ylab,
      title = title,
      subtitle = subtitle,
      caption = caption
    )
  ## add equal scaling
  plt <- plt + coord_fixed(ratio = 1)
  ## do we want a legend
  plt <- plt + theme(legend.position = legend.position)
  plt
}
