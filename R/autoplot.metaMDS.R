#' @title ggplot-based plot for objects of class \code{"metaMDS"}
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of
#' objects produced by \code{\link[vegan]{metaMDS}}.
#'
#' @details
#' TODO
#'
#' @param object an object of class \code{"metaMDS"}, the result of a call
#' to \code{\link[vegan]{metaMDS}}.
#' @param axes numeric; which axes to plot, given as a vector of length 2.
#' @param geom character; which geoms to use for the layers. Can be a
#' vector of length equal to \code{length(display)}, in which case the
#' \emph{i}th element of \code{type} refers to the \emph{i}th element
#' of \code{display}.
#' @param layers character; which scores to plot as layers
#' @param legend.position character or two-element numeric vector; where to position the legend. See \code{\link[ggplot2]{theme}} for details. Use \code{"none"} to not draw the legend.
#' @param xlab character; label for the x-axis
#' @param ylab character; label for the y-axis
#' @param title character; subtitle for the plot
#' @param subtitle character; subtitle for the plot
#' @param caption character; caption for the plot
#' @param ... Additional arguments passed to \code{\link{fortify.metaMDS}}.
#'
#' @return Returns a ggplot object.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom grid arrow unit
#' @importFrom ggplot2 autoplot ggplot geom_point geom_text labs coord_fixed aes_string
#'
#' @examples
#' ## load example data
#' data(dune)
#'
#' sol <- metaMDS(dune)
#' autoplot(sol)
`autoplot.metaMDS` <- function(object, axes = c(1,2), geom = c("point","text"),
                               layers = c("species", "sites"),
                               legend.position = "right",
                               title = NULL, subtitle = NULL, caption = NULL,
                               ylab, xlab, ...) {
    axes <- rep(axes, length.out = 2L)
    obj <- fortify(object, axes = axes, ...)
    obj <- obj[obj$score %in% layers, ]
    ## sort out x, y aesthetics
    vars <- getDimensionNames(obj)
    ## skeleton layer
    plt <- ggplot()
    geom <- match.arg(geom)
    point <- TRUE
    if (isTRUE(all.equal(geom, "text"))) {
        point <- FALSE
    }
    if (point) {
        plt <- plt + geom_point(data = obj,
                                aes_string(x = vars[1], y = vars[2], shape = 'score',
                                           colour = 'score'))
    } else {
        plt <- plt + geom_text(data = obj,
                               aes_string(x = vars[1], y = vars[2], label = 'label',
                                          colour = 'score'))
    }
    if(missing(xlab)) {
        xlab <- vars[1]
    }
    if(missing(ylab)) {
        ylab <- vars[2]
    }
    plt <- plt + labs(x = xlab, y = ylab, title = title, subtitle = subtitle,
                      caption = caption)
    ## add equal scaling
    plt <- plt + coord_fixed(ratio = 1)
    ## do we want a legend
    plt <- plt + theme(legend.position = legend.position)
    plt
}
