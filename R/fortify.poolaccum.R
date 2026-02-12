#' @title Fortify extrapolated species richness of a species pool
#'
#' @description Prepares a fortified version of results from
#'   [vegan::poolaccum()] objects.
#'
#' @param model an object of class [vegan::poolaccum()].
#' @param data original data set. Currently ignored.
#' @param alpha level of quantiles for envelopes shown (default 0.05).
#' @param ... additional arguments passed to [vegan::summary.poolaccum()],
#'   notably `display` to control which indices should be computed.
#'
#' @return A data frame with columns `index`, `size`, `richness`, `lower`,
#'   `upper`, and `std_dev`, containing the richness index, permutation richness
#'   estimator, sample size, upper and lower \eqn{1 - \alpha}{1 - alpha}
#'   quantile interval, and standard deviation of permutation estimates,
#'   respectively.
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom tibble as_tibble
#' @importFrom vctrs vec_cbind
#'
#' @author Gavin L. Simpson & Didzis Elferts
#' @examples
#'
#' library("vegan")
#' library("ggplot2")
#' data(BCI)
#' pool <- poolaccum(BCI)
#' df <- fortify(pool)
#' df
#'
#' ggplot(df, aes(x = size, y = richness, colour = index)) +
#'     geom_ribbon(aes(ymin = lower, ymax = upper, x = size, fill = index),
#'                 alpha = 0.3, inherit.aes = FALSE) +
#'     geom_line() +
#'     facet_wrap(~ index)
`fortify.poolaccum` <- function(model, data, alpha = 0.05, ...) {
  m <- summary(model, alpha = alpha, ...)
  lens <- vapply(
    m, FUN = NROW, FUN.VALUE = numeric(1), USE.NAMES = FALSE
  )
  vars <- vapply(
    m, FUN = \(x) colnames(x)[2], FUN.VALUE = character(1),
    USE.NAMES = FALSE
  )
  df <- do.call("rbind", m) |>
    as.data.frame() |>
    setNames(c("size", "richness", "lower", "upper", "std_dev")) |>
    as_tibble()
  df <- vec_cbind(
    index = factor(rep(vars, times = lens)),
    df
  )
  df
}
