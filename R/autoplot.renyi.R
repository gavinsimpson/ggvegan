### autoplot & fortify functions for

#' Autoplot Graphics for vegan Rényi and Tsallis diversity Objects
#'
#' \code{autoplot} for [vegan::renyi()] and [vegan::tsallis()] plots
#' the diversites against diversity salce as dots over a ribbon of
#' data extremes in the graph and line of data median, faceted by
#' sites.
#'
#' @examples
#' ## Rényi
#' library(vegan)
#' data(BCI)
#' mod <- renyi(BCI[sample(50, 16),])
#' autoplot(mod)
#'
#' @param object Result from [vegan::renyi()] or [vegan::tsallis()]
#'     functions.
#'
#' @param point.params,line.params,ribbon.params List of graphical
#'     parameters passed to [ggplot2::geom_point()],
#'     [ggplot2::geom_line()] or [ggplot2::geom_ribbon()].
#'
#' @importFrom ggplot2 fortify ggplot aes geom_point geom_ribbon geom_line
#'      facet_wrap
#' @importFrom utils modifyList

#' @export
`autoplot.renyi` <-
    function(object, point.params = list(), line.params = list(),
             ribbon.params = list(),  ...)
{
    df <- fortify(object)
    ## geom ordering is weird because scale is a factor, but
    ## geom_ribbon and geom_line need continuous x and geom_point
    ## against factor alpha must be before them
    ribbon.params = modifyList(
        list(mapping = aes(x = as.numeric(.data[["scale"]]),
                           ymin = .data[["lo"]], ymax = .data[["hi"]]),
             fill = "skyblue", alpha = 0.2),
        ribbon.params)
    line.params = modifyList(
        list(mapping = aes(x = as.numeric(.data[["scale"]]),
                           y = .data[["median"]]),
             colour = "blue"),
        line.params)
    ggplot(df, aes(.data[["scale"]], .data[["diversity"]])) +
        do.call("geom_point", point.params) +
        do.call("geom_ribbon", ribbon.params) +
        do.call("geom_line", line.params) +
        facet_wrap(~site)
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
            "diversity" = as.vector(model),
            "scale" = factor(rep(colnames(model), each = nrow(model)),
                                 levels = colnames(model)),
            "site" = factor(rep(rownames(model), ncol(model)),
                            levels = rownames(model)),
            "median" = rep(apply(model, 2, median), each=nrow(model)),
            "lo" = rep(apply(model, 2, min), each=nrow(model)),
            "hi" = rep(apply(model, 2, max), each=nrow(model)))
    }
    df
}
