#' @title Tidied species octave abundance data
#'
#' @description Prepares a data frame of results from a \code{\link{fisherfit}} object suitable for plotting with \code{\link{ggplot}}.
#' @param model an object of class \code{\link{prestonfit}}
#' @param data original data set. Currently ignored.
#' @param ... other arguments pass to methods. Currently ignored.
#' @return A data frame with columns \code{'Octave'} and \code{'Abundance'}.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#'
#' @examples
#'
#' data(BCI)
#' pfit <- prestonfit(colSums(BCI))
#' head(fortify(pfit))
`fortify.prestonfit` <- function(model, data, ...) {
    df <- data.frame(Octave = as.numeric(names(model[['freq']])),
                     Abundance = unclass(model[['freq']]))
    df
}
