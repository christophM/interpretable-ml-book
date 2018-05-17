# Interpretable machine learning

Explaining the decisions and behaviour of machine learning models.

[![Build Status](https://travis-ci.org/christophM/interpretable-ml-book.svg?branch=master)](https://travis-ci.org/christophM/interpretable-ml-book)

## Summary
You can find the current version of the book here: https://christophm.github.io/interpretable-ml-book/

This book is about interpretable machine learning. Machine learning is being built into many products and processes of our daily lives, yet decisions made by machines don't automatically come with an explanation. An explanation increases the trust in the decision and in the machine learning model. As the programmer of an algorithm you want to know whether you can trust the learned model. Did it learn generalizable features? Or are there some odd artifacts in the training data which the algorithm picked up? This book will give an overview over techniques that can be used to make black boxes as transparent as possible and explain decisions. In the first chapter algorithms that produce simple, interpretable models are introduced together with instructions how to interpret the output. The later chapters focus on analyzing complex models and their decisions.
In an ideal future, machines will be able to explain their decisions and make a transition into an algorithmic age more human. This books is recommended for machine learning practitioners, data scientists, statisticians and also for stakeholders deciding on the use of machine learning and intelligent algorithms.


The book is automatically build from the master branch and pushed to gh-pages by Travis CI.

## Contributing

See [how to contribute](CONTRIBUTING.md)

## Rendering the book
Clone the repository.
```{shell}
git clone git@github.com:christophM/interpretable-ml-book.git
```
Make sure all dependencies for the book are installed. This book has the structure of an R package, so dependencies can be installed easily, only R and the devtools library is required.
Start an R session in the folder of the book repository and type:
```{r}
devtools::install_deps()
```

For rendering the book, start an R session and type:
```{r}
setwd("manuscript")
bookdown::render_book('', 'bookdown::gitbook')
```

After rendering, the HTML files of the  book will be in the "_book" folder. You can either double-click index.html directly or, of course, do it in R:
```{r}
browseURL('_book/index.html')
```



## Changelog
All notable changes to the book will be documented here.

### v0.4 (IN PROGRESS)
- Added chapter on global surrogate models
- Added improved Shapley pictograms
- Added feature interaction chapter
- Improved example in partial dependence plot chapter
- The weights in LIME text chapter where shown with the wrong words. This has been fixed.

### v0.3 (2018-04-24)
- Reworked the Feature Importance Chapter
- Added third short story
- Removed xkcd comic
- Merged introduction and about the book chapters
- Addeds pros & cons to pdp and ice chapters
- Started using the iml package for plots in ice and pdp
- Restructured the book files for Leanpub
- Added a cover
- Added some CSS for nicer formatting

### v0.2 (2018-02-13)
- Added chapter about Shapley value explanations
- Added short story chapters
- Added donation links in Preface
- Reworked RuleFit with examples and theory.
- Interpretability chapter extended
- Add chapter on human-style explanations
- Making it easier to collaborate: Travis checks if book can be rendered for pull requests

### v0.1 (2017-12-03)
- First release of the Interpretable Machine Learning book
