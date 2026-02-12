#' @title ggplot-based plot for objects of class \code{'rda'}
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{rda}}.
#'
#' @details
#' TODO
#'
#' @param object an object of class \code{"rda"}, the result of a call to \code{\link[vegan]{rda}}
#' @param axes numeric; which axes to plot, given as a vector of length 2.
#' @param geom character; which geoms to use for the layers. Can be a vector of
#'   up to length 2, in which case, the first element of \code{geom} will be
#'   used for any site scores (both weighted sum or linear combination scores),
#'   and the second element will be used for species scores. The latter will be
#'   ignored if \code{arrows = TRUE}.
#' @param layers character; which scores to plot as layers
#' @param arrows logical; represent species (variables) using vectors?
#' @param legend.position character or two-element numeric vector; where to position the legend. See \code{\link[ggplot2]{theme}} for details. Use \code{"none"} to not draw the legend.
#' @param xlab character; label for the x-axis
#' @param ylab character; label for the y-axis
#' @param title character; subtitle for the plot
#' @param subtitle character; subtitle for the plot
#' @param caption character; caption for the plot
#' @param const General scaling constant to \code{rda} scores. See
#'   \code{\link[vegan]{scores.rda}} for details.
#' @param ... Additional arguments passed to \code{\link{fortify.cca}}.
#'
#' @return Returns a ggplot object.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom grid arrow unit
#' @importFrom ggplot2 autoplot ggplot geom_point geom_text geom_segment labs coord_fixed aes_string
#'
#' @examples
#'
#' library("vegan")
#'
#' data(dune)
#'
#' pca <- rda(dune)
#' autoplot(pca)
#'
#' ## Just the species scores
#' autoplot(pca, layers = "species")
`autoplot.rda` <- function(object, axes = c(1,2), geom = c("point", "text"),
                           layers = c("species", "sites", "biplot", "centroids"),
                           arrows = TRUE, legend.position = "right",
                           title = NULL, subtitle = NULL, caption = NULL,
                           ylab, xlab, const, ...) {
    ## determine which layers to plot
    valid <- valid_layers(object)       # vector of valid layers
    ok_layers <- check_user_layers(layers, valid, message = TRUE)
    layers <- layers[ok_layers]         # subset user-supplied layers
    draw_list <- layer_draw_list(valid, layers) # what are we drawing

    ## fix-up axes needed to plot
    laxes <- length(axes)
    if (laxes != 2L) {
        if (laxes > 2L) {
            axes <- rep(axes, length.out = 2L)  # shrink to required length
        } else {
            stop("Need 2 ordination axes to plot; only 1 was given.",
                 call. = FALSE)
        }
    }

    obj <- fortify(object, axes = axes, const = const, ...) # grab some scores
    available <- levels(obj[["score"]])
    draw_list <- layer_draw_list(valid, layers, available) # what are we drawing
    layer_names <- names(draw_list)[draw_list]

    ## sort out x, y aesthetics
    vars <- get_dimension_names(obj)

    ## process geom arg
    geom <- match.arg(geom, several.ok = TRUE)
    geom <- unique(geom)    # simplify geom if elements are the same

    ## subset out the layers wanted
    obj <- obj[obj[["score"]] %in% layer_names, , drop = FALSE]

    ## skeleton layer
    plt <- ggplot()

    ## draw sites, species, constraints == lc site scores
    if (any(draw_list[c("species","sites","constraints")])) {
        plt <- add_spp_site_scores(obj, plt, vars, geom, draw_list, arrows)
    }

    ## remove biplot arrows for centroids if present
    if(all(draw_list[c("biplot","centroids")])) {
        want <- obj[["score"]] == "biplot"
        tmp <- obj[want, ]
        obj <- obj[!want, ]
        bnam <- tmp[, "label"]
        cnam <- obj[obj[["score"]] == "centroids", "label"]
        obj <- rbind(obj, tmp[!bnam %in% cnam, , drop = FALSE])
    }

    if(isTRUE(draw_list["biplot"])) {
        want <- obj[["score"]] == "biplot"
        if (any(want)) {
            if (length(layer_names) > 1) {
                mul <- arrow_mul(obj[want, vars, drop = FALSE],
                                obj[!want, vars, drop = FALSE])
                obj[want, vars] <- mul * obj[want, vars]
            }
            col <- "navy"
            plt <- plt +
                geom_segment(data = obj[want, , drop = FALSE ],
                            aes_string(x = 0, y = 0,
                                        xend = vars[1], yend = vars[2]),
                            arrow = arrow(length = unit(0.2, "cm")),
                            colour = col)
            obj[want, vars] <- 1.1 * obj[want, vars]
            plt <- plt + geom_text(data = obj[want, , drop = FALSE ],
                                aes_string(x = vars[1], y = vars[2],
                                            label = 'label'))
        }
    }

    if(isTRUE(draw_list["centroids"])) {
        want <- obj[["score"]] == "centroids"
        if (any(want)) {
            plt <- plt +
                geom_text(data = obj[want, , drop = FALSE],
                        aes_string(x = vars[1], y = vars[2], label = 'label'),
                        colour = "navy")
        }
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
