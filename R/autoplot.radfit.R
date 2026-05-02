### Rank-Abundance Distribution models: ggplot2 alternatives to
### lattice graphics in vegan.

#' Autoplot graphics for vegan rank-abundance models
#'
#' \pkg{ggplot2} graphics for Rank-Abundance Distribution models
#' fitted with \pkg{vegan} functions [vegan::radfit()] or produced
#' with [vegan::as.rad()].
#'
#' The [ggplot2::autoplot()] function draws graphics which are \pkg{ggplot2}
#' alternatives for \CRANpkg{lattice} graphics in \pkg{vegan}. In
#' addition, there are functions for [vegan::as.rad()]
#' results which do not have dedicated graphics in\pkg{vegan}.
#'
#' @param object Result object from \code{\link[vegan]{radfit}}.
#' @param facet Draw each fitted model to a separate facet or (if
#'     \code{FALSE}) all fitted lines to a single graph.
#' @param point.params,line.params Parameters to modify points or
#'     lines (passed to \code{\link[ggplot2]{geom_point}} and
#'     \code{\link[ggplot2]{geom_line}}).
#' @param ... Additional arguments passed to the functions.
#'
#' @return Returns a ggplot object.
#' @author Jari Oksanen
#'
#' @importFrom ggplot2 ggplot aes scale_y_log10 facet_wrap geom_point
#'     geom_line fortify autoplot
#' @importFrom scales oob_squish_infinite
#' @importFrom utils modifyList
#' @importFrom rlang !!!
#'
#' @export
#' @examples
#' library(vegan)
#' library(ggplot2)
#' data(mite)
#' m1 <- radfit(mite[1, ])
#'
#' ## With logarithmic y-axis (default) Pre-emption model is a line
#' autoplot(m1) +
#'   labs(title="log-Abundance: Pre-emption model is a line")
#'
#' ## With log-log scale, Zipf model is a line
#' autoplot(m1) +
#'   scale_x_log10() +
#'   labs(title="log-log Scale: Zipf model is a line")
#'
#' ## Show only the best model
#' autoplot(m1, pick = "AIC")
#'
#' ## Show selected models in one frame
#' autoplot(m1, pick = c("Z","M","L"), facet=FALSE)
#'
#' ## plot best models for several sites
#' m <- radfit(mite[1:12,])
#' autoplot(m) +
#'   labs(title = "Model Selection AIC (Default)")
#'
#' ## use BIC and reorder sites by their diversity
#' autoplot(m, pick="BIC", order.by = diversity(mite[1:12,])) +
#'    labs(title="Model Selection BIC, Ordered by Increasing Diversity")
#'
#' ## Plot RAD models without fits highlighting most abundant species in the
#' ## whole data.
#' m0 <- as.rad(mite[1:12,])
#' dominants <- names(sort(colSums(mite), decreasing = TRUE))[1:6]
#' autoplot(m0, highlight = dominants)
`autoplot.radfit` <- function(
  object,
  facet = TRUE,
  point.params = list(),
  line.params = list(),
  ...
) {
  df <- fortify(object, ...)
  ymin <- min(1, df$abundance)
  point.params <- modifyList(
    list(mapping = aes(y = .data[["abundance"]])),
    point.params
  )
  line.params <- modifyList(
    list(mapping = aes(y = .data[["Fit"]], colour = .data[["Model"]])),
    line.params
  )
  pl <- ggplot(df, aes(.data[["Rank"]])) +
    scale_y_log10(limit = c(ymin, NA), oob = oob_squish_infinite) +
    #do.call("geom_point", point.params) +
    #do.call("geom_line", line.params)
    geom_point(!!!point.params) +
    geom_line(!!!line.params)
  if (facet) {
    pl <- pl + facet_wrap(~Model)
  }
  pl
}

#' @importFrom ggplot2 fortify aes scale_y_log10 geom_point geom_line
#'     facet_wrap
#' @importFrom scales oob_squish_infinite
#' @importFrom utils modifyList
#' @importFrom rlang !!!
#'
#' @rdname autoplot.radfit
#' @export
`autoplot.radfit.frame` <- function(
  object,
  point.params = list(),
  line.params = list(),
  ...
) {
  df <- fortify(object, ...)
  ymin <- min(1, df$abundance)
  point.params <- modifyList(
    list(mapping = aes(y = .data[["abundance"]])),
    point.params
  )
  line.params <- modifyList(
    list(mapping = aes(y = .data[["fit"]], colour = .data[["model"]])),
    line.params
  )
  ggplot(df, aes(.data[["rank"]])) +
    scale_y_log10(limit = c(ymin, NA), oob = oob_squish_infinite) +
    geom_point(!!!point.params) +
    geom_line(!!!line.params) +
    facet_wrap(~Site)
}

#' @importFrom ggplot2 ggplot scale_y_log10 geom_point geom_line aes
#'   fortify
#' @importFrom utils modifyList
#' @importFrom rlang !!!
#' @rdname autoplot.radfit
#' @export
`autoplot.radline` <- function(
  object,
  point.params = list(),
  line.params = list(),
  ...
) {
  df <- fortify(object, ...)
  ymin <- min(1, df$abundance)
  point.params <- modifyList(
    list(mapping = aes(y = .data[["abundance"]])),
    point.params
  )
  line.params <- modifyList(
    list(mapping = aes(y = .data[["fit"]])),
    line.params
  )
  ggplot(df, aes(.data[["rank"]])) +
    scale_y_log10() + # no lower limit for a single line
    geom_point(!!!point.params) +
    geom_line(!!!line.params)
}

### Methods for rad: only points, no lines from vegan::as.rad()

#' @importFrom utils modifyList
#' @importFrom ggplot2 aes scale_y_log10 geom_point
#' @importFrom rlang !!!
#' @rdname autoplot.radfit
#' @export
`autoplot.rad` <- function(
  object,
  point.params = list(),
  line.params = list(),
  ...
) {
  df <- fortify(object, ...)
  ymin <- min(1, df$abundance)
  point.params <- modifyList(
    list(mapping = aes(y = .data[["abundance"]])),
    point.params
  )
  ggplot(df, aes(.data[["rank"]])) +
    scale_y_log10() + # no lower limit for a single line
    # do.call("geom_point", point.params)
    geom_point(!!!point.params)
}

#' @param highlight Names of species that should be highlighted as
#'   coloured points.
#' @importFrom utils modifyList
#' @importFrom ggplot2 aes scale_colour_discrete scale_y_log10
#'   geom_point facet_wrap
#' @rdname autoplot.radfit
#' @export
`autoplot.rad.frame` <- function(
  object,
  point.params = list(),
  highlight = NULL,
  ...
) {
  df <- fortify(object, ...)
  ymin <- min(1, df$abundance)
  point.params <- modifyList(
    list(mapping = aes(y = .data[["abundance"]])),
    point.params
  )
  pl <- ggplot(df, aes(.data[["rank"]])) +
    scale_y_log10(limit = c(ymin, NA)) +
    do.call("geom_point", point.params) +
    facet_wrap(~site)
  if (!is.null(highlight)) {
    highlight <- factor(highlight, levels = highlight)
    for (sp in highlight) {
      pl <- pl +
        geom_point(
          data = df[df$species == sp, , drop = FALSE],
          aes(y = .data[["abundance"]], colour = .data[["species"]])
        )
    }
    pl <- pl + scale_colour_discrete(highlight, name = "species")
  }
  pl
}
