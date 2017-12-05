##' @title Fortify Renyi and Hill diversity objects
##' @description Prepares a fortified version from \code{\link[vegan]{renyi}} objects.
##' @param model an object of class \code{\link[vegan]{renyi}}.
##' @param data original data set. Currently ignored.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{Scale}, \code{Diversity} and \code{Site}, showing divesity values at different scales. Column \code{Site} produced if more than one site used in analysis.
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
##' mod <- renyi(BCI[i,])
##' df <- fortify(mod)
##' 
##' ggplot(df, aes(x = Scale, y = Diversity)) + 
##'    geom_point() +
##'    facet_wrap(~Site, ncol = 3) 
##'    
`fortify.renyi` <- function(model,data,...){
  if(is.data.frame(model)){
    df <- model
    df$Site <- factor(rownames(df))
    df <- gather(df,"Scale","Diversity", -"Site")
    df$Scale <- factor(df$Scale, levels = colnames(model))
  } else {
    df <- data.frame(Diversity = model,
                     Scale = factor(names(model), levels = names(model)))
    row.names(df) <- NULL
  }
  df
}
