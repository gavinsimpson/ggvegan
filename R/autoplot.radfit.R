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
#' ## Show only the best model
#' autoplot(m1, pick = "AIC")
#' ## Show selected models in one frame
#' autoplot(m1, pick = c("Z","M","L"), facet=FALSE)
#' ## plot best modesl for several sites
#' m <- radfit(mite[1:12,])
#' autoplot(m, pick="AIC")
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
    pl <- ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(1,NA)) +
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
    pl <- ggplot(df, aes_(~Rank)) +
        scale_y_log10(limit=c(1,NA)) +
        geom_point(mapping=aes_(y = ~Abundance)) +
        geom_line(mapping=aes_(y = ~Fit, colour = ~Model)) +
        facet_wrap(~Site)
    pl
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

#'
#'
#' @rdname autoplot.radfit
#' @export
`fortify.radfit.frame` <-
    function(model, data, pick = "AIC", ...)
{
    allmods <- names(model[[1]]$models)
    pick <- match.arg(pick, c(allmods, "AIC", "BIC"))
    abu <- lapply(model, function(x) x$y)
    nsp <- sapply(abu, length)
    spe <- lapply(abu, names)
    sit <- names(model)
    fv <- lapply(model, radpicker, pick = pick)
    mod <- sapply(fv, colnames)
    df <- data.frame(
        "Site" = factor(rep(sit, nsp), levels=sit),
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

