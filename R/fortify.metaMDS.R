#' @title Fortify a \code{"mataMDS"} object.
#'
#' @description
#' Fortifies an object of class \code{"metaMDS"} to produce a
#' data frame of the selected axis scores in long format, suitable for
#' plotting with \code{\link[ggplot2]{ggplot}}.
#'
#' @details
#' TODO
#'
#' @param  model an object of class \code{"metaMDS"}, the result of a call
#' to \code{\link[vegan]{metaMDS}}.
#' @param data currently ignored.
#' @param ... additional arguments passed to
#' \code{\link[vegan]{scores.metaMDS}}. Note you can't use \code{display}.
#' @return A data frame in long format containing the ordination scores.
#' The first two components are the axis scores.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom vegan scores
#'
#' @examples
#' ## load example data
#' data(dune)
#'
#' ord <- metaMDS(dune)
#' head(fortify(ord))
`fortify.metaMDS` <- function(model, data, ...) {
    samp <- scores(model, display = "sites", ...)
    spp <- tryCatch(scores(model, display = "species", ...),
                    error = function(c) {NULL})
    if (!is.null(spp)) {
        df <- rbind(samp, spp)
        df <- as.data.frame(df)
        df <- cbind(score = factor(rep(c("sites","species"),
                                        c(nrow(samp), nrow(spp)))),
                    label = c(rownames(samp), rownames(spp)),
                    df)
    } else {
        df <- data.frame(score = factor(rep("sites", nrow(df))),
                         label = rownames(samp),
                         samp)
    }
    rownames(df) <- NULL
    df
}
