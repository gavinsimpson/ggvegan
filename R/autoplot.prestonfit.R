#' @title Plot Preston's log-normal model of species abundance
#'
#' @description Draws a bar plot of species rank abundance with Fisher's log-series superimposed.
#'
#' @param object an object of class \code{\link{prestonfit}}.
#' @param show.fitted logical; should the estimated distribution also be plotted?
#' @param xlab character; label for the x axis.
#' @param ylab character; label for the y axis.
#' @param title character; title for the plot.
#' @param subtitle character; subtitle for the plot.
#' @param caption character; caption for the plot.
#' @param bar.col colour for the bar outlines. The default, \code{NA}, does not draw outlines around bars.
#' @param bar.fill fill colour for the bars.
#' @param line.col colour for Fisher's log-series curve.
#' @param size numeric; size aesthetic for the log-series curve.
#' @param ... additional arguments passed to other methods.
#' @return A ggplot object.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 ggplot autoplot geom_bar geom_segment scale_x_continuous stat_function aes_string labs fortify
#'
#' @examples
#'
#' data(BCI)
#' pfit <- prestonfit(colSums(BCI))
#' autoplot(pfit)
`autoplot.prestonfit` <- function(object, show.fitted = TRUE,
                                  xlab = "Abundance", ylab = "Number of Species",
                                  title = "Preston's lognormal distribution",
                                  subtitle = NULL, caption = NULL,
                                  bar.col = NA, bar.fill = "grey35",
                                  line.col = "red", size = 1,
                                  ...) {
    presfun <- function(x, mode, width, S0) {
        S0 * exp(-(x - mode)^2/2/width^2)
    }
    df <- fortify(object)
    noct <- nrow(df)
    brks <- seq(0, nrow(df))
    df[['OctaveMinusOne']] <- df[['Octave']] - 0.5
    plt <- ggplot(df, aes_string(x = 'OctaveMinusOne', y = 'Abundance')) +
        geom_bar(stat = 'identity', colour = bar.col, fill = bar.fill)
    coefs <- coef(object)
    lineSegs <- data.frame(x1 = c(coefs['mode'], coefs['mode'] - coefs['width']),
                           y1 = c(0, coefs['S0'] * exp(-0.5)),
                           x2 = c(coefs['mode'], coefs['mode'] + coefs['width']),
                           y2 = c(coefs['S0'], coefs['S0'] * exp(-0.5)))
    if (show.fitted) {
        plt <- plt + stat_function(fun = presfun,
                                   args = list(mode = coefs['mode'],
                                               width = coefs['width'],
                                               S0 = coefs['S0']),
                                   colour = line.col, size = size)
    }
    plt <- plt + geom_segment(data = lineSegs,
                              mapping = aes_string(x = 'x1', y = 'y1',
                                                   xend = 'x2', yend = 'y2'),
                              colour = line.col, size = size) +
        scale_x_continuous(breaks = brks, labels = 2^brks) +
        labs(x = xlab, y = ylab, title = title, subtitle = subtitle,
             caption = caption)
    plt
}
