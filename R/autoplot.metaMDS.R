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
##' @method autoplot metaMDS
##'
##' @importFrom grid arrow unit
##' @importFrom ggplot2 autoplot
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
                               aes(x = Dim1, y = Dim2, colour = Score))
    }
    if(missing(xlab))
        xlab <- dimlabels[2]
    if(missing(ylab))
        ylab <- dimlabels[2]
    plt <- plt + xlab(xlab) + ylab(ylab)
    ## add equal scaling
    plt <- plt + coord_fixed()
    plt
}
