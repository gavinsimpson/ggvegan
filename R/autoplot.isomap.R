#' @title ggplot-based plot for objects of class `"isomap"`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects
#'   produced by [vegan::isomap()].
#'
#' @param object an object of class `"isomap"`, the result of a call to
#'   [vegan::isomap()].
#' @param axes numeric; which axes to plot, given as a vector of length 2.
#' @param geom character; which geom to use for the MDS scores layer.
#' @param network logical; should the edges of the ISOMAP network be drawn?
#' @param line.col colour with which to draw the network edges.
#' @param size numeric; size aesthetic for the log-series curve.
#' @param xlab character; label for the x-axis.
#' @param ylab character; label for the y-axis.
#' @param title character; subtitle for the plot.
#' @param subtitle character; subtitle for the plot.
#' @param caption character; caption for the plot.
#' @param ... additional arguments passed to other methods.
#' @return A ggplot object.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 ggplot autoplot geom_point geom_segment aes labs
#'   fortify coord_fixed
#'
#' @examples
#'
#' library("vegan")
#'
#' data(BCI)
#' dis <- vegdist(BCI)
#' ord <- isomap(dis, k = 3)
#'
#' autoplot(ord)
#'
#' autoplot(ord, geom = "text")
`autoplot.isomap` <- function(
  object,
  axes = c(1, 2),
  geom = c("point", "text"),
  network = TRUE,
  line.col = "grey85",
  size = 0.7,
  xlab = NULL,
  ylab = NULL,
  title = "Isometric feature mapping",
  subtitle = NULL,
  caption = NULL,
  ...
) {
  pts <- fortify(object, axes = axes)
  net <- fortify(object, axes = axes, what = "network")

  vars <- paste0("dim", axes)
  plt <- ggplot(
    pts,
    aes(
      x = .data[[vars[1]]],
      y = .data[[vars[2]]]
    )
  )

  if (isTRUE(network)) {
    plt <- plt +
      geom_segment(
        data = net,
        mapping = aes(
          x = .data[["xfrom"]],
          y = .data[["yfrom"]],
          xend = .data[["xto"]],
          yend = .data[["yto"]]
        ),
        colour = line.col,
        size = size
      )
  }

  ## match the geom
  geom <- match.arg(geom)
  point <- TRUE
  if (isTRUE(all.equal(geom, "text"))) {
    point <- FALSE
  }

  plt <- if (point) {
    plt + geom_point()
  } else {
    plt +
      geom_text(
        mapping = aes(label = .data[["label"]])
      )
  }

  if (is.null(xlab)) {
    xlab = vars[1]
  }
  if (is.null(ylab)) {
    ylab = vars[2]
  }

  plt <- plt +
    labs(
      x = xlab,
      y = ylab,
      title = title,
      subtitle = subtitle,
      caption = caption
    ) +
    coord_fixed()

  plt
}
