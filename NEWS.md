# ggvegan 0.2.1

Patch release to address issued raised by CRAN during manual inspection of the
package upon first submission.

## Bug Fixes

* CRAN requested that the `Description` be lengthened.

* CRAN noted that all exported functions and Rd files of such should have
  `\value` sections.

# ggvegan 0.2

This [was intended as] the first release to CRAN. *ggvegan** is under active
development, and comments and contributions are welcome.

## New features

* Added a `NEWS.md` file to track changes to the package.

* All `fortify()` methods now return a tibble.

* Complementary `tidy()` method for all `fortify()` methods.

## Bug Fixes

* `const` was not being passed to `scores.rda` in `autoplot.rda`. #26 Reported
  by Richard Telford
