# A Look into the Crystal Ball {#future}

![](images/prophet.png)

What is the future of interpretable machine learning?
This chapter is a speculative mental exercise and a subjective guess how interpretable machine learning will develop.
I opened the book with rather pessimistic [short stories](#storytime) and would like to conclude with a more optimistic outlook. 

I have based my "predictions" on three premises:

1. **Digitization: Any (interesting) information will be digitized.**
Think of electronic cash and online transactions. 
Think of e-books, music and videos. 
Think of all the sensory data about our environment, our human behavior, industrial production processes and so on.
The drivers of the digitization of everything are: Cheap computers/sensors/storage, scaling effects (winner takes it all), new business models, modular value chains, cost pressure and much more.
1. **Automation: When a task can be automated and the cost of automation is lower than the cost of performing the task over time, the task will be automated.**
Even before the introduction of the computer we had a certain degree of automation.
For example, the weaving machine automated weaving or the steam machine automated horsepower.
But computers and digitization take automation to the next level. 
Simply the fact that you can program for-loops, write Excel macros, automate e-mail responses, and so on, show how much an individual can automate. 
Ticket machines automate the purchase of train tickets (no cashier needed any longer), washing machines automate laundry, standing orders automate payment transactions and so on.
Automating tasks frees up time and money, so there is a huge economic and personal incentive to automate things.
We are currently observing the automation of language translation, driving and, to a small degree, even scientific discovery. 
1. **Misspecification: We are not able to perfectly specify a goal with all its constraints.**
Think of the genie in a bottle that always takes your wishes literally:
"I want to be the richest person in the world!" -> You become the richest person, but as a side effect the currency you hold crashes due to inflation.  
"I want to be happy for the rest of my life!" -> The next 5 minutes you feel very happy, then the genie kills you.  
"I wish for world peace!" -> The genie kills all humans.  
We specify goals incorrectly, either because we do not know all the constraints or because we cannot measure them. 
Let's look at corporations as an example of imperfect goal specification.
A corporation has the simple goal of earning money for its shareholders.
But this specification does not capture the true goal with all its constraints that we really strive for:
For example, we do not appreciate a company killing people to make money, poisoning rivers, or simply printing its own money. 
We have invented laws, regulations, sanctions, compliance procedures, labor unions and more to patch up the imperfect goal specification.
Another example that you can experience for yourself is
[Paperclips](http://www.decisionproblem.com/paperclips/index2.html), a game in which you play a machine with the goal of producing as many paperclips as possible.
WARNING: It is addictive.
I do not want to spoil it too much, but let's say things get out of control really fast.
In machine learning, the imperfections in the goal specification come from imperfect data abstractions (biased populations, measurement errors, ...), unconstrained loss functions, lack of knowledge of the constraints, shifting of the distribution between training and application data and much more. 

Digitization is driving automation. 
Imperfect goal specification conflicts with automation.
I claim that this conflict is mediated partially by interpretation methods.

The stage for our predictions is set, the crystal ball is ready, now we look at where the field could go!


## The Future of Machine Learning

Without machine learning there can be no interpretable machine learning.
Therefore we have to guess where machine learning is heading before we can talk about interpretability.

Machine learning (or "AI") is associated with a lot of promises and expectations.
But let's start with a less optimistic observation:
While science develops a lot of fancy machine learning tools, in my experience it is quite difficult to integrate them into existing processes and products.
Not because it is not possible, but simply because it takes time for companies and institutions to catch up. 
In the gold rush of the current AI hype, companies open up "AI labs", "Machine Learning Units" and hire "Data Scientists", "Machine Learning Experts", "AI engineers", and so on, but the reality is, in my experience, rather frustrating.
Often companies do not even have data in the required form and the data scientists wait idle for months.
Sometimes companies have such high expectation of AI and Data Science due to the media that data scientists could never fulfill them.
And often nobody knows how to integrate data scientists into existing structures and many other problems.
This leads to my first prediction.

**Machine learning will grow up slowly but steadily**.

Digitalization is advancing and the temptation to automate is constantly pulling.
Even if the path of machine learning adoption is slow and stony, machine learning is constantly moving from science to business processes, products and real world applications.

I believe we need to better explain to non-experts what types of problems can be formulated as machine learning problems.
I know many highly paid data scientists who perform Excel calculations or classic business intelligence with reporting and SQL queries instead of applying machine learning.
But a few companies are already successfully using machine learning, with the big Internet companies at the forefront. 
We need to find better ways to integrate machine learning into processes and products, train people and develop machine learning tools that are easy to use.
I believe that  machine learning will become much easier to use: 
We can already see that machine learning is becoming more accessible, for example through cloud services ("Machine Learning as a service" -- just to throw a few buzzwords around).
Once machine learning has matured -- and this toddler has already taken its first steps -- my next prediction is:

**Machine learning will fuel a lot of things.**

Based on the principle "Whatever can be automated will be automated", I conclude that whenever possible, 
tasks will be formulated as prediction problems and solved with machine learning. 
Machine learning is a form of automation or can at least be part of it.
Many tasks currently performed by humans are replaced by machine learning. 
Here are some examples of tasks where machine learning is used to automate parts of it:

- Sorting / decision-making / completion of documents (e.g. in insurance companies, the legal sector or consulting firms)
- Data-driven decisions such as credit applications
- Drug discovery
- Quality controls in assembly lines
- Self-driving cars
- Diagnosis of diseases
- Translation. For this book, I used a translation service called ([DeepL](https://deepl.com)) powered by deep neural networks to improve my sentences by translating them from English into German and back into English. 
- ...

The breakthrough for machine learning is not only achieved through better computers / more data / better software, but also:



**Interpretability tools catalyze the adoption of machine learning.**

Based on the premise that the goal of a machine learning model can never be perfectly specified, it follows that interpretable machine learning is necessary to close the gap between the misspecified and the actual goal. 
In many areas and sectors, interpretability will be the catalyst for the adoption of machine learning. 
Some anecdotal evidence:
Many people I have spoken to do not use machine learning because they cannot explain the models to others. 
I believe that interpretability will address this issue and make machine learning attractive to organisations and people who demand some transparency.
In addition to the misspecification of the problem, many industries require interpretability, be it for legal reasons, due to risk aversion or to gain insight into the underlying task.
Machine learning automates the modeling process and moves the human a bit further away from the data and the underlying task: 
This increases the risk of problems with experimental design, choice of training distribution, sampling, data encoding, feature engineering, and so on.
Interpretation tools make it easier to identify these problems.



## The Future of Interpretability

Let us take a look at the possible future of machine learning interpretability.


**The focus will be on model-agnostic interpretability tools.**

It is much easier to automate interpretability when it is decoupled from the underlying machine learning model. 
The advantage of model-agnostic interpretability lies in its modularity.
We can easily replace the underlying machine learning model. 
We can just as easily replace the interpretation method.
For these reasons, model-agnostic methods will scale much better. 
That is why I believe that model-agnostic methods will become more dominant in the long term.
But intrinsically interpretable methods will also have a place.


**Machine learning will be automated and, with it, interpretability.**

An already visible trend is the automation of model training. 
That includes automated engineering and selection of features, automated hyperparameter optimization, comparison of different models, and ensembling or stacking of the models. 
The result is the best possible prediction model. 
When we use model-agnostic interpretation methods, we can automatically apply them to any model that emerges from the automated machine learning process.
In a way, we can automate this second step as well: 
Automatically compute the feature importance, plot the partial dependence, train a surrogate model, and so on. 
Nobody stops you from automatically computing all these model interpretations.
The actual interpretation still requires people.
Imagine: You upload a dataset, specify the prediction goal and at the push of a button the best prediction model is trained and the program spits out all interpretations of the model. 
There are already first products and I argue that for many applications it will be sufficient to use these automated machine learning services. 
Today anyone can build websites without knowing HTML, CSS and Javascript, but there are still many web developers around.
Similarly, I believe that everyone will be able to train machine learning models without knowing how to program, and there will still be a need for machine learning experts.


**We do not analyze data, we analyze models.**

The raw data itself is always useless.
(I exaggerate on purpose.
The reality is that you need a deep understanding of the data to conduct a meaningful analysis.) 
I don't care about the data; 
I care about the knowledge contained in the data. 
Interpretable machine learning is a great way to distill knowledge from data.
You can probe the model extensively, the model automatically recognizes if and how features are relevant for the prediction (many models have built-in feature selection), the model can automatically detect how relationships are represented, and -- if trained correctly -- the final model is a very good approximation of reality.


Many analytical tools are already based on data models (because they are based on distribution assumptions): 

- Simple hypothesis tests like Student's t-test.
- Hypothesis tests with adjustments for confounders (usually GLMs)
- Analysis of Variance (ANOVA)
- The correlation coefficient (the standardized linear regression coefficient is related to Pearson's correlation coefficient)
- ...

What I am telling you here is actually nothing new. 
So why switch from analyzing assumption-based, transparent models to analyzing assumption-free black box models?
Because making all these assumptions is problematic:
They are usually wrong (unless you believe that most of the world follows a Gaussian distribution), difficult to check, very inflexible and hard to automate.
In many domains, assumption-based models typically have a worse predictive performance on untouched test data than black box machine learning models.
This is only true for big datasets, since interpretable models with good assumptions often perform better with small datasets than black box models.
The black box machine learning approach requires a lot of data to work well.
With the digitization of everything, we will have ever bigger datasets and therefore the approach of machine learning becomes more attractive.
We do not make assumptions, we approximate reality as close as possible (while avoiding overfitting of the training data).
I argue that we should develop all the tools that we have in statistics to answer questions (hypothesis tests, correlation measures, interaction measures, visualization tools, confidence intervals, p-values, prediction intervals, probability distributions) and rewrite them for black box models.
In a way, this is already happening: 

- Let us take a classical linear model: The standardized regression coefficient is already a feature importance measure. 
With the [permutation feature importance measure](#feature-importance), we have a tool that works with any model. 
- In a linear model, the coefficients measures the effect of a single feature on the predicted outcome. 
The generalized version of this is the [partial dependence plot](#pdp).
- Test whether A or B is better: 
For this we can also use partial dependence functions. 
What we do not have yet (to the best of my best knowledge) are statistical tests for arbitrary black box models.


**The data scientists will automate themselves.**

I believe that data scientists will eventually automate themselves out of the job for many analysis and prediction tasks.
For this to happen, the tasks must be well-defined and there must to be some processes and routines around them. 
Today, these routines and processes are missing, but data scientists and colleagues are working on them.
As machine learning becomes an integral part of many industries and institutions, many of the tasks will be automated.
 

**Robots and programs will explain themselves.**

We need more intuitive interfaces to machines and programs that make heavy use of machine learning. 
Some examples:
A self-driving car that reports why it stopped abruptly ("70% probability that a kid will cross the road");
A credit default program that explains to a bank employee why a credit application was rejected ("Applicant has too many credit cards and is employed in an unstable job.");
A robot arm that explains why it moved the item from the conveyor belt into the trash bin ("The item has a craze at the bottom.").


**Interpretability could boost machine intelligence research.**

I can imagine that by doing more research on how programs and machines can explain themselves, we can improve improve our understanding of intelligence and become better at creating intelligent machines.

In the end, all these predictions are speculations and we have to see what the future really brings. 
Form your own opinion and continue learning!
