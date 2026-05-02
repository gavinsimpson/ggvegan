# Changelog

## ggvegan (development version)

### New features

- `fortify.radfit` and `autoplot.radfit` methods implemented providing
  support for
  [`vegan::radfit()`](https://vegandevs.github.io/vegan/reference/radfit.html)
  and `vegan::as_rad()`.

### Bug fixes

- *ggplot2* would report a warning about dropped aesthetics when
  `StatVectorfit` was run
  [\#43](https://github.com/gavinsimpson/ggvegan/issues/43) Fixed by
  [@jarioksa](https://github.com/jarioksa) in
  [\#44](https://github.com/gavinsimpson/ggvegan/issues/44)

## ggvegan 0.2.1

CRAN release: 2026-02-27

Patch release to address issued raised by CRAN during manual inspection
of the package upon first submission.

### Bug Fixes

- CRAN requested that the `Description` be lengthened.

- CRAN noted that all exported functions and Rd files of such should
  have `\value` sections.

## ggvegan 0.2

This \[was intended as\] the first release to CRAN. \*ggvegan\*\* is
under active development, and comments and contributions are welcome.

### New features

- Added a `NEWS.md` file to track changes to the package.

- All
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  methods now return a tibble.

- Complementary
  [`tidy()`](https://generics.r-lib.org/reference/tidy.html) method for
  all
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  methods.

### Bug Fixes

- `const` was not being passed to `scores.rda` in `autoplot.rda`.
  [\#26](https://github.com/gavinsimpson/ggvegan/issues/26) Reported by
  Richard Telford
