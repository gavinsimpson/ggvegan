#' Autoplot Graphics for vegan permustats Objects
#'
#' Alternatives for \pkg{lattice} graphics functions
#' [vegan::densityplot.permustats()],
#' [vegan::densityplot.permustats()] and
#' [vegan::boxplot.permustats()].
#'
#' Function `fortify()` returns a data frame with variables `permutations`
#' (numeric) and `term` (factor labelling the permutation). The result of
#' `fortify()` can be used to custom build diagnostic plots. `autoplot()`
#' provides basic plots of [vegan::permustats()] objects with limited
#' flexibility.
#'
#' @param object object from [vegan::permustats()].
#' @param plot character; the type of plot, or a geom from \pkg{ggplot2}.
#' @param scale logical; use standardized effect sizes (SES)?
#' @param facet logical; should the plot be faceted by `term`?
#' @param gg.params list; arguments passed to function drawing the box-like
#'   object. Depending on argument `plot` the parameters are passed to
#'   [ggplot2::geom_boxplot()], [ggplot2::geom_violin()],
#'   [ggplot2::geom_density()] or [ggplot2::geom_qq()].
#' @param ... Other parameters passed to functions (ignored).
#'
#' @importFrom ggplot2 fortify ggplot aes geom_hline geom_vline geom_boxplot
#'   geom_violin geom_density geom_qq facet_wrap
#' @importFrom utils modifyList
#' @importFrom dplyr .data
#'
#' @return Returns a ggplot object.
#'
#' @rdname autoplot.permustats
#' @export
#' @examples
#'
#' library("vegan")
#'
#' data(dune, dune.env)
#' mod <- cca(dune ~ A1 + Management + Moisture, dune.env)
#' (ano <- anova(mod, by = "onedf"))
#' pstat <- permustats(ano)
#' head(fortify(pstat))
#' autoplot(pstat, "box")
#'
#'
#' if (requireNamespace("ggplot2")) {
#'   library("ggplot2")
#'
#'   # avoid overplotting x-axis text
#'   autoplot(pstat, "violin") +
#'     scale_x_discrete(guide = guide_axis(n.dodge = 2))
#'
#'   autoplot(pstat, "qqnorm", facet = TRUE) +
#'     geom_qq_line()
#' }
#'
#' autoplot(pstat, "density", facet = TRUE)
`autoplot.permustats` <- function(
  object,
  plot = c("box", "violin", "density", "qqnorm"),
  scale = FALSE,
  facet = FALSE,
  gg.params = list(),
  ...
) {
  df <- fortify(object, scale = scale)
  plot <- match.arg(plot)
  if (plot != "qqnorm") {
    gg.params <- modifyList(list(alpha = 0.5), gg.params)
  }
  pl <- switch(
    plot,
    "box" = ,
    "violin" = ggplot(
      df,
      aes(
        x = .data[["term"]],
        y = .data[["permutation"]],
        fill = .data[["term"]],
        colour = .data[["term"]]
      )
    ),
    "density" = ggplot(
      df,
      aes(
        x = .data[["permutation"]],
        fill = .data[["term"]],
        colour = .data[["term"]]
      )
    ),
    "qqnorm" = ggplot(
      df,
      aes(
        sample = .data[["permutation"]],
        colour = .data[["term"]]
      )
    )
  )

  if (!scale) {
    pl <- pl +
      switch(
        plot,
        "density" = geom_vline(
          xintercept = 0,
          linetype = 3
        ),
        geom_hline(
          yintercept = 0,
          linetype = 3
        )
      )
  }
  pl <- pl +
    switch(
      plot,
      "box" = do.call("geom_boxplot", gg.params),
      "violin" = do.call("geom_violin", gg.params),
      "density" = do.call("geom_density", gg.params),
      "qqnorm" = do.call("geom_qq", gg.params)
    )
  if (facet) {
    pl <- pl + facet_wrap(~term)
  }
  pl
}
