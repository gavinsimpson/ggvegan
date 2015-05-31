##' @title ggplot-based plot for objects of class \code{"decorana"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{decorana}}.
##'
##' @details
##' TODO
##'
##' @param object an object of class \code{"decorana"}, the result of a call to \code{\link[vegan]{decorana}}.
##' @param geom character; which geoms to use for the layers. Can be a
##' vector of length equal to \code{length(display)}, in which case the
##' \emph{i}th element of \code{type} refers to the \emph{i}th element
##' of \code{display}.
##' @param layers character; which scores to plot as layers
##' @param xlab character; label for the x-axis
##' @param ylab character; label for the y-axis
##' @param ... Additional arguments passed to \code{\link{fortify.deocrana}}.
##' @return Returns a ggplot object.
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom grid arrow unit
##' @importFrom ggplot2 autoplot ggplot geom_point geom_text geom_segment xlab ylab coord_fixed aes
##'
##' @examples
##' data(dune)
##'
##' sol <- decorana(dune)
##' autoplot(sol)
##' autoplot(sol, display = "species", geom = "text")
`autoplot.decorana` <- function(object, geom = c("point", "text"),
                                layers = c("species", "sites"),
                                ylab, xlab, ...) {
    obj <- fortify(object, ...)
    LAYERS <- levels(obj$Score)
    dimlabels <- attr(obj, "dimlabels")
    ## match the geom
    geom <- match.arg(geom)
    point <- TRUE
    if (isTRUE(all.equal(geom, "text")))
        point <- FALSE
    ## subset out the layers wanted
    ### need something here first to match acceptable ones?
    ### or just check that the layers selected would return a df with
    ### at least 1 row.
    obj <- obj[obj$Score %in% layers, , drop = FALSE]
    ## skeleton layer
    plt <- ggplot()
    ## add plot layers as required
    want <- obj$Score %in% c("species", "sites")
    if (point) {
        plt <- plt +
            geom_point(data = obj[want, , drop = FALSE ],
                       aes(x = Dim1, y = Dim2, shape = Score,
                           colour = Score))
    } else {
        plt <- plt +
            geom_text(data = obj[want, , drop = FALSE ],
                      aes(x = Dim1, y = Dim2, label = Label,
                          colour = Score))
    }
    if(missing(xlab))
        xlab <- dimlabels[1]
    if(missing(ylab))
        ylab <- dimlabels[2]
    plt <- plt + xlab(xlab) + ylab(ylab)
    ## add equal scaling
    plt <- plt + coord_fixed()
    plt
}
