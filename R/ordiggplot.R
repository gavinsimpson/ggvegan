### Creates a ggplot() skeleton to which graphical layers can be added

#' Create a ggplot Object
#'
#' Function \code{ordiggplot} sets up an ordination graph but draws no
#' result. You can add new graphical elements to this plot with
#' \code{geom_ordi*} function of this package, or you can use standard
#' \CRANpkg{ggplot2} \code{geom_*} functions and use \code{ggscores}
#' as their \code{data=} argument.
#'
#' The \pkg{ggvegan} package has two contrasting approaches to draw
#' ordination plots. The \code{autoplot} functions
#' (e.g. \code{\link{autoplot.rda}}, \code{\link{autoplot.cca}},
#' \code{\link{autoplot.metaMDS}}) draw a complete plot with one
#' command, but the design is hard-coded in the function. However, you
#' but can add new elements to the graph.
#'
#' In contrast, function \code{ordiggplot} only sets up an ordination
#' plot, but draws no result. It allows you to add layers to the graph
#' one by one with full flexibility of the \CRANpkg{ggplot2}
#' functions. There are some specific functions \code{geom_ordi*}
#' functions that are similar as similarly named \code{geom_*}
#' functions. For these you need to give the name of ordination score
#' to be added, and in addition, you can give any \code{geom_}
#' function arguments to modify the plot. Alternatively, you can use
#' any \pkg{ggplot2} function and in its \code{data=} argument use
#' \code{ggscores} function to select the data elements for the
#' function.
#'
#' The \code{ordiggplot} function extracts results using
#' \code{fortify} functions of this package, and it accepts the
#' arguments of those functions. This allows setting, e.g., the
#' scaling of ordination axes.
#' @param model An ordination result object from \CRANpkg{vegan}.
#' @param axes Two axes to be plotted
#' @param Score Ordination score to be added to the plot.
#' @param box Draw a box behind the text (logical).
#' @param text Add text labels to the plot.
#' @param ... Parameters passed to underlying functions.
#'
#'
#'
#' @examples
#' data(dune, dune.env, varespec, varechem)
#' m <- cca(dune ~ Management + A1, dune.env)
#' ## use geom_ordi* functions
#' ordiggplot(m) + geom_ordiaxis() + geom_ordipoint("sites") +
#'   geom_orditext("species", col="darkblue", mapping=aes(fontface="italic")) +
#'   geom_ordilabel("centroids") + geom_ordiarrow("biplot")
#' ## use ggscores + standard geom_* functions
#' ordiggplot(m, scaling="sites") + geom_point(data=ggscores("sites")) +
#'    geom_text(data=ggscores("species"), mapping=aes(fontface="italic")) +
#'    geom_label(data=ggscores("centroids"), fill="yellow") +
#'    geom_ordiarrow("biplot")
#' ## Messy arrow biplot for PCA
#' m <- rda(dune)
#' ordiggplot(m) + geom_ordiaxis() + geom_ordipoint("sites") +
#'    geom_ordiarrow("species")
#' ## Fitted vectors, selecting variables with formula
#' m <- metaMDS(varespec, trace=FALSE)
#' ordiggplot(m) + geom_ordipoint("sites") +
#'    geom_ordiarrow("sites", stat="vectorfit", edata=varechem,
#'    formula = ~ N + Ca + Al + Humdepth + pH)
#'
#' @importFrom stats weights
#' @importFrom ggplot2 ggplot coord_fixed aes_string
#'
#' @param arrowmul Multiplier to arrow length. If missing, the arrow
#'     length are adjusted to fit to other scores, but if some score
#'     types are not displayed, the arrows may be badly scaled, and
#'     manual adjustment can be useful.
#' @export
`ordiggplot` <-
    function(model, axes = c(1,2), arrowmul, ...)
{
    if (length(axes) > 2)
        stop("only two-dimensional plots made: too many axes defined")
    df <- fortify(model, axes = axes, ...)
    ## I don't currently know a way of adjusting arrows to the final
    ## plot frame, so try to scale them to fit the data points at
    ## least
    isBip <- df$Score == "biplot"
    if (any(isBip)) {
        ## remove biplot scores that have equal centroid
        if (any(cntr <- df$Score == "centroids")) {
            dup <- isBip & df$Label %in% df$Label[cntr]
            if (any(dup))
                df <- df[!dup,]
            isBip <- df$Score == "biplot"
        }
        if (any(isBip)) { # isBip may have changed
            if (missing(arrowmul))
                arrowmul <- arrowMul(df[isBip, 3:4, drop=FALSE],
                                     df[!isBip, 3:4, drop=FALSE])
            df[isBip, 3:4] <- df[isBip, 3:4] * arrowmul
        }
    }
    ## weights are needed in some statistics
    if (inherits(model, c("cca", "wcmdscale", "decorana"))) {
        rw <- weights(model)
        cw <- weights(model, display="species")
        wts <- rep(NA, nrow(df))
        if (any(want <- df$Score == "sites"))
            wts[want] <- rw
        if (any(want <- df$Score == "constraints"))
            wts[want] <- rw
        if (any(want <- df$Score == "species"))
            wts[want] <- cw
        df$weight <- wts
    }
    dlab <- colnames(df)[3:4]
    pl <- ggplot(data = df, mapping=aes_string(dlab[1], dlab[2],
                 label="Label"))
    pl <- pl + coord_fixed(ratio=1)
    pl
}

### add points to the skeleton

#' @importFrom ggplot2 geom_point

#' @rdname ordiggplot
#'
#' @param data Alternative data to the function that will be used
#'     instead of \code{Score}.
#'
#' @export
`geom_ordipoint` <-
    function(Score, data,...)
{
    if (missing(Score) && missing(data))
        stop("either Score or data must be defined")
    if (missing(data))
        data <- ggscores(Score)
    geom_point(data = data, ...)
}

### add text to the plot

#' @importFrom ggplot2 geom_label geom_text

#' @rdname ordiggplot
#' @export
`geom_orditext` <-
    function(Score, data, ...)
{
    if (missing(Score) && missing(data))
        stop("either Score or data must be defined")
    if (missing(data))
        data <- ~.x[.x$Score == Score,]
    geom_text(data = data, ...)
}
#' @rdname ordiggplot
#' @export
`geom_ordilabel` <-
    function(Score, data, ...)
{
    if (missing(Score) && missing(data))
        stop("either Score or data must be defined")
    if (missing(data))
        data <- ~.x[.x$Score == Score,]
    geom_label(data = data, ...)
}
#' @importFrom ggplot2 geom_segment geom_label geom_text aes
#' @importFrom grid arrow
#' @rdname ordiggplot
#' @export
`geom_ordiarrow` <-
    function(Score, data, text = TRUE, box = FALSE, ...)
{
    if (missing(Score) && missing(data))
        stop("either Score or data must be defined")
    if (missing(data))
        data <- ggscores(Score)
    pl <- geom_segment(data = data, mapping = aes(xend = 0, yend = 0),
                       arrow = arrow(ends = "first", length=unit(0.2, "cm")),
                       ...)
    if (text) {
        if(box)
            p2 <- geom_label(data = data, vjust = "outward", hjust = "outward",
                             ...)
        else
            p2 <- geom_text(data = data, vjust = "outward", hjust = "outward",
                            ...)
        pl <- list(pl, p2) ## ggprotos cannot be added (+)
    }
    pl
}

## crosshair for axes in eigenvector methods

#' @importFrom ggplot2 geom_hline geom_vline
#' @rdname ordiggplot
#' @param lty Linetype.
#'
#' @export
`geom_ordiaxis` <-
    function(lty = 3, ...)
{
    list(
        geom_hline(yintercept = 0, lty = lty, ...),
        geom_vline(xintercept = 0, lty = lty, ...)
    )
}

## envfit, separately for vectorfit & factorfit as these imply
## different geometries. 'edata', 'formula' and 'arrowmul' can be
## given as parameters, and 'arrowmul' is calculated in
## StatVectorfit$setup_params if not given.
#' @importFrom stats model.frame
#' @importFrom vegan vectorfit

`calculate_vectorfit` <-
    function(data = data, scales, vars = c("x", "y"), edata, formula, arrowmul)
{
    if(!missing(formula) && !is.null(formula))
        edata <- model.frame(formula, data)
    else
        edata <- data[, names(edata)]
    vecs <- sapply(edata, is.numeric)
    edata <- edata[, vecs, drop=FALSE]
    wts <- data$weight
    fit <- vectorfit(as.matrix(data[, vars]), edata, permutations=0, w=wts)
    fit <- sqrt(fit$r) * fit$arrows
    fit <- arrowmul * fit
    fit <- as.data.frame(fit)
    fit$label = rownames(fit)
    fit
}

#' @rdname stat_vectorfit
#' @format NULL
#' @usage NULL
#' @export
`StatVectorfit` <-
    ggproto("StatVectorfit", Stat,
            required_aes = c("x","y"),
            compute_group = calculate_vectorfit,
            setup_data = function(data, params) {
               data <- cbind(data, params$edata)
               data
            },
            ## same scaling of arrows in all panels
            setup_params = function(data, params) {
               if (!is.null(params$arrowmul))
                   return(params)
               if (!is.null(params$formula))
                   ed <- model.frame(params$formula, params$edata)
               else
                   ed <- params$edata
               vecs <- sapply(ed, is.numeric)
               ed <- ed[,vecs, drop=FALSE]
               xy <- data[, c("x","y")]
               if (is.null(data$weight))
                   data$weight <- 1
               w <- split(data$weight, data$PANEL)
               sxy <- split(xy, data$PANEL)
               ed <- split(ed, data$PANEL)
               arrs <- sapply(seq_len(length(sxy)), function(i) {
                   v <- vectorfit(as.matrix(sxy[[i]]), as.matrix(ed[[i]]), w=w[[i]])
                   ggvegan:::arrowMul(sqrt(v$r)*v$arrows, as.matrix(xy))
               })
               params$arrowmul <- min(arrs)
               params
            }
    )

#' @importFrom ggplot2 layer
#' @rdname stat_vectorfit
#'
#' @title Add Fitted Vectors to Ordination plots
#'
#' @description Fits arrows to show the direction of fastest increase
#'     in continuous environmental variables in ordination space.The
#'     arrows are scaled relative to their correlation coefficient,
#'     and they can be added to an ordination plot with
#'     \code{\link{geom_ordiarrow}}.
#'
#' @inheritParams ggplot2::layer
#' @param na.rm Remove missing values (Not Yet Implemented).
#' @param edata Environmental data where the continuous variables are
#'     found.
#' @param formula Formula to select variables from \code{edata}. If
#'     missing, all continuos variables of \code{edata} are used.
#' @param arrowmul Multiplier to arrow length. If missing, the
#'     multiplier is selected automatically so that arrows fit the
#'     current graph.
#' @param ... Other arguments passed to the functions.
#' 
#' @examples
#' data(mite, mite.env)
#' m <- metaMDS(mite, trace=FALSE, trymax=100)
#' ## add fitted vectors for continuous variables
#' ordiggplot(m) + geom_ordipoint("sites") +
#'   geom_ordiarrow("sites", edata=mite.env)
#' ## can be faceted
#' ordiggplot(m) + geom_ordipoint("sites") +
#'   geom_ordiarrow("sites", edata=mite.env) +
#'   facet_wrap(mite.env$Topo)
#' @export
`stat_vectorfit` <-
    function(mapping = NULL, data = NULL,
             geom = "text", position = "identity",
             na.rm = FALSE, show.legend = FALSE, inherit.aes = TRUE,
             edata = NULL, formula = NULL, arrowmul=NULL, ...)
{
    layer(stat = StatVectorfit, data = data, mapping = mapping, geom = geom,
          position = position, show.legend = show.legend,
          inherit.aes = inherit.aes,
          params = list(edata = edata, formula = formula, na.rm = na.rm,
                        arrowmul = arrowmul)
          )
}
## extract ordination scores for data= statement in ggplot2 functions
#' @rdname ordiggplot
#' @export
`ggscores` <-
    function(Score)
{
    ~.x[.x$Score == Score,]
}
