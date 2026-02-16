#' @title Fortify a `"vegan_pco"` object.
#'
#' @description
#' Fortifies an object of class `"vegan_pco"` to produce a
#' data frame of the selected axis scores in long format, suitable for
#' plotting with [ggplot2::ggplot()].
#'
#' @details
#' TODO
#'
#' @param model,x an object of class `"vegan_pco"`, the result of a call to
#' [vegan::pco()].
#' @param ... additional arguments passed to [vegan::scores.rda()].
#'
#' @inheritParams fortify.rda
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
#'
#' sol <- pco(dune)
#' head(fortify(sol))
`fortify.vegan_pco` <- function(
  model,
  data = NULL,
  axes = 1:6,
  ...
) {
  tidy(
    x = model,
    data = data,
    axes = axes,
    ...
  )
}

#' @export
#' @rdname fortify.vegan_pco
#' @inheritParams fortify.rda
`tidy.vegan_pco` <- function(
  x,
  data = NULL,
  axes = 1:6,
  const = NULL,
  ...
) {
  ## extract scores
  scrs <- scores(x, choices = axes, ...)
  ## handle case of only 1 set of scores - must be a list!
  scrs <- list(sites = scrs)
  miss <- vapply(scrs, function(x) all(is.na(x)), logical(1L))
  scrs <- scrs[!miss]
  # build the tibble
  df <- prep_tidy_scores_tbl(scrs)
  df
}
