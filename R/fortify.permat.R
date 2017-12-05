##' @title Fortify matrix permutation algorithms for presence-absence and count data results
##' @description Prepares a fortified version of results from \code{permat} objects.
##' @param model an object of class \code{permat}.
##' @param data original data set. Currently ignored.
##' @param ... additional arguments for other methods. Currently ignored.
##' @return A data frame with columns \code{Runs}, \code{Dissimilarity} and \code{Type}, showing number of runs, dissimilarity index and type of dissimilarity values.
##'
##' @export
##'
##' @importFrom ggplot2 fortify
##' @importFrom stats is.ts time
##'
##' @author Didzis Elferts
##'
##' @examples
##' data(BCI)
##' perm <- permatswap(BCI, "quasiswap", times=19)
##' df <- fortify(perm)
##' 
##' ggplot(df, aes(x = Runs, y = Dissimilarity)) + 
##'    geom_line() +
##'    facet_wrap(~Type, ncol = 2) 
##'    
`fortify.permat` <- function(model, data, ...) {
  if(is.ts(summary(model)$bray)){
    df <- rbind(data.frame(Runs = as.numeric(time(summary(model)[["bray"]])),
                           Dissimilarity = as.numeric(summary(model)[["bray"]]),
                           Type = "Bray"),
                data.frame(Runs = as.numeric(time(summary(model)[["chisq"]])),
                           Dissimilarity = as.numeric(summary(model)[["chisq"]]),
                           Type = "Chisq"))
  } else {
    df <- rbind(data.frame(Runs = 1:attr(model, "times"),
                           Dissimilarity = as.numeric(summary(model)[["bray"]]),
                           Type = "Bray"),
                data.frame(Runs = 1:attr(model, "times"),
                           Dissimilarity = as.numeric(summary(model)[["chisq"]]),
                           Type = "Chisq"))
  }
  df
}
