\name{autoplot.metaMDS}
\alias{autoplot.metaMDS}
\title{ggplot-based plot for objects of class \code{"metaMDS"}}
\usage{
  \method{autoplot}{metaMDS} (object,
    geom = c("point", "text"),
    layers = c("species", "sites"), ylab, xlab, ...)
}
\arguments{
  \item{object}{an object of class \code{"metaMDS"}, the
  result of a call to \code{\link[vegan]{metaMDS}}.}

  \item{geom}{character; which geoms to use for the layers.
  Can be a vector of length equal to
  \code{length(display)}, in which case the \emph{i}th
  element of \code{type} refers to the \emph{i}th element
  of \code{display}.}

  \item{layers}{character; which scores to plot as layers}

  \item{xlab}{character; label for the x-axis}

  \item{ylab}{character; label for the y-axis}

  \item{...}{Additional arguments passed to
  \code{\link{fortify.metaMDS}}.}
}
\value{
  Returns a ggplot object.
}
\description{
  Produces a multi-layer ggplot object representing the
  output of objects produced by
  \code{\link[vegan]{metaMDS}}.
}
\details{
  TODO
}
\author{
  Gavin L. Simpson
}

