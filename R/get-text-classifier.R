
get.ycomments.classifier = function(ycomments){
  labeledTerms = prepare_data(ycomments$CONTENT)
  labeledTerms$class = factor(ycomments$CLASS, levels = c(0,1), labels = c('no spam', 'spam'))
  rp = rpart::rpart(class ~ ., data = labeledTerms)
  get_predict_fun(rp, labeledTerms)
}

prepare_data = function(comments, trained_corpus = NULL){

  corpus = Corpus(VectorSource(comments))
  dtm = DocumentTermMatrix(corpus, control = list(removePunctuation = TRUE,
                                                  stopwords=TRUE,
                                                  stemming = FALSE,
                                                  removeNumbers = TRUE
                                                  ))

  labeledTerms = as.data.frame(as.matrix(dtm))

  # Seems that columns called break or next cause trouble
  names(labeledTerms)[names(labeledTerms) %in% c('break')] <- 'break.'
  names(labeledTerms)[names(labeledTerms) %in% c('next')] <- 'next.'
  names(labeledTerms)[names(labeledTerms) %in% c('else')] <- 'else.'


  if(!is.null(trained_corpus)){
    # Make sure only overlapping features are used
    labeledTerms = labeledTerms[intersect(colnames(labeledTerms), colnames(trained_corpus))]

    empty_corpus = trained_corpus[1, ]
    labeledTerms = data.frame(data.table::rbindlist(list(empty_corpus, labeledTerms), fill=TRUE))
    labeledTerms = labeledTerms[2:nrow(labeledTerms),]
  }
  labeledTerms
}


get_predict_fun = function(model, train_corpus){
  function(comments){
    terms = prepare_data(comments, train_corpus)
    predict(model, newdata = terms, type='prob')
  }
}


# Text data is not yet implemented in LIME
# Doing it myself here


#' Tokenize sentence into words
#'
#' @param x string with sentence
#' @return list of words
tokenize = function(x){
  unlist(strsplit(x, "\\s+"))
}


#' Get a subset from a text
#'
#' @param words List of words
#' @param prob Probability with which to keep a word
#' @return List with two objects. First object is the new text. Second object is a vector
#' of length number of words with 0s and 1s, indicating whether a word is in the new
#' sentence (1) or not (0)
draw_combination =  function(words, prob=0.5){
  # Create combination
  combi = rbinom(n = length(words), size = 1, prob = prob)
  names(combi) = words
  df = data.frame(t(combi))
  # Create text
  new_text = paste(words[which(combi==1)], collapse  = ' ')
  list(text = new_text,
       combi = df)
}


#'Create variations of a text
#'
#'@param text The text
#'@param pred_fun The prediction function from the machine learning model.
#'      It should contain the complete pipeline:  take the raw text, do all the pre-processing
#'      and do the prediction. Returned prediction should be a data.frame with one column per class
#'@param prob Probability with which to keep a word
#'@param n_variations Number of variations to create
#'@param class The class for which to create the predictions
#'@return data.frame for a local linear model, containing binary features for word occurence
#'weights for distance to original sentence and the predictions for the chosen class.
create_variations = function(text, pred_fun, prob=0.5, n_variations = 100, class, round.to = 2){
  tokenized = tokenize(text)
  df = data.frame(lapply(tokenized, function(x) 1))
  names(df) = tokenized

  combinations = lapply(1:n_variations, function(x){
    draw_combination(tokenized, prob=prob)
  })

  texts = as.vector(sapply(combinations, function(x) x['text']))

  features = data.frame(data.table::rbindlist(sapply(combinations, function(x) x['combi'])))
  weights = round(rowSums(features) / ncol(features), round.to)
  predictions = round(pred_fun(texts)[,class], round.to)

  cbind(features, pred=predictions, weights = weights)
}


#' Explain the classification of a text
#'
#'@param text The text for which to explain the classification
#'@param pred_fun The prediction function from the machine learning model.
#'      It should contain the complete pipeline:  take the raw text, do all the pre-processing
#'      and do the prediction. Returned prediction should be a data.frame with one column per class
#'@param prob The probability to keep a word in the variations
#'@param n_variations The number of text variations to create
#'@param K The number of features to use for the explanation
#'@param case The ID of the observation
#'@param class The class for which to create the explanations
explain_text = function(text, pred_fun, prob=0.9, n_variations=500, K = 3, case=1, class){
  stopifnot(K >= 1)
  df = create_variations(text, pred_fun = pred_fun, prob = prob, n_variations = n_variations, class=class)
  mod = glm(pred ~ . - weights, data =df , weights=df$weights, family = 'binomial')
  coefs = coef(mod)
  coefs = coefs[names(coefs) != '(Intercept)']
  names(coefs) = tokenize(text)
  coefs = coefs[base::order(abs(coefs), decreasing = TRUE)]
  coefs = coefs[1:K]
  # Create explanation compatible to R-LIME format
  tibble(case = case,
         label = class,
         label_prob = pred_fun(text)[, class],
         model_intercept = coef(mod)['(Intercept)'],
         feature = names(coefs),
         feature_value = names(coefs),
         feature_weight = coefs,
         feature_desc = names(coefs),
         data = text,
         prediction = list(pred_fun(text)))
}
