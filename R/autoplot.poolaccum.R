#' @title ggplot-based plot for objects of class `"poolaccum"`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects
#' produced by [vegan::poolaccum()].
#'
#' @param object an object of class `"poolaccum"`, the result of a call to
#'   [vegan::poolaccum()].
#' @param facet logical; should extrapolated richness estimators be shown in
#'   separate facets?
#' @param ribbon logical; show the quantile-based uncertainty interval? Uses
#'   [ggplot2::geom_ribbon()] for plot.
#' @param ncol numeric; if faceting the plot, how many columns to use. Default
#'   arguments will result in three columns.
#' @param ribbon.alpha numeric; alpha transparency used for the uncertainty
#'   interval. Passed to the `alpha` aesthetic of [ggplot2::geom_ribbon()].
#' @param xlab character; label for the x axis.
#' @param ylab character; label for the y axis.
#' @param title character; title for the plot.
#' @param subtitle character; subtitle for the plot.
#' @param caption character; caption for the plot.
#' @param ... additional arguments passed to [fortify.poolaccum()].
#'
#' @return A ggplot object.
#'
#' @author Didzis Elferts & Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 ggplot autoplot geom_line geom_ribbon aes_string labs
#'   fortify facet_wrap
#'
#' @examples
#'
#' library("vegan")
#'
#' data(BCI)
#' pool <- poolaccum(BCI)
#'
#' autoplot(pool)
#'
#' ## Turn off facetting; turns off ribbon too
#' autoplot(pool, facet = FALSE)
`autoplot.poolaccum` <- function(
  object,
  facet = TRUE,
  ribbon = facet,
  ncol = NULL,
  ribbon.alpha = 0.3,
  xlab = "Size",
  ylab = "Richness",
  title = "Accumulated species richness",
  subtitle = NULL,
  caption = NULL,
  ...
) {
  ## Fortify object; pass ... here
  df <- fortify(object, ...)

  ## base plot
  plt <- ggplot(df, aes_string(x = "size", y = "richness", colour = "index"))

  if (isTRUE(ribbon)) {
    plt <- plt +
      geom_ribbon(
        aes_string(ymin = "lower", ymax = "upper", x = "size", fill = "index"),
        alpha = ribbon.alpha,
        inherit.aes = FALSE
      )
  }

  plt <- plt +
    geom_line() +
    labs(
      x = xlab,
      y = ylab,
      title = title,
      subtitle = subtitle,
      caption = caption
    )

  ## are we facetting
  if (isTRUE(facet)) {
    if (is.null(ncol)) {
      ncol <- (nlevels(df[["index"]]) + 1) %/% 2
    }
    plt <- plt + facet_wrap("index", ncol = ncol)
  }

  plt
}
