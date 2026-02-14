#' @title Fortify a `"decorana"` object.
#'
#' @description Fortifies an object of class `"decorana"` to produce a data
#'   frame of the selected axis scores in long format, suitable for plotting
#'   with [ggplot2::ggplot()].
#'
#' @details
#' TODO
#'
#' @param model,x an object of class `"decorana"`, the result of a call to
#' [vegan::decorana()].
#' @param data currently ignored.
#' @param axes numeric; which axis scores are required?
#' @param display character; the scores to extract in the fortified object.
#' @param ... additional arguments passed to [vegan::scores.decorana()].
#' @return A data frame in long format containing the ordination scores. The
#'   first two components are the axis scores.
#'
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
#' sol <- decorana(dune)
#' head(fortify(sol))
#' head(fortify(sol, display = "species"))
`fortify.decorana` <- function(
  model,
  data,
  axes = 1:4,
  display = c("sites", "species"),
  ...
) {
  ## work around the fact that scores.decorana handles only one type of scores
  ## at a time
  scrs <- lapply(
    display,
    function(display, x, ...) scores(x, display = display, ...),
    x = model,
    choices = axes,
    ...
  )
  names(scrs) <- display
  # scrs <- scores(model, choices = axes, display = display, ...)
  miss <- vapply(scrs, function(x) all(is.na(x)), logical(1L))
  scrs <- scrs[!miss]

  # build the tibble
  df <- prep_tidy_scores_tbl(scrs)
  df
}

#' @export
#' @rdname fortify.decorana
`tidy.decorana` <- function(
  x,
  data,
  axes = 1:4,
  display = c("sites", "species"),
  ...
) {
  ## work around the fact that scores.decorana handles only one type of scores
  ## at a time
  scrs <- lapply(
    display,
    function(display, x, ...) scores(x, display = display, ...),
    x = x,
    choices = axes,
    ...
  )
  names(scrs) <- display
  #scrs <- scores(x, choices = axes, display = display, ...)
  miss <- vapply(scrs, function(x) all(is.na(x)), logical(1L))
  scrs <- scrs[!miss]

  # build the tibble
  df <- prep_tidy_scores_tbl(scrs)
  df
}
