## help codetools "find" variables - i.e. ignore the warnings in the
## ggplot() calls below - doing this on per-function basis in case
## R goes that way in the future. As ?globalVariables states, this
## is really active at the package level
if(getRversion() >= "2.15.1") {
  utils::globalVariables(c("Dim1", "Dim2", "Score", "Label"))
}
## end help codetools

##' @title ggplot-based plot for objects of class \code{"wcmdscale"}
##'
##' @description
##' Produces a  ggplot object representing the output of
##' objects produced by \code{\link[vegan]{wcmdscale}}.
##'
##' @details
##' TODO
##'
##' @param object an object of class \code{"wcmdscale"}, the result of a call
##' to \code{\link[vegan]{wcmdscale}} with eig = TRUE.
##' @param geom character; which geoms to use for the layer.
##' @param xlab character; label for the x-axis
##' @param ylab character; label for the y-axis
##' @param ... Additional arguments passed to \code{\link{fortify.wcmdscale}}.
##'
##' @return Returns a ggplot object.
##'
##' @author Eduard Szoecs eduardszoecs@@gmail.com
##'
##' @export
##'
##' @importFrom grid arrow unit
##' @importFrom ggplot2 autoplot ggplot geom_point geom_text xlab ylab coord_fixed
##'
##' @examples
##' ## load example data
##' data(dune)
##' d <- vegdist(decostand(dune, method = 'pa'), method = 'jaccard')
##' ord <- wcmdscale(d, eig = TRUE)
##' autoplot(ord)
##'  autoplot(ord, geom = 'text')
`autoplot.wcmdscale` <- function(object, geom = c("point","text"),
                               ylab, xlab, ...) {
  obj <- fortify(object, ...)
  dimlabels <- attr(obj, "dimlabels")
  eig <- attr(obj, 'eig')
  tot.chi <- sum(eig)
  expl <- round(eig / tot.chi * 100, 2)
  
  ## skeleton layer
  plt <- ggplot()
  geom <- match.arg(geom)
  point <- TRUE
  if (isTRUE(all.equal(geom, "text")))
    point <- FALSE
  if(point) {
    plt <- plt + geom_point(data = obj,
                            aes(x = Dim1, y = Dim2))
  } else {
    plt <- plt + geom_text(data = obj,
                           aes(x = Dim1, y = Dim2, label = Label))
  }
  if(missing(xlab))
    xlab <- dimlabels[1]
  if(missing(ylab))
    ylab <- dimlabels[2]
  xlab <- paste0(xlab, ' (', expl[1] , '%)')
  ylab <- paste0(ylab, ' (', expl[2] , '%)')
  plt <- plt + xlab(xlab) + ylab(ylab)
  ## add equal scaling
  plt <- plt + coord_fixed(ratio = 1)
  plt
}