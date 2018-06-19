# 
# library(data.table)
# library(mlr)
# 
# devtools::load_all()
# data(bike)
# 
# madk = function (x) {
#   median(abs(x - median(x)))
# }
# 
# 
# mad = function (X) {
#  apply(X, 2, madk)
# }
# 
# 
# 
# mad.dist = function(x, x.star, mads) {
#   sum(abs(x - x.star) / mads)
# }
# 
# data(cervical)
# cervical.x = cervical[-which(names(cervical) %in% "Biopsy")]
# 
# cervical.task = makeClassifTask(data = cervical, target = "Biopsy")
# mod.cervical = mlr::train(mlr::makeLearner(cl = 'classif.randomForest', predict.type = "prob"), cervical.task)
# 
# f.mod = function(x){
#   getPredictionProbabilities(predict(mod.cervical, newdata = x))
# }
# 
# 
# loss.iris = function(x, x.initial = cervical.x[1,], y.target = 2, X = cervical.x, f = f.mod, lambda = 0.1
#   ){
#   mads = mad(X)
#   mads.positive = mads > 0
#   #lambda * (f(x) - y.target) + gower_dist(x, x.initial)
#   lambda * (f(x) - y.target)^2 + mad.dist(x[mads.positive], x.initial[mads.positive], mads[mads.positive])
#   
# }
# 
# 
# loss.iris(cervical.x[1,], lambda = 10)
# loss.iris(cervical.x[2,], lambda = 10)
# loss.iris(cervical.x[3,], lambda = 10)
# loss.iris(cervical.x[4,], lambda = 10)
# loss.iris(cervical.x[5,], lambda = 10)
# loss.iris(cervical.x[6,], lambda = 10)
# lapply(1:nrow(cervical.x), function(i){loss.iris(cervical.x[i,])})
# 
# optim(par =  cervical.x[4,], fn = loss.iris )
