##' @title ggplot-based plot for objects of class \code{"renyi"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{renyi}}.
##'
##' @param object an object of class \code{renyi}, the result of a call to \code{\link[vegan]{renyi}}.
##' @param col character; colors of median diversity line and qunatiles envelope.
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

`autoplot.renyi` <- function(object, col = c("red","blue"), nrow = 3,
                             xlab = "Scale", ylab = "Diversity",
                             title = "Diversity at different scales",
                             subtitle = NULL, caption = NULL,
                             ...){
  if(length(col) != 2) {
    stop("Exactly two colors should be provided")
  }
  
  df <- fortify(object)
  
  if(is.data.frame(object)){
    df_levels <- data.frame(Scale = factor(levels(df$Scale),levels = levels(df$Scale)),
                            Med = tapply(df$Diversity,df$Scale,median),
                            Q0025 = tapply(df$Diversity,df$Scale,quantile,probs = 0.025),
                            Q0975 = tapply(df$Diversity,df$Scale,quantile,probs = 0.975))
    
    plt <- ggplot(df, aes_string("Scale","Diversity")) +
      geom_line(data = df_levels, aes_string("Scale","Med", group = 1), color = col[1], inherit.aes = FALSE) +
      geom_line(data = df_levels, aes_string("Scale","Q0025", group = 1), color = col[2], inherit.aes = FALSE) +
      geom_line(data = df_levels, aes_string("Scale","Q0975", group = 1), color = col[2], inherit.aes = FALSE) +
      geom_point() + facet_wrap(as.formula("~ Site"), nrow = nrow)
  } else {
    plt <- ggplot(df, aes_string("Scale","Diversity")) +
      geom_point()
  }
  plt <- plt + labs(x = xlab, y = ylab, title = title, subtitle = subtitle, caption = caption)
  plt
}
