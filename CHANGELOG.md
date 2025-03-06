# Changelog

## v3.0 (2025-03-11) [html; print; ebook]

- Renamed chapters to reflect the more established names:
  - Local Surrogate (LIME) -> LIME
  - Global Surrogate -> Surrogate Models
  - SHAP (SHapley Additive exPlanations) -> SHAP 
  - Pixel Attribution (Saliency Maps) -> Saliency Maps
- Switched the order of global and local: Now local model-agnostic methods come before global methods.
- Unified and improved the examples:
  - Train models just once
  - Measure and report performance (in Data chapter)
  - Study correlations and mutual information
  - Made examples in each chapter much more 
- Strongly shortened the text between first word and first method:
  - Scope of interpretability: Now part of Overview chapter.
  - removed preface by the author and moved relevant parts into about the book and introduction
  - moved chapters "Terminology" and "What is Machine Learning" into appendix
  - Moved short stories to the end of the book
- Combined all the intro texts (e.g. global methods) into an overview chapter 
- New chapters:
  - Methods Overview 
  - Goals of interpretability
  - Ceteris Paribus 
  - LOFO
- Updated lots of references (and move them from footnotes to proper bibtex references).
- Made math more consistent
- Improved the captions of the figures and referenced them from within the text.
- Use Palmer Penguins for classification examples. This replaces the examples with the cancer dataset. There was an error in how how I coded the outcome, so all interpretations were reversed. Instead of reversing the labels, I decided to replace the data, since I on longer think it's a good fit for the book. The penguin data examples are more accessible, and less sensitive.
- Deleted chapter "Other interpretable models": only contained naive bayes and knn, but raised more question than it answered.
- Replaced contribute chapter with links to repo
- Smaller errors fixed:
  - in chapter Learned Features -> Network Dissection -> Step 2: Retrieve network activations, quantile level was corrected to not depend on x, i.e.g T_k instead of T_k(x).


## v2.0 (2022-03-04)

- Added "Preface by the Author" chapter
- Started section on neural network interpretation
- Added chapter on feature visualization
- Added SHAP chapter
- Added Anchors chapter
- Fixed error in logistic regression chapter: Logistic regression was predicting class "Healthy", but interpretation in the text was for class "Cancer". Now regression weights have the correct sign.
- Renamed Feature Importance chapter to "Permutation Feature Importance"
- Added chapter about functional decomposition
- Rearranged interpretation methods by local, global and deep learning (before: model-agnostic, example-based, deep learning)
- Math Errata:
	- Chapter 4.3 GLM, GAM and more: Logistic regression uses logit, not logistic function as link function.
	- Chapter Linear models: Formula for adjusted R-squared was corrected (twice)
        - Chapter Decision Rules: Newly introduced mix up between Healthy and Cancer in OneR chapter was fixed.
        - Chapter RuleFit: The importance of the linear term in the total importance formulate was indexed with an $l$ instead of $j$.
    - Chapter Influential Instances: removed $(1-\epsilon)$ from model parameter update.
- Updated images

## v1.1 (2019-03-23) 
- Fixes wrong index in Cooks Distance summation (i -> j)
- fixed boxplot formula (1.5 instead of 1.58)
- Change to colorblind-friendly color palettes (viridis)
- Make sure plots work in black and white as well
- Extends counterfactual chapter with MOC (by Susanne Dandl)

## v1.0 (2019-02-21)
- Extensive proofreading and polishing

## v0.7 (2018-11-21)
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

## v0.6 (2018-11-02)
- Added chapter on accumulated local effects plots
- Added some advantages and disadvantages to pdps
- Added chapter on extending linear models
- Fixed missing square in the Friedman H-statistic
- Added discussion about training vs. test data in feature importance chapter
- Improved the definitions, also added some graphics
- Added an example with a categorical feature to PDP

## v0.5 (2018-08-14)
- Added chapter on influential instances
- Added chapter on Decision Rules
- Added chapter on adversarial machine examples
- Added chapter on prototypes and criticisms
- Added chapter on counterfactual explanations
- Added section on LIME images (by Verena Haunschmid)
- Added section on when we don't need interpretability
- Renamed chapter: Human-style Explanations -> Human-friendly Explanations

## v0.4 (2018-05-23)
- Added chapter on global surrogate models
- Added improved Shapley pictograms
- Added acknowledgements chapter
- Added feature interaction chapter
- Improved example in partial dependence plot chapter
- The weights in LIME text chapter where shown with the wrong words. This has been fixed.
- Improved introduction text
- Added chapter about the future of interpretability
- Added Criteria for Interpretability Methods

## v0.3 (2018-04-24)
- Reworked the Feature Importance Chapter
- Added third short story
- Removed xkcd comic
- Merged introduction and about the book chapters
- Added pros & cons to pdp and ice chapters
- Started using the iml package for plots in ice and pdp
- Restructured the book files for Leanpub
- Added a cover
- Added some CSS for nicer formatting

## v0.2 (2018-02-13)
- Added chapter about Shapley value explanations
- Added short story chapters
- Added donation links in Preface
- Reworked RuleFit with examples and theory.
- Interpretability chapter extended
- Add chapter on human-style explanations
- Making it easier to collaborate: Travis checks if book can be rendered for pull requests

## v0.1 (2017-12-03)
- First release of the Interpretable Machine Learning book
