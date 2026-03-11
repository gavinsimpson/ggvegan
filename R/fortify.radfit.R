#' @title Fortify results of ranked abundance distribution models
#'
#' @description Prepares a fortified version of results from
#'     [vegan::radfit()] or [vegan::as.rad()].
#'
#' @inheritParams ggplot2::fortify
#' @inheritParams generics::tidy
#'
#' @param pick Pick or several models. Allowed values are \code{"AIC"}
#'     and \code{"BIC"} for selecting the best model by AIC or BIC, or
#'     (a vector of) model names that can be abbreviated. The default
#'     returns all fitted models.
#'
#' @importFrom stats AIC fitted
#' @importFrom ggplot2 fortify
#'
#' @rdname fortify.radfit
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
    data.frame(Species = Species,
               Rank = rep(Rank, nmods),
               Abundance = rep(Abundance, nmods),
               Fit = as.vector(fv),
               Model = mods)
}

#' @param order.by A vector used for ordering site panels.
#'
#' @rdname fortify.radfit
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
    data.frame(
        "Site" = factor(rep(sit, nsp), levels=sit[order.by]),
        "Species" = unlist(spe, use.names=FALSE),
        "Rank" =  unlist(sapply(nsp, seq_len), use.names=FALSE),
        "Abundance" = unlist(abu, use.names=FALSE),
        "Fit" = drop(do.call(rbind, fv)),
        "Model" = factor(rep(mod, nsp), levels=allmods)
    )
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
#' @rdname fortify.radfit
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

#' @rdname fortify.radfit
#' @export
`fortify.rad` <-
    function(model, data, ...)
{
    data.frame(
        Species = names(model),
        Rank = seq_along(model),
        Abundance = as.vector(model)
    )
}

#' @rdname fortify.radfit
#' @export
`fortify.rad.frame` <-
    function(model, data, order.by = NULL, ... )
{
    abu <- lapply(model, as.vector)
    nsp <- sapply(model, length)
    spe <- lapply(model, names)
    sit <- names(model)
    ## enable re-ordering of Site panels
    if (is.null(order.by))
        order.by <- seq_along(sit)
    else
        order.by <- order(order.by)
    data.frame(
        "Site" = factor(rep(sit, nsp), levels=sit[order.by]),
        "Species" = unlist(spe, use.names=FALSE),
        "Rank" =  unlist(sapply(nsp, seq_len), use.names=FALSE),
        "Abundance" = unlist(abu, use.names=FALSE)
    )
}

### tidy() as fortify() synonyms

#' @importFrom tibble as_tibble

#' @rdname fortify.radfit
#' @export
`tidy.radfit` <- function(x, data, pick = NULL, ...)
    as_tibble(fortify(model = x, data = data , pick = pick, ...))

#' @rdname fortify.radfit
#' @export
`tidy.radfit.frame` <- function(x, data, pick = "AIC", order.by = NULL, ...)
    as_tibble(
        fortify(model = x, data = data, pick = pick, order.by = order.by, ...))

#' @rdname fortify.radfit
#' @export
`tidy.radline` <- function(x, data, ...)
    as_tibble(fortify(model = x, data = data, ...))

#' @rdname fortify.radfit
#' @export
`tidy.rad` <- function(x, data, ...)
    as_tibble(fortify(model = x, data = data, ...))

#' @rdname fortify.radfit
#' @export
`tidy.rad.frame` <- function(x, data, order.by = NULL, ...)
    as_tibble(fortify(model = x, data = data, order.by = order.by, ...))
