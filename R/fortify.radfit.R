##' @title Fortify \code{radfit} object
##' @description Prepares a fortified version of \code{\link[vegan]{radfit}} object.
##' @param model an object of class \code{radfit}.
##' @param data original data set. Currently ignored.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{Species}, \code{Rank}, \code{Type} and \code{Abundance}, showing species name, their rank, type of values (observed or model fitted) and abundance values.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##' @importFrom tidyr gather
##' @importFrom stats fitted
##'
##' @author Didzis Elferts
##'
##' @examples
##' data(BCI)
##' mod <- radfit(BCI[5,])
##' 
##' df <- fortify(mod)
##' ggplot() +
##'     geom_point(data = df[df$Type == "Observed",], aes(Rank, Abundance)) +
##'     geom_line(data = df[df$Type != "Observed",], aes(Rank, Abundance, color = Type)) +
##'     scale_y_log10() + labs(color = "Model")
##'    
`fortify.radfit` <- function(model, data, ...) {
  
  if (length(model$y) == 0) 
    stop("No species, nothing to fortify")
  if (length(model$y) == 1) 
    stop("There is only one species, nothing to fortify")
  
  fit <- data.frame(fitted(model))
  row.names(fit) <- NULL
  
  df <- data.frame(Species = names(model[["y"]]),
                   Rank = seq_along(model[["y"]]),
                   Observed = as.numeric(model[["y"]]),
                   fit)
  
  df <- gather(df, key = "Type", value = "Abundance", -"Species", -"Rank")
  df
}