.PHONY : ebook html kindle pdf print docx sbrl

bookname = iml




all :  kindle print ebook pdf html
kindle : output/kindle-$(bookname).epub
print: output/print-$(bookname).pdf
ebook: output/ebook-$(bookname).epub
pdf: output/pdf-$(bookname).pdf
beta-reader: output/beta-reader-$(bookname).docx


COMMON_BOOK_FILES = $(wildcard *.qmd) $(wildcard *.qmd) references.bib grateful-refs.bib _quarto.yml

grateful-refs.bib: _setup.qmd
	Rscript -e 'grateful::cite_packages(output = "table", out.dir = ".")'

html: $(COMMON_BOOK_FILES) html/*.html
	quarto render --to html --no-cache

docx : $(COMMON_BOOK_FILES)
	quarto render --to docx --profile beta-reader --no-cache

output/ebook-$(bookname).epub :  $(COMMON_BOOK_FILES) _quarto-ebook.yml html/epub.css
	quarto render --profile ebook --to epub --no-cache
	mv _book/$(bookname).epub output/ebook-$(bookname).epub

output/kindle-$(bookname).epub :  $(COMMON_BOOK_FILES) _quarto-kindle.yml html/epub.css
	quarto render --profile kindle --to epub --no-cache
	mv _book/$(bookname).epub output/kindle-$(bookname).epub

output/print-$(bookname).pdf : $(COMMON_BOOK_FILES) _quarto-print.yml latex/
	git rev-parse --short HEAD > latex/hash.tex
	quarto render --profile print --to pdf --no-cache
	mv _book/$(bookname).pdf output/print-$(bookname).pdf 

output/pdf-$(bookname).pdf : $(COMMON_BOOK_FILES) _quarto-pdf.yml  latex/
	git rev-parse --short HEAD > latex/hash.tex
	quarto render --profile pdf --to pdf --no-cache
	mv _book/$(bookname).pdf output/pdf-$(bookname).pdf 

output/sample-$(bookname).pdf: output/pdf-$(bookname).pdf
	pdftk output/pdf-$(bookname).pdf cat 1-40 output output/leanpub/sample-pdf-$(bookname).pdf

output/beta-reader-$(bookname).docx: $(COMMON_BOOK_FILES)
	quarto render --to docx --no-cache
	mv _book/$(bookname).docx output/beta-reader-$(bookname).docx

editing: *.qmd _quarto-editing.yml latex _quarto.yml
	mkdir -p output/editing
	git rev-parse --short HEAD > latex/hash.tex
	quarto render --profile editing --to pdf --no-cache
	mv _book/$(bookname).pdf output/editing.pdf

check-epub-leanpub:
	java -jar ../scripts/epubcheck-5.0.0/epubcheck.jar output/ebook-$(bookname).epub

check-epub-amazon:
	java -jar ../scripts/epubcheck-5.0.0/epubcheck.jar output/kindle-$(bookname).epub

check-epubs: check-epub-leanpub check-epub-amazon
 
html/epub.css :
	curl https://raw.githubusercontent.com/jgm/pandoc/main/data/epub.css --output html/epub.css
	sed -i '' 's/background-color: #fdfdfd;/background-color: transparent;/g' html/epub.css

install-sbrl-deps:
	sudo apt install -y libgsl10-dev open-cobol


data:
	Rscript ../scripts/get-bike-sharing-dataset.R
	Rscript ../scripts/get-SpamTube-dataset.R
