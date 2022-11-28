.PHONY : sbrl

all : html pdf epub

html : _book/index.html

pdf : _book/interpretable-ml.pdf

epub : _book/interpretable-ml.epub

amazon : _book/amazon.pdf

_book/amazon.pdf : _book/interpretable-ml.pdf
	gs -dPDFX -dBATCH -dNOPAUSE -dUseCIEColor -sProcessColorModel=DeviceCMYK -sDEVICE=pdfwrite -sPDFACompatibilityPolicy=1 -sOutputFile=_book/amazon.pdf _book/interpretable-machine-learning.pdf


package: ../DESCRIPTION ../R/*.R
	Rscript  -e "devtools::install('../')"

_book/index.html :  *.Rmd
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	Rscript  -e "bookdown::render_book('./', 'bookdown::gitbook')"


%.md : %.Rmd
	R --no-save --args $< < ../scripts/process-rmd-leanpub.R
	R --no-save --args $@ < ../scripts/fix-leanpub.R

_book/interpretable-ml.pdf : *.Rmd latex/*
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	git rev-parse --short HEAD > latex/hash.tex
	Rscript  -e "bookdown::render_book('./', 'bookdown::pdf_book')"

_book/interpretable-ml.epub : *.Rmd
	# When build fails interpretable-ml.Rmd is created and not removed. Next build will fail when file exists.
	rm -f interpretable-ml.Rmd
	Rscript  -e "bookdown::render_book('./', 'bookdown::epub_book')"

11-references.Rmd : *.Rmd ../scripts/references.R
	Rscript ../scripts/references.R

sbrl:
	sudo apt install -y libgsl10-dev open-cobol
