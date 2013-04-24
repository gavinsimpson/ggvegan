##' @title ggplot-based plot for objects of class \code{"cca"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of
##' objects produced by \code{\link[vegan]{cca}}, \code{\link[vegan]{rda}},
##' or \code{\link[vegan]{capscale}}.
##'
##' @details
##' TODO
##'
##' @param object an object of class \code{"cca"}, the result of a call
##' to \code{\link[vegan]{cca}}.
##' @param geom character; which geoms to use for the layers. Can be a
##' vector of length equal to \code{length(display)}, in which case the
##' \emph{i}th element of \code{type} refers to the \emph{i}th element
##' of \code{display}.
##' @param layers character; which scores to plot as layers
##' @param xlab character; label for the x-axis
##' @param ylab character; label for the y-axis
##' @param const General scaling constant to \code{rda} scores. See
##' \code{\link[vegan]{plot.cca}} for details.
##' @param ... Additional arguments passed to \code{\link{fortify.cca}}.
##' @return Returns a ggplot object.
##' @author Gavin L. Simpson
##'
##' @export
##' @method autoplot cca
##'
##' @importFrom grid arrow unit
##' @importFrom ggplot2 autoplot
##'
##' @examples
##' data(dune)
##' data(dune.env)
##'
##' sol <- cca(dune ~ A1 + Management, data = dune.env)
##' autoplot(sol)
`autoplot.cca` <- function(object, geom = c("point","text"),
                           layers = c("species", "sites", "biplot", "centroids"),
                           ylab, xlab, const, ...) {
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
    ## remove biplot arrows for centroids if present
    if(all(c("biplot","centroids") %in% LAYERS)) {
        want <- obj$Score == "biplot"
        tmp <- obj[want, ]
        obj <- obj[!want, ]
        bnam <- tmp[, "Label"]
        cnam <- obj[obj$Score == "centroids", "Label"]
        obj <- rbind(obj, tmp[!bnam %in% cnam, , drop = FALSE])
    }
    if(any(want <- obj$Score == "constraints")) {
        if (point) {
            plt <- plt + geom_point(data = obj[want, , drop = FALSE ],
                                    aes(x = Dim1, y = Dim2))
        } else {
            plt <- plt + geom_text(data = obj[want, , drop = FALSE ],
                                   aes(x = Dim1, y = Dim2,
                                       label = Label))
        }
    }
    if(any(want <- obj$Score == "biplot")) {
        if (length(layers) > 1) {
            mul <- vegan:::ordiArrowMul(obj[want, , drop = FALSE ])
            obj[want, c("Dim1","Dim2")] <- mul * obj[want, c("Dim1","Dim2")]
        }
        col <- "navy"
        plt <- plt +
            geom_segment(data = obj[want, , drop = FALSE ],
                         aes(x = 0, y = 0, xend = Dim1, yend = Dim2),
                         arrow = arrow(length = unit(0.2, "cm")),
                         colour = col)
        obj[want, c("Dim1","Dim2")] <- 1.1 * obj[want, c("Dim1","Dim2")]
        plt <- plt + geom_text(data = obj[want, , drop = FALSE ],
                               aes(x = Dim1, y = Dim2, label = Label))
    }
    if(any(want <- obj$Score == "centroids")) {
        plt <- plt + geom_text(data = obj[want, , drop = FALSE ],
                               aes(x = Dim1, y = Dim2, label = Label),
                               colour = "navy")
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
