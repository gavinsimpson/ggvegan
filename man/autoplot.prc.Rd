\name{autoplot.prc}
\alias{autoplot.prc}
\title{ggplot-based plot for objects of class \code{"prc"}}
\usage{
  \method{autoplot}{prc} (object, select, xlab, ylab)
}
\arguments{
  \item{object}{an object inheriting from class
  \code{"prc"}, the result of a call to
  \code{\link[vegan]{prc}}.}

  \item{select}{a logical vector where \code{TRUE} selects
  and \code{FALSE} deselects species. Alternatively a
  numeric vector that contains the indices selecting
  species. Note that these are with respect to the original
  species matrix, \strong{not} the fortified object.}

  \item{xlab}{character; label for the x-axis}

  \item{ylab}{character; label for the y-axis}

  \item{...}{Additional arguments passed to
  \code{\link{fortify.prc}}.}
}
\value{
  Returns a ggplot object.
}
\description{
  Produces a multi-layer ggplot object representing the
  output of objects produced by \code{\link[vegan]{prc}}.
}
\details{
  TODO
}
\examples{
data(pyrifos)
week <- gl(11, 12, labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24))
dose <- factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6), 11))

## Fit PRC model
mod <- prc(pyrifos, dose, week)

## plot
want <- colSums(pyrifos)
autoplot(sol, select = want)
}
\author{
  Gavin L. Simpson
}

