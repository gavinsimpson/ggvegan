##' @title Fortify analysis of similarities (ANOSIM) results
##' @description Prepares fortified versions of results from \code{\link[vegan]{anosim}} objects.
##' @details TODO
##' @param model an object of class \code{\link[vegan]{anosim}}.
##' @param data original data set. Currently ignored.
##' @param what character; what aspect of the results should be fortified? \code{"ranks"} returns ranks of dissimilarity entries and names of classies. \code{"stats"} returns significance from permutation  and the value of ANOSIM statistic R.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame. For \code{what = "ranks"}, the data frame contains columns \code{'Rank'} and \code{'Class'} with ranks of dissimilarity. For \code{what = "stats"}, the data frame contains columns \code{'Parameter'} and \code{'Value'} with values permutation test and R statistic.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##'
##' @author Didzis Elferts
##'
##' @examples
##' data(dune)
##' data(dune.env)
##' dune.dist <- vegdist(dune)
##' attach(dune.env)
##' dune.ano <- anosim(dune.dist, Management)
##' 
##' df <- fortify(dune.ano, what = "ranks")
##' df.title <- fortify(dune.ano, what = "stats")
##' 
##' ggplot(df, aes(x = Class, y = Rank)) +
##'       geom_boxplot(notch = TRUE, varwidth = TRUE) + 
##'       labs(subtitle = paste("R = ", df.title$Value[2], ", ", "P = ", df.title$Value[1])) +
##'       theme(axis.title = element_blank())
`fortify.anosim` <- function(model, data, 
                             what = c("ranks","stats"),...) {
  
  what <- match.arg(what)
  
  if (isTRUE(all.equal(what, "ranks"))) {
      df <- data.frame(Rank = model$dis.rank,
                   Class = model$class.vec)
  } else {
    if (model$permutations) {
      pval <- format.pval(model$signif)
    }
    else {
      pval <- "not assessed"
    }
    df <- data.frame(Parameter = c("P", "R"),
                     Value = c(pval, round(model$statistic,3)))
  }
  df
}
