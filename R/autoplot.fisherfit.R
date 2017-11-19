##' @title Plot Fisher's log-series
##'
##' @description Draws a bar plot of species rank abundance with Fisher's log-series superimposed.
##'
##' @param object an object of class \code{\link{fisherfit}}.
##' @param show.fitted logical; should the estimated distribution also be plotted?
##' @param xlab character; label for the x axis.
##' @param ylab character; label for the y axis.
##' @param title character; title for the plot.
##' @param bar.col colour for the bar outlines. The default, \code{NA}, does not draw outlines around bars.
##' @param bar.fill fill colour for the bars.
##' @param line.col colour for Fisher's log-series curve.
##' @param size numeric; size aesthetic for the log-series curve.
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom ggplot2 ggplot autoplot geom_bar stat_function aes_string labs fortify
##'
##' @examples
##'
##' data(BCI)
##' mod <- fisherfit(BCI[5,])
##' autoplot(mod)
`autoplot.fisherfit` <- function(object, show.fitted = TRUE,
                                 xlab = "Abundance", ylab = "Number of Species",
                                 title = "Fisher's log-series distribution",
                                 bar.col = NA, bar.fill = "grey35",
                                 line.col = "red", size = 1,
                                 ...) {
    fishfun <- function(x, k, alpha) {
        alpha * k^x / x
    }
    df <- fortify(object)
    plt <- ggplot(df, aes_string(x = 'Rank', y = 'Abundance')) +
        geom_bar(stat = 'identity', colour = bar.col, fill = bar.fill)
    if (show.fitted) {
        alpha <- object[['estimate']]
        k <- object[['nuisance']]
        plt <- plt + stat_function(fun = fishfun, args = list(k = k, alpha = alpha),
                                   colour = line.col, size = size)
    }
    plt <- plt + labs(x = xlab, y = ylab, title = title)
    plt
}
