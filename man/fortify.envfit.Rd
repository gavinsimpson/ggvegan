% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fortify.envfit.R
\name{fortify.envfit}
\alias{fortify.envfit}
\title{Fortify method for \code{envfit} objects}
\usage{
\method{fortify}{envfit}(model, data, ...)
}
\arguments{
\item{model}{an object of class \code{envfit}, the result of a call to \code{\link[vegan]{envfit}}.}

\item{data}{additional data to augment the \code{envfit} results. Currently ignored.}

\item{...}{arguments passed to \code{\link[vegan]{scores.envfit}}.}
}
\value{
A data frame with columns \code{label}, \code{type}, containing the label for, and whether each row refers to, the fitted vector or factor. Remaining variables are coordinates on the respective ordination axes returned by \code{\link[vegan]{scores.envfit}}.
}
\description{
Produces a tidy data frame from the results of an \code{\link[vegan]{envfit}} object.
}
\examples{
data(varespec, varechem)
ord <- metaMDS(varespec)
fit <- envfit(ord, varechem, perm = 199)

fortify(fit)

data(dune, dune.env)
ord <- cca(dune)
fit <- envfit(ord ~ Moisture + A1, dune.env, perm = 199)

fortify(fit)
}
\author{
Gavin L. Simpson
}
