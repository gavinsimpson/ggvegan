\name{fortify.metaMDS}
\alias{fortify.metaMDS}
\title{Fortify a \code{"mataMDS"} object.}
\usage{
\method{fortify}{metaMDS}(model, data, ...)
}
\arguments{
  \item{model}{an object of class \code{"metaMDS"}, the
  result of a call to \code{\link[vegan]{metaMDS}}.}

  \item{data}{currently ignored.}

  \item{...}{additional arguments passed to
  \code{\link[vegan]{scores.metaMDS}}. Note you can't use
  \code{display}.}
}
\value{
A data frame in long format containing the ordination
scores. The first two components are the axis scores.
}
\description{
Fortifies an object of class \code{"metaMDS"} to produce a
data frame of the selected axis scores in long format,
suitable for plotting with \code{\link[ggplot2]{ggplot}}.
}
\details{
TODO
}
\examples{
## load example data
data(dune)

sol <- metaMDS(dune)
head(fortify(sol))
}
\author{
Gavin L. Simpson
}

