##' @title Scale Vectors to Data
##' @description Scale vector arrows to \code{fill} proportion of the data.
##' @param arrows a two-column matrix-like object containing coordinates for the arrows/vectors on x and y axes.
##' @param data a two-column matrix-like object containing coordinates of the data on the x and y axes.
##' @param at numeric vector of length 2; location of the origin of the arrows.
##' @param fill numeric; what proportion of the range of the data to fill
##' @return a numeric multiplier that will scale the arrows
##' @author Gavin L. Simpson
`arrowMul` <- function(arrows, data, at = c(0, 0), fill = 0.75) {
    u <- c(range(data[,1], range(data[,2])))
    u <- u - rep(at, each = 2)
    r <- c(range(arrows[, 1], na.rm = TRUE), range(arrows[, 2], na.rm = TRUE))
    rev <- sign(diff(u))[-2]
    if (rev[1] < 0)
        u[1:2] <- u[2:1]
    if (rev[2] < 0)
        u[3:4] <- u[4:3]
    u <- u/r
    u <- u[is.finite(u) & u > 0]
    fill * min(u)
}

##' @title Number of scores
##' @description Returns the number of scores returns in object \code{x}.
##'
##' @param x The object whose number of scores is required.
##'
##' @return a numeric vector of length 1 with the number of scores.
##'
##' @author Gavin L. Simpson
`scoresLength` <- function(x) {
        obs <- NROW(x)
        if (is.null(obs))
            obs <- 0
        obs

}

##' @title Extract the names of the dimensions to plot as a character vector
##'
##' @description Find the character vector of names for the two dimensions of data to be plotted.
##' @param object a fortified ordination object.
##' @return A length 2 character vector of dimension names.
##' @author Gavin L. Simpson
`getDimensionNames` <- function(object) {
    names(object)[-c(1,2)]
}

##' @title Adds a label layer using one of a set of common geoms
##'
##' @description Adds labels to a plot using one of \code{geom_label}, \code{geom_text}, \code{geom_label_repel} or \code{geom_text_repel}.
##'
##' @param data data frame; data set to use for the label layer. Must contain a variable \code{Label} containing the strings to use as labels.
##' @param geom character; which geom to use for labelling.
##' @param vars character; vector of names of variables to ass to the \code{x} and \code{y} aesthetics of the chosen geom.
##'
##' @author Gavin L. Simpson
##'
##' @importFrom ggplot2 geom_text geom_label aes_string
##' @importFrom ggrepel geom_text_repel geom_label_repel
##'
`label_fun` <- function(data,
                        geom = c("label", "text", "label_repel", "text_repel"),
                        vars) {
    ll <- switch(geom,
                 label =
                     geom_label(data = data,
                                mapping = aes_string(x = vars[1],
                                                     y = vars[2],
                                                     label = 'Label')),
                 text =
                     geom_text(data = data,
                               mapping = aes_string(x = vars[1],
                                                    y = vars[2],
                                                    label = 'Label')),
                 label_repel =
                     geom_label_repel(data = data,
                                      mapping = aes_string(x = vars[1],
                                                           y = vars[2],
                                                          label = 'Label')),
                 text_repel =
                     geom_text_repel(data = data,
                                    mapping = aes_string(x = vars[1],
                                                         y = vars[2],
                                                         label = 'Label'))
                 )
    ll
}
