##' @title Fortify a \code{"wcmdscale"} object.
##'
##' @description
##' Fortifies an object of class \code{"wcmdscale"} to produce a
##' data frame of the selected axis scores in long format, suitable for
##' plotting with \code{\link[ggplot2]{ggplot}}.
##'
##' @details
##' TODO
##'
##' @param  model an object of class \code{"wcmdscale"}, the result of a call
##' to \code{\link[vegan]{wcmdscale}} with eig = TRUE.
##' @param data currently ignored.
##' @param ... currently ignored.
##' 
##' @return A data frame in long format containing the ordination scores.
##' 
##' @author Eduard Szoecs eduardszoecs@gmail.com
##'
##' @export
##'
##' @importFrom vegan scores
##'
##' @examples
##' ## load example data
##' data(dune)
##'
##' data(dune)
##' d <- vegdist(decostand(dune, method = 'pa'), method = 'jaccard')
##' ord <- wcmdscale(d, eig = TRUE)
##' head(fortify(ord))
`fortify.wcmdscale` <- function(model, data, ...) {
  samp <- scores(model)
  out <- data.frame(samp, Score = factor(rep("sites", nrow(samp))),
                    Label = rownames(samp))
  attr(out, "dimlabels") <- names(out)[1:2]
  attr(out, 'eig') <- model$eig
  rownames(out) <- NULL
  out
}
