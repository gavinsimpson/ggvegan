##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##' @title Fortify a \code{"cca"} object.
##' @param model 
##' @param data 
##' @param display 
##' @param ... 
##' @return 
##' @author Gavin
`fortify.cca` <- function(model, data, display, ...) {
    scrLen <- function(x) {
        obs <- nrow(x)
        if(is.null(obs))
            obs <- 0
        obs
    }
    if(missing(display))
        display <- c("sp", "wa", "lc", "bp", "cn")
    scrs <- scores(model, display = display, ...)
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
