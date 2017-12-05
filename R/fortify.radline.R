##' @title Fortify \code{radline} object
##' @description Prepares a fortified version of \code{radline} object.
##' @param model an object of class \code{radline}.
##' @param data original data set. Currently ignored.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{Species}, \code{Rank}, \code{Type} and \code{Abundance}, showing species name, their rank, type of values (observed or model fitted) and abundance values.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##' @importFrom tidyr gather
##'
##' @author Didzis Elferts
##'
##' @examples
##' data(BCI)
##' mod <- rad.lognormal(BCI[5,])
##' 
##' df <- fortify(mod)
##' ggplot() +
##'     geom_point(data = df[df$Type == "Observed",], aes(Rank, Abundance)) +
##'     geom_line(data = df[df$Type == "Fitted",], aes(Rank, Abundance)) +
##'     scale_y_log10() + labs(color = "Model")
##'    
`fortify.radline` <- function(model, data, ...) {
  
  if (length(model$y) == 0) 
    stop("No species, nothing to fortify")
  if (length(model$y) == 1) 
    stop("There is only one species, nothing to fortify")
  
  df <- data.frame(Species = names(model[["y"]]),
                   Rank = seq_along(model[["y"]]),
                   Observed = as.numeric(model[["y"]]),
                   Fitted = as.numeric(model[["fitted.values"]]))
  df <- gather(df, key = "Type", value = "Abundance", -"Species", -"Rank")
  df
}
