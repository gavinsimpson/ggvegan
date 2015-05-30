##' @title ggplot-based plot for objects of class \code{"cca"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{rda}}.
##'
##' @details
##' TODO
##'
##' @param object an object of class \code{"rda"}, the result of a call to \code{\link[vegan]{rda}}
##' @param geom character; which geoms to use for the layers. Can be a vector of length equal to \code{length(display)}, in which case the \emph{i}th element of \code{type} refers to the \emph{i}th element of \code{display}.
##' @param layers character; which scores to plot as layers
##' @param arrows logical; represent species (variables) using vectors?
##' @param xlab character; label for the x-axis
##' @param ylab character; label for the y-axis
##' @param const General scaling constant to \code{rda} scores. See \code{\link[vegan]{plot.cca}} for details.
##' @param ... Additional arguments passed to \code{\link{fortify.cca}}.
##'
##' @return Returns a ggplot object.
##'
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom grid arrow unit
##' @importFrom ggplot2 autoplot ggplot geom_point geom_text geom_segment xlab ylab coord_fixed aes
##'
##' @examples
##'
##' data(dune)
##'
##' pca <- rda(dune)
##' autoplot(pca, arrows = TRUE)
##'
##' ## Just the species scores
##' autoplot(pca, arrows = TRUE, display = "species")
##'
`autoplot.rda` <- function(object, geom = c("point", "text"),
                           layers = c("species", "sites", "biplot", "centroids"),
                           arrows = TRUE,
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
    take <- if (isTRUE(arrows)) {
        "sites"
    } else {
        c("species", "sites")
    }
    want <- obj$Score %in% take
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
    ## Draw species (variables) as arrows?
    if (isTRUE(arrows)) {
        want <- obj$Score == "species"
        pdat <- obj[want, , drop = FALSE]
        col <- "black"
        want <- obj[["Score"]] == "species"
        plt <- plt +
            geom_segment(data = pdat,
                         aes(x = 0, y = 0, xend = Dim1, yend = Dim2),
                         arrow = arrow(length = unit(0.2, "cm")),
                         colour = col)
        pdat[, c("Dim1", "Dim2")] <- 1.1 * pdat[, c("Dim1", "Dim2"), drop = FALSE]
        plt <- plt + geom_text(data = pdat,
                               aes(x = Dim1, y = Dim2, label = Label))
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
            mul <- arrowMul(obj[want, c("Dim1","Dim2"), drop = FALSE],
                            obj[!want, c("Dim1","Dim2"), drop = FALSE])
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
        xlab <- dimlabels[1]
    if(missing(ylab))
        ylab <- dimlabels[2]
    plt <- plt + xlab(xlab) + ylab(ylab)
    ## add equal scaling
    plt <- plt + coord_fixed()
    plt
}
