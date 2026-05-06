### autoplot & fortify functions for

#' Autoplot Graphics for vegan `renyi()` and `tsallis()` diversity
#' Objects
#'
#' \code{autoplot} for [vegan::renyi()] and [vegan::tsallis()] plots
#' the diversities against diversity scale as dots separately for each
#' site. As a background it uses a ribbon of data extremes and a line of
#' data median in all sites.
#'
#' @examples
#' ## Rényi
#' library(vegan)
#' data(BCI)
#' mod <- renyi(BCI[1:16,])
#' autoplot(mod)
#'
#' @inheritParams ggplot2::autoplot
#' #'
#' @param point.params,line.params,ribbon.params List of graphical
#'     parameters passed to [ggplot2::geom_point()],
#'     [ggplot2::geom_line()] or [ggplot2::geom_ribbon()].
#'
#' @importFrom ggplot2 fortify ggplot aes geom_point geom_ribbon
#'     geom_line facet_wrap
#' @importFrom utils modifyList

#' @export
`autoplot.renyi` <-
    function(object, point.params = list(), line.params = list(),
             ribbon.params = list(), ...)
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
