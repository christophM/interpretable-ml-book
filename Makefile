all : html

html : chapters/*.Rmd index.Rmd
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	Rscript --vanilla -e "bookdown::render_book('./', 'bookdown::gitbook')"
