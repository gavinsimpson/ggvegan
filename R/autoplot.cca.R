##' @title ggplot-based plot for objects of class \code{"cca"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of
##' objects produced by \code{\link[vegan]{cca}}, \code{link[vegan]{rda}},
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
##' @S3method autoplot cca
##' @method autoplot cca
##'
##' @importFrom grid arrow unit
##' @importFrom ggplot2 autoplot
##'
`autoplot.cca` <- function(object, geom = c("point","text"),
                           layers = c("species", "sites", "biplot", "centroids"),
                           ylab, xlab, const, ...) {
    obj <- fortify(object, ...)
    LAYERS <- levels(object$Score)
    dimlabels <- attr(obj, "dimlabels")
    obj <- split(obj, obj$Score)
    ## skeleton layer
    plt <- ggplot()
    geom <- match.arg(geom)
    point <- TRUE
    if (isTRUE(all.equal(geom, "text")))
        point <- FALSE
    ## remove biplot arrows for centroids if present
    if("biplot" %in% layers && "centroids" %in% layers) {
        bnam <- obj[["biplot"]][, "Label"]
        cnam <- obj[["centroids"]][, "Label"]
        obj[["biplot"]] <- obj[["biplot"]][!bnam %in% cnam, , drop = FALSE]
    }
    ## add plot layers as required
    if(all(c("species","sites") %in% layers)) {
        dat <- do.call(rbind, obj[c("species","sites")])
        if (point) {
            plt <- plt + geom_point(data = dat,
                                    aes(x = Dim1, y = Dim2, shape = Score,
                                        colour = Score))
        } else {
            plt <- plt + geom_text(data = dat,
                                   aes(x = Dim1, y = Dim2, label = Label,
                                       colour = Score))
        }
    } else {
        if("species" %in% layers) {
            if (point) {
                plt <- plt + geom_point(data = obj[["species"]],
                                        aes(x = Dim1, y = Dim2),
                                        shape = 2)
            } else {
                plt <- plt + geom_text(data = obj[["species"]],
                                       aes(x = Dim1, y = Dim2,
                                           label = Label))
            }
        }
        if("sites" %in% layers) {
            if (point) {
                plt <- plt + geom_point(data = obj[["sites"]],
                                        aes(x = Dim1, y = Dim2),
                                        shape = 1)
            } else {
                plt <- plt + geom_text(data = obj[["sites"]],
                                       aes(x = Dim1, y = Dim2,
                                           label = Label))
            }
        }
    }
    if("constraints" %in% layers) {
        if (point) {
            plt <- plt + geom_point(data = obj[["constraints"]],
                                    aes(x = Dim1, y = Dim2))
        } else {
            plt <- plt + geom_text(data = obj[["constraints"]],
                                   aes(x = Dim1, y = Dim2,
                                       label = Label))
        }
    }
    if("biplot" %in% layers) {
        if (length(layers) > 1) {
            mul <- vegan:::ordiArrowMul(obj[["biplot"]])
            obj[["biplot"]][, c("Dim1","Dim2")] <-
                mul * obj[["biplot"]][, c("Dim1","Dim2")]
        }
        col <- "navy"
        plt <- plt +
            geom_segment(data = obj[["biplot"]],
                         aes(x = 0, y = 0, xend = Dim1, yend = Dim2),
                         arrow = arrow(length = unit(0.2, "cm")),
                         colour = col)
        obj[["biplot"]][, c("Dim1","Dim2")] <-
            1.1 * obj[["biplot"]][, c("Dim1","Dim2")]
        plt <- plt + geom_text(data = obj[["biplot"]],
                               aes(x = Dim1, y = Dim2, label = Label))
    }
    if("centroids" %in% layers) {
        plt <- plt + geom_text(data = obj[["centroids"]],
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
