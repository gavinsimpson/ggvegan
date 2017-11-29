##' @title Fortify accumulated species richness in as species pool results
##' @description Prepares fortified versions of results from \code{\link[vegan]{poolaccum}} objects.
##' @param model an object of class \code{\link[vegan]{poolaccum}}.
##' @param data original data set. Currently ignored.
##' @param alpha level of quantiles for envelopes shown (default 0.05).
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{'Size'}, \code{'Richness'}, \code{'Lower'}, \code{'Upper'}, \code{'Std.dev'} and \code{'Index'}, showing permutation richness estimator, sample size, standart deviation, quantile envelope and indices names.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##'
##' @author Didzis Elferts
##'
##' @examples
##' data(BCI)
##' pool <- poolaccum(BCI)
##' df <- fortify(pool)
##' 
##' ggplot(df, aes(x = Size)) + 
##'    geom_line(aes(y = Richness), color = "red") +
##'    geom_line(aes(y = Lower), color = "blue") +
##'    geom_line(aes(y = Upper), color = "blue") +
##'    facet_wrap(~Index, ncol = 3) 
`fortify.poolaccum` <- function(model, data, 
                                alpha = 0.05,...) {
  m <- summary(model, alpha = alpha, ...)
  m <- lapply(1:length(m), function(x) {
    mdf <- as.data.frame(m[[x]])
    mdf$Index <- names(mdf)[2]
    colnames(mdf) <- c("Size","Richness","Lower","Upper","Std.Dev","Index")
    mdf
  })
  df <- do.call("rbind",m)
  df
}
