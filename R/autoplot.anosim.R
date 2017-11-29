##' @title ggplot-based plot for objects of class \code{"anosim"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{anosim}}.
##'
##' @param object an object of class \code{"anosim"}, the result of a call to \code{\link[vegan]{anosim}}.
##' @param notch logical; make notched (default) or standard box plot?
##' @param varwidth logical; make box width proportional to to the square-roots of the number of observations in the groups (default) or standart box plot?
##' @param xlab character; label for the x-axis.
##' @param ylab character; label for the y-axis.
##' @param title character; title for the plot
##' @param subtitle character; subtitle for the plot
##' @param caption character; caption for the plot
##' @param show.stats logical; should R and p values be added to the plot.
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Didzis Elferts
##'
##' @export
##'
##' @importFrom ggplot2 ggplot autoplot geom_boxplot aes_string labs fortify annotate
##'
##' @examples
##'
##' data(dune)
##' data(dune.env)
##' dune.dist <- vegdist(dune)
##' dune.ano <- with(dune.env, anosim(dune.dist, Management))
##'
##' autoplot(dune.ano)

`autoplot.anosim` <- function(object, notch = TRUE, varwidth = TRUE, show.stats = TRUE,
                              xlab = NULL, ylab = NULL, title = "Results of analysis of similarities",
                              caption = NULL, subtitle = NULL, ...) {
  df <- fortify(object)
  
  plt <- ggplot(df, aes_string(x = "Class", y = "Rank")) +
    geom_boxplot(notch = notch, varwidth = varwidth) + 
    labs(x = xlab, y = ylab, title = title, caption = caption)
  
  if(isTRUE(show.stats)) {
    if (object$permutations) {
      pval <- format.pval(object$signif)
    }
    else {
      pval <- "not assessed"
    }
    rval <- round(object$statistic,3)
    plt <- plt + annotate("text", x = 0.5, y = max(df$Rank, na.rm = TRUE) *1.05, hjust = 0, vjust = 0,
                          label = paste("R = ", rval, ", ", "P = ", pval))
  }
  plt
}


