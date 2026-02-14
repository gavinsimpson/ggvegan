#' Fortify permutation statistics
#'
#' @param model,x an object of created by [vegan::permustats()].
#' @param data original data set. Currently ignored.
#' @param scale logical; return standardized effect sizes (SES)?
#' @param ... Other parameters passed to functions (ignored).
#'
#' @importFrom ggplot2 fortify
#' @importFrom stats sd
#' @importFrom tibble tibble
#' @return A tibble with columns `permutations`, and `terms` containing the
#'   values of tests statistics under the null hypothesis, and a factor
#'   labelling the permutation, respectively.
#'
#' @export
#'
#' @examples
#' library("vegan")
#' data(dune, dune.env, package = "vegan")
#' mod <- adonis2(dune ~ Management + A1, data = dune.env)
#' ## use permustats
#' perm <- permustats(mod)
`fortify.permustats` <- function(
  model,
  data,
  scale = FALSE,
  ...
) {
  x <- model$permutations
  if (isTRUE(scale)) {
    scale <- apply(x, 2, sd, na.rm = TRUE)
  }
  x <- scale(x, center = model$statistic, scale = scale)
  lab <- attr(model$statistic, "names")
  # FIXME: do we need the statistic and alternative component
  tibble(
    term = factor(rep(lab, each = nrow(x)), levels = lab),
    permutation = as.vector(x)
  )
}

#' @export
#' @rdname fortify.permustats
`tidy.permustats` <- function(
  x,
  data,
  scale = FALSE,
  ...
) {
  m <- x$permutations
  if (isTRUE(scale)) {
    scale <- apply(m, 2, sd, na.rm = TRUE)
  }
  m <- scale(m, center = x$statistic, scale = scale)
  lab <- attr(x$statistic, "names")
  # FIXME: do we need the statistic and alternative component
  tibble(
    term = factor(rep(lab, each = nrow(m)), levels = lab),
    permutation = as.vector(m)
  )
}
