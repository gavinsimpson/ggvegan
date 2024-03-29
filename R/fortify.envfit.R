#' @title Fortify method for \code{envfit} objects
#' @description Produces a tidy data frame from the results of an \code{\link[vegan]{envfit}} object.
#' @param model an object of class \code{envfit}, the result of a call to \code{\link[vegan]{envfit}}.
#' @param data additional data to augment the \code{envfit} results. Currently ignored.
#' @param ... arguments passed to \code{\link[vegan]{scores.envfit}}.
#'
#' @return A data frame with columns \code{label}, \code{type}, containing the label for, and whether each row refers to, the fitted vector or factor. Remaining variables are coordinates on the respective ordination axes returned by \code{\link[vegan]{scores.envfit}}.
#' @author Gavin L. Simpson
#'
#' @importFrom vegan scores
#'
#' @export
#'
#' @examples
#' data(varespec, varechem)
#' ord <- metaMDS(varespec)
#' fit <- envfit(ord, varechem, perm = 199)
#'
#' fortify(fit)
#'
#' data(dune, dune.env)
#' ord <- cca(dune)
#' fit <- envfit(ord ~ Moisture + A1, dune.env, perm = 199)
#'
#' fortify(fit)
`fortify.envfit` <- function(model, data, ...) {
    vs <- scores(model, display = 'vectors', ...)
    fs <- scores(model, display = 'factors', ...)
    df <- as.data.frame(rbind(vs, fs))
    df <- cbind(label = c(rownames(vs), rownames(fs)),
                type  = rep(c('Vector', 'Centroid'),
                            times = c(NROW(vs), NROW(fs))),
                df)
    rownames(df) <- NULL
    df
}
