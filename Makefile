# Get the version info for later
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)

all: docs check clean

docs:
	R -q -e 'library("roxygen2"); roxygenise(".")'

build: docs
	cd ..;\
	R CMD build ggvegan

check: build
	cd ..;\
	R CMD check ggvegan_$(PKGVERS).tar.gz

check-cran: build
	cd ..;\
	R CMD check --as-cran ggvegan_$(PKGVERS).tar.gz

install: build
	cd ..;\
	R CMD INSTALL ggvegan_$(PKGVERS).tar.gz

move: check
	cp ../ggvegan.Rcheck/ggvegan-Ex.Rout ./tests/Examples/ggvegan-Ex.Rout.save

clean:
	cd ..;\
	rm -r ggvegan.Rcheck/
