


all : docs/index.html

docs/index.html : *.Rmd
	Rscript --vanilla -e "bookdown::render_book('./', 'bookdown::gitbook')"
