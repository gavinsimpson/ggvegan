#' @title Fortify isometric feature mapping results
#' @description Prepares fortified versions of results from [vegan::isomap()]
#'   objects.
#'
#' @details Two different objects can be created from the results of an
#'   [vegan::isomap()] object. The first is the standard scores representation
#'   of fortified ordinations in vegan, which results in a wide data frame
#'   where rows contain observations and column the coordinates of observations
#'   on the MDS axes. Because ISOMAP also produces a network or sorts, the
#'   coordinates of the edges of the network can also be returned in a tidy
#'   format using `what = "network"`.
#' @param model an object of class [vegan::isomap()].
#' @param data data.frame; additional data to be added to the fortified object.
#' @param axes numeric; which axes to return. For `what = "network"` this must
#'   be of length two only.
#' @param what character; what aspect of the results should be fortified?
#'   `"sites"` returns to ordination scores from the multidimensional scaling
#'   part of the model. `"network"` returns the coordinates for edges joining
#'   points.
#' @param ... additional arguments for other methods. Currently ignored.
#' @return A data frame. For `what = "sites"`, the data frame contains one
#'   variable per dimension of the multidimensional scaling embedding of the
#'   dissimilarities. Variables are named `"DimX"` with `"X"` being an integer.
#'   An additional variable is `label`, containing a label for each observation.
#'   For `what = "network"`, the data frame contains four variables containing
#'   the coordinates in the chosen MDS axes for the start and end points of the
#'   network edges.
#'
#' @export
#'
#' @importFrom ggplot2 fortify
#'
#' @author Gavin L. Simpson
#'
#' @examples
#'
#' library("vegan")
#'
#' library("ggplot2")
#' data(BCI)
#' dis <- vegdist(BCI)
#' ord <- isomap(dis, k = 3)
#'
#' df <- fortify(ord, data = data.frame(Richness = specnumber(BCI)))
#' net <- fortify(ord, what = "network", axes = 1:2)
#'
#' ggplot(df, aes(x = Dim1, y = Dim2)) +
#'     geom_segment(data = net,
#'                  aes(x = xfrom, y = yfrom,
#'                      xend = xto, yend = yto),
#'                  colour = "grey85", size = 0.8) +
#'     geom_point(aes(size = Richness)) +
#'     coord_fixed()
`fortify.isomap` <- function(
  model,
  data = NULL,
  axes = 1:6,
  what = c("sites", "network"),
  ...
) {
  what <- match.arg(what)

  if (isTRUE(all.equal(what, "sites"))) {
    df <- as.data.frame(scores(model))
    if (!is.null(data)) {
      df <- cbind(df, data)
    }
    df <- cbind(label = rownames(df), df)
    rownames(df) <- NULL
  } else {
    ## axes must be of length two for this to work
    if (!isTRUE(all.equal(length(axes), 2L))) {
      stop("'axes' must be a vector of length 2.")
    }
    df <- scores(model)
    net <- model[["net"]]
    df <- cbind(
      xfrom = df[net[, 1], axes[1]],
      yfrom = df[net[, 1], axes[2]],
      xto = df[net[, 2], axes[1]],
      yto = df[net[, 2], axes[2]]
    )
    df <- as.data.frame(df)
    if (!is.null(data)) {
      df <- cbind(df, data)
    }
    rownames(df) <- NULL
  }

  df
}
