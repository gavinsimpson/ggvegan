##' @title ggplot-based plot for objects of class \code{"radline"}
##'
##' @description Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{rad.null}}, \code{\link[vegan]{rad.preempt}}, \code{\link[vegan]{rad.lognormal}}, \code{\link[vegan]{rad.zipf}} or \code{\link[vegan]{rad.zipfbrot}}.
##'
##' @param object an object of class \code{radline}.
##' @param log character; use logarithmic scale for "x" or "y", "xy" makes both axis logarthmic and "none" use original scale.
##' @param xlab character; label for the x axis.
##' @param ylab character; label for the y axis.
##' @param title character; title for the plot.
##' @param subtitle character; subtitle for the plot.
##' @param caption character; caption for the plot.
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Didzis Elferts
##'
##' @export
##'
##' @importFrom ggplot2 ggplot autoplot geom_line aes_string labs fortify scale_x_log10 scale_y_log10
##'
##' @examples
##'
##' data(BCI)
##' mod <- rad.lognormal(BCI[5,])
##'
##' autoplot(mod)

`autoplot.radline` <- function(object, log = "y",
                                 xlab = "Rank", ylab = "Abundance",
                                 title = "Species abundance against species rank",
                                 subtitle = NULL, caption = NULL,
                                 ...) {

  if (length(object$y) == 0) 
    stop("No species, nothing to plot")
  if (length(object$y) == 1) 
    stop("There is only one species, nothing to plot")
  
  df <- fortify(object)
  log <- match.arg(log, c("x","y","xy","none"))
  
  plt <- ggplot() +
    geom_point(data = df[df$Type == "Observed",], aes_string(x = "Rank", y = "Abundance")) +
    geom_line(data = df[df$Type == "Fitted",], aes_string(x = "Rank", y = "Abundance")) +
    labs(x = xlab, y = ylab, title = title, caption = caption)
  if(log == "x") {
    plt <- plt + scale_x_log10()
  }
  if(log == "y") {
    plt <- plt + scale_y_log10()
  }
  if(log == "xy") {
    plt <- plt + scale_x_log10() + scale_y_log10()
  }
  plt
}


