##' @title ggplot-based plot for objects of class \code{"anosim"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{anosim}}.
##'
##' @param object an object of class \code{"anosim"}, the result of a call to \code{\link[vegan]{anosim}}.
##' @param notch logical; make notched (default) or standard box plot?
##' @param varwidth logical; make box width proportional to to the square-roots of the number of observations in the groups (default) or standart box plot?
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Didzis Elferts
##'
##' @export
##'
##' @importFrom ggplot2 ggplot autoplot geom_boxplot aes_string labs fortify theme element_blank
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

`autoplot.anosim` <- function(object, notch = TRUE,
                              varwidth = TRUE, ...) {
  ranks <- fortify(object, what = "ranks")
  df.title <- fortify(object, what = "stats")
  
  plt <- ggplot(ranks, aes_string(x = "Class", y = "Rank")) +
    geom_boxplot(notch = notch, varwidth = varwidth) + 
          labs(subtitle = paste("R = ", df.title$Value[2], ", ", "P = ", df.title$Value[1])) +
    theme(axis.title = element_blank())
  plt
}


