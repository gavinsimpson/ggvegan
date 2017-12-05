##' @title ggplot-based plot for objects of class \code{"renyi"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{renyi}}.
##'
##' @param object an object of class \code{renyi}, the result of a call to \code{\link[vegan]{renyi}}.
##' @param facet logical; should diversity values be shown in separate facets if more than one site present?
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
##' @importFrom ggplot2 ggplot autoplot geom_line aes_string labs fortify theme element_blank facet_wrap
##' @importFrom stats as.formula median quantile
##'
##' @examples
##'
##' data(BCI)
##' i <- sample(nrow(BCI), 12)
##' mod <- renyi(BCI[i,])
##'
##' autoplot(mod)

`autoplot.renyi` <- function(object,
                             facet = TRUE,
                             ribbon = TRUE,
                             ncol = NULL,
                             ribbon.alpha = 0.3,
                             xlab = "Scale", 
                             ylab = "Diversity",
                             title = "Diversity at different scales",
                             subtitle = NULL, 
                             caption = NULL,
                             ...){
  
  df <- fortify(object, ...)
  
  ## base plot
  plt <- ggplot(df, aes_string("Scale","Diversity")) +
    geom_point(aes_string(color = "Site"))
  
  ## calculate median and quantiles if more than one site present
  if(is.data.frame(object)){
    df_levels <- data.frame(Scale = factor(levels(df$Scale),levels = levels(df$Scale)),
                            Med = tapply(df$Diversity,df$Scale,median),
                            Lower = tapply(df$Diversity,df$Scale,quantile,probs = 0.025),
                            Upper = tapply(df$Diversity,df$Scale,quantile,probs = 0.975))
    ## add mean line to plot
    plt <- plt + geom_line(data = df_levels, aes_string("Scale","Med", group = 1), inherit.aes = FALSE)
    
    if (isTRUE(ribbon)) {
      plt <- plt +
        geom_ribbon(data = df_levels, aes_string(ymin = "Lower", ymax = "Upper", x = "Scale", group = 1),
                    alpha = ribbon.alpha, inherit.aes = FALSE)
    }
    ## are we facetting
    if (isTRUE(facet)) {
      if (is.null(ncol)) {
        ncol <- (nlevels(df[["Site"]]) + 2) %/% 3
      }
      plt <- plt + facet_wrap("Site", ncol = ncol)
    }
  }
  plt <- plt + labs(x = xlab, y = ylab, title = title, subtitle = subtitle, caption = caption)
  plt
}
