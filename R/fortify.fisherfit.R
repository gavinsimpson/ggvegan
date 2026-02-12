#' @title Tidied species rank abundance data and estimated Fisher's log-series
#'
#' @description Prepares a data frame of results from a [vegan::fisherfit()])
#'   object suitable for plotting with [ggplot2::ggplot()]).
#' @param model an object of class [vegan::fisherfit()]).
#' @param data original data set. Currently ignored.
#' @param ... other arguments pass to methods. Currently ignored.
#' @return A data frame with columns `'Rank'` and `'Abundance'`. Additionally,
#'   Fisher's \eqn{\alpha} and the nuisance parameter are returned as
#'   attributes `'alpha'` and `'k'` respectively.
#'
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#'
#' @examples
#'
#' library("vegan")
#'
#' data(BCI)
#' mod <- fisherfit(BCI[5,])
#' head(fortify(mod))
`fortify.fisherfit` <- function(model, data, ...) {
  df <- data.frame(
    Rank = as.numeric(names(model[['fisher']])),
    Abundance = unclass(model[['fisher']])
  )
  attr(df, "alpha") <- model[['estimate']]
  attr(df, "k") <- model[['nuisance']]
  df
}
