#' @title Fortify a `"prc"` object
#'
#' @description
#' Fortifies an object of class `"prc"` to produce a data frame of the selected
#' axis scores in long format, suitable for plotting with [ggplot2::ggplot()].
#'
#' @details
#' TODO
#'
#' @param model,x an object of class `"prc"`, the result of a call to
#'   [vegan::prc()].
#' @param data currently ignored.
#' @param scaling the desired scaling. See [vegan::scores.cca()] for details.
#' @param axis numeric; which PRC axis to extract. Default is `axis = 1`, which
#'   is the most generally useful choice.
#' @param ... additional arguments currently ignored.
#' @return A data frame in long format containing the ordination scores. The
#'   first three components are the `Time`, `Treatment`, and associated
#'   `Response`. The last two components, `score` and `label` are an indicator
#'   factor and a label for the rows for use in plotting.
#' @author Gavin L. Simpson
#'
#' @export
#'
#' @importFrom stats coef
#' @importFrom ggplot2 fortify
#' @importFrom tidyr gather
#' @importFrom vegan scores
#'
#' @examples
#' library("vegan")
#' data(pyrifos)
#' week <- gl(11, 12, labels=c(-4, -1, 0.1, 1, 2, 4, 8, 12, 15, 19, 24))
#' dose <- factor(rep(c(0.1, 0, 0, 0.9, 0, 44, 6, 0.1, 44, 0.9, 0, 6), 11))
#' ditch <- gl(12, 1, length=132)
#'
#' pyrifos_prc <- prc(pyrifos, dose, week)
#' fortify(pyrifos_prc)
`fortify.prc` <- function(
  model,
  data,
  scaling = "symmetric",
  axis = 1,
  ...
) {
  s <- summary(model, scaling = scaling, axis = axis)
  b <- as.data.frame(t(coef(s)))
  dimb <- dim(b)
  rs <- rownames(b)
  cs <- colnames(b)
  b <- cbind(time = as.numeric(rs), b)
  res <- gather(b, 'treatment', 'response', -'time')
  # names(res) <- c("Time", "Treatment", "Response")

  ## insure Treatment is a factor
  res[['time']] <- factor(res[['time']], levels = model$terminfo$xlev[[1]])
  res[['treatment']] <- factor(
    res[['treatment']],
    levels = model$terminfo$xlev[[2]]
  )

  n <- length(s$sp)
  samp_lab <- paste(res$treatment, res$time, sep = "|")
  res <- rbind(
    res,
    cbind(
      time = rep(NA, n),
      treatment = rep(NA, n),
      response = s$sp
    )
  )
  res <- cbind(
    score = factor(
      c(
        rep("Sample", prod(dimb)),
        rep("Species", n)
      )
    ),
    label = c(samp_lab, names(s$sp)),
    res
  )
  ## return
  res |> as_tibble()
}

#' @export
#' @rdname fortify.prc
`tidy.prc` <- function(
  x,
  data,
  scaling = "symmetric",
  axis = 1,
  ...
) {
  s <- summary(x, scaling = scaling, axis = axis)
  b <- as.data.frame(t(coef(s)))
  dimb <- dim(b)
  rs <- rownames(b)
  cs <- colnames(b)
  b <- cbind(time = as.numeric(rs), b)
  res <- gather(b, 'treatment', 'response', -'time')
  # names(res) <- c("Time", "Treatment", "Response")

  ## insure Treatment is a factor
  res[['time']] <- factor(res[['time']], levels = x$terminfo$xlev[[1]])
  res[['treatment']] <- factor(
    res[['treatment']],
    levels = x$terminfo$xlev[[2]]
  )

  n <- length(s$sp)
  samp_lab <- paste(res$treatment, res$time, sep = "|")
  res <- rbind(
    res,
    cbind(
      time = rep(NA, n),
      treatment = rep(NA, n),
      response = s$sp
    )
  )
  res <- cbind(
    score = factor(
      c(
        rep("Sample", prod(dimb)),
        rep("Species", n)
      )
    ),
    label = c(samp_lab, names(s$sp)),
    res
  )
  ## return
  res |> as_tibble()
}
