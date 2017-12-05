##' @title ggplot-based plot for \code{envfit} objects
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{isomap}}.
##' @param object an object of class \code{"envfit"}, the result of a call to \code{\link[vegan]{envfit}}.
##' @param geom character; which geom to use to label vectors and factor centroids.
##' @param line.col colour with which to draw vectors.
##' @param xlab character; label for the x-axis.
##' @param ylab character; label for the y-axis.
##' @param title character; subtitle for the plot.
##' @param subtitle character; subtitle for the plot.
##' @param caption character; caption for the plot.
##' @param ... additional arguments passed to \code{\link{fortify}}.
##' @return A ggplot object.
##'
##' @importFrom ggplot2 autoplot fortify geom_segment geom_text geom_label aes_string labs coord_fixed
##' @importFrom ggrepel geom_text_repel geom_label_repel
##'
##' @export
##'
##' @author Gavin L. Simpson
##'
##' @examples
##' data(varespec, varechem)
##' ord1 <- metaMDS(varespec)
##' fit1 <- envfit(ord1, varechem, perm = 199)
##'
##' autoplot(fit1, geom = 'label_repel')
##'
##' data(dune, dune.env)
##' ord2 <- cca(dune)
##' fit2 <- envfit(ord2 ~ Moisture + A1, dune.env, perm = 199)
##'
##' autoplot(fit2)
`autoplot.envfit` <- function(object,
                              geom = c("label","text","label_repel","text_repel"),
                              line.col = 'black',
                              xlab = NULL, ylab = NULL, title = NULL, 
                              subtitle = NULL, caption = NULL, ...) {
    geom <- match.arg(geom)

    df <- fortify(object, ...)

    plt <- ggplot()

    ind <- df[['Type']] == 'Vector'
    vs <- df[ind, ]
    fs <- df[!ind, ]

    vars <- names(df)[-c(1:2)]

    ## add segment layer for arrows
    if (NROW(vs) > 0L) {
        plt <- plt + geom_segment(data = vs,
                                  mapping = aes_string(x = 0,
                                                       y = 0,
                                                       xend = vars[1],
                                                       yend = vars[2]),
                                  arrow = arrow(length = unit(0.1, 'cm')),
                                  colour = line.col) +
            label_fun(data = vs, geom = geom, vars = vars)
    }

    if (NROW(fs) > 0L) {
        plt <- plt +
            geom_point(data = fs,
                       mapping = aes_string(x = vars[1],
                                            y = vars[2])) +
            label_fun(data = fs, geom = geom, vars = vars)
    }

    if (is.null(xlab)) {
        xlab <- vars[1]
    }

    if (is.null(ylab)) {
        ylab <- vars[2]
    }

    plt <- plt +
        labs(x = xlab, y = ylab, title = title, subtitle = subtitle,
             caption = caption) +
        coord_fixed()

    plt
}
