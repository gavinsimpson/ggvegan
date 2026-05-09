# Contributing to ggvegan

Contributions to **ggvegan** are welcomed. When contributing to
**ggvegan**, the following coding guidelines and conventions apply.

## Importing from other packages

- Keep imports to a minimum, especially from outside the *tidyverse*
  packages

- Only selectively import functions from packages; importing all of a
  package’s functions is not allowed

- Use base-R wherever possible (to reduce hard dependencies), though
  *tidyverse* alternatives are allowed.

- Make sure the version of R required to install **ggvegan** is not too
  strict; try to avoid adding code that would put a requirement to use
  the latest minor release of R.

- To this end, a goal for \*ggvegan\*\* is to be compatible with at
  least the last minor release of R, and ideally the last two minor
  releases, to the extent possible; at the time of writing *ggrepel* has
  a dependency on R 4.5.x such that *ggvegan* is only compatible with R
  versions 4.5.x (r-oldrel) and 4.6.x (r-release).

## Package versioning

- Package versions follow [Semantic Versioning](https://semver.org/)
  conventions.

- If pull requests include user-visible changes, the “developer” version
  number should be increased (e.g. from 0.10.1.5 to 0.10.1.6).

## Naming functions and arguments

- Function names and arguments should be lower case, underscore
  separated if more than one verb/word.

- Lower case, underscore separated if more than one verb.

## `fortify()` and `tidy()` methods

- If implementing a
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  method, provide a complementary
  [`tidy()`](https://generics.r-lib.org/reference/tidy.html) method as a
  synonym. It is acceptable to have the
  [`tidy()`](https://generics.r-lib.org/reference/tidy.html) method
  simply be a call to or simple wrapper around the
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  method.

- [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  and [`tidy()`](https://generics.r-lib.org/reference/tidy.html) should
  both return a *tibble*.

- The names of variables should be lowercase.

- No camelCase or CamelCase

- Separate words or terms with underscores `_` in function names;
  *ggvegan* uses so-called `snake_case`.

- Use `<-` for assignment, with spaces either side of `<-`.

- Place spaces around operators, after commas, e.g. `foo(arg1 = bar)`,
  `a + b`.

- *ggvegan* uses the [Air formatter](https://posit-dev.github.io/air/).
  Please run any code contributions through Air prior to submission of
  PRs if possible. The repo provides a configuration file `air.toml`
  with the settings used for *ggvegan*. Your code will be reformatted
  with Air if you do not format it with Air yourself.

- Code should be indented using spaces, at 2-space intervals.
