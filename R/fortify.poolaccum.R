##' @title Fortify extrapolated species richness of a species pool
##'
##' @description Prepares a fortified version of results from \code{\link[vegan]{poolaccum}} objects.
##'
##' @param model an object of class \code{\link[vegan]{poolaccum}}.
##' @param data original data set. Currently ignored.
##' @param alpha level of quantiles for envelopes shown (default 0.05).
##' @param ... additional arguments passed to \code{\link[vegan]{summary.poolaccum}}, notably \code{display} to control which indices should be computed.
##'
##' @return A data frame with columns \code{Index}, \code{Size}, \code{Richness}, \code{Lower}, \code{Upper}, and \code{Std.dev}, containing the richness index, permutation richness estimator, sample size, upper and lower \eqn{1 - \alpha}{1 - alpha} quantile interval, and standard deviation of permutation estimates, respectively.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##'
##' @author Didzis Elferts & Gavin L. Simpson
##'
##' @examples
##' data(BCI)
##' pool <- poolaccum(BCI)
##' df <- fortify(pool)
##'
##' ggplot(df, aes(x = Size, y = Richness, colour = Index)) +
##'     geom_ribbon(aes(ymin = Lower, ymax = Upper, x = Size, fill = Index),
##'                 alpha = 0.3, inherit.aes = FALSE) +
##'     geom_line() +
##'     facet_wrap(~ Index)

`fortify.poolaccum` <- function(model, data, alpha = 0.05, ...) {
    m <- summary(model, alpha = alpha, ...)
    lens <- vapply(m, NROW, numeric(1), USE.NAMES = FALSE)
    vars <- vapply(m, function(x) colnames(x)[2], character(1),
                   USE.NAMES = FALSE)
    df <- as.data.frame(do.call("rbind", m)) # bind_rows later?
    names(df) <- c("Size", "Richness", "Lower", "Upper", "Std.Dev")
    df <- cbind(Index = rep(vars, times = lens), df)
}
