##' @title Fortify Renyi and Hill diversity accumulation objects
##' @description Prepares a fortified version from \code{\link[vegan]{renyiaccum}} objects.
##' @param model an object of class \code{\link[vegan]{renyiaccum}}.
##' @param data original data set. Currently ignored.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{Sites}, \code{Scale}, \code{Lower}, \code{Max}, \code{Mean}, \code{Min}, \code{St.dev} and \code{Upper}, showing divesity values at different scales for different number of sites.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##' @importFrom tidyr gather spread
##'
##' @author Didzis Elferts
##'
##' @examples
##' data(BCI)
##' i <- sample(nrow(BCI), 12)
##' mod <- renyiaccum(BCI[i,])
##' df <- fortify(mod)
##' 
##' ggplot(df, aes(Sites, Mean)) +
##'   geom_line() + 
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
  df$Parameter <- rep(c("Mean","St.dev","Min","Max","Lower","Upper"), each = dim(model)[1]*dim(model)[2])
  df <- spread(df,"Parameter","Diversity")
  df[["Scale"]] <- as.factor(df[["Scale"]])
  df
}
