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
#' data(dune, dune.env)
#' m <- cca(dune ~ Management, dune.env)
#' ## use geom_ordi* functions
#' ordiggplot(m) + geom_ordipoint("sites") +
#'   geom_orditext("species", col="darkblue", mapping=aes(fontface="italic")) +
#'   geom_orditext("centroids", box=TRUE)
#' ## use ggscores + standard geom_* functions
#' ordiggplot(m, scaling="sites") + geom_point(data=ggscores("sites")) +
#'    geom_text(data=ggscores("species"), mapping=aes(fontface="italic")) +
#'    geom_label(data=ggscores("centroids"), fill="yellow")
#'
#'
#' @importFrom ggplot2 ggplot coord_equal aes_string
#'
#' @export
`ordiggplot` <-
    function(model, axes = c(1,2), ...)
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
            mul <- arrowMul(df[isBip, 3:4, drop=FALSE],
                            df[!isBip, 3:4, drop=FALSE])
            df[isBip, 3:4] <- df[isBip, 3:4] * mul
        }
    }
    dlab <- colnames(df)[3:4]
    pl <- ggplot(data = df, mapping=aes_string(dlab[1], dlab[2],
                 label="Label"))
    pl <- pl + coord_equal()
    pl
}

### add points to the skeleton

#' @importFrom ggplot2 geom_point

#' @rdname ordiggplot
#' @export
`geom_ordipoint` <-
    function(Score, ...)
{
    if (missing(Score))
        stop("Score must be defined")
    geom_point(data = ~.x[.x$Score == Score, ], ...)
}

### add text to the plot

#' @importFrom ggplot2 geom_label geom_text

#' @rdname ordiggplot
#' @export
`geom_orditext` <-
    function(Score, box = FALSE, ...)
{
    if (missing(Score))
        stop("Score must be defined")
    data = ~.x[.x$Score == Score,]
    if (box)
        geom_label(data = data, ... )
    else
        geom_text(data = data, ...)
}

#' @importFrom ggplot2 geom_segment geom_label geom_text aes arrow
#' @rdname ordiggplot
#' @export
`geom_ordiarrow` <-
    function(Score, text = TRUE, box = FALSE, ...)
{
    if (missing(Score))
        stop("Score must be defined")
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

## extract ordination scores for data= statement in ggplot2 functions
#' @rdname ordiggplot
#' @export
`ggscores` <-
    function(Score)
{
    ~.x[.x$Score == Score,]
}
