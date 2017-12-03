all : html

html : *.Rmd
	# When build fails xai-book.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml-book.Rmd
	Rscript --vanilla -e "bookdown::render_book('./', 'bookdown::gitbook')"
