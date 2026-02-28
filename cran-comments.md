This is a resubmission of the first release to CRAN of the ggvegan package.
The package has been checked on Windows, Linux, and MacOS X, and with r-release
and r-devel, including CRAN's winbuilder service. The results of R CMD check
are shown below.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

During the initial submission, the manual inspection identify a couple of issues
that needed to be fixed:

>  The `Description` field should be a paragraph:

_I have extended the Description field with a little more detail as requested._

>"vegan" was not written in single quotes:

_Fixed_

> Add references to `DESCRIPTION`

_There are no relevant references to add; the package provides functionality
for converting vegan's objects into tidy representation for using within the
tidyverse._

> Add \value to .Rd files regarding exported methods

_These have been added_
