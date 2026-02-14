#' @title Fortify a `"mataMDS"` object.
#'
#' @description
#' Fortifies an object of class `"metaMDS"` to produce a
#' data frame of the selected axis scores in long format, suitable for
#' plotting with [ggplot2::ggplot()].
#'
#' @details
#' TODO
#'
#' @param model,x an object of class `"metaMDS"`, the result of a call
#' to [vegan::metaMDS()].
#' @param data currently ignored.
#' @param ... additional arguments passed to
#' [vegan::scores.metaMDS()]. Note you can't use `display`.
#' @return A data frame in long format containing the ordination scores.
#' The first two components are the axis scores.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom vegan scores
#' @importFrom tibble tibble as_tibble
#' @importFrom dplyr bind_cols
#'
#' @examples
#'
#' library("vegan")
#'
#' data(dune)
#'
#' ord <- metaMDS(dune)
#' head(fortify(ord))
`fortify.metaMDS` <- function(model, data, ...) {
  samp <- scores(model, display = "sites", ...)
  spp <- tryCatch(scores(model, display = "species", ...), error = function(c) {
    NULL
  })
  if (length(spp) > 0L) {
    df <- rbind(samp, spp)
    df <- tibble::as_tibble(as.data.frame(df))
    df <- tibble::add_column(
      df,
      score = factor(rep(c("sites", "species"), c(nrow(samp), nrow(spp)))),
      label = c(rownames(samp), rownames(spp)),
      .before = 1L
    )
  } else {
    df <- tibble(
      score = factor(rep("sites", nrow(samp))),
      label = rownames(samp)
    ) |>
      bind_cols(samp)
  }
  names(df) <- tolower(names(df))
  df
}

#' @export
#' @rdname fortify.metaMDS
#' @importFrom tibble tibble as_tibble
#' @importFrom dplyr bind_cols
`tidy.metaMDS` <- function(x, data, ...) {
  samp <- scores(x, display = "sites", ...)
  spp <- tryCatch(scores(x, display = "species", ...), error = function(c) {
    NULL
  })
  if (length(spp) > 0L) {
    df <- rbind(samp, spp)
    df <- tibble::as_tibble(as.data.frame(df))
    df <- tibble::add_column(
      df,
      score = factor(rep(c("sites", "species"), c(nrow(samp), nrow(spp)))),
      label = c(rownames(samp), rownames(spp)),
      .before = 1L
    )
  } else {
    df <- tibble(
      score = factor(rep("sites", nrow(samp))),
      label = rownames(samp)
    ) |>
      bind_cols(samp)
  }
  names(df) <- tolower(names(df))
  df
}
