\name{fortify.cca}
\alias{fortify.cca}
\title{Fortify a \code{"cca"} object.}
\usage{
  \method{fortify}{cca} (model, data, ...)
}
\arguments{
  \item{model}{an object of class \code{"cca"}, the result
  of a call to \code{\link[vegan]{cca}},
  \code{\link[vegan]{rda}}, or
  \code{\link[vegan]{capscale}}.}

  \item{data}{currently ignored.}

  \item{...}{additional arguments passed to
  \code{\link[vegan]{scores.cca}}.}
}
\value{
  A data frame in long format containing the ordination
  scores. The first to components are the axis scores.
}
\description{
  Fortifies an object of class \code{"cca"} to produce a
  data frame of the selected axis scores in long format,
  suitable for plotting with \code{\link[ggplot2]{ggplot}}.
}
\details{
  TODO
}
\author{
  Gavin
}

