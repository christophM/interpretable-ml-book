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
# first, generate the references
source("../scripts/references.R")
bookdown::render_book('', 'bookdown::gitbook')
```

After rendering, the HTML files of the  book will be in the "_book" folder. You can either double-click index.html directly or, of course, do it in R:
```{r}
browseURL('_book/index.html')
```
## Notes on Printing with lulu.com

- Export from Leanpub in 7.44" x 9.68" 	18.9cm x 24.6cm
- For cover: 7.565 x 9.925", 19.226 x 25.224cm, see [recommended sizes](https://connect.lulu.com/en/discussion/33279/recommended-book-cover-image-dimensions)
- Font for front cover: Francois One

## Writing

Stuff that both works for leanpub and for bookdown:

- Titles start with #, subtitles with ## and so on.
- Titles can be tagged using {#tag-of-the-title}
- Chapters can be referenced by using `[text of the link](#tag-of-the-title)`
- Figures can be referenced by using `[text of the link](#fig:tag-of-r-chunk-that-produced-figure)`
- Start and end mathematical expressions with `$` (inline) or with `$$` (extra line). Will be automatically changed for leanpub with a regexpr. Conversion script only works if no empty spaces are in the formula.
- Leave empty lines between formulas and text (if formula not inline)
- References have to be writen like this: `[^ref-tag]` and must be at the end of the respective file with `[^ref]: Details of the reference ...`. Make sure the space is included. References are collected in 10-reference.Rmd with the script references.R. Make sure not to use `[^ref-tag]: ` anywhere in the text, only at the bottom for the actual reference.

Printing for  proofreading with extra line spacing: 
Build HTML book, go to manuscript/_book/libs/gitbook*/css/style.css, change line-height:1.7 to line-height:2.5, open local html with chrome, print to pdf with custom margin.
## Changelog
All notable changes to the book will be documented here.

### v1.2 (IN PROGRESS)


### v1.1 (2019-03-23) [Print Version]
- Fixes wrong index in Cooks Distance summation (i -> j)
- fixed boxplot formula (1.5 instead of 1.58)
- Change to colorblind-friendly color palettes (viridis)
- Make sure plots work in black and white as well

### v1.0 (2019-02-21)
- Extensive proofreading and polishing

### v0.7 (2018-11-21)
- Renamed Definitions chapter to Terminology
- Added mathematical notation to Terminology (former Definitions) chapter
- Added LASSO example
- Restructured lm chapter and added pros/cons
- Renamed "Criteria of Interpretability Methods" to "Taxonomy of Interpretability Methods"
- Added advantages and disadvantages of logistic regression
- Added list of references at the end of book
- Added images to the short stories
- Added drawback of shapley value: feature have to be independent
- Added tree decomposition and feature importance to tree chapter
- Improved explanation of individual prediction in lm
- Added "What's Wrong With my Dog" example to Adversarial Examples
- Added links to data files and pre-processing R scripts

### v0.6 (2018-11-02)
- Added chapter on accumulated local effects plots
- Added some advantages and disadvantages to pdps
- Added chapter on extending linear models
- Fixed missing square in the Friedman H-statistic
- Added discussion about training vs. test data in feature importance chapter
- Improved the definitions, also added some graphics
- Added an example with a categorical feature to PDP

### v0.5 (2018-08-14)
- Added chapter on influential instances
- Added chapter on Decision Rules
- Added chapter on adversarial machine examples
- Added chapter on prototypes and criticisms
- Added chapter on counterfactual explanations
- Added section on LIME images (by Verena Haunschmid)
- Added section on when we don't need interpretability
- Renamed chapter: Human-style Explanations -> Human-friendly Explanations

### v0.4 (2018-05-23)
- Added chapter on global surrogate models
- Added improved Shapley pictograms
- Added acknowledgements chapter
- Added feature interaction chapter
- Improved example in partial dependence plot chapter
- The weights in LIME text chapter where shown with the wrong words. This has been fixed.
- Improved introduction text
- Added chapter about the future of interpretability
- Added Criteria for Intepretability Methods

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
