# ggvegan 0.1.9992

## New features

* Added a `NEWS.md` file to track changes to the package.

* All `fortify()` methods now return a tibble.

* Complementary `tidy()` method for all `fortify()` methods.

## Bug Fixes

* `const` was not being passed to `scores.rda` in `autoplot.rda`. #26 Reported
  by Richard Telford
