#' @title Fortify analysis of similarities (ANOSIM) results
#'
#' @description Prepares a fortified version of results from [vegan::anosim()]
#'   objects.
#' @param model,x an object of class [vegan::anosim()].
#' @param data original data set. Currently ignored.
#' @param ... additional arguments for other methods. Currently ignored.
#' @return A data frame with columns `Rank` and `Class` with ranks of
#'   dissimilarity.
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#' @importFrom tibble tibble
#'
#' @author Original implementation by Didzis Elferts. Modification to tibbles
#'   by Gavin L. Simpson.
#'
#' @examples
#'
#' library("vegan")
#'
#' library("ggplot2")
#' data(dune, dune.env)
#' dune.dist <- vegdist(dune)
#' dune.ano <- with(dune.env, anosim(dune.dist, Management))
#'
#' df <- fortify(dune.ano)
#'
#' ggplot(df, aes(x = class, y = rank)) +
#'     geom_boxplot(notch = FALSE, varwidth = TRUE)
#'
`fortify.anosim` <- function(model, data, ...) {
  df <- tibble(
    rank = model[["dis.rank"]],
    class = model[["class.vec"]]
  )
  df
}

#' @export
#' @rdname fortify.anosim
`tidy.anosim` <- function(x, data, ...) {
  df <- tibble(
    rank = x[["dis.rank"]],
    class = x[["class.vec"]]
  )
  df
}
