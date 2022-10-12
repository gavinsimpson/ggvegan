### autoplot & fortify functions for

#' Autoplot Graphics for vegan renyi and renyiaccum Objects
#'
#' Alternatives to \pkg{lattice} graphics \code{plot} functions in
#' \pkg{vegan}.
#'
#' @param object Result from \pkg{vegan} \code{\link[vegan]{renyi}} or
#'     \code{\link[vegan]{renyiaccum}} functions.
#'
#' @param fill,alpha Parameters passed to \code{\link[ggplot2]{geom_ribbon}}
#'
#' @importFrom ggplot2 fortfiy ggplot aes geom_point geom_ribbon geom_line
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

#' @rdname autoplot.renyi
#' @export
`autoplot.renyiaccum` <-
    function(object)
{
    .NotYetImplemented()
}

#' @inheritParams ggplot2::fortify

#' @rdname autoplot.renyi
#' @export
`fortify.renyiaccum` <-
    function(model, data, ...)
{
    .NotYetImplemented()
}
