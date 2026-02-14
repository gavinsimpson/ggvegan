#' @title Tidied species octave abundance data
#'
#' @description Prepares a data frame of results from a [vegan::prestonfit()]
#'   object suitable for plotting with [ggplot2::ggplot()].
#' @param model,x an object of class [vegan::prestonfit()].
#' @param data original data set. Currently ignored.
#' @param ... other arguments pass to methods. Currently ignored.
#' @return A data frame with columns `'Octave'`` and `'Abundance'``.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom tibble tibble
#'
#' @examples
#'
#' library("vegan")
#'
#' data(BCI)
#' pfit <- prestonfit(colSums(BCI))
#' fortify(pfit)
`fortify.prestonfit` <- function(model, data, ...) {
  df <- tibble::tibble(
    octave = as.numeric(names(model[['freq']])),
    abundance = unclass(model[['freq']])
  )
  df
}

#' @export
#' @rdname fortify.prestonfit
#' @importFrom tibble as_tibble
`tidy.prestonfit` <- function(x, data, ...) {
  df <- tibble::tibble(
    octave = as.numeric(names(x[['freq']])),
    abundance = unclass(x[['freq']])
  )
  df
}
