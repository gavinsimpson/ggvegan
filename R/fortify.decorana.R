#' @title Fortify a \code{"decorana"} object.
#'
#' @description Fortifies an object of class \code{"decorana"} to produce a data frame of the selected axis scores in long format, suitable for plotting with \code{\link[ggplot2]{ggplot}}.
#'
#' @details
#' TODO
#'
#' @param model an object of class \code{"decorana"}, the result of a call to
#' \code{\link[vegan]{decorana}}.
#' @param data currently ignored.
#' @param axes numeric; which axis scores are required?
#' @param display character; the scores to extract in the fortified object.
#' @param ... additional arguments passed to \code{\link[vegan]{scores.decorana}}.
#' @return A data frame in long format containing the ordination scores. The first two components are the axis scores.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom vegan scores
#'
#' @examples
#' data(dune)
#'
#' sol <- decorana(dune)
#' head(fortify(sol))
#' head(fortify(sol, display = "species"))
`fortify.decorana` <- function(model, data, axes = 1:4,
                               display = c("sites", "species"), ...) {
    ## need to work around the fact that scores.decorana handles only one type of scores
    ## at a time
    scrs <- lapply(display,
                   function(display, x, ...) scores(x, display = display, ...),
                   x = model, choices = axes, ...)
    miss <- vapply(scrs, function(x ) all(is.na(x)), logical(1L))
    scrs <- scrs[!miss]
    nr <- vapply(scrs, FUN = NROW, FUN.VALUE = integer(1))
    df <- do.call('rbind', scrs)
    rownames(df) <- NULL
    df <- as.data.frame(df)
    df <- cbind(score = factor(rep(display, times = nr)),
                label = unlist(lapply(scrs, rownames), use.names = FALSE),
                df)
    df
}
