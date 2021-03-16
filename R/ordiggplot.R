### Creates a ggplot() skeleton to which graphical layers can be added

#' Create a ggplot Object
#'
#' Function \code{ordiggplot} set ups an ordination plot. The function
#' extracts results using \code{fortify} functions of this package,
#' and it accepts the arguments of those functions. This allows
#' setting, e.g., the scaling of ordination axes. Functions
#' \code{geom_ordipoint} and \code{geom_orditext} add points or gext
#' to this plot. The \code{geom_ordi} functions accept arguments of
#' \code{\link[ggplot2]{geom_point}} and
#' \code{\link[ggplot2]{geom_text}} allowing flexible editing of
#' plots.
#'
#' @param model An ordination result object from \CRANpkg{vegan}.
#' @param axes Two axes to be plotted
#' @param Score Ordination score to be added to the plot.
#' @param box Draw a box behind the text (logical).
#' @param ... Parameters passed to underlying functions.
#'
#'
#'
#' @examples
#' data(dune, dune.env)
#' m <- cca(dune ~ Management, dune.env)
#' ordiggplot(m) + geom_ordipoint("sites") +
#'   geom_orditext("species", col="darkblue", mapping=aes(fontface="italic")) +
#'   geom_orditext("centroids", box=TRUE)
#'
#' @importFrom ggplot2 ggplot coord_equal aes_string
#' 
#' @export
`ordiggplot` <-
    function(model, axes = c(1,2), ...)
{
    if (!inherits(model, "cca"))
        warning("currently tried only with cca objects: you are on your own")
    if (length(axes) > 2)
        stop("only two-dimensional plots made: too many axes defined")
    df <- fortify(model, axes = axes,
                  display = c("sp", "wa", "lc", "bp", "cn", "reg"), ...)
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
