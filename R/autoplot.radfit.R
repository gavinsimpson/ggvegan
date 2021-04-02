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
#'

#' @param object Result object from \code{\link[vegan]{radfit}}.
#' @param facet Draw each fitted model to a separate facet or (if
#'     \code{FALSE}) all fitted lines to a single graph.
#'
#' @importFrom ggplot2 ggplot aes_ scale_y_log10 facet_wrap geom_point
#'     geom_line fortify
#'
#' @export
`autoplot.radfit` <-
    function(object, facet = TRUE, ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    pl <- ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(ymin,NA)) +
        geom_point(mapping=aes_(y = ~Abundance)) +
        geom_line(mapping=aes_(y = ~Fit, colour = ~Model))
    if(facet)
        pl <- pl + facet_wrap(~Model)
    pl
}

#'
#' @importFrom ggplot2 fortify aes_ scale_y_log10 geom_point geom_line
#'     facet_wrap
#'
#' @rdname autoplot.radfit
#' @export
`autoplot.radfit.frame` <-
    function(object, ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    pl <- ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(ymin,NA)) +
        geom_point(mapping=aes_(y = ~Abundance)) +
        geom_line(mapping=aes_(y = ~Fit, colour = ~Model)) +
        facet_wrap(~Site)
    pl
}

#' @importFrom ggplot2 ggplot scale_y_log10 geom_point geom_line aes_
#'     fortify
#' @rdname autoplot.radfit
#' @export
`autoplot.radline`<-
    function(object, ...)
{
    df <- fortify(object, ...)
    ymin <- min(1, df$Abundance)
    ggplot(df, aes_(~Rank)) +
        scale_y_log10() +  # no lower limit for a single line
        geom_point(mapping=aes_(y = ~Abundance)) +
        geom_line(mapping=aes_(y = ~ Fit))
}

#'
#' @inheritParams ggplot2::fortify
#'
#' @param pick Pick or several models. Allowed values are \code{"AIC"}
#'     and \code{"BIC"} for selecting the best model by AIC or BIC, or
#'     (a vector of) model names that can be abbreviated. The default
#'     returns all fitted models.
#'
#' @importFrom stats AIC fitted
#'
#' @rdname autoplot.radfit
#' @export
`fortify.radfit` <-
    function(model, data, pick = NULL, ...)
{
    Abundance <- model$y
    nsp <- length(Abundance)
    Rank <- seq_len(nsp)
    Species <- names(Abundance)
    fv <- fitted(model)
    ## only pick wanted models
    if (!is.null(pick)) {
        pick <- match.arg(pick, c(names(model$models), "AIC","BIC"),
                          several.ok=TRUE)
        if (any(c("AIC","BIC") %in% pick)) {
            if("BIC" %in% pick)
                k <- log(length(model$y))
            else
                k <- 2
            pick <- which.min(AIC(model, k=k))
        }
        fv <- fv[, pick, drop=FALSE]
    }
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

#' @param order.by A vector used for ordering site panels.
#'
#' @rdname autoplot.radfit
#' @export
`fortify.radfit.frame` <-
    function(model, data, pick = "AIC", order.by = NULL, ...)
{
    allmods <- names(model[[1]]$models)
    pick <- match.arg(pick, c(allmods, "AIC", "BIC"))
    abu <- lapply(model, function(x) x$y)
    nsp <- sapply(abu, length)
    spe <- lapply(abu, names)
    sit <- names(model)
    fv <- lapply(model, radpicker, pick = pick)
    mod <- sapply(fv, colnames)
    ## enable re-ordering of Site panels
    if (is.null(order.by))
        order.by <- seq_along(sit)
    else
        order.by <- order(order.by)
    df <- data.frame(
        "Site" = factor(rep(sit, nsp), levels=sit[order.by]),
        "Species" = unlist(spe, use.names=FALSE),
        "Rank" =  unlist(sapply(nsp, seq_len), use.names=FALSE),
        "Abundance" = unlist(abu, use.names=FALSE),
        "Fit" = drop(do.call(rbind, fv)),
        "Model" = factor(rep(mod, nsp), levels=allmods)
    )
    df
}
## support function to pick the model with lowest AIC or BIC or by the
## name. Input is a single model from a radfit.frame and pick is a
## single argument value.

#' @importFrom stats AIC fitted
#'
`radpicker` <-
    function(mod1, pick, ...)
{
    fv <- fitted(mod1)
    switch(pick,
           "AIC" = fv[, which.min(AIC(mod1)), drop=FALSE],
           "BIC" = fv[, which.min(AIC(mod1, k=log(nrow(fv)))), drop=FALSE],
           fv[,pick, drop=FALSE])
}

#' @importFrom stats fitted
#' @rdname autoplot.radfit
#' @export
`fortify.radline` <-
    function(model, data, ...)
{
    data.frame(
        Species = names(model$y),
        Rank = seq_along(model$y),
        Abundance = unclass(model$y),
        Fit = fitted(model)
    )
}
