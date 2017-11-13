##' @title Fortify a \code{"prc"} object
##'
##' @description
##' Fortifies an object of class \code{"prc"} to produce a
##' data frame of the selected axis scores in long format, suitable for
##' plotting with \code{\link[ggplot2]{ggplot}}.
##'
##' @details
##' TODO
##'
##' @param model an object of class \code{"prc"}, the result of a call to
##' \code{\link[vegan]{prc}}.
##' @param data currently ignored.
##' @param scaling the desired scaling. See \code{\link{scores.cca}} for
##' details.
##' @param axis numeric; which PRC axis to extract. Default is
##' \code{axis = 1}, which is the most generally useful choice.
##' @param ... additional arguments currently ignored.
##' @return A data frame in long format containing the ordination scores.
##' The first three components are the \code{Time}, \code{Treatment}, and
##' associated \code{Response}. The last two components, \code{Score} and
##' \code{Label} are an indictor factor and a label for the rows for use
##' in plotting.
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom stats coef
##' @importFrom ggplot2 fortify
##' @importFrom tidyr gather
##' @importFrom vegan scores
fortify.prc <- function(model, data, scaling = 3, axis = 1, ...) {
    s <- summary(model, scaling = scaling, axis = axis)
    b <- as.data.frame(t(coef(s)))
    dimb <- dim(b)
    rs <- rownames(b)
    cs <- colnames(b)
    b <- cbind(Time = as.numeric(rs), b)
    res <- gather(b, 'Treatment', 'Response', - 'Time')
    ##names(res) <- c("Time", "Treatment", "Response")

    ## insure Treatment is a factor
    res[['Time']] <- factor(res[['Time']], levels = model$terminfo$xlev[[1]])
    res[['Treatment']] <- factor(res[['Treatment']], levels = model$terminfo$xlev[[2]])

    n <- length(s$sp)
    sampLab <- paste(res$Treatment, res$Time, sep = "|")
    res <- rbind(res, cbind(Time = rep(NA, n),
                            Treatment = rep(NA, n),
                            Response = s$sp))
    res <- cbind(Score = factor(c(rep("Sample", prod(dimb)),
                                  rep("Species", n))),
                 Label = c(sampLab, names(s$sp)),
                 res)
    ## return
    res
}
