##' @title ggplot-based plot for objects of class \code{"permat"}
##'
##' @description Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{permatswap}}.
##'
##' @param object an object of class \code{permat}, the result of a call to \code{\link[vegan]{permatswap}}.
##' @param type character; type of plot to be displayed: "bray" for Bray-Curtis dissimilarities, "chisq" for Chi-squared values.
##' @param lowess logical; whether a locally weighted regression curve should be drawn.
##' @param xlab character; label for the x axis.
##' @param ylab character; label for the y axis.
##' @param title character; title for the plot.
##' @param subtitle character; subtitle for the plot.
##' @param caption character; caption for the plot.
##' @param color character; name for the colors legend.
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Didzis Elferts
##'
##' @export
##'
##' @importFrom ggplot2 ggplot autoplot geom_line aes_string labs fortify geom_smooth aes
##'
##' @examples
##'
##' data(BCI)
##' perm <- permatswap(BCI, "quasiswap", times=19)
##'
##' autoplot(perm)

`autoplot.permat` <- function(object, type = "bray", lowess = TRUE,
                                 xlab = "Runs", ylab = NULL, color = NULL,
                                 title = "Results of matrix permutation algorithms",
                                 subtitle = NULL, caption = NULL,
                                 ...) {
  df <- fortify(object, ...)
  
  type <- match.arg(type, c("bray", "chisq"))
  
  if (type == "bray") {
    if (is.null(ylab)) 
      ylab <- "Bray-Curtis dissimilarity"
    plt <- ggplot(data = df[df$Type == "Bray",],
                  aes_string(x = "Runs", y = "Dissimilarity")) + 
      geom_line(aes(color = "Index"))
  }
  
  if (type == "chisq") {
    if (is.null(ylab)) 
      ylab <- "Chi-squared"
    plt <- ggplot(data = df[df$Type == "Chisq",],
                  aes_string(x = "Runs", y = "Dissimilarity")) + 
      geom_line(aes(color = "Index"))
  }
  
  # add lowess line?
  if (isTRUE(lowess)) {
    plt <- plt + geom_smooth(method = "loess", se = FALSE, aes (color = "Lowess"))
  }

  plt <- plt +
    labs(x = xlab, y = ylab, title = title, subtitle = subtitle, caption = caption, color = color)
  plt
}


