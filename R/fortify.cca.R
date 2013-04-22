##' Fortifies an object of class \code{"cca"} to produce a data frame of
##' the selected axis scores in long format, suitable for plotting with
##' \code{\link[ggplot2]{ggplot}.
##'
##' .. content for \details{} ..
##' @title Fortify a \code{"cca"} object.
##' @param model an object of class \code{"cca"}, the result of a call to
##' \code{\link[vegan]{cca}}, \code{\link[vegan]{rda}}, or
##' \code{\link[vegan]{capscale}}.
##' @param data currently ignored.
##' @param ... additional arguments passed to \code{\link[vegan]{scores.cca}}.
##' @return A data frame in long format containing the ordination scores.
##' The first to components are the axis scores.
##' @author Gavin
##' @S3method fortify cca
`fortify.cca` <- function(model, data, ...) {
    scrLen <- function(x) {
        obs <- nrow(x)
        if(is.null(obs))
            obs <- 0
        obs
    }
    if(missing(display))
        display <- c("sp", "wa", "lc", "bp", "cn")
    scrs <- scores(model, ...)
    scrs <- lapply(scrs, function(x) {
        data.frame(x, Label = rownames(x))
    })
    fdf <- data.frame(do.call(rbind, scrs))
    rownames(fdf) <- NULL
    lens <- sapply(scrs, scrLen)
    fdf <- transform(fdf, Score = rep(c("species", "sites", "constraints",
                          "biplot", "centroids"), times = lens))
    attr(fdf, "dimlabels") <- names(fdf)[1:2]
    names(fdf)[1:2] <- paste0("Dim", 1:2)
    fdf
}
