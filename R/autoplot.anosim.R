#' @title ggplot-based plot for objects of class \code{"anosim"}
#'
#' @description
#' Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{anosim}}.
#'
#' @param object an object of class \code{"anosim"}, the result of a call to \code{\link[vegan]{anosim}}.
#' @param notch logical; make notched (default) or standard box plot?
#' @param varwidth logical; make box width proportional to the square-root of the number of observations in the group (default)?
#' @param xlab character; label for the x-axis.
#' @param ylab character; label for the y-axis.
#' @param title character; title for the plot.
#' @param subtitle character; subtitle for the plot.
#' @param caption character; caption for the plot.
#' @param ... additional arguments passed to other methods.
#' @return A ggplot object.
#' @author Didzis Elferts. Modifications by Gavin L. Simpson.
#'
#' @export
#'
#' @importFrom ggplot2 ggplot autoplot geom_boxplot aes_string labs fortify
#'
#' @examples
#'
#' library("vegan")
#'
#' data(dune)
#' data(dune.env)
#' dune.dist <- vegdist(dune)
#' dune.ano <- with(dune.env, anosim(dune.dist, Management))
#'
#' autoplot(dune.ano, notch = FALSE)

`autoplot.anosim` <- function(object, notch = TRUE, varwidth = TRUE,
                              xlab = NULL, ylab = NULL,
                              title = "Analysis of similarities",
                              subtitle = NULL,
                              caption = bquote(R == .(R) * "," ~ P == .(P)),
                              ...) {
    df <- fortify(object)

    plt <- ggplot(df, aes_string(x = "Class", y = "Rank")) +
        geom_boxplot(notch = notch, varwidth = varwidth)

    ## prepare stats for caption --- may not be used
    P <- if (is.null(object$permutations)) {
        "not assessed"
    } else {
        format.pval(object$signif)
    }
    R <- round(object$statistic,3)

    ## add on labels here, not earlier due to lazy evaluation of caption default
    plt <- plt + labs(x = xlab, y = ylab, title = title, subtitle = subtitle,
                      caption = caption)
    plt
}
