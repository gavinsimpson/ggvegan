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
#' @param legend.position Legend position: see [ggplot2::theme()] for
#'   details. Use `"none"` to not draw the legend.
#' @param ... Parameters passed to underlying functions.

#' @importFrom stats weights
#' @importFrom ggplot2 ggplot coord_fixed aes ggproto
#' @export
#'
#' @return Returns a ggplot object with slot `data` for full
#'   ordination data and slot mapping where ordination axes are mapped
#'   to `x` and `y`, `label` for text labels for each row and factor
#'   `score` type mapped to `colour`.
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
`ordiggplot` <- function(
  model,
  axes = c(1, 2),
  legend.position = "right",
  ...
) {
  if (length(axes) > 2) {
    stop("only two-dimensional plots made: too many axes defined")
  }
  if (is.data.frame(model) &&
      all(c("score", "label") %in% colnames(model))) {
    df <- model
  } else {
    df <- fortify(model, axes = axes, ...)
  }
  ## I don't currently know a way of adjusting biplot arrows to the
  ## final axis dimensions on plot. However, constraints (lc scores)
  ## are found from regression coefficients and biplots are fitted to
  ## the constraints: it is prudent to adjust arrow lengths to lc
  ## scores. The following will be skipped for non-CCA family of
  ## methods which do not have any of these items (but we may need to
  ## add if(inherits(model, "cca")) block to be sure with future
  ## methods.
  isBip <- df$score == "biplot"
  if (any(isBip)) {
    ## remove biplot scores that have equal centroid
    if (any(cntr <- df$score == "centroids")) {
      dup <- isBip & df$label %in% df$label[cntr]
      if (any(dup)) {
        df <- df[!dup, ]
      }
    }
    ## Same scaling with all biplot-like arrows
    isBip <- df$score %in% c("biplot", "regression", "factorbiplot")
    if (any(isBip)) {
      arrow.mul <- arrow_mul(
          df[isBip, 3:4, drop = FALSE],
          df[df$score == "constraints", 3:4, drop = FALSE]
      )
    }
    arrow.mul <- max(arrow.mul, 1)
    df[isBip, 3:4] <- df[isBip, 3:4] * arrow.mul
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
  } else {
    df$weight <- 1
  }
  dlab <- colnames(df)[3:4]
  pl <- ggplot(
    data = df,
    mapping = aes(
      x = .data[[dlab[1]]],
      y = .data[[dlab[2]]],
      label = .data[["label"]],
      colour = .data[["score"]]
    )
  )
  pl <- pl +
    coord_fixed(ratio = 1) +
    theme(legend.position = legend.position)
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
#' @return Returns a ggplot2 layer `geom_point`.
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
#'   instead of `score`. This can be a [vegan::envfit()] result object
#'   which is used to plot centroids of factor levels.
#' @param ... other arguments passed to [ggplot2::geom_text()]
#' @importFrom ggplot2 geom_text
#'
#' @return Returns a ggplot2 layer `geom_text`.
#'
#' @export
`geom_ordi_text` <- function(score, data, ...) {
  if (missing(score) && missing(data)) {
    stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ggscores(score)
  } else if (inherits(data, "envfit")) {
    data <- fortify(data)
    data$score <- "gradient"
    colnames(data) <- tolower(colnames(data))
    want <- data[["type"]] == "Centroid"
    data <- data[want,]
  }
  geom_text(data = data, ...)
}

#' Add a label layer to an ordiggplot
#'
#' @param score Ordination score to be added to the plot.
#' @param data Alternative data to the function that will be used
#'   instead of `score`. This can be a [vegan::envfit()] result object
#'   which is used to plot centroids of factor levels.
#' @param ... other arguments passed to [ggplot2::geom_label()]
#'
#' @return Returns a ggplot2 layer `geom_label`.
#'
#' @importFrom ggplot2 geom_label
#' @export
`geom_ordi_label` <- function(score, data, ...) {
  if (missing(score) && missing(data)) {
    stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ggscores(score)
  } else if (inherits(data, "envfit")) {
    data <- fortify(data)
    data$score <- "gradient"
    colnames(data) <- tolower(colnames(data))
    want <- data[["type"]] == "Centroid"
    data <- data[want,]
  }
  geom_label(data = data, ...)
}

#' Add a biplot arrow layer to an ordiggplot
#'
#' @param score Ordination score to be added to the plot.
#' @param data Alternative data to the function that will be used
#'   instead of `score`. This can be a [vegan::envfit] result object
#'   which is used to draw arrows to fitted vectors.
#' @param text Add text labels to the plot.
#' @param box Draw a box behind the text (logical).
#' @param arrow.mul Arrow multiplier.
#' @param arrow.params,text.params Parameters to modify arrows or
#'   their text labels.
#' @param ... other arguments passed to [ggplot2::geom_segment()],
#'   [ggplot2::geom_label()], or [ggplot2::geom_text()]
#'
#' @importFrom ggplot2 geom_segment geom_label geom_text aes
#' @importFrom grid arrow
#' @importFrom utils modifyList
#'
#' @return Returns ggplot2 layers `geom_segment` for arrows and
#'   `geom_text` or `geom_label` (optionally) for their names.
#'
#' @export
`geom_ordi_arrow` <- function(
  score,
  data,
  text = TRUE,
  box = FALSE,
  arrow.mul = 1,
  arrow.params = list(),
  text.params = list(),
  ...
) {
  if (missing(score) && missing(data)) {
    stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ggscores(score)
  } else if (inherits(data, "envfit")) {
    data <- fortify(data)
    data$score <- "gradient"
    colnames(data) <- tolower(colnames(data))
    want <- data[["type"]] == "Vector"
    data <- data[want, ]
    vars <- 3:4
    data[, vars] <- arrow.mul * data[, vars]
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
    ## calculated stat "vectorfit" needs weight that is in .data but
    ## not mapped by default
    if (!is.null(dots$stat) && dots$stat == "vectorfit") {
      arrowdefs <- modifyList(arrowdefs,
                              list(mapping = aes(weight = .data[["weight"]])))
      textdefs <- modifyList(textdefs,
                             list(mapping = aes(weight = .data[["weight"]])))
    }
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

#' Add points and their labels to the plot. The labels are repelled
#' from other pitems to minimize overplotting.
#'
#' Function adds points to the exact position of the ordination score
#' with a label, but labels are repelled from each other to avoid
#' over-plotting. In very congested areas, the labels are completely
#' omitted.
#'
#' @param score Ordination score added to the plot.
#' @param data Alternative data to the function that will be used
#'   instead of `score`. This function does *not* handle
#'   [vegan::envfit()] results.
#' @param box Draw a box behind the text (logical).
#' @param points Draw points (logical).
#' @param point.params,text.params Parameters to modify points or
#'   their repelled text labels.
#' @param ... other arguments passed to [ggrepel::geom_text_repel()]
#'   and [ggrepel::geom_label_repel()].
#'
#' @return Returns ggrepel layers `geom_text_repel` or
#'   `geom_label_repel` and  ggplot2 layer `geom_point` (optionally).
#'
#' @examples
#' library(vegan)
#' data(mite, mite.env, package = "vegan")
#' mod <- cca(mite)
#' ordiggplot(mod) +
#'   geom_ordi_axis() +
#'   geom_ordi_point("sites")
#'   geom_ordi_repel("species",
#'     text.params = list(size=3, fontface = "italic"))
#'
#' @importFrom utils modifyList
#' @importFrom ggrepel geom_text_repel geom_label_repel
#'
#' @export
`geom_ordi_repel` <- function(
  score,
  data,
  box = FALSE,
  points = TRUE,
  point.params = list(),
  text.params = list(),
  ...
) {
  if (missing(score) && missing(data)) {
      stop("either score or data must be defined")
  }
  if (missing(data)) {
    data <- ggscores(score)
  }
  dots <- match.call(expand.dots = FALSE)$...
  layerdef <- list(data = data)
  if (!is.null(dots)) {
    layerdef <- modifyList(layerdef, dots)
  }
  pp <- pt <- NULL
  if (points) {
    pp <- do.call("geom_point", modifyList(layerdef, point.params))
  }
  layerdef <- modifyList(layerdef, list(size = 3))
  if (box) {
    pt <- do.call("geom_label_repel", modifyList(layerdef, text.params))
  } else {
    pt <- do.call("geom_text_repel", modifyList(layerdef, text.params))
  }
  c(pp, pt)
}

#' Crosshair for axes in eigenvector methods
#'
#' @param ... other arguments passed to [ggplot2::geom_hline()] and
#' [ggplot2::geom_vline()]
#'
#' @importFrom ggplot2 geom_hline geom_vline
#' @param lty Linetype.
#'
#' @return Returns  ggplot2 layers `geom_hline` and `geom_vline`.
#'
#' @export
`geom_ordi_axis` <- function(lty = 3, ...) {
  list(
    geom_hline(yintercept = 0, lty = lty, ...),
    geom_vline(xintercept = 0, lty = lty, ...)
  )
}

#' Add ordisurf Result as Contours in Ordination plot
#'
#' Function adds [vegan::ordisurf] result object
#'
#' @param object [vegan::ordisurf] result object.
#' @param fill Use filled contours.
#' @param ... Other arguments passed to [ggplot2::geom_contour] or
#'   [ggplot2::geom_contour_filled].
#'
#' @author Jari Oksanen
#' @examples
#' library(vegan)
#' library(ggplot2)
#' data(mite, mite.env, package="vegan")
#' mod <- cca(mite)
#' surf <- ordisurf(mod ~ WatrCont, mite.env, plot = FALSE)
#' ordiggplot(mod) +
#'   geom_ordi_point("sites") +
#'   autolayer(surf) +
#'   autolayer(envfit(mod ~ WatrCont, mite.env, permutations=0),
#'     arrow.mul = 1.3)
#'
#' @return Returns ggplot2 layers `geom_contour` and `geom_raster`
#'   (optionally).
#'
#' @importFrom ggplot2 autolayer geom_contour geom_raster
#' @importFrom stats complete.cases
#'
#' @export
`autolayer.ordisurf` <- function(object, fill = FALSE, ...) {
  x <- object$grid$x
  y <- object$grid$y
  z <- as.vector(object$grid$z)
  df <- expand.grid("x" = x, "y" = y)
  df$label <- "surface"
  df$score <- "surface"
  df$z <- z
  df <- df[complete.cases(df),] # warns on NA outside hull
  ## geom_contour_filled returns discrete coverclasses, geom_raster a
  ## smooth surface
  pf <- pl <- NULL
  if (fill) { # should we have fill.params, contour.params lists?
    pf <- geom_raster(mapping = aes(
                          .data[["x"]],
                          .data[["y"]],
                          fill = .data[["z"]]),
                      data = df, ...)
    }
    pl <- geom_contour(mapping=aes(
                           .data[["x"]],
                           .data[["y"]],
                           z = .data[["z"]]),
                       data = df, ...)

  c(pf, pl)
}

## add precalculated envfit object as arrows & text

#' Add envfit Results to Ordination
#'
#' Function adds fitted vector arrays via [geom_ordi_arrow] and factor
#' centroids via [geom_ordi_text] or [geom_ordi_label].
#'
#' @param object [vegan::envfit()] result object
#' @param text add text to plot.
#' @param box write text on a non-transparent label.
#' @param arrow.mul arro multiplier.
#' @param arrow.params,text.params List of additional parameters to
#'   arrows and text.
#' @param ... Other parameters passed to all graphical functions
#'   [geom_ordi_arrow], [geom_ordi_text] and [geom_ordi_label].
#'
#' @return Returns ggplot2 layers `geom_segment` for arrows (when
#'   appropriate), and `geom_text` or `geom_label` for text.
#'
#' @examples
#' library(vegan)
#' library(ggplot2)
#' data(mite, mite.env, package = "vegan")
#' mod <- cca(mite)
#' ef <- envfit(mod ~ Shrub+Topo+WatrCont+SubsDens, mite.env)
#' ordiggplot(mod, scaling="sites") +
#'   geom_ordi_axis() +
#'   geom_ordi_point("sites") +
#'   autolayer(ef, arrow.mul=1.3, col="navy", box=TRUE,
#'     text.params=list(mapping=aes(fontface="bold")))
#'
#' @importFrom ggplot2 autolayer
#' @importFrom utils modifyList
#' @rdname autolayer.envfit
#' @export
`autolayer.envfit` <- function(
   object,
   text = TRUE,
   box = FALSE,
   arrow.mul = 1,
   arrow.params = list(),
   text.params = list(),
   ...
) {
  data <- object # would be prudent to change every 'data' to 'object'
  if (!is.null(data$vectors)) {
    colnames(data$vectors$arrows) <-
      tolower(colnames(data$vectors$arrows))
  }
  if (!is.null(data$factors)) {
    colnames(data$factors$centroids) <-
      tolower(colnames(data$factors$centroids))
  }
  dots <- match.call(expand.dots = FALSE)$...
  if (!is.null(dots)) {
    if (!is.null(arrow.params))
      arrow.params <- modifyList(arrow.params, dots)
    if (!is.null(text.params))
      text.params <- modifyList(text.params, dots)
  }
  pvec <- pfac <- NULL
  if (!is.null(data$vectors)) {
    pvec <- geom_ordi_arrow(
        data=data,
        text = text,
        box = box,
        arrow.mul = arrow.mul,
        arrow.params = arrow.params,
        text.params = text.params,
        ...
    )
  }
  if (!is.null(data$factors) && text) {
    textcall <- list(data=data)
    if (!is.null(text.params)) {
      textcall <- modifyList(textcall, text.params)
    }
    if (box) {
      pfac <- do.call("geom_ordi_label", textcall)
    } else {
      pfac <- do.call("geom_ordi_text", textcall)
    }
  }
  c(pvec, pfac)
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
    edata <- model.frame(formula, edata)
  }
  vecs <- sapply(edata, is.numeric)
  ed <- edata[, vecs, drop=FALSE]
  if (NROW(ed) != NROW(data)) {
      ed <- ed[data$label, , drop = FALSE]
  }
  wts <- data[["weight"]]
  fit <- vectorfit(as.matrix(data[, vars]), ed, permutations = 0, w = wts)
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
    required_aes = c("x", "y", "weight"),
    dropped_aes = c("weight"),
    extra_params = c("na.rm", "edata", "formula", "arrow.mul"),
    compute_group = calculate_vectorfit,
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
#' @return Returns a layer that containts a StatVectorfit object that
#'   is responsible for rendering the fitted vectors in the plot.
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
      arrow.mul = arrow.mul,
      ...
    )
  )
}
## extract ordination scores for data statement in ggplot2 functions
#' @rdname ordiggplot
#' @export
`ggscores` <- function(score) {
  ~ .x[.x$score == score, ]
}
