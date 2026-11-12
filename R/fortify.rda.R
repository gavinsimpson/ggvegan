#' @title Fortify a `"rda"` object.
#'
#' @description
#' Fortifies an object of class `"rda"` to produce a
#' data frame of the selected axis scores in long format, suitable for
#' plotting with [ggplot2::ggplot()].
#'
#' @details
#' TODO
#'
#' @param model,x an object of class `"rda"`, the result of a call to
#' [vegan::rda()].
#' @param const NULL; General scaling constant to RDA scores. See
#'   [vegan::scores.rda()] for the details.
#' @param ... additional arguments passed to [vegan::scores.rda()].
#'
#' @inheritParams fortify.cca
#'
#' @return A data frame (tibble) in long format containing the ordination
#'   scores. The first two components are `score` (the type of score in each
#'   row) and `label` (the text label to use on plots for this row). The
#'   remaining columns are the extracted ordination axis scores.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom vegan scores
#'
#' @examples
#'
#' library("vegan")
#'
#' data(dune)
#' data(dune.env)
#'
#' sol <- rda(dune ~ A1 + Management, data = dune.env)
#' head(fortify(sol))
`fortify.rda` <- function(
  model,
  data = NULL,
  axes = 1:6,
  layers = c("sp", "wa", "lc", "bp", "cn"),
  const = NULL,
  ...
) {
  tidy(
    x = model,
    data = data,
    axes = axes,
    layers = layers,
    const = const,
    ...
  )
}

#' @export
#' @rdname fortify.rda
`tidy.rda` <- function(
  x,
  data = NULL,
  axes = 1:6,
  layers = c("sp", "wa", "lc", "bp", "reg", "cn"),
  const = NULL,
  ...
) {
  tidy_cca_scores(x, axes, layers, ..., const = const)
}
