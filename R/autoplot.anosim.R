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
##' @param subtitle logical; should subtitle with R and p values be added.
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Didzis Elferts
##'
##' @export
##'
##' @importFrom ggplot2 ggplot autoplot geom_boxplot aes_string labs fortify
##'
##' @examples
##'
##' data(dune)
##' data(dune.env)
##' dune.dist <- vegdist(dune)
##' attach(dune.env)
##' dune.ano <- anosim(dune.dist, Management)
##'
##' autoplot(dune.ano)

`autoplot.anosim` <- function(object, notch = TRUE, varwidth = TRUE, subtitle = TRUE,
                              xlab = NULL, ylab = NULL, ...) {
  ranks <- fortify(object, what = "ranks")
  df.title <- fortify(object, what = "stats")
  
  plt <- ggplot(ranks, aes_string(x = "Class", y = "Rank")) +
    geom_boxplot(notch = notch, varwidth = varwidth) + 
    labs(x = xlab, y = ylab)
  if(subtitle == TRUE) {
    plt = plt + labs(subtitle = paste("R = ", df.title$Value[2], ", ", "P = ", df.title$Value[1]))
  }
  plt
}


