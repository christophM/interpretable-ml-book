# Introduction {#intro}

This book explains to you how to make (supervised) machine learning models interpretable.
The chapters contain some mathematical formulas, but you should be able to understand the ideas behind the methods even without the formulas.
This book is not for people trying to learn machine learning from scratch.
If you are new to machine learning, there are a lot of books and other resources to learn the basics.
I recommend the book "The Elements of Statistical Learning" by Hastie, Tibshirani, and Friedman (2009) [^Hastie] and [Andrew Ng's "Machine Learning" online course](https://www.coursera.org/learn/machine-learning)  on the online learning platform  coursera.com to start with machine learning.
Both the book and the course are available free of charge!

New methods for the interpretation of machine learning models are published at breakneck speed.
To keep up with everything that is published would be madness and simply impossible. 
That is why you will not find the most novel and fancy methods in this book, but established methods and basic concepts of machine learning interpretability.
These basics prepare you for making machine learning models interpretable.
Internalizing the basic concepts also empowers you to better understand and evaluate any new paper on interpretability published on [arxiv.org](https://arxiv.org/) in the last 5 minutes since you began reading this book (I might be exaggerating the publication rate).

This book starts with some (dystopian) [short stories](#storytime) that are not needed to understand the book, but hopefully will entertain and make you think.
Then the book explores the concepts of [machine learning interpretability](#interpretability).
We will discuss when interpretability is important and what different types of explanations there are.
Terms used throughout the book can be looked up in the [Terminology chapter](#terminology).
Most of the models and methods explained are presented using real data examples which are described in the [Data chapter](#data).
One way to make machine learning interpretable is to use [interpretable models](#simple), such as linear models or decision trees.
The other option is the use of [model-agnostic interpretation tools](#agnostic) that can be applied to any supervised machine learning model.
The Model-Agnostic Methods chapter deals with methods such as partial dependence plots and permutation feature importance.
Model-agnostic methods work by changing the input of the machine learning model and measuring changes in the prediction output.
Model-agnostic methods that return data instances as explanations are discussed in the chapter [Example Based Explanations](#example-based).
All model-agnostic methods can be further differentiated based on whether they explain global model behavior across all data instances or individual predictions.
The following methods explain the overall behavior of the model: [Partial Dependence Plots](#pdp), [Accumulated Local Effects](#ale), [Feature Interaction](#interaction), [Feature Importance](#feature-importance), [Global Surrogate Models](#global) and [Prototypes and Criticisms](#proto).
To explain individual predictions we have [Local Surrogate Models](#lime), [Shapley Value Explanations](#shapley), [Counterfactual Explanations](#counterfactual) (and closely related: [Adversarial Examples](#adversarial)). 
Some methods can be used to explain both aspects of global model behavior and individual predictions: [Individual Conditional Expectation](#ice) and [Influential Instances](#influential).

The book ends with an optimistic outlook on what [the future of interpretable machine learning](#future) might look like.

You can either read the book from beginning to end or jump directly to the methods that interest you.

I hope you will enjoy the read!

[^Hastie]: Friedman, Jerome, Trevor Hastie, and Robert Tibshirani. "The elements of statistical learning". www.web.stanford.edu/~hastie/ElemStatLearn/  (2009).
