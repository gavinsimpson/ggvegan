#' @title Fortify \enc{Rényi}{Renyi} accumulation curves
#'
#' @description Prepares a fortified version of results from
#'   [vegan::renyiaccum()] objects.
#'
#' @param model,x an object of class [vegan::renyiaccum()].
#' @param data original data set. Currently ignored.
#' @param ... additional arguments passed to other methods. Ignored in this
#'   method.
#'
#' @return A data frame (tibble) is returned. What is returned depends on how
#'   [vegan::renyiaccum()] was called.
#'   If `raw = FALSE`, then a data frame with columns `site`, `scale`, `mean`,
#'   `std_dev`, `min`, `max`, `q2.5`, and `q97.5`, containing the accumulated
#'   sites, the \enc{Rényi}{Renyi} scale, and summary statistics of the
#'   \enc{Rényi}{Renyi} accumulation curves. An additional column `collector`
#'   will be present if `collector = TRUE` was used in the [vegan::renyiaccum()]
#'   call.
#'   If `raw = TRUE`, then a data frame with columns `site`, `permutation`,
#'   `scale`, and `diversity`, containing the `site` and `permutation`
#'   identifiers, \enc{Rényi}{Renyi} scale, and the \enc{Rényi}{Renyi}
#'   diversity, respectively.
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom tibble as_tibble
#' @importFrom vctrs vec_rbind vec_cbind vec_rep vec_rep_each
#'
#' @author Gavin L. Simpson much rewritten from an original by Didzis Elferts.
#' @examples
#'
#' library("vegan")
#' library("ggplot2")
#' data(BCI)
#' pool <- renyiaccum(BCI)
#' df <- fortify(pool)
#' df
#'
#' ggplot(df, aes(x = site, y = mean)) +
#'     geom_ribbon(aes(ymin = q2.5, ymax = q97.5, x = site),
#'                 alpha = 0.2, inherit.aes = FALSE) +
#'     geom_line() +
#'     facet_wrap(~ scale)
`fortify.renyiaccum` <- function(model, data, ...) {
  dn_names <- dimnames(model) |> names()

  df <- if (identical(dn_names[3], "permutation")) {
    fortify_renyi_permuted(model)
  } else {
    fortify_renyi_accum(model)
  }

  df
}

#' @importFrom tibble as_tibble
#' @importFrom vctrs vec_rbind vec_cbind vec_rep vec_rep_each
`fortify_renyi_accum` <- function(model) {
  dn <- dimnames(model)[["scale"]]
  n_pooled <- dim(model)[[1]]
  m <- lapply(
    split(
      model,
      arrayInd(seq_along(model), dim(model))[, 2]
    ),
    FUN = \(x, dim, dn) {
      array(x, dim = dim, dimnames = dn) |>
        as.data.frame() |>
        as_tibble()
    },
    dim = dim(model)[-2],
    dn = dimnames(model)[-2]
  )
  # might need .names_to = rlang::zap(), but it works without
  df <- vec_rbind(!!!m)
  new_dn <- c("mean", "std_dev", "min", "max", "q2.5", "q97.5", "collector")
  if (length(names(m[[1]])) < 7L) {
    # must not have the collectors curve
    new_dn <- new_dn[-7L]
  }
  df <- setNames(df, new_dn)
  df <- vec_cbind(
    site = vec_rep(seq_len(n_pooled), times = length(dn)),
    scale = vec_rep_each(dn, times = n_pooled),
    df
  )
  df
}

#' @importFrom tibble as_tibble
#' @importFrom vctrs vec_rbind vec_cbind vec_rep vec_rep_each
#' @importFrom tidyr pivot_longer
`fortify_renyi_permuted` <- function(model) {
  model <- aperm(model, c(3, 1, 2))
  dn <- dimnames(model)[["scale"]]
  dims <- dim(model)
  n_sites <- dims[2]
  n_perm <- dims[1]
  m <- lapply(
    split(
      model,
      arrayInd(seq_along(model), dim(model))[, 2]
    ),
    FUN = \(x, dim, dn) {
      array(x, dim = dim, dimnames = dn) |>
        as.data.frame() |>
        as_tibble()
    },
    dim = dim(model)[-2],
    dn = dimnames(model)[-2]
  )
  # might need .names_to = rlang::zap(), but it works without
  df <- vec_rbind(!!!m)
  df <- vec_cbind(
    site = vec_rep_each(seq_len(n_sites), times = n_perm),
    permutation = vec_rep(seq_len(n_perm), times = n_sites),
    df
  )
  df |>
    pivot_longer(
      cols = !c("site", "permutation"),
      names_to = "scale",
      values_to = "diversity"
    )
}

#' @export
#' @rdname fortify.renyiaccum
#' @importFrom tibble as_tibble
`tidy.renyiaccum` <- function(x, data, ...) {
  dn_names <- dimnames(x) |> names()

  df <- if (identical(dn_names[3], "permutation")) {
    fortify_renyi_permuted(x)
  } else {
    fortify_renyi_accum(x)
  }

  df
}
