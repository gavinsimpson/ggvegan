### Rank-Abundance Distribution models: ggplot2 alternatives to
### lattice graphics in vegan.

#' Autoplot Graphics for vegan RAD models
#'
#' \CRANpkg{ggplot2} graphics for Rank-Abundance Distribution models
#' fitted with \CRANpkg{vegan} function \code{\link[vegan]{radfit}}.
#'
#' The \code{autoplot} function draws graphics which are \pkg{ggplot2}
#' alternatives for \CRANpkg{lattice} graphics in \pkg{vegan}. The
#' \code{fortify} function produces \dQuote{tidy} data frames that can
#' be used to produce the graphics.
#'
#' @examples
#' data(mite)
#' m1 <- radfit(mite[1,])
#' ## With logarithmic y-axis (default) Pre-emption model is a line
#' autoplot(m1)
#' ## With log-log scale, Zipf model is a line
#' autoplot(m1) + scale_x_log10()

#' @param object Result object from \code{\link[vegan]{radfit}}.
#' @param facet Draw each fitted model to a separate facet or (if
#'     \code{FALSE}) all fitted lines to a single graph.
#'
#' @importFrom ggplot2 ggplot aes_ scale_y_log10 facet_wrap geom_point
#'     geom_line
#'
#' @export
`autoplot.radfit` <-
    function(object, facet = TRUE, ...)
{
    df <- fortify(object)
    pl <- ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(1,NA)) +
        geom_point(mapping=aes_(y = ~Abundance)) +
        geom_line(mapping=aes_(y = ~Fit, colour = ~Model))
    if(facet)
        pl <- pl + facet_wrap(~Model)
    pl
}

#'
#' @inheritParams ggplot2::fortify
#'
#' @importFrom stats fitted
#'
#' @rdname autoplot.radfit
#' @export
`fortify.radfit` <-
    function(model, data, ...)
{
    Abundance <- model$y
    nsp <- length(Abundance)
    Rank <- seq_len(nsp)
    Species <- names(Abundance)
    fv <- fitted(model)
    nmods <- NCOL(fv)
    modnames <- colnames(fv)
    mods <- factor(rep(modnames, each=nsp), levels=modnames)
    df <- data.frame(Species = Species,
                     Rank = rep(Rank, nmods),
                     Abundance = rep(Abundance, nmods),
                     Fit = as.vector(fv),
                     Model = mods)
    df
}
