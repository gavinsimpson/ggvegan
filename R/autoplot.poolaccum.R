##' @title ggplot-based plot for objects of class \code{"poolaccum"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{poolaccum}}.
##'
##' @param object an object of class \code{"poolaccum"}, the result of a call to \code{\link[vegan]{poolaccum}}.
##' @param alpha numeric; level of quantiles for envelopes shown (default 0.05).
##' @param col character; colors of mean Richness line and qunatiles envelope.
##' @param nrow numeric; number of rows in faceted plot.
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
##' @importFrom ggplot2 ggplot autoplot geom_line aes_string labs fortify facet_wrap
##' @importFrom stats as.formula
##'
##' @examples
##'
##' data(BCI)
##' pool <- poolaccum(BCI)
##'
##' autoplot(pool)

`autoplot.poolaccum` <- function(object, alpha = 0.05, col = c("red","blue"), nrow = 2,
                                 xlab = "Size", ylab = "Richness",
                                 title = "Accumulated species richness in a species pool",
                                 subtitle = NULL, caption = NULL,
                                 ...) {
  if(length(col) != 2) {
    stop("Exactly two colors should be provided")
  } 
  
  df <- fortify(object, alpha = alpha)
  
  plt <- ggplot(df, aes_string(x = "Size")) +
    geom_line(aes_string(y = "Richness"), color = col[1]) +
    geom_line(aes_string(y = "Lower"), color = col[2]) +
    geom_line(aes_string(y = "Upper"), color = col[2]) +
    facet_wrap(as.formula("~ Index"), nrow = nrow) +
    labs(x = xlab, y = ylab, title = title, subtitle = subtitle, caption = caption)
  plt
}


