## help codetools "find" variables - i.e. ignore the warnings in the
## ggplot() calls below - doing this on per-function basis in case
## R goes that way in the future. As ?globalVariables states, this
## is really active at the package level
if(getRversion() >= "2.15.1") {
    utils::globalVariables(c("Time", "Response", "Treatment"))
}
## end help codetools

##' @title ggplot-based plot for objects of class \code{"prc"}
##'
##' @description
##' Produces a multi-layer ggplot object representing the output of
##' objects produced by \code{\link[vegan]{prc}}.
##'
##' @details
##' TODO
##'
##' @param object an object inheriting from class \code{"prc"}, the
##' result of a call to \code{\link[vegan]{prc}}.
##' @param select a logical vector where \code{TRUE} selects and
##' \code{FALSE} deselects species. Alternatively a numeric vector that
##' contains the indices selecting species. Note that these are with
##' respect to the original species matrix, \strong{not} the fortified
##' object.
##' @param xlab character; label for the x-axis
##' @param ylab character; label for the y-axis
##' @param leg.pos character; position for the legend grob. See argument
##' \code{legend.position} in function \code{\link[ggplot2]{theme}}.
##' @param ... Additional arguments passed to \code{\link{fortify.prc}}.
##'
##' @return Returns a ggplot object.
##'
##' @author Gavin L. Simpson
##'
##' @export
##'
##' @importFrom ggplot2 fortify ggplot geom_hline geom_rug geom_line theme scale_x_continuous xlab ylab aes
##'
##' @examples
##' data(pyrifos)
##' week <- gl(11, 12, labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24))
##' dose <- factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6), 11))
##'
##' ## Fit PRC model
##' mod <- prc(pyrifos, dose, week)
##'
##' ## plot
##' want <- colSums(pyrifos)
##' autoplot(mod, select = want)
`autoplot.prc` <- function(object, select, xlab, ylab, leg.pos = "top", ...) {
    ## fortify the model object
    fobj <- fortify(object, ...)

    ## levels of factors - do this now before we convert things
    TimeLevs <- levels(fobj$Time)
    TreatLevs <- levels(fobj$Treatment)

    ## convert Time to a numeric
    fobj$Time <- as.numeric(as.character(fobj$Time))

    ## process select
    ind <- fobj$Score != "Sample"
    if(missing(select)) {
        select <- rep(TRUE,sum(ind))
    } else {
        stopifnot(isTRUE(all.equal(length(select), sum(ind))))
    }

    ## samples and species "scores"
    samp <- fobj[!ind, ]
    spp <- fobj[ind,][select, ]

    ## base plot
    plt <- ggplot(data = samp,
                  aes(x = Time, y = Response, group = Treatment,
                      colour = Treatment, linetype = Treatment))
    ## add the control
    plt <- plt + geom_hline(yintercept = 0)
    ## add species rug
    plt <- plt +
        geom_rug(data = spp,#subset(fobj, Score != "Sample"),
                 sides = "r",
                 mapping = aes(group = NULL, x = NULL,
                 colour = NULL, linetype = NULL))
    ## add the coefficients
    plt <- plt + geom_line() +
        theme(legend.position = leg.pos) +
            scale_x_continuous(breaks = as.numeric(TimeLevs),
                               minor_breaks = NULL)

    ## add labels
    if(missing(xlab))
        xlab <- "Time"
    if(missing(ylab))
        ylab <- "Response"
    plt <- plt + xlab(xlab) + ylab(ylab)

    ## order for species linestack
    ord <- order(spp$Response)
    spp <- spp[ord, ]

    ## species labels plot
    ## labs <- spp[, "Label"]
    ## yran <- max(samp$Response, na.rm = TRUE) -
    ##     min(samp$Response, na.rm = TRUE)
    ## ht <- 2 *
    ##     (air *
    ##      (sapply(labs,
    ##              function(x) convertHeight(stringHeight(x),
    ##                                        "npc", valueOnly = TRUE)) * yran))
    ## n <- length(labs)
    ## pos <- numeric(n)
    ## mid <- (n + 1) %/% 2
    ## pos[mid] <- spp$Response[mid]
    ## if (n > 1) {
    ##     for (i in (mid + 1):n) {
    ##         pos[i] <- max(spp$Response[i], pos[i - 1] + ht[i])
    ##     }
    ## }
    ## if (n > 2) {
    ##     for (i in (mid - 1):1) {
    ##         pos[i] <- min(spp$Response[i], pos[i + 1] - ht[i])
    ##     }
    ## }
    ## sppDat <- data.frame(y = pos, x = rep(0, n), labs = labs,
    ##                      y0 = spp$Response)

    ## return
    plt
}
