


all : _book/index.html

_book/index.html : *.Rmd
	Rscript --vanilla -e "library('bookdown'); bookdown::render_book('./', 'bookdown::gitbook')"
