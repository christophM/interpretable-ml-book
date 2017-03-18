# Book about 'Explainable machine learning'
Book about explainable machine learning: How to explain the decisions and behaviours of machine learning algorithm.


You can find the current version of the book here: https://christophm.github.io/exML-book/index.html.

It is in a very early stage. If you are interested in working with me on this topic or if you have just some feedback, drop me a message.

This book is written in R Markdown using the bookdown package for compilation.


## Render book
Make sure bookdown is installed:
```{r}
install.packages('bookdown')
```

```{r}
bookdown::render_book("index.Rmd", "bookdown::pdf_book")
```
