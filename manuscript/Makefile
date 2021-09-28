.PHONY : sbrl

all : html pdf epub mobi

html : _book/index.html

pdf : _book/interpretable-ml.pdf

epub : _book/interpretable-ml.epub

mobi : _book/interpretable-ml.mobi


package: ../DESCRIPTION ../R/*.R
	Rscript  -e "devtools::install('../')"

_book/index.html :  *.Rmd
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	Rscript  -e "bookdown::render_book('./', 'bookdown::gitbook')"


%.md : %.Rmd
	R --no-save --args $< < ../scripts/process-rmd-leanpub.R
	R --no-save --args $@ < ../scripts/fix-leanpub.R

_book/interpretable-ml.pdf : *.Rmd
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	Rscript  -e "bookdown::render_book('./', 'bookdown::pdf_book')"

_book/interpretable-ml.epub : *.Rmd
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	Rscript  -e "bookdown::render_book('./', 'bookdown::epub_book')"

_book/interpretable-ml.mobi: _book/interpretable-ml.epub
	Rscript -e "bookdown::calibre('$<', output = '$@')"

11-references.Rmd : *.Rmd
	Rscript ../scripts/references.R

sbrl:
	sudo apt install -y libgsl10-dev open-cobol
