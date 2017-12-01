##' @title Fortify \code{rad} object
##' @description Prepares  a fortified version of \code{rad} object.
##' @param model an object of class \code{rad}.
##' @param data original data set. Currently ignored.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{Species}, \code{Rank} and \code{Abundance}, showing species name, their rank and abundance values.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##'
##' @author Didzis Elferts
##'
##' @examples
##' data(BCI)
##' mod <- rad.lognormal(BCI[5,])
##' 
##' df <- fortify(mod$y)
##' ggplot(df, aes(Rank, Abundance)) +
##'     geom_point() +
##'     scale_y_log10()
##'    
`fortify.rad` <- function(model, data, ...) {
  
  if (length(model) == 0) 
    stop("No species, nothing to fortify")
  if (length(model) == 1) 
    stop("There is only one species, nothing to fortify")
  
  df <- data.frame(Species = names(model),
                   Rank = seq_along(model),
                   Abundance = as.numeric(model))
  df
}
