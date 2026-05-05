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
#' mod <- renyi(BCI[sample(50, 16),])
#' autoplot(mod)
#' ## Diversity against the number of sites
#' mod <- renyiaccum(BCI)
#' autoplot(mod)
#' autoplot(mod) + scale_x_log10()
#'
#' @param object Result from \pkg{vegan} \code{\link[vegan]{renyi}} or
#'     \code{\link[vegan]{renyiaccum}} functions.
#'
#' @param point.params,line.params,ribbon.params List of graphical
#'     parameters passed to \code{\link[ggplot2]{geom_point}},
#'     \code{\link[ggplot2]{geom_line}},
#'     \code{\link[ggplot2]{geom_ribbon}}.
#'
#' @importFrom ggplot2 fortify ggplot aes_ geom_point geom_ribbon geom_line
#'      facet_wrap
#' @importFrom utils modifyList

#' @export
`autoplot.renyi` <-
    function(object, point.params = list(), line.params = list(),
             ribbon.params = list(),  ...)
{
    df <- fortify(object)
    ## geom ordering is weird because alpha is a factor, but
    ## geom_ribbon and geom_line need continuous x and geom_point
    ## against factor alpha must be befor them
    ribbon.params = modifyList(
        list(mapping = aes_(x = ~as.numeric(alpha), ymin = ~lo, ymax = ~hi),
             fill = "skyblue", alpha = 0.2),
        ribbon.params)
    line.params = modifyList(
        list(mapping = aes_(x = ~as.numeric(alpha), y = ~median),
             colour = "blue"),
        line.params)
    ggplot(df, aes_(~alpha, ~Diversity)) +
        do.call("geom_point", point.params) +
        do.call("geom_ribbon", ribbon.params) +
        do.call("geom_line", line.params) +
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
