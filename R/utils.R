#' @title Scale Vectors to Data
#' @description Scale vector arrows to `fill` proportion of the data.
#' @param arrows a two-column matrix-like object containing coordinates for the
#'   arrows/vectors on x and y axes.
#' @param data a two-column matrix-like object containing coordinates of the
#'   data on the x and y axes.
#' @param at numeric vector of length 2; location of the origin of the arrows.
#' @param fill numeric; what proportion of the range of the data to fill
#' @return a numeric multiplier that will scale the arrows
#' @author Gavin L. Simpson
`arrow_mul` <- function(arrows, data, at = c(0, 0), fill = 0.75) {
  u <- c(range(data[, 1], range(data[, 2])))
  u <- u - rep(at, each = 2)
  r <- c(range(arrows[, 1], na.rm = TRUE), range(arrows[, 2], na.rm = TRUE))
  rev <- sign(diff(u))[-2]
  if (rev[1] < 0) {
    u[1:2] <- u[2:1]
  }
  if (rev[2] < 0) {
    u[3:4] <- u[4:3]
  }
  u <- u / r
  u <- u[is.finite(u) & u > 0]
  fill * min(u)
}

#' @title Number of scores
#' @description Returns the number of scores returns in object `x``.
#'
#' @param x The object whose number of scores is required.
#'
#' @return a numeric vector of length 1 with the number of scores.
#'
#' @author Gavin L. Simpson
`scores_length` <- function(x) {
  obs <- NROW(x)
  if (is.null(obs)) {
    obs <- 0
  }
  obs
}

#' @title Extract the names of the dimensions to plot as a character vector
#'
#' @description Find the character vector of names for the two dimensions of
#'   data to be plotted.
#' @param object a fortified ordination object.
#' @return A length 2 character vector of dimension names.
#' @author Gavin L. Simpson
`get_dimension_names` <- function(object) {
  names(object)[-c(1, 2)]
}

#' @title Adds a label layer using one of a set of common geoms
#'
#' @description Adds labels to a plot using one of [ggplot2::geom_label()],
#'   [ggplot2::geom_text()], [ggrepel::geom_label_repel()] or
#'   [ggrepel::geom_text_repel()].
#'
#' @param data data frame; data set to use for the label layer. Must contain a
#'   variable label containing the strings to use as labels.
#' @param geom character; which geom to use for labelling.
#' @param vars character; vector of names of variables to pass to the `x` and
#'   `y` aesthetics of the chosen geom.
#'
#' @author Gavin L. Simpson
#'
#' @importFrom ggplot2 geom_text geom_label aes
#' @importFrom ggrepel geom_text_repel geom_label_repel
#'
`label_fun` <- function(
  data,
  geom = c("label", "text", "label_repel", "text_repel"),
  vars
) {
  ll <- switch(
    geom,
    label = geom_label(
      data = data,
      mapping = aes(
        x = .data[[vars[1]]],
        y = .data[[vars[2]]],
        label = .data[["label"]]
      )
    ),
    text = geom_text(
      data = data,
      mapping = aes(
        x = .data[[vars[1]]],
        y = .data[[vars[2]]],
        label = .data[["label"]]
      )
    ),
    label_repel = geom_label_repel(
      data = data,
      mapping = aes(
        x = .data[[vars[1]]],
        y = .data[[vars[2]]],
        label = .data[["label"]]
      )
    ),
    text_repel = geom_text_repel(
      data = data,
      mapping = aes(
        x = .data[[vars[1]]],
        y = .data[[vars[2]]],
        label = .data[["label"]]
      )
    )
  )
  ll
}

#' @title Valid layers for vegan objects
#'
#' @param object An R object.
#' @param ... Additional arguments passed to methods.
#'
#' @rdname valid_layers
#' @export
`valid_layers` <- function(object, ...) {
  UseMethod('valid_layers')
}

#' @rdname valid_layers
#' @export
`valid_layers.rda` <- function(object, ...) {
  c("species", "sites", "constraints", "biplot", "centroids", "regression")
}
#' @rdname valid_layers
#' @export
`valid_layers.cca` <- function(object, ...) {
  c("species", "sites", "constraints", "biplot", "centroids", "regression")
}

#' @title Check user-supplied layers against list of valid layers
#'
#' @param user character; vector of user supplied layer names.
#' @param valid character; vector of valid layer names.
#' @param message logical; should a message be raised in the case of invalid
#'   user-supplied layer names.
`check_user_layers` <- function(user, valid, message = FALSE) {
  ok <- user %in% valid

  if (isTRUE(message) && any(!ok)) {
    msg <- "Invalid (ignored) layers for this object:"
    invalid <- paste(user[!ok], collapse = ', ')
    message(paste(msg, invalid, sep = " "))
  }

  ok
}

#' @title List of layers to draw for a given vegan object
#'
#' @param valid character; vector of valid layer names
#' @param layers character; a vector of layer names for `object` that has
#'   already been filtered for validity.
#' @param available character; what layers are actually available
#'
#' @importFrom stats setNames
`layer_draw_list` <- function(valid, layers = NULL, available = NULL) {
  l <- setNames(rep(TRUE, length(valid)), valid)
  if (!is.null(layers)) {
    if (!is.null(available)) {
      layers <- layers[layers %in% available]
    }
    i <- valid %in% layers
    l[!i] <- FALSE
  }
  l
}

#' @title Adds species and site score layers to an existing plot
#'
#' @param object an ordination object.
#' @param plt a ggplot object.
#' @param vars character; length 2 vector of dimension names.
#' @param geom character; vector of length 1 or 2 indicating which geom will
#'   be used for the species or site scores.
#' @param draw_list logical; vector of types of scores indicating which are
#'   available and requested for plotting.
#' @param arrows logical; length 1 vector indicating if species scores should
#'   be drawn using arrows.
#'
#' @importFrom ggplot2 geom_point geom_text
`add_spp_site_scores` <- function(object, plt, vars, geom, draw_list, arrows) {
  wanted <- names(draw_list[c("species", "sites", "constraints")])
  ## if we're plotting species by arrows, drop species if in list
  if (isTRUE(arrows)) {
    wanted <- wanted[wanted != "species"]
  }

  ## if still something to draw, draw it
  if (length(wanted) > 0L) {
    ## case of a single geom
    if (length(geom) == 1L) {
      take <- object[["score"]] %in% wanted
      if (geom == "point") {
        plt <- plt +
          geom_point(
            data = object[take, , drop = FALSE],
            mapping = aes(
              x = .data[[vars[1]]],
              y = .data[[vars[2]]],
              shape = .data[["score"]],
              colour = .data[["score"]]
            )
          )
      } else {
        plt <- plt +
          geom_text(
            data = object[take, , drop = FALSE],
            mapping = aes(
              x = .data[[vars[1]]],
              y = .data[[vars[2]]],
              label = .data[["label"]],
              colour = .data[["score"]]
            ),
            size = 3
          )
      }
    } else {
      ## we have to plot species and sites/constraints separately
      if ("species" %in% wanted) {
        take <- object[["score"]] == "species"
        if (geom[2L] == "point") {
          plt <- plt +
            geom_point(
              data = object[take, , drop = FALSE],
              mapping = aes(
                x = .data[[vars[1]]],
                y = .data[[vars[2]]],
                shape = .data[["score"]],
                colour = .data[["score"]]
              )
            )
        } else {
          plt <- plt +
            geom_text(
              data = object[take, , drop = FALSE],
              mapping = aes(
                x = .data[[vars[1]]],
                y = .data[[vars[2]]],
                label = .data[["label"]],
                colour = .data[["score"]]
              ),
              size = 3
            )
        }
      }
      if (any(c("sites", "constraints") %in% wanted)) {
        take <- object[["score"]] %in% c("sites", "constraints")
        if (geom[1L] == "point") {
          plt <- plt +
            geom_point(
              data = object[take, , drop = FALSE],
              mapping = aes(
                x = .data[[vars[1]]],
                y = .data[[vars[2]]],
                shape = .data[["score"]],
                colour = .data[["score"]]
              )
            )
        } else {
          plt <- plt +
            geom_text(
              data = object[take, , drop = FALSE],
              mapping = aes(
                x = .data[[vars[1]]],
                y = .data[[vars[2]]],
                label = .data[["label"]],
                colour = .data[["score"]]
              ),
              size = 3
            )
        }
      }
    }
  }

  ## now check if species should be added as arrows
  if (isTRUE(arrows) && draw_list["species"]) {
    take <- object[["score"]] == "species"
    pdat <- object[take, , drop = FALSE]
    col <- "black"
    plt <- plt +
      geom_segment(
        data = pdat,
        mapping = aes(
          x = 0,
          y = 0,
          xend = .data[[vars[1]]],
          yend = .data[[vars[2]]]
        ),
        arrow = arrow(length = unit(0.2, "cm")),
        colour = col
      )
    pdat[, vars] <- 1.1 * pdat[, vars, drop = FALSE]
    plt <- plt +
      geom_text(
        data = pdat,
        mapping = aes(
          x = .data[[vars[1]]],
          y = .data[[vars[2]]],
          label = .data[["label"]]
        ),
        size = 4
      )
  }

  ## return
  plt
}

#' @importFrom tibble as_tibble
`prep_tidy_scores_tbl` <- function(x) {
  nr <- vapply(x, FUN = NROW, FUN.VALUE = integer(1L))
  scr_labs <- unlist(lapply(x, rownames), use.names = FALSE)
  df <- do.call("rbind", x)
  rownames(df) <- NULL
  colnames(df) <- tolower(colnames(df))
  df <- df |>
    as.data.frame() |>
    tibble::as_tibble() |>
    tibble::add_column(
      score = factor(rep(names(x), times = nr)),
      label = scr_labs,
      .before = 1L
    )
  df
}

`rda_constant` <- function(x, const) {
  stopifnot(inherits(x, "rda"))
  # handle const because it has to be missing in scores
  nr <- if (is.null(x$CCA)) {
    nrow(x$CA$u)
  } else {
    nrow(x$CCA$u)
  }
  if (is.null(const)) {
    const <- sqrt(sqrt((nr - 1) * x$tot.chi))
  }
  if (identical(length(const), 1L)) {
    const <- rep(const, length.out = 2L)
  }
  const
}

#' @title Adds a biplot arrow layer to an existing plot
#'
#' @inheritParams add_spp_site_scores
#' @param arrow.col colour specification for biplot arrows and their labels.
#'
#' @importFrom ggplot2 geom_segment geom_text aes
#' @importFrom grid unit arrow
`add_biplot_arrows` <- function(
  object,
  plt,
  vars,
  arrow.col = "navy"
) {
  want <- object[["score"]] == "biplot"
  if (any(want)) {
    #if (length(layer_names) > 1) {
    mul <- arrow_mul(
      object[want, vars, drop = FALSE],
      object[!want, vars, drop = FALSE]
    )
    object[want, vars] <- mul * object[want, vars]
    #}
    #col <- "navy"
    plt <- plt +
      geom_segment(
        data = object[want, , drop = FALSE],
        aes(
          x = 0,
          y = 0,
          xend = .data[[vars[1]]],
          yend = .data[[vars[2]]]
        ),
        arrow = arrow(length = unit(0.2, "cm")),
        colour = arrow.col
      )
    object[want, vars] <- 1.1 * object[want, vars]
    plt <- plt +
      geom_text(
        data = object[want, , drop = FALSE],
        aes(
          x = .data[[vars[1]]],
          y = .data[[vars[2]]],
          label = .data[["label"]]
        ),
        colour = arrow.col
      )
  }
  plt
}

#' @title Adds a biplot arrow layer to an existing plot
#'
#' @inheritParams add_spp_site_scores
#' @inheritParams add_biplot_arrows
#'
#' @importFrom ggplot2 geom_segment geom_text aes
#' @importFrom grid unit arrow
`add_biplot_centroids` <- function(
  object,
  plt,
  vars,
  arrow.col = "navy"
) {
  want <- object[["score"]] == "centroids"
  if (any(want)) {
    plt <- plt +
      geom_text(
        data = object[want, , drop = FALSE],
        aes(
          x = .data[[vars[1]]],
          y = .data[[vars[2]]],
          label = .data[["label"]]
        ),
        colour = arrow.col
      )
  }
  plt
}
