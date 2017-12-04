##' @title Fortify Renyi and Hill diversity accumulation objects
##' @description Prepares a fortified version from \code{\link[vegan]{renyiaccum}} objects.
##' @param model an object of class \code{\link[vegan]{renyiaccum}}.
##' @param data original data set. Currently ignored.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{Scale}, \code{Diversity}, \code{Sites} and \code{Parameter}, showing divesity values at different scales for different number of sites. Column \code{Parameter} contains type of diversity value - mean, standart deviation, minimal, maximal, 2.5% and 97.5% quantiles.
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
##' i <- sample(nrow(BCI), 12)
##' mod <- renyiaccum(BCI[i,])
##' df <- fortify(mod)
##' 
##' ggplot() +
##'   geom_line(data = df[df$Parameter == "mean",], aes(Sites, Diversity), color = "red") +
##'   geom_line(data = df[df$Parameter == "Qnt 0.025",], aes(Sites, Diversity), color = "blue") +
##'   geom_line(data = df[df$Parameter == "Qnt 0.975",], aes(Sites, Diversity), color = "blue") +
##'   facet_wrap(~ Scale, nrow = 2)  
##'    
`fortify.renyiaccum` <- function(model,data,...){
  
  mod_list <- lapply(seq(dim(model)[3]), function(x) model[ , , x])
  mod_list <- lapply(mod_list, function(x) {
    df <- as.data.frame(x)
    df$Sites <- as.numeric(rownames(df))
    df <- gather(df,"Scale","Diversity", -"Sites")
    df
  })
  
  df <- do.call("rbind",mod_list)
  df$Parameter <- rep(c("mean","stdev","min","max","Qnt 0.025","Qnt 0.975"), each = dim(model)[1]*dim(model)[2])
  df
}
