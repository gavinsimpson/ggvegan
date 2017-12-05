##' @title ggplot-based plot for objects of class \code{"renyiaccum"}
##'
##' @description Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{renyiaccum}}.
##'
##' @param object an object of class \code{renyiaccum}, the result of a call to \code{\link[vegan]{renyiaccum}}.
##' @param facet logical; should diversity values be shown in separate facets?
##' @param ribbon logical; show the quantile-based uncertainty interval? Uses \code{\link{geom_ribbon}} for plot.
##' @param ncol numeric; if facetting the plot, how many columns to use.
##' @param ribbon.alpha numeric; alpha transparency used for the uncertainty interval. Passed to the \code{alpha} aesthetic of \code{\link[ggplot2]{geom_ribbon}}.
##' @param xlab character; label for the x axis.
##' @param ylab character; label for the y axis.
##' @param title character; title for the plot.
##' @param subtitle character; subtitle for the plot.
##' @param caption character; caption for the plot.
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Didzis Elferts & Gavin L. Simpson
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
##' ## Turn off facetting; turns off ribbon too
##' autoplot(mod, facet = FALSE)

`autoplot.renyiaccum` <- function(object,
                                  facet = TRUE,
                                  ribbon = facet,
                                  ncol = NULL,
                                  ribbon.alpha = 0.3,
                                  xlab = "Sites", 
                                  ylab = "Diversity",
                                  title = "Diversity accumulation curves",
                                  subtitle = NULL, 
                                  caption = NULL,
                                  ...){

  df <- fortify(object, ...)
  
  ## base plot
  plt <- ggplot(df, aes_string("Sites","Mean", color = "Scale")) +
    geom_line() + scale_x_continuous(breaks = pretty_breaks())
  
  if (isTRUE(ribbon)) {
      plt <- plt +
        geom_ribbon(aes_string(ymin = "Lower", ymax = "Upper", x = "Sites", group = 1, fill = "Scale"),
                    alpha = ribbon.alpha, inherit.aes = FALSE)
    }
  ## are we facetting
  if (isTRUE(facet)) {
    if (is.null(ncol)) {
        ncol <- (nlevels(df[["Scale"]]) + 1) %/% 2
      }
      plt <- plt + facet_wrap("Scale", ncol = ncol)
    }
    
  plt <- plt + labs(x = xlab, y = ylab, title = title, subtitle = subtitle, caption = caption)
  plt
}

