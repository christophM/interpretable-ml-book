
library('mlr')
library('dplyr')
bike = read.csv(sprintf('%s/bike-sharing-daily.csv', data_dir), stringsAsFactors = FALSE)

# See http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset

## TODO: Name levels
bike$weekday = factor(bike$weekday, levels=0:6, labels = c('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'))
bike$holiday = factor(bike$holiday, levels = c(0,1), labels = c('no holiday', 'holiday'))
bike$workingday = factor(bike$workingday, levels = c(0,1), labels = c('no working day', 'working day'))
bike$season = factor(bike$season, levels = 1:4, labels = c('spring', 'summer', 'fall', 'winter'))
bike$weathersit = factor(bike$weathersit, levels = 1:3, labels = c('clear to partly cloudy', 'misty', 'Light snow/rain or stormy'))
bike$mnth = factor(bike$mnth)
bike$yr[bike$yr == 0] = 2011
bike$yr[bike$yr == 1] = 2012
bike.raw = bike

bike = dplyr::select(bike, -cnt, -registered, -instant, -dteday)
set.seed(41)
train.index = sample(1:nrow(bike), size = 0.85 * nrow(bike))
bike.train = bike[train.index,]
task.train = mlr::makeRegrTask(id='bike', data=bike.train, target = 'casual')

bike.test = bike[setdiff(1:nrow(bike), train.index),]
task.test = mlr::makeRegrTask(id='bike.test', data=bike.test, target = 'casual')



# 
# lrn = mlr::makeLearner(cl='regr.randomForest')
# 
# 
# lrn.trained = mlr::train(learner = lrn, task = task.train)
# 
# 
# pred = mlr::getPredictionResponse(predict(lrn.trained, bike.test))
# 
# 
# 
# pdp.dat = mlr::generatePartialDependenceData(lrn.trained, input = bike.test, features = 'temp')
# mlr::plotPartialDependence(pdp.dat)
# 
# 
# pdp.dat = mlr::generatePartialDependenceData(lrn.trained, input = bike.test, features = 'windspeed')
# mlr::plotPartialDependence(pdp.dat)
# 
# 
# pdp.dat = mlr::generatePartialDependenceData(lrn.trained, input = bike.test, features = 'hum')
# mlr::plotPartialDependence(pdp.dat)
# 
# 
# 
# pdp.dat = mlr::generatePartialDependenceData(lrn.trained, input = bike.test, features = c('hum', 'temp'), interaction = TRUE)
# mlr::plotPartialDependence(pdp.dat, geom='tile')
