#' Fortify permutation statistics
#'
#' @param model an object of created by [vegan::permustats()].
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
  tibble(
    permutations = as.vector(x),
    term = factor(rep(lab, each = nrow(x)), levels = lab)
  )
}
