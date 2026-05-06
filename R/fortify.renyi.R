#' @inheritParams ggplot2::fortify
#' @inheritParams generics::tidy
#'
#' @title Fortify vegan `renyi()` or `tsallis()` diversity results
#'
#' @description Prepares a fortified version of result objects from
#'     [vegan::renyi()] and [vegan::tsallis()].
#'
#' @importFrom stats median
#'
#' @rdname fortify.renyi
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

#' @importFrom tibble as_tibble
#' @rdname fortify.renyi
#' @export
`tidy.renyi` <-
    function(x, data, ...)
{
    as_tibble(fortify(model = x, data = data, ...))
}
