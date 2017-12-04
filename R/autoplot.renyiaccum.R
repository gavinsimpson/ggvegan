##' @title ggplot-based plot for objects of class \code{"renyiaccum"}
##'
##' @description Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{renyiaccum}}.
##'
##' @param object an object of class \code{renyiaccum}, the result of a call to \code{\link[vegan]{renyiaccum}}.
##' @param col character; colors of mean diversity line and qunatiles envelope.
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
##' @importFrom ggplot2 ggplot autoplot geom_line geom_point aes_string labs fortify facet_wrap
##' @importFrom stats as.formula
##' @importFrom scales pretty_breaks
##'
##' @examples
##'
##' data(BCI)
##' i <- sample(nrow(BCI), 12)
##' mod <- renyiaccum(BCI[i,])
##'
##' autoplot(mod)

`autoplot.renyiaccum` <- function(object, col = c("red","blue"), nrow = 2,
                                  xlab = "Sites", ylab = "Diversity",
                                  title = "Diversity accumulation curves",
                                  subtitle = NULL, caption = NULL,
                                  ...){
  if(length(col) != 2) {
    stop("Exactly two colors should be provided")
  }
  
  df <- fortify(object)
  
  plt <- ggplot() +
    geom_line(data = df[df$Parameter == "mean",], aes_string("Sites","Diversity"), color = col[1]) +
    geom_line(data = df[df$Parameter == "Qnt 0.025",], aes_string("Sites","Diversity"), color = col[2]) +
    geom_line(data = df[df$Parameter == "Qnt 0.975",], aes_string("Sites","Diversity"), color = col[2]) +
    facet_wrap(as.formula("~ Scale"), nrow = nrow) + 
    scale_x_continuous(breaks= pretty_breaks()) + 
    labs(x = xlab, y = ylab, title = title, subtitle = subtitle, caption = caption)
  plt
}

