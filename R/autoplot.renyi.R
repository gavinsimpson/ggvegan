### autoplot & fortify functions for

#' Autoplot Graphics for vegan renyi and renyiaccum Objects
#'
#' Alternatives to \pkg{lattice} graphics functions in
#' \pkg{vegan}.
#'
#' \code{autoplot} for \code{\link[vegan]{renyi}} displays the
#' diversites against alpha as dots over a ribbon of data extremes in
#' the graph and line of data median faceted by sites. \code{autoplot}
#' for \code{\link[vegan]{renyiaccum}} shows the median of diversity
#' accumulation against the number of sites over a ribbon of
#' permutation values faceted by alpha.
#'
#' @examples
#' ## Rényi
#' data(BCI)
#' mod <- renyi(BCI[sample(16),])
#' autoplot(mod)
#' ## Diversity against the number of sites
#' mod <- renyiaccum(BCI)
#' autoplot(mod)
#' autoplot(mod) + scale_x_log10()
#'
#' @param object Result from \pkg{vegan} \code{\link[vegan]{renyi}} or
#'     \code{\link[vegan]{renyiaccum}} functions.
#'
#' @param fill,alpha Parameters passed to \code{\link[ggplot2]{geom_ribbon}}
#'
#' @importFrom ggplot2 fortify ggplot aes geom_point geom_ribbon geom_line
#'      facet_wrap

#' @export
`autoplot.renyi` <-
    function(object, fill = "skyblue", alpha = 0.2, ...)
{
    df <- fortify(object)
    ## geom ordering is weird because alpha is a factor, but
    ## geom_ribbon and geom_line need continuous x and geom_point
    ## against factor alpha must be befor them
    ggplot(df, aes(alpha, Diversity)) +
        geom_point(...) +
        geom_ribbon(aes(x = as.numeric(alpha), ymin = lo, ymax = hi),
                    fill = fill, alpha = alpha) +
        geom_line(aes(x = as.numeric(alpha), y = median), ...) +
        facet_wrap(~Site)
}

#' @inheritParams ggplot2::fortify

#' @importFrom stats median
#'
#' @rdname autoplot.renyi
#' @export
`fortify.renyi` <-
    function(model, data, ...)
{
    if (!is.data.frame(model)) {
        stop("not yet implemented for single sites")
    } else {
        model <- as.matrix(model)
        df <- data.frame(
            "Diversity" = as.vector(model),
            "alpha" = factor(rep(colnames(model), each = nrow(model)),
                                 levels = colnames(model)),
            "Site" = factor(rep(rownames(model), ncol(model)),
                            levels = rownames(model)),
            "median" = rep(apply(model, 2, median), each=nrow(model)),
            "lo" = rep(apply(model, 2, min), each=nrow(model)),
            "hi" = rep(apply(model, 2, max), each=nrow(model)))
    }
    df
}

#' @param ribbon Show ribbon for 0.95 interval, extreme values or for
#'     standard deviation of permutations.
#'
#' @importFrom ggplot2 fortify ggplot aes geom_ribbon geom_line facet_wrap
#'
#' @rdname autoplot.renyi
#' @export
`autoplot.renyiaccum` <-
    function(object, ribbon = c("0.95", "minmax", "stdev"),
             fill = "skyblue", alpha = 0.5, ...)
{
    df <- fortify(object)
    ribbon <- match.arg(ribbon)
    lo <- switch(ribbon,
                 "0.95" = df[, "Qnt 0.025"],
                 "minmax" = df[, "min"],
                 "stdev" = df[,"mean"] - df[, "stdev"]
                 )
    hi <- switch(ribbon,
                 "0.95" = df[, "Qnt 0.975"],
                 "minmax" = df[, "max"],
                 "stdev" = df[, "mean"] + df[, "stdev"]
                 )
    ggplot(df, aes(Sites, Diversity)) +
        geom_ribbon(aes(ymin = lo, ymax = hi), fill = fill, alpha = alpha) +
        geom_line(...) +
        facet_wrap(~alpha)
}

#' @inheritParams ggplot2::fortify
#'
#' @importFrom ggplot2 fortify

#' @rdname autoplot.renyi
#' @export
`fortify.renyiaccum` <-
    function(model, data, ...)
{
    nr <- nrow(model)
    Sites <- seq_len(nr)
    alpha <- unlist(dimnames(model)[2])
    alpha <- factor(rep(alpha, each = nr), levels=alpha)
    x <- apply(model, 3, as.vector)
    colnames(x)[1] <- "Diversity"
    df <- cbind(data.frame(Sites=Sites, alpha=alpha), x)
    rownames(df) <- seq_len(nrow(df))
    df
}
