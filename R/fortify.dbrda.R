#' @title Fortify a `"dbrda"` object.
#'
#' @description
#' Fortifies an object of class `"dbrda"` to produce a
#' data frame of the selected axis scores in long format, suitable for
#' plotting with [ggplot2::ggplot()].
#'
#' @details
#' TODO
#'
#' @param model,x an object of class `"dbrda"`, the result of a call to
#' [vegan::dbrda()].
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
#' sol <- dbrda(dune ~ A1 + Management, data = dune.env)
#' head(fortify(sol))
`fortify.dbrda` <- function(
  model,
  data = NULL,
  axes = 1:6,
  layers = c("wa", "lc", "bp", "reg", "cn"),
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
#' @rdname fortify.dbrda
`tidy.dbrda` <- function(
  x,
  data = NULL,
  axes = 1:6,
  layers = c("wa", "lc", "bp", "reg", "cn"),
  const = NULL,
  ...
) {
  # handle const because it has to be missing in scores
  const <- rda_constant(x, const)
  ## extract scores
  scrs <- scores(x, choices = axes, display = layers_to_display(layers), ...)
  ## handle case of only 1 set of scores
  if (length(layers) == 1L) {
    scrs <- list(scrs)
    nam <- switch(
      layers,
      sp = "species",
      species = "species",
      wa = "sites",
      sites = "sites",
      lc = "constraints",
      bp = "biplot",
      cn = "centroids",
      stop("Unknown value for 'layers'")
    )
    names(scrs) <- nam
  }
  miss <- vapply(scrs, function(x) all(is.na(x)), logical(1L))
  scrs <- scrs[!miss]
  # build the tibble
  df <- prep_tidy_scores_tbl(scrs)
  df
}
