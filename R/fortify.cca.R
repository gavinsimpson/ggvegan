#' @title Fortify a `"cca"` object.
#'
#' @description
#' Fortifies an object of class `"cca"` to produce a
#' data frame of the selected axis scores in long format, suitable for
#' plotting with [ggplot2::ggplot()].
#'
#' @details
#' TODO
#'
#' @param model,x an object of class `"cca"`, the result of a call to
#' [vegan::cca()], [vegan::rda()], or [vegan::capscale()].
#' @param data currently ignored.
#' @param axes numeric; which axes to extract scores for.
#' @param display numeric; the scores to extract in the fortified object.
#' @param ... additional arguments passed to [vegan::scores.cca()],
#'   and [vegan::scores.rda()].
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
#' sol <- cca(dune ~ A1 + Management, data = dune.env)
#' head(fortify(sol))
`fortify.cca` <- function(
  model,
  data,
  axes = 1:6,
  display = c("sp", "wa", "lc", "bp", "cn"),
  ...
) {
  ## extract scores
  scrs <- scores(model, choices = axes, display = display, ...)
  ## handle case of only 1 set of scores
  if (length(display) == 1L) {
    scrs <- list(scrs)
    nam <- switch(
      display,
      sp = "species",
      species = "species",
      wa = "sites",
      sites = "sites",
      lc = "constraints",
      bp = "biplot",
      cn = "centroids",
      stop("Unknown value for 'display'")
    )
    names(scrs) <- nam
  }
  miss <- vapply(scrs, function(x) all(is.na(x)), logical(1L))
  scrs <- scrs[!miss]
  # build the tibble
  df <- prep_tidy_scores_tbl(scrs)
  df
}

#' @export
#' @rdname fortify.cca
`tidy.cca` <- function(
  x,
  data,
  axes = 1:6,
  display = c("sp", "wa", "lc", "bp", "cn"),
  ...
) {
  ## extract scores
  scrs <- scores(x, choices = axes, display = display, ...)
  ## handle case of only 1 set of scores
  if (length(display) == 1L) {
    scrs <- list(scrs)
    nam <- switch(
      display,
      sp = "species",
      species = "species",
      wa = "sites",
      sites = "sites",
      lc = "constraints",
      bp = "biplot",
      cn = "centroids",
      stop("Unknown value for 'display'")
    )
    names(scrs) <- nam
  }
  miss <- vapply(scrs, function(x) all(is.na(x)), logical(1L))
  scrs <- scrs[!miss]
  # build the tibble
  df <- prep_tidy_scores_tbl(scrs)
  df
}
