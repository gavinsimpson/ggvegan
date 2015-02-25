##' @title Fortify a \code{"mataMDS"} object.
##'
##' @description
##' Fortifies an object of class \code{"metaMDS"} to produce a
##' data frame of the selected axis scores in long format, suitable for
##' plotting with \code{\link[ggplot2]{ggplot}}.
##'
##' @details
##' TODO
##'
##' @param  model an object of class \code{"metaMDS"}, the result of a call
##' to \code{\link[vegan]{metaMDS}}.
##' @param data currently ignored.
##' @param ... additional arguments passed to
##' \code{\link[vegan]{scores.metaMDS}}. Note you can't use \code{display}.
##' @return A data frame in long format containing the ordination scores.
##' The first two components are the axis scores.
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##' @importFrom vegan scores
##'
##' @examples
##' ## load example data
##' data(dune)
##'
##' sol <- metaMDS(dune)
##' head(fortify(sol))
`fortify.metaMDS` <- function(model, data, ...) {
    samp <- scores(model, display = "sites", ...)
    spp <- try(scores(model, display = "species", ...), silent = TRUE)
    if (!is.null(spp) || !inherits(spp, "try-error")) {
        out <- rbind(samp, spp)
        out <- data.frame(out, Score = factor(rep(c("sites","species"),
                               c(nrow(samp), nrow(spp)))),
                          Label = c(rownames(samp), rownames(spp)))
    } else {
        out <- samp
        out <- data.frame(samp, Score = factor(rep("sites", nrow(out))),
                          Label = rownames(samp))
    }
    attr(out, "dimlabels") <- names(out)[1:2]
    rownames(out) <- NULL
    names(out)[1:2] <- paste0("Dim", 1:2)
    out
}
