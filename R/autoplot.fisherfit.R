##' @title Plot Fisher's log-series
##'
##' @description Draws a bar plot of species rank abundance with Fisher's log-series superimposed.
##'
##' @param object an object of class \code{\link{fisherfit}}.
##' @param xlab character; label for the x axis.
##' @param ylab character; label for the y axis.
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
`autoplot.fisherfit` <- function(object, xlab = "Rank", ylab = "Abundance",
                                 bar.col = NA, bar.fill = "grey35",
                                 line.col = "red", size = 1,
                                 ...) {
    fishfun <- function(x, k, alpha) {
        alpha * k^x / x
    }
    df <- fortify(object)
    plt <- ggplot(df, aes_string(x = 'Rank', y = 'Abundance')) +
        geom_bar(stat = 'identity', colour = bar.col, fill = bar.fill)
    alpha <- object[['estimate']]
    k <- object[['nuisance']]
    plt <- plt + stat_function(fun = fishfun, args = list(k = k, alpha = alpha),
                               colour = line.col, size = size) +
        labs(x = xlab, y = ylab)
    plt
}
