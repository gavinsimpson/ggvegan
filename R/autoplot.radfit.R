### Rank-Abundance Distribution models: ggplot2 alternatives to
### lattice graphics in vegan.

#' Autoplot graphics for vegan rank-abundance models
#'
#' \pkg{ggplot2} graphics for Rank-Abundance Distribution models
#' fitted with \pkg{vegan} functions [vegan::radfit()] or produced
#' with [vegan::as.rad()].
#'
#' The \code{autoplot} function draws graphics which are \pkg{ggplot2}
#' alternatives for \CRANpkg{lattice} graphics in \pkg{vegan}. In
#' addition, there are functions for [vegan::as.rad()]
#' results which do not have dedicated graphics in\pkg{vegan}.
#'
#' @examples
#' library(vegan)
#' library(ggplot2)
#' data(mite)
#' m1 <- radfit(mite[1,])
#' ## With logarithmic y-axis (default) Pre-emption model is a line
#' autoplot(m1) + labs(title="log-Abundance: Pre-emption model is a line")
#' ## With log-log scale, Zipf model is a line
#' autoplot(m1) + scale_x_log10() +
#'    labs(title="log-log Scale: Zipf model is a line")
#' ## Show only the best model
#' autoplot(m1, pick = "AIC")
#' ## Show selected models in one frame
#' autoplot(m1, pick = c("Z","M","L"), facet=FALSE)
#' ## plot best models for several sites
#' m <- radfit(mite[1:12,])
#' autoplot(m) + labs(title="Model Selection AIC (Default)")
#' ## use BIC and reoreder sites by their diversity
#' autoplot(m, pick="BIC", order.by = diversity(mite[1:12,])) +
#'    labs(title="Model Selection BIC, Ordered by Increasing Diversity")
#' ## Plot RAD models without fits highlighting most abundant species in the
#' ## whole data.
#' m0 <- as.rad(mite[1:12,])
#' dominants <- names(sort(colSums(mite), decreasing=TRUE))[1:6]
#' autoplot(m0, highlight = dominants)

#' @param object Result object from \code{\link[vegan]{radfit}}.
#' @param facet Draw each fitted model to a separate facet or (if
#'     \code{FALSE}) all fitted lines to a single graph.
#' @param point.params,line.params Parameters to modify points or
#'     lines (passed to \code{\link[ggplot2]{geom_point}} and
#'     \code{\link[ggplot2]{geom_line}}).
#' @param ... Additional arguments passed to the functions.
#'
#' @importFrom ggplot2 ggplot aes_ scale_y_log10 facet_wrap geom_point
#'     geom_line fortify autoplot
#' @importFrom scales oob_squish_infinite
#' @importFrom utils modifyList
#'
#' @export
`autoplot.radfit` <-
    function(object, facet = TRUE, point.params = list(), line.params = list(),
             ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    point.params <- modifyList(list(mapping=aes_(y = ~ Abundance)),
                               point.params)
    line.params <- modifyList(list(mapping=aes_(y = ~Fit, colour = ~ Model)),
                                   line.params)
    pl <- ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(ymin,NA), oob = oob_squish_infinite) +
        do.call("geom_point", point.params) +
        do.call("geom_line", line.params)
    if(facet)
        pl <- pl + facet_wrap(~Model)
    pl
}

#'
#' @importFrom ggplot2 fortify aes_ scale_y_log10 geom_point geom_line
#'     facet_wrap
#' @importFrom scales oob_squish_infinite
#' @importFrom utils modifyList
#'
#' @rdname autoplot.radfit
#' @export
`autoplot.radfit.frame` <-
    function(object, point.params=list(), line.params=list(), ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    point.params <- modifyList(list(mapping=aes_(y = ~ Abundance)),
                               point.params)
    line.params <- modifyList(list(mapping=aes_(y = ~Fit, colour = ~Model)),
                              line.params)
    ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(ymin,NA), oob = oob_squish_infinite) +
        do.call("geom_point", point.params) +
        do.call("geom_line", line.params) +
        facet_wrap(~Site)
}

#' @importFrom ggplot2 ggplot scale_y_log10 geom_point geom_line aes_
#'     fortify
#' @importFrom utils modifyList
#' @rdname autoplot.radfit
#' @export
`autoplot.radline`<-
    function(object, point.params = list(), line.params = list(), ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    point.params <- modifyList(list(mapping=aes_(y = ~ Abundance)),
                               point.params)
    line.params <- modifyList(list(mapping=aes_(y = ~ Fit)),
                              line.params)
    ggplot(df, aes_(~Rank)) +
        scale_y_log10() +  # no lower limit for a single line
        do.call("geom_point", point.params) +
        do.call("geom_line", line.params)
}

### Methods for rad: only points, no lines from vegan::as.rad()

#' @importFrom utils modifyList
#' @importFrom ggplot2 aes_ scale_y_log10 geom_point
#' @rdname autoplot.radfit
#' @export
`autoplot.rad` <-
    function(object, point.params = list(), line.params = list(), ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    point.params <- modifyList(list(mapping=aes_(y = ~ Abundance)),
                               point.params)
    ggplot(df, aes_(~Rank)) +
        scale_y_log10() +  # no lower limit for a single line
        do.call("geom_point", point.params)
}

#' @param highlight Names of species that should be highlighted as
#'     coloured points.
#' @importFrom utils modifyList
#' @importFrom ggplot2 aes_ scale_colour_discrete scale_y_log10
#'     geom_point facet_wrap
#' @rdname autoplot.radfit
#' @export
`autoplot.rad.frame` <-
    function(object, point.params=list(), highlight = NULL, ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    point.params <- modifyList(list(mapping=aes_(y = ~ Abundance)),
                               point.params)
    pl <- ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(ymin,NA)) +
        do.call("geom_point", point.params) +
        facet_wrap(~Site)
    if (!is.null(highlight)) {
        highlight <- factor(highlight, levels=highlight)
        for(sp in highlight)
            pl <- pl + geom_point(data=df[df$Species == sp, ,drop=FALSE],
                                  aes_(y = ~Abundance, colour = sp))
        pl <- pl + scale_colour_discrete(highlight, name = "Species")
    }
    pl
}


