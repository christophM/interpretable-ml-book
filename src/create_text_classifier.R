

library('tm')
library('SnowballC')
library('rpart')


urls = sprintf('http://lasid.sor.ufscar.br/labeling/datasets/%i/download/', 9:13)
ycomments = lapply(urls, read.csv, stringsAsFactors=FALSE)
ycomments = do.call('rbind', ycomments)
cleanFun <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}
ycomments$CONTENT = cleanFun(ycomments$CONTENT)
# Convert to ASCII
ycomments$CONTENT = iconv(ycomments$CONTENT, "UTF-8", "ASCII", sub="")


prepare_data = function(comments, trained_corpus = NULL){
  
  corpus = Corpus(VectorSource(comments))
  dtm = DocumentTermMatrix(corpus, control = list(removePunctuation = TRUE, 
                                                  stopwords=TRUE,
                                                  removeNumbers = TRUE,
                                                  stemming = TRUE))
  
  labeledTerms = as.data.frame(as.matrix(dtm))
  
  # Seems that columns called break or next cause trouble
  names(labeledTerms)[names(labeledTerms) %in% c('break')] <- 'break.'
  names(labeledTerms)[names(labeledTerms) %in% c('next')] <- 'next.'
  
  
  if(!is.null(trained_corpus)){
    # Make sure only overlapping features are used
    labeledTerms = labeledTerms[intersect(colnames(labeledTerms), colnames(trained_corpus))]
    
    empty_corpus = trained_corpus[1, ]
    labeledTerms = data.frame(data.table::rbindlist(list(empty_corpus, labeledTerms), fill=TRUE))
    labeledTerms = labeledTerms[2:nrow(labeledTerms),]
  }
  labeledTerms
}




# Split into training and test by date
set.seed(42)
percent_train = 0.8
train_index = sample(1:nrow(ycomments), size=percent_train * nrow(ycomments), replace = FALSE)
test_index = setdiff(1:nrow(ycomments), train_index)

train = ycomments[train_index,]
test = ycomments[test_index, ]



get_predict_fun = function(model, train_corpus){
  function(comments){
    terms = prepare_data(comments, train_corpus)
    predict(model, newdata = terms, type='prob')
  }
}



labeledTerms = prepare_data(train$CONTENT)
labeledTerms$class = factor(ycomments$CLASS[train_index], levels = c(0,1), labels = c('no spam', 'spam'))
labeledTerms2 = prepare_data(test$CONTENT, trained_corpus = labeledTerms)




rp = rpart(class ~ ., data = labeledTerms)


rp
predict(rp, newdata = labeledTerms2)


predict_fun = get_predict_fun(rp, labeledTerms)
predict_fun(test$CONTENT)


predict_fun(test_text)




library('lime')

# Text data is not yet implemented

# Doing it myself now







# Tokenize

tokenize = function(x){
  unlist(strsplit(x, "\\s+")) 
}


draw_combination =  function(words, prob=0.5, pred_fun){
  # Create combination
  combi = rbinom(n = length(words), size = 1, prob = prob)
  names(combi) = words
  df = data.frame(t(combi))
  # Create text
  new_text = paste(words[which(combi==1)], collapse  = ' ')
  list(text = new_text, 
       combi = df)
}

create_variations = function(text, pred_fun, prob=0.5, n_variations = 100, class){
  tokenized = tokenize(text)
  df = data.frame(lapply(tokenized, function(x) 1))
  names(df) = tokenized
  
  combinations = lapply(1:n_variations, function(x){
    draw_combination(tokenized, prob=prob, pred_fun=pred_fun)
  })
  
  texts = as.vector(sapply(combinations, function(x) x['text']))
  
  features = data.frame(data.table::rbindlist(sapply(combinations, function(x) x['combi'])))
  weights = rowSums(features) / ncol(features)
  predictions = pred_fun(texts)[,class]
  
  cbind(features, pred=predictions, weights = weights)
}


explain_text = function(text, pred_fun, prob=0.9, n_variations=500, K = 3, case=1, class){
  stopifnot(K >= 1)
  df = create_variations(text, pred_fun = predict_fun, prob = prob, n_variations = n_variations, class=class)
  mod = glm(pred ~ . - weights, data =df , weights=df$weights, family = 'binomial')
  
  coefs = coef(mod)
  coefs = coefs[names(coefs) != '(Intercept)']
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


texts = test$CONTENT[2:4]

explanations  = data.table::rbindlist(lapply(seq_along(texts), function(i) {
  explain_text(test_texts[i], pred_fun, class='spam', case=i)
  })
)
plot_features(data.frame(explanations), ncol=1)












