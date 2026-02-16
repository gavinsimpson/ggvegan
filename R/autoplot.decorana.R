#' @title ggplot-based plot for objects of class `"decorana"`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects
#'   produced by [vegan::decorana()].
#'
#' @details
#' TODO
#'
#' @param object an object of class `"decorana"`, the result of a call to
#'   [vegan::decorana()].
#' @param ... Additional arguments passed to [fortify.decorana()].
#'
#' @inheritParams autoplot.cca
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
#'
#' sol <- decorana(dune)
#' autoplot(sol)
#' autoplot(sol, layers = "species", geom = "text")
`autoplot.decorana` <- function(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  layers = c("sites", "species"),
  legend.position = "right",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab,
  xlab,
  ...
) {
  axes <- rep(axes, length.out = 2L)
  obj <- fortify(object, axes = axes, layers = layers, ...)
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
        aes(
          x = .data[[vars[1]]],
          y = .data[[vars[2]]],
          shape = .data[["score"]],
          colour = .data[["score"]]
        )
      )
  } else {
    plt <- plt +
      geom_text(
        data = obj[want, , drop = FALSE],
        aes(
          x = .data[[vars[1]]],
          y = .data[[vars[2]]],
          label = .data[["label"]],
          colour = .data[["score"]]
        )
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
