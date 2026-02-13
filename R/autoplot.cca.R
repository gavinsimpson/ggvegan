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
#' @param axes numeric; which axes to plot, given as a vector of length 2.
#' @param geom character; which geom to use for the layers. Can be a
#'   vector of length equal to `length(display)`, in which case the *i*th
#'   element of `type` refers to the *i*th element of `display`.
#' @param layers character; which scores to plot as layers
#' @param legend.position character or two-element numeric vector; where to
#'   position the legend. See [vegan::theme()] for details. Use `"none"`
#'   to not draw the legend.
#' @param xlab character; label for the x-axis
#' @param ylab character; label for the y-axis
#' @param title character; subtitle for the plot
#' @param subtitle character; subtitle for the plot
#' @param caption character; caption for the plot
#' @param ... Additional arguments passed to [vegan::capscale()].
#' @return Returns a ggplot object.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom grid arrow unit
#' @importFrom ggplot2 autoplot ggplot geom_point geom_text geom_segment labs
#'   coord_fixed aes_string
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
  ylab,
  xlab,
  ...
) {
  axes <- rep(axes, length.out = 2L)
  obj <- fortify(object, axes = axes, ...)
  LAYERS <- levels(obj$score)
  ## sort out x, y aesthetics
  vars <- get_dimension_names(obj)
  ## match the geom
  geom <- match.arg(geom)
  point <- TRUE
  if (isTRUE(all.equal(geom, "text"))) {
    point <- FALSE
  }
  ## subset out the layers wanted
  ### need something here first to match acceptable ones?
  ### or just check that the layers selected would return a df with
  ### at least 1 row.
  obj <- obj[obj$score %in% layers, , drop = FALSE]
  ## skeleton layer
  plt <- ggplot()
  ## add plot layers as required
  want <- obj$score %in% c("species", "sites")
  if (point) {
    plt <- plt +
      geom_point(
        data = obj[want, , drop = FALSE],
        aes_string(x = vars[1], y = vars[2], shape = 'score', colour = 'score')
      )
  } else {
    plt <- plt +
      geom_text(
        data = obj[want, , drop = FALSE],
        aes_string(x = vars[1], y = vars[2], label = 'label', colour = 'score')
      )
  }
  ## remove biplot arrows for centroids if present
  if (all(c("biplot", "centroids") %in% LAYERS)) {
    want <- obj$score == "biplot"
    tmp <- obj[want, ]
    obj <- obj[!want, ]
    bnam <- tmp[, "label"]
    cnam <- obj[obj$score == "centroids", "label"]
    obj <- rbind(obj, tmp[!bnam %in% cnam, , drop = FALSE])
  }
  if (any(want <- obj$score == "constraints")) {
    if (point) {
      plt <- plt +
        geom_point(
          data = obj[want, , drop = FALSE],
          aes_string(x = vars[1], y = vars[2])
        )
    } else {
      plt <- plt +
        geom_text(
          data = obj[want, , drop = FALSE],
          aes_string(x = vars[1], y = vars[2], label = 'label')
        )
    }
  }
  if (any(want <- obj$score == "biplot")) {
    if (length(layers) > 1) {
      mul <- arrow_mul(
        obj[want, vars, drop = FALSE],
        obj[!want, vars, drop = FALSE]
      )
      obj[want, vars] <- mul * obj[want, vars]
    }
    col <- "navy"
    plt <- plt +
      geom_segment(
        data = obj[want, , drop = FALSE],
        aes_string(x = 0, y = 0, xend = vars[1], yend = vars[2]),
        arrow = arrow(length = unit(0.2, "cm")),
        colour = col
      )
    obj[want, vars] <- 1.1 * obj[want, vars]
    plt <- plt +
      geom_text(
        data = obj[want, , drop = FALSE],
        aes_string(x = vars[1], y = vars[2], label = 'label')
      )
  }
  if (any(want <- obj$score == "centroids")) {
    plt <- plt +
      geom_text(
        data = obj[want, , drop = FALSE],
        aes_string(x = vars[1], y = vars[2], label = 'label'),
        colour = "navy"
      )
  }
  if (missing(xlab)) {
    xlab <- vars[1]
  }
  if (missing(ylab)) {
    ylab <- vars[2]
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

## `aplot.cca` <- `autoplot.cca`
