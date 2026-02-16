#' @title Fortify method for `envfit` objects
#'
#' @description Produces a tidy data frame from the results of an
#'   [vegan::envfit()] object.
#' @param model,x an object of class `envfit`, the result of a call to
#'   [vegan::envfit()].
#' @param data additional data to augment the `envfit` results. Currently
#'   ignored.
#' @param ... arguments passed to [vegan::scores.envfit()].
#'
#' @return A data frame with columns `label`, `type`, containing the label for,
#'   and whether each row refers to, the fitted vector or factor. Remaining
#'   variables are coordinates on the respective ordination axes returned by
#'   [vegan::scores.envfit()].
#'
#' @author Gavin L. Simpson
#'
#' @importFrom vegan scores
#' @importFrom tibble as_tibble
#'
#' @export
#'
#' @examples
#'
#' library("vegan")
#'
#' data(varespec, varechem)
#' ord <- metaMDS(varespec)
#' fit <- envfit(ord, varechem, perm = 199)
#'
#' fortify(fit)
#'
#' data(dune, dune.env)
#' ord <- ca(dune)
#' fit <- envfit(ord ~ Moisture + A1, dune.env, perm = 199)
#'
#' fortify(fit)
`fortify.envfit` <- function(model, data, ...) {
  vs <- scores(model, display = "vectors", ...)
  fs <- scores(model, display = "factors", ...)
  df <- as.data.frame(rbind(vs, fs)) |> as_tibble()
  df <- tibble::add_column(
    df,
    label = c(rownames(vs), rownames(fs)),
    type = rep(c("Vector", "Centroid"), times = c(NROW(vs), NROW(fs))),
    .before = 1L
  )
  df
}

#' @export
#' @rdname fortify.envfit
#' @importFrom tibble as_tibble add_column
`tidy.envfit` <- function(x, data, ...) {
  vs <- scores(x, display = "vectors", ...)
  fs <- scores(x, display = "factors", ...)
  df <- as.data.frame(rbind(vs, fs)) |> as_tibble()
  df <- tibble::add_column(
    df,
    label = c(rownames(vs), rownames(fs)),
    type = rep(c("Vector", "Centroid"), times = c(NROW(vs), NROW(fs))),
    .before = 1L
  )
  df
}
