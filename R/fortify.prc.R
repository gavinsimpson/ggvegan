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
fortify.prc <- function(model, data, scaling = 3, axis = 1,
                        ...) {
    s <- summary(model, scaling = scaling, axis = axis)
    b <- t(coef(s))
    rs <- rownames(b)
    cs <- colnames(b)
    res <- melt(b)
    names(res) <- c("Time", "Treatment", "Response")
    n <- length(s$sp)
    sampLab <- paste(res$Treatment, res$Time, sep = "-")
    res <- rbind(res, cbind(Time = rep(NA, n),
                            Treatment = rep(NA, n),
                            Response = s$sp))
    res$Score <- factor(c(rep("Sample", prod(dim(b))),
                          rep("Species", n)))
    res$Label <- c(sampLab, names(s$sp))
    res
}
