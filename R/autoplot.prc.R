#' @title ggplot-based plot for objects of class `"prc"`
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of
#' objects produced by [vegan::prc()].
#'
#' @details
#' TODO
#'
#' @param object an object inheriting from class `"prc"`, the
#' result of a call to [vegan::prc()].
#' @param select a logical vector where `TRUE` selects and
#' `FALSE` deselects species. Alternatively a numeric vector that
#' contains the indices selecting species. Note that these are with
#' respect to the original species matrix, \strong{not} the fortified
#' object.
#' @param xlab character; label for the x-axis
#' @param ylab character; label for the y-axis
#' @param title character; subtitle for the plot
#' @param subtitle character; subtitle for the plot
#' @param caption character; caption for the plot
#' @param legend.position character; position for the legend grob. See argument
#' `legend.position` in function [ggplot2::theme()].
#' @param ... Additional arguments passed to `\link{fortify.prc}`.
#'
#' @return Returns a ggplot object.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify ggplot geom_hline geom_rug geom_line theme
#'   scale_x_continuous labs aes
#'
#' @examples
#'
#' library("vegan")
#'
#' data(pyrifos)
#' week <- gl(11, 12, labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24))
#' dose <- factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6), 11))
#'
#' ## Fit PRC model
#' mod <- prc(pyrifos, dose, week)
#'
#' ## plot
#' want <- colSums(pyrifos) >= 300
#' autoplot(mod, select = want)
`autoplot.prc` <- function(
  object,
  select,
  xlab,
  ylab,
  title = NULL,
  subtitle = NULL,
  caption = NULL,
  legend.position = "top",
  ...
) {
  ## fortify the model object
  fobj <- fortify(object, ...)

  ## levels of factors - do this now before we convert things
  time_levs <- levels(fobj$time)
  treat_levs <- levels(fobj$treatment)

  ## convert time to a numeric
  fobj$time <- as.numeric(as.character(fobj$time))

  ## process select
  ind <- fobj$score != "Sample"
  if (missing(select)) {
    select <- rep(TRUE, sum(ind))
  } else {
    stopifnot(isTRUE(all.equal(length(select), sum(ind))))
  }

  ## samples and species "scores"
  samp <- fobj[!ind, ]
  spp <- fobj[ind, ][select, ]

  ## base plot
  plt <- ggplot(
    data = samp,
    aes(
      x = .data[["time"]],
      y = .data[["response"]],
      group = .data[["treatment"]],
      colour = .data[["treatment"]],
      linetype = .data[["treatment"]]
    )
  )
  ## add the control
  plt <- plt + geom_hline(yintercept = 0)
  ## add species rug
  plt <- plt +
    geom_rug(
      data = spp,
      sides = "r",
      mapping = aes(
        group = NULL,
        x = NULL,
        colour = NULL,
        linetype = NULL
      )
    )
  ## add the coefficients
  plt <- plt +
    geom_line() +
    theme(legend.position = legend.position) +
    scale_x_continuous(breaks = as.numeric(time_levs), minor_breaks = NULL)

  ## add labels
  if (missing(xlab)) {
    xlab <- "Time"
  }
  if (missing(ylab)) {
    ylab <- "Treatment"
  }
  plt <- plt +
    labs(
      x = xlab,
      y = ylab,
      title = title,
      subtitle = subtitle,
      caption = caption,
      colour = ylab,
      linetype = ylab
    )

  ## return
  plt
}
