\name{fortify.prc}
\alias{fortify.prc}
\title{Fortify a \code{"prc"} object}
\usage{
\method{fortify}{metaMDS}(model, data, scaling = 3, axis = 1, ...)
}
\arguments{
  \item{model}{an object of class \code{"prc"}, the result
  of a call to \code{\link[vegan]{prc}}.}

  \item{data}{currently ignored.}

  \item{scaling}{the desired scaling. See
  \code{\link{scores.cca}} for details.}

  \item{axis}{numeric; which PRC axis to extract. Default
  is \code{axis = 1}, which is the most generally useful
  choice.}

  \item{...}{additional arguments currently ignored.}
}
\value{
A data frame in long format containing the ordination
scores. The first three components are the \code{Time},
\code{Treatment}, and associated \code{Response}. The last
two components, \code{Score} and \code{Label} are an
indictor factor and a label for the rows for use in
plotting.
}
\description{
Fortifies an object of class \code{"prc"} to produce a data
frame of the selected axis scores in long format, suitable
for plotting with \code{\link[ggplot2]{ggplot}}.
}
\details{
TODO
}
\author{
Gavin L. Simpson
}

