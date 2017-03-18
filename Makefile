


all : docs/index.html 

docs/index.html : *.Rmd
	Rscript --vanilla -e "library('bookdown'); bookdown::render_book('./', 'bookdown::gitbook')"
