#' @title Tidied species rank abundance data and estimated Fisher's log-series
#'
#' @description Prepares a data frame of results from a [vegan::fisherfit()])
#'   object suitable for plotting with [ggplot2::ggplot()]).
#' @param model,x an object of class [vegan::fisherfit()]).
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
#' @importFrom tibble as_tibble
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
    rank = as.numeric(names(model[['fisher']])),
    abundance = unclass(model[['fisher']])
  )
  attr(df, "alpha") <- model[['estimate']]
  attr(df, "k") <- model[['nuisance']]
  df <- as_tibble(df)
  df
}

#' @export
#' @rdname fortify.fisherfit
`tidy.fisherfit` <- function(x, data, ...) {
  df <- data.frame(
    rank = as.numeric(names(x[['fisher']])),
    abundance = unclass(x[['fisher']])
  )
  attr(df, "alpha") <- x[['estimate']]
  attr(df, "k") <- x[['nuisance']]
  df <- as_tibble(df)
  df
}
