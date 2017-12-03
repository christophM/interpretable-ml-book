# Interpretable machine learning

Explaining the decisions and behaviour of machine learning models.

[![Build Status](https://travis-ci.org/christophM/interpretable-ml-book.svg?branch=master)](https://travis-ci.org/christophM/interpretable-ml-book)

## Summary
You can find the current version of the book here: https://christophm.github.io/interpretable-ml-book/.

This book is about interpretable machine learning. Machine learning is being built into many products and processes of our daily lives, yet decisions made by machines don't automatically come with an explanation. An explanation increases the trust in the decision and in the machine learning model. As the programmer of an algorithm you want to know whether you can trust the learned model. Did it learn generalizable features? Or are there some odd artifacts in the training data which the algorithm picked up? This book will give an overview over techniques that can be used to make black boxes as transparent as possible and explain decisions. In the first chapter algorithms that produce simple, interpretable models are introduced together with instructions how to interpret the output. The later chapters focus on analyzing complex models and their decisions.
In an ideal future, machines will be able to explain their decisions and make a transition into an algorithmic age more human. This books is recommended for machine learning practitioners, data scientists, statisticians and also for stakeholders deciding on the use of machine learning and intelligent algorithms.


The book is automatically build from the master branch and pushed to gh-pages by Travis CI.

## Contributing

Any contribution is very welcome.

If you find a typo, a better way to formulate a sentence or if you have stylistic improvements, don't hesitate and make a PR!

If you are interested in a bigger contribution, like writing a chapter or providing examples: that's great! Please open an issue on Github and we can discuss your ideas.

Rules for contributing text or code:

- Make sure each text line only contains one sentence. Exception: for item lists it is one item (with possibly multiple sentences) per line.
- Fork the repository and open a pull request (PR) for requesting to include the changes. You can use "[WIP]" in the title of the PR, to indicate that you are still working on it


## Rendering the book
Make sure all dependencies for the book are installed. This book has the structure of an R package, so dependencies can be installed easily, only R and the devtools library is required:
```{r}
devtools::install_github("christophM/interpretable-ml-book")
```

After you installed the dependencies, you have to clone the repository.
```{shell}
git clone git@github.com:christophM/interpretable-ml-book.git
```

For rendering the book, start an R session and type:
```{r}
bookdown::render_book('./', 'bookdown::gitbook')
```

After rendering, the HTML files of the  book will be in the "_book" folder. You can either double-click index.html directly or, of course, do it in R:
```{r}
browseURL('_book/index.html')
 ```



## Changelog
All notable changes to the book will be documented here.

### v0.1 (2017-12-03)
- First release of the Interpretable Machine Learning book
