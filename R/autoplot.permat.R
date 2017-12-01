##' @title ggplot-based plot for objects of class \code{permat}
##'
##' @description Produces a multi-layer ggplot object representing the output of objects produced by \code{\link[vegan]{permatswap}}.
##'
##' @param object an object of class \code{permat}, the result of a call to \code{\link[vegan]{permatswap}}.
##' @param col character; colors of Dissimilarity line and lowess line.
##' @param type character; type of plot to be displayed: "bray" for Bray-Curtis dissimilarities, "chisq" for Chi-squared values.
##' @param lowess logical; whether a locally weighted regression curve should be drawn.
##' @param xlab character; label for the x axis.
##' @param ylab character; label for the y axis.
##' @param title character; title for the plot.
##' @param subtitle character; subtitle for the plot.
##' @param caption character; caption for the plot.
##' @param ... additional arguments passed to other methods.
##' @return A ggplot object.
##' @author Didzis Elferts
##'
##' @export
##'
##' @importFrom ggplot2 ggplot autoplot geom_line aes_string labs fortify geom_smooth
##'
##' @examples
##'
##' data(BCI)
##' perm <- permatswap(BCI, "quasiswap", times=19)
##'
##' autoplot(perm)

`autoplot.permat` <- function(object, col = c("red","blue"), type = "bray", lowess = TRUE,
                                 xlab = "Runs", ylab = NULL, 
                                 title = "Results of matrix permutation algorithms",
                                 subtitle = NULL, caption = NULL,
                                 ...) {
  if(length(col) != 2) {
    stop("Exactly two colors should be provided")
  } 
  df <- fortify(object)
  
  type <- match.arg(type, c("bray", "chisq"))
  
  if (type == "bray") {
    if (is.null(ylab)) 
      ylab <- "Bray-Curtis dissimilarity"
    plt <- ggplot(data = df[df$Type == "Bray",],
                  aes_string(x = "Runs", y = "Dissimilarity")) + 
      geom_line(color = col[1])
  }
  
  if (type == "chisq") {
    if (is.null(ylab)) 
      ylab <- "Chi-squared"
    plt <- ggplot(data = df[df$Type == "Chisq",],
                  aes_string(x = "Runs", y = "Dissimilarity")) + 
      geom_line(color = col[1])
  }
  
  if (isTRUE(lowess)) {
    plt <- plt + geom_smooth(method = "loess", se = FALSE, color = col[2])
  }

  plt <- plt +
    labs(x = xlab, y = ylab, title = title, subtitle = subtitle, caption = caption)
  plt
}


