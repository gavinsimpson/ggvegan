### fortify permustats objects

#' Autoplot Graphics for vegan permustats Objects
#'
#' Alternatives for \pkg{lattice} graphics functions
#' \code{\link[vegan]{densityplot.permustats}},
#' \code{\link[vegan]{qqmath.permustats}} and
#' \code{\link[vegan]{boxplot.permustats}}.
#'
#' Function \code{fortify} returns a data frame with variables
#' \code{Permutations} (numeric) and \code{Term} (factor labelling the
#' permutation). The result of \code{fortify} can be used to custom
#' build diagnostic plots. \code{autoplot} provides quick basic graphs
#' with limited flexibility.
#'
#' @param object Result object from \code{\link[vegan]{permustats}}.
#' @param plot Plot type, or geometry of \pkg{ggplot2}.
#' @param scale Use standardized effect sizes (SES).
#' @param facet Split graph to facets by \code{Term}.
#' @param alpha alpha channel of geometry.
#' @param ... Other parameters passed to functions (ignored).
#'
#' @examples
#' data(dune, dune.env)
#' mod <- cca(dune ~ A1 + Management + Moisture, dune.env)
#' (ano <- anova(mod, by="onedf"))
#' pstat <- permustats(ano)
#' head(fortify(pstat))
#' autoplot(pstat, "box")
#' autoplot(pstat, "violin")
#' autoplot(pstat, "density", facet = TRUE)
#' autoplot(pstat, "qqnorm")
#'

#' @importFrom ggplot2 fortify ggplot aes_ geom_hline geom_vline geom_boxplot
#' geom_violin geom_density geom_qq facet_wrap
#'
#' @rdname autoplot.permustats
#' @export
`autoplot.permustats` <-
    function(object, plot = c("box", "violin", "density", "qqnorm"),
             scale = FALSE, facet = FALSE, alpha = 0.5, ...)
{
    df <- fortify(object, scale = scale)
    plot <- match.arg(plot)
    pl <-
        switch(plot,
               "box" =,
               "violin" = ggplot(df,
                                 aes_(~Term, ~Permutations, fill=~Term,
                                     colour=~Term)),
               "density" = ggplot(df, aes_(~Permutations, fill = ~Term,
                                          colour=~Term)),
               "qqnorm" = ggplot(df, aes_(sample = ~Permutations, colour=~Term)))
    if(!scale) {
        pl <- pl + switch(plot,
                          "density" = geom_vline(xintercept=0, lty=3),
                          geom_hline(yintercept = 0, lty=3))
    }
    pl <- pl +
        switch(plot,
               "box" = geom_boxplot(alpha = alpha),
               "violin" = geom_violin(alpha = alpha),
               "density" = geom_density(alpha = alpha),
               "qqnorm" = geom_qq(alpha = alpha))
    if (facet)
        pl <- pl + facet_wrap(~Term)
    pl
}
#'
#' @inheritParams ggplot2::fortify
#'
#' @importFrom ggplot2 fortify
#' @importFrom stats sd
#'
#' @rdname autoplot.permustats
#' @export
`fortify.permustats` <-
    function(model, data, scale = FALSE, ...)
{
    x <- model$permutations
    if (isTRUE(scale))
        scale <- apply(x, 2, sd, na.rm = TRUE)
    x <- scale(x, center = model$statistic, scale = scale)
    lab <- attr(model$statistic, "names")
    data.frame("Permutations" = as.vector(x),
               "Term" = factor(rep(lab, each = nrow(x)), levels=lab))
}
