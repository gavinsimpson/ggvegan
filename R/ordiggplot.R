### Creates a ggplot() skeleton to which graphical layers can be added

#' Create a ggplot Object
#'
#' Function `ordiggplot` sets up an ordination graph but draws no
#' result. You can add new graphical elements to this plot with
#' `geom_ordi_*` function of this package, or you can use standard
#' \CRANpkg{ggplot2} `geom_*` functions and use `ggscores`
#' as their `data` argument.
#'
#' The \pkg{ggvegan} package has two contrasting approaches to draw
#' ordination plots. The `autoplot` functions (e.g. [autoplot.rda()],
#' [autoplot.cca()], and [autoplot.metaMDS]) draw a complete plot with one
#' command, but the design is hard-coded in the function. However, you
#' can add new elements to the graph.
#'
#' In contrast, function `ordiggplot()` only sets up an ordination
#' plot, and does not draw anything. It allows you to add layers to the plot
#' one by one with full flexibility of the \CRANpkg{ggplot2} functions.
#' There are some specific functions `geom_ordi_*`
#' functions that are similar as similarly named `geom_*`
#' functions. For these you need to give the type of ordination scores
#' to be added, and in addition, you can give any `geom_*`
#' function arguments to modify the plot. Alternatively, you can use
#' any \pkg{ggplot2} function and in its `data` argument use
#' `ggscores()` function to select the data elements for the
#' function.
#'
#' The `ordiggplot()` function extracts results using
#' `fortify()` functions of this package, and it accepts the
#' arguments of those functions. This allows setting, e.g., the
#' scaling of ordination axes.
#'
#' @param model An ordination result object from \CRANpkg{vegan}.
#' @param axes Two axes to be plotted
#' @param score Ordination score to be added to the plot.
#' @param ... Parameters passed to underlying functions.
#' @param arrow.mul Multiplier to arrow length. If missing, the arrow
#'     length are adjusted to fit to other scores, but if some score
#'     types are not displayed, the arrows may be badly scaled, and
#'     manual adjustment can be useful.
#'
#' @importFrom stats weights
#' @importFrom ggplot2 ggplot coord_fixed aes ggproto
#' @export
#'
#' @return Returns a ggplot object.
#'
#' @examples
#' library("vegan")
#' library("ggplot2")
#' data(dune, dune.env, varespec, varechem)
#' m <- cca(dune ~ Management + A1, dune.env)
#'
#' ## use geom_ordi_* functions
#' ordiggplot(m) + geom_ordi_axis() +
#'   geom_ordi_point("sites") +
#'   geom_ordi_text("species", col = "darkblue",
#'                  mapping = aes(fontface = "italic")) +
#'   geom_ordi_label("centroids") +
#'   geom_ordi_arrow("biplot")
#'
#' ## use ggscores + standard geom_* functions
#' ordiggplot(m, scaling = "sites") +
#'   geom_point(data = ggscores("sites")) +
#'   geom_text(data = ggscores("species"),
#'             mapping = aes(fontface = "italic")) +
#'   geom_label(data = ggscores("centroids"), fill = "yellow") +
#'   geom_ordi_arrow("biplot")
#'
#' ## Messy arrow biplot for PCA
#' m <- rda(dune)
#' ordiggplot(m) +
#'   geom_ordi_axis() +
#'   geom_ordi_point("sites") +
#'   geom_ordi_arrow("species")
`ordiggplot` <- function(model, axes = c(1, 2), arrow.mul, ...) {
  if (length(axes) > 2) {
    stop("only two-dimensional plots made: too many axes defined")
  }
  df <- fortify(model, axes = axes, ...)
  ## I don't currently know a way of adjusting arrows to the final
  ## plot frame, so try to scale them to fit the data points at
  ## least
  isBip <- df$score == "biplot"
  if (any(isBip)) {
    ## remove biplot scores that have equal centroid
    if (any(cntr <- df$score == "centroids")) {
      dup <- isBip & df$label %in% df$label[cntr]
      if (any(dup)) {
        df <- df[!dup, ]
      }
      isBip <- df$score == "biplot"
    }
    if (any(isBip)) {
      # isBip may have changed
      if (missing(arrow.mul)) {
        arrow.mul <- arrow_mul(
          df[isBip, 3:4, drop = FALSE],
          df[!isBip, 3:4, drop = FALSE]
        )
      }
      df[isBip, 3:4] <- df[isBip, 3:4] * arrow.mul
    }
  }
  ## weights are needed in some statistics
  if (inherits(model, c("cca", "wcmdscale", "decorana"))) {
    rw <- weights(model)
    cw <- weights(model, display = "species")
    wts <- rep(NA, nrow(df))
    if (any(want <- df$score == "sites")) {
      wts[want] <- rw
    }
    if (any(want <- df$score == "constraints")) {
      wts[want] <- rw
    }
    if (any(want <- df$score == "species")) {
      wts[want] <- cw
    }
    df$weight <- wts
  }
  dlab <- colnames(df)[3:4]
  pl <- ggplot(
    data = df,
    mapping = aes(
      x = .data[[dlab[1]]],
      y = .data[[dlab[2]]],
      label = .data[["label"]]
    )
  )
  pl <- pl + coord_fixed(ratio = 1)
  pl
}

### add points to the skeleton

#' Add a point layer to an ordiggplot
#'
#' @importFrom ggplot2 geom_point
#'
#' @param score Ordination score to be added to the plot.
#' @param data Alternative data to the function that will be used
#'     instead of `score`.
#' @param ... other arguments passed to [ggplot2::geom_point()]
#'
#' @return Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
#'   object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
#'
#' @export
`geom_ordi_point` <- function(score, data, ...) {
  if (missing(score) && missing(data)) {
    stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ggscores(score)
  }
  geom_point(data = data, ...)
}

### add text to the plot

#' Add a text layer to an ordiggplot
#'
#' @param score Ordination score to be added to the plot.
#' @param data Alternative data to the function that will be used
#'     instead of `score`.
#' @param ... other arguments passed to [ggplot2::geom_text()]
#' @importFrom ggplot2 geom_text
#'
#' @return Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
#'   object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
#'
#' @export
`geom_ordi_text` <- function(score, data, ...) {
  if (missing(score) && missing(data)) {
    stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ~ .x[.x$score == score, ]
  }
  geom_text(data = data, ...)
}

#' Add a label layer to an ordiggplot
#'
#' @param score Ordination score to be added to the plot.
#' @param data Alternative data to the function that will be used
#'     instead of `score`.
#' @param ... other arguments passed to [ggplot2::geom_label()]
#'
#' @return Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
#'   object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
#'
#' @importFrom ggplot2 geom_label
#' @export
`geom_ordi_label` <- function(score, data, ...) {
  if (missing(score) && missing(data)) {
    stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ~ .x[.x$score == score, ]
  }
  geom_label(data = data, ...)
}

#' Add a biplot arrow layer to an ordiggplot
#'
#' @param score Ordination score to be added to the plot.
#' @param data Alternative data to the function that will be used
#'     instead of `score`.
#' @param text Add text labels to the plot.
#' @param box Draw a box behind the text (logical).
#' @param arrow.params,text.params Parameters to modify arrows or
#'   their text labels.
#' @param ... other arguments passed to [ggplot2::geom_segment()],
#'   [ggplot2::geom_label()], or [ggplot2::geom_text()]
#'
#' @importFrom ggplot2 geom_segment geom_label geom_text aes
#' @importFrom grid arrow
#' @importFrom utils modifyList
#'
#' @return Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
#'   object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
#'
#' @export
`geom_ordi_arrow` <- function(
  score,
  data,
  text = TRUE,
  box = FALSE,
  arrow.params = list(),
  text.params = list(),
  ...
) {
  if (missing(score) && missing(data)) {
    stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ggscores(score)
  }
  ## default params & possible modification
  arrowdefs <- list(arrow = arrow(ends = "first", length = unit(0.2, "cm")))
  textdefs <- list(vjust = "outward", hjust = "outward")
  arrowdefs <- modifyList(arrowdefs, arrow.params)
  textdefs <- modifyList(textdefs, text.params)
  dots <- match.call(expand.dots = FALSE)$...
  if (!is.null(dots)) {
    arrowdefs <- modifyList(arrowdefs, dots)
    textdefs <- modifyList(textdefs, dots)
  }
  ## graphics
  pl <- do.call(
    "geom_segment",
    modifyList(list(data = data, mapping = aes(xend = 0, yend = 0)), arrowdefs)
  )
  if (text) {
    if (box) {
      p2 <- do.call("geom_label", modifyList(list(data = data), textdefs))
    } else {
      p2 <- do.call("geom_text", modifyList(list(data = data), textdefs))
    }
    pl <- list(pl, p2) ## ggprotos cannot be added (+)
  }
  pl
}

#' Crosshair for axes in eigenvector methods
#'
#' @param ... other arguments passed to [ggplot2::geom_hline()] and
#' [ggplot2::geom_vline()]
#'
#' @importFrom ggplot2 geom_hline geom_vline
#' @param lty Linetype.
#'
#' @return Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
#'   object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
#'
#' @export
`geom_ordi_axis` <- function(lty = 3, ...) {
  list(
    geom_hline(yintercept = 0, lty = lty, ...),
    geom_vline(xintercept = 0, lty = lty, ...)
  )
}

## envfit, separately for vectorfit & factorfit as these imply
## different geometries. 'edata', 'formula' and 'arrow.mul' can be
## given as parameters, and 'arrow.mul' is calculated in
## StatVectorfit$setup_params if not given.
#' @importFrom stats model.frame
#' @importFrom vegan vectorfit
`calculate_vectorfit` <- function(
  data = data,
  scales,
  vars = c("x", "y"),
  edata,
  formula,
  arrow.mul
) {
  if (!missing(formula) && !is.null(formula)) {
    edata <- model.frame(formula, data)
  } else {
    edata <- data[, names(edata)]
  }
  vecs <- sapply(edata, is.numeric)
  edata <- edata[, vecs, drop = FALSE]
  wts <- data$weight
  fit <- vectorfit(as.matrix(data[, vars]), edata, permutations = 0, w = wts)
  fit <- sqrt(fit$r) * fit$arrows
  fit <- arrow.mul * fit
  fit <- as.data.frame(fit) # as_tibble? FIXME
  fit$label = rownames(fit)
  fit
}

#' @rdname stat_vectorfit
#' @importFrom ggplot2 Stat
#' @format NULL
#' @usage NULL
#' @export
`StatVectorfit` <-
  ggproto(
    "StatVectorfit",
    Stat,
    required_aes = c("x", "y"),
    compute_group = calculate_vectorfit,
    setup_data = function(data, params) {
      data <- cbind(data, params$edata)
      data
    },
    ## same scaling of arrows in all panels
    setup_params = function(data, params) {
      if (!is.null(params$arrow.mul)) {
        return(params)
      }
      if (!is.null(params$formula)) {
        ed <- model.frame(params$formula, params$edata)
      } else {
        ed <- params$edata
      }
      vecs <- sapply(ed, is.numeric)
      ed <- ed[, vecs, drop = FALSE]
      xy <- data[, c("x", "y")]
      if (is.null(data$weight)) {
        data$weight <- 1
      }
      w <- split(data$weight, data$PANEL)
      sxy <- split(xy, data$PANEL)
      ed <- split(ed, data$PANEL)
      arrs <- sapply(seq_len(length(sxy)), function(i) {
        v <- vectorfit(as.matrix(sxy[[i]]), as.matrix(ed[[i]]), w = w[[i]])
        arrow_mul(sqrt(v$r) * v$arrows, as.matrix(xy))
      })
      params$arrow.mul <- min(arrs)
      params
    }
  )

#' @importFrom ggplot2 layer
#' @rdname stat_vectorfit
#'
#' @title Add Fitted Vectors to Ordination plots
#'
#' @description Fits arrows to show the direction of fastest increase
#'  in continuous environmental variables in ordination space.The
#'  arrows are scaled relative to their correlation coefficient,
#'  and they can be added to an ordination plot with [geom_ordi_arrow()].
#'
#' @inheritParams ggplot2::layer
#' @param na.rm Remove missing values (Not Yet Implemented).
#' @param edata Environmental data where the continuous variables are
#'     found.
#' @param formula Formula to select variables from `edata`. If
#'     missing, all continuos variables of `edata` are used.
#' @param arrow.mul Multiplier to arrow length. If missing, the
#'     multiplier is selected automatically so that arrows fit the
#'     current graph.
#' @param ... Other arguments passed to the functions.
#'
#' @export
#'
#' @return Returns a ggplot2 layer or a list of such layers: a `"LayerInstance"`
#'   object that inherits from classes `"Layer"`, `"ggproto"`, and `"gg"`.
#'
#' @examples
#'
#' library("vegan")
#' library("ggplot2")
#' \dontshow{set.seed(1)}
#' data(mite, mite.env)
#' m <- metaMDS(mite, trace = FALSE, trymax = 100)
#'
#' ## add fitted vectors for continuous variables
#' ordiggplot(m) +
#'   geom_ordi_point("sites") +
#'   geom_ordi_arrow("sites", stat = "vectorfit", edata = mite.env)
#'
#' ## can be faceted
#' ordiggplot(m) + geom_ordi_point("sites") +
#'   geom_ordi_arrow("sites", stat = "vectorfit", edata = mite.env) +
#'   facet_wrap(mite.env$Topo)
`stat_vectorfit` <- function(
  mapping = NULL,
  data = NULL,
  geom = "text",
  position = "identity",
  na.rm = FALSE,
  show.legend = FALSE,
  inherit.aes = TRUE,
  edata = NULL,
  formula = NULL,
  arrow.mul = NULL,
  ...
) {
  layer(
    stat = StatVectorfit,
    data = data,
    mapping = mapping,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      edata = edata,
      formula = formula,
      na.rm = na.rm,
      arrow.mul = arrow.mul
    )
  )
}
## extract ordination scores for data statement in ggplot2 functions
#' @rdname ordiggplot
#' @export
`ggscores` <- function(score) {
  ~ .x[.x$score == score, ]
}
