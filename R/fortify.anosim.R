#' @title Fortify analysis of similarities (ANOSIM) results
#'
#' @description Prepares a fortified version of results from [vegan::anosim()]
#'   objects.
#' @param model an object of class [vegan::anosim()].
#' @param data original data set. Currently ignored.
#' @param ... additional arguments for other methods. Currently ignored.
#' @return A data frame with columns `Rank` and `Class` with ranks of
#'   dissimilarity.
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#'
#' @author Didzis Elferts
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
#' ggplot(df, aes(x = Class, y = Rank)) +
#'     geom_boxplot(notch = FALSE, varwidth = TRUE)
#'
`fortify.anosim` <- function(model, data, ...) {
  df <- data.frame(Rank = model[["dis.rank"]], Class = model[["class.vec"]])
  df
}
