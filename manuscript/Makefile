all : html leanpub

package: ../DESCRIPTION ../R/*.R
	Rscript --vanilla -e "devtools::install('../')"

html : *.Rmd
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	Rscript --vanilla -e "bookdown::render_book('./', 'bookdown::gitbook')"

leanpub : index.md 01-introduction.md 01.1-expectation.md 01.2-short-stories.md 01.3-ml-definitions.md 02-interpretability.md 03-datasets.md 04.1-interpretable-models.md 04.2-interpretable-linear.md 04.3-interpretable-logistic.md 04.4-interpretable-tree.md 04.5-interpretable-rulefit.md 04.6-interpretable-other.md 05.1-agnostic.md 05.2-agnostic-pdp.md 05.3-agnostic-ice.md 05.4-agnostic-permfeatimp.md 05.5-agnostic-lime.md 05.6-agnostic-shapley.md 06-contribute.md 07-references.md


%.md : %.Rmd
	Rscript --vanilla -e "knitr::knit('$<', envir = new.env())" 
	R --no-save --args $@ < fixmath.R
