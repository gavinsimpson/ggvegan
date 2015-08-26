## help codetools "find" variables - i.e. ignore the warnings in the
## ggplot() calls below - doing this on per-function basis in case
## R goes that way in the future. As ?globalVariables states, this
## is really active at the package level
if(getRversion() >= "2.15.1") {
    utils::globalVariables(c("Dim1", "Dim2", "Score", "Label"))
}
## end help codetools

##' @title ggplot-based plot for objects of class \code{"metaMDS"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of
##' objects produced by \code{\link[vegan]{metaMDS}}.
##'
##' @details
##' TODO
##'
##' @param object an object of class \code{"metaMDS"}, the result of a call
##' to \code{\link[vegan]{metaMDS}}.
##' @param geom character; which geoms to use for the layers. Can be a
##' vector of length equal to \code{length(display)}, in which case the
##' \emph{i}th element of \code{type} refers to the \emph{i}th element
##' of \code{display}.
##' @param layers character; which scores to plot as layers
##' @param xlab character; label for the x-axis
##' @param ylab character; label for the y-axis
##' @param ... Additional arguments passed to \code{\link{fortify.metaMDS}}.
##'
##' @return Returns a ggplot object.
##'
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom grid arrow unit
##' @importFrom ggplot2 autoplot ggplot geom_point geom_text xlab ylab coord_fixed
##'
##' @examples
##' ## load example data
##' data(dune)
##'
##' sol <- metaMDS(dune)
##' autoplot(sol)
`autoplot.metaMDS` <- function(object, geom = c("point","text"),
                               layers = c("species", "sites"),
                               ylab, xlab, ...) {
    obj <- fortify(object, ...)
    obj <- obj[obj$Score %in% layers, ]
    dimlabels <- attr(obj, "dimlabels")
    ## skeleton layer
    plt <- ggplot()
    geom <- match.arg(geom)
    point <- TRUE
    if (isTRUE(all.equal(geom, "text")))
        point <- FALSE
    if(point) {
        plt <- plt + geom_point(data = obj,
                                aes(x = Dim1, y = Dim2, shape = Score,
                                    colour = Score))
    } else {
        plt <- plt + geom_text(data = obj,
                               aes(x = Dim1, y = Dim2, label = Label,
                                   colour = Score))
    }
    if(missing(xlab))
        xlab <- dimlabels[1]
    if(missing(ylab))
        ylab <- dimlabels[2]
    plt <- plt + xlab(xlab) + ylab(ylab)
    ## add equal scaling
    plt <- plt + coord_fixed(ratio = 1)
    plt
}
