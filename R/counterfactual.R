
library(data.table)


madk = function (x) {
  median(abs(x - median(x)))
}


mad = function (X) {
 apply(X, 2, madk)
}



mad.dist = function(x, x.star, mads) {
  sum((x - x.star) / mads)
}


##mad.dist(iris[93,1:4], iris[2,1:4], mad(iris[1:4]))



mod = function(x){sum(x)}

loss.iris = function(x, x.initial = unlist(iris[1,1:4, drop = TRUE]), y.star = sum(iris[1, 1:4]), X = iris[1:4], f = mod, lambda = 1){
  lambda * (f(x) - y.star) + mad.dist(x, x.initial, mad(X))
}






# loss.iris(x = iris[4,1:4])
# 
# 
# iris[4, 1:4, drop = TRUE]
# optim(par =  iris[4, 1:4, drop = TRUE], fn = loss.iris )
