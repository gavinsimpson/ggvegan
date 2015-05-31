##' @title Fortify a \code{"decorana"} object.
##'
##' @description Fortifies an object of class \code{"decorana"} to produce a data frame of the selected axis scores in long format, suitable for plotting with \code{\link[ggplot2]{ggplot}}.
##'
##' @details
##' TODO
##'
##' @param model an object of class \code{"decorana"}, the result of a call to
##' \code{\link[vegan]{decorana}}.
##' @param data currently ignored.
##' @param display character; the scores to extract in the fortified object.
##' @param choices numeric; which axis scores are required?
##' @param ... additional arguments passed to \code{\link[vegan]{scores.decorana}}.
##' @return A data frame in long format containing the ordination scores. The first two components are the axis scores.
##'
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##' @importFrom vegan scores
##'
##' @examples
##' data(dune)
##'
##' sol <- decorana(dune)
##' head(fortify.decorana(sol))
##' head(fortify(sol, display = "species"))
`fortify.decorana` <- function(model, data, display = c("sites", "species"),
                               choices = c(1,2), ...) {
    ## need to work around the fact that scores.decorana handles only one type of scores
    ## at a time
    scrs <- lapply(display,
                   function(display, x, ...) scores(x, display = display, ...),
                   x = model, choices = choices, ...)
    names(scrs) <- display
    rnam <- lapply(scrs, rownames)
    take <- !sapply(rnam, is.null)
    rnam <- unlist(rnam[take], use.names = FALSE)
    scrs <- scrs[take]
    fdf <- do.call(rbind, scrs)
    rownames(fdf) <- NULL
    fdf <- data.frame(fdf)
    lens <- sapply(scrs, scoresLength)
    fdf$Score <- factor(rep(names(lens), times = lens))
    fdf$Label <- rnam
    attr(fdf, "dimlabels") <- names(fdf)[1:2]
    names(fdf)[1:2] <- paste0("Dim", 1:2)
    fdf
}
