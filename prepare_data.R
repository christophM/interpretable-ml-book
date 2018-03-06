library(R.utils)
library(tm)
library(dplyr)
library(mlr)

devtools::load_all("R/")
data_dir = "data/"
ycomments = read.csv(sprintf('%s/TubeSpam.csv', data_dir), stringsAsFactors = FALSE)
save(ycomments, file = sprintf("%sycomments.RData", data_dir))

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

rp = rpart::rpart(class ~ ., data = labeledTerms)
predict_fun = get_predict_fun(rp, labeledTerms)




## load datasets
bike.data = get.bike.data(data_dir)
save(bike.data, file = sprintf('%sbike.data.RData', data_dir))

# bike.task = get.bike.task(data_dir)

cervical.data = get.cervical.data(data_dir)
save(cervical.data, file =  sprintf('%scervical.data.RData', data_dir))

# cervical.task = get.cervical.task(data_dir)


ycomments.data = get.ycomments.data(data_dir)
save(ycomments.data, file = sprintf('%sycomments.data.RData', data_dir))

