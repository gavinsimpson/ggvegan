#' @title ggplot-based plot for objects of class `"vegan_pco"`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of
#' objects produced by [vegan::pco()].
#'
#' @details
#' TODO
#'
#' @param object an object of class `"vegan_pco"`, the result of a call
#' to [vegan::pco()].
#' @param geom character; which geom to use for the site (sample) scores. One
#'   of `"point"`, or `"text"`.
#' @param ... Additional arguments passed to the [fortify()] method.
#'
#' @inheritParams autoplot.cca
#' @return Returns a ggplot object.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 autoplot ggplot geom_point geom_text labs coord_fixed
#'   aes
#'
#' @examples
#'
#' library("vegan")
#'
#' data(dune)
#'
#' sol <- pco(dune)
#' autoplot(sol)
`autoplot.vegan_pco` <- function(
  object,
  geom = "point",
  legend.position = "right",
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  ylab = NULL,
  xlab = NULL,
  ...
) {
  obj <- fortify(object, ...)
  ## sort out x, y aesthetics
  vars <- get_dimension_names(obj)
  ## skeleton layer
  plt <- ggplot()
  point <- TRUE
  if (isTRUE(all.equal(geom, "text"))) {
    point <- FALSE
  }
  if (point) {
    plt <- plt +
      geom_point(
        data = obj,
        mapping = aes(
          x = .data[[vars[1]]],
          y = .data[[vars[2]]],
          shape = .data[["score"]],
          colour = .data[["score"]]
        )
      )
  } else {
    plt <- plt +
      geom_text(
        data = obj,
        mapping = aes(
          x = .data[[vars[1]]],
          y = .data[[vars[2]]],
          label = .data[["label"]],
          colour = .data[["score"]]
        )
      )
  }
  if (is.null(xlab)) {
    xlab <- vars[1]
  }
  if (is.null(ylab)) {
    ylab <- vars[2]
  }
  plt <- plt +
    labs(
      x = toupper(xlab),
      y = toupper(ylab),
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
