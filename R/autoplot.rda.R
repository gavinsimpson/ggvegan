##' @title ggplot-based plot for objects of class \code{'rda'}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{rda}}.
##'
##' @details
##' TODO
##'
##' @param object an object of class \code{"rda"}, the result of a call to \code{\link[vegan]{rda}}
##' @param axes numeric; which axes to plot, given as a vector of length 2.
##' @param geom character; which geoms to use for the layers. Can be a vector of length equal to \code{length(display)}, in which case the \emph{i}th element of \code{type} refers to the \emph{i}th element of \code{display}.
##' @param layers character; which scores to plot as layers
##' @param arrows logical; represent species (variables) using vectors?
##' @param legend.position character or two-element numeric vector; where to position the legend. See \code{\link[ggplot2]{theme}} for details. Use \code{"none"} to not draw the legend.
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
##' @importFrom ggplot2 autoplot ggplot geom_point geom_text geom_segment labs coord_fixed aes_string
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
`autoplot.rda` <- function(object, axes = c(1,2), geom = c("point", "text"),
                           layers = c("species", "sites", "biplot", "centroids"),
                           arrows = TRUE, legend.position = "right",
                           ylab, xlab, const, ...) {
    axes <- rep(axes, length.out = 2L)
    obj <- fortify(object, axes = axes, ...)
    LAYERS <- levels(obj$Score)
    ## sort out x, y aesthetics
    vars <- names(obj)[-c(1,2)]
    ## match the geom
    geom <- match.arg(geom)
    point <- TRUE
    if (isTRUE(all.equal(geom, "text"))) {
        point <- FALSE
    }
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
                       aes_string(x = vars[1], y = vars[2], shape = 'Score',
                                  colour = 'Score'))
    } else {
        plt <- plt +
            geom_text(data = obj[want, , drop = FALSE ],
                      aes_string(x = vars[1], y = vars[2], label = 'Label',
                                 colour = 'Score'), size = 3)
    }
    ## Draw species (variables) as arrows?
    if (isTRUE(arrows)) {
        want <- obj$Score == "species"
        pdat <- obj[want, , drop = FALSE]
        col <- "black"
        want <- obj[["Score"]] == "species"
        plt <- plt +
            geom_segment(data = pdat,
                         aes_string(x = 0, y = 0, xend = vars[1], yend = vars[2]),
                         arrow = arrow(length = unit(0.2, "cm")),
                         colour = col)
        pdat[, vars] <- 1.1 * pdat[, vars, drop = FALSE]
        plt <- plt + geom_text(data = pdat,
                               aes_string(x = vars[1], y = vars[2], label = 'Label'), size = 4)
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
                                    aes_string(x = vars[1], y = vars[2]))
        } else {
            plt <- plt + geom_text(data = obj[want, , drop = FALSE ],
                                   aes_string(x = vars[1], y = vars[2],
                                              label = 'Label'))
        }
    }
    if(any(want <- obj$Score == "biplot")) {
        if (length(layers) > 1) {
            mul <- arrowMul(obj[want, vars, drop = FALSE],
                            obj[!want, vars, drop = FALSE])
            obj[want, vars] <- mul * obj[want, vars]
        }
        col <- "navy"
        plt <- plt +
            geom_segment(data = obj[want, , drop = FALSE ],
                         aes_string(x = 0, y = 0, xend = vars[1], yend = vars[2]),
                         arrow = arrow(length = unit(0.2, "cm")),
                         colour = col)
        obj[want, vars] <- 1.1 * obj[want, vars]
        plt <- plt + geom_text(data = obj[want, , drop = FALSE ],
                               aes_string(x = vars[1], y = vars[2], label = 'Label'))
    }
    if(any(want <- obj$Score == "centroids")) {
        plt <- plt + geom_text(data = obj[want, , drop = FALSE ],
                               aes_string(x = vars[1], y = vars[2], label = 'Label'),
                               colour = "navy")
    }
    if(missing(xlab)) {
        xlab <- vars[1]
    }
    if(missing(ylab)) {
        ylab <- vars[2]
    }
    plt <- plt + labs(x = xlab, y = ylab)
    ## add equal scaling
    plt <- plt + coord_fixed(ratio = 1)
    ## do we want a legend
    plt <- plt + theme(legend.position = legend.position)
    plt
}
