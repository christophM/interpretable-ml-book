library(R.utils)
library(tm)
library(dplyr)
library(mlr)

devtools::load_all("R/")
data_dir = "data/"



bike = get.bike.data(data_dir)
save(bike, file = sprintf('%sbike.RData', data_dir))

cervical = get.cervical.data(data_dir)
save(cervical, file =  sprintf('%scervical.RData', data_dir))


ycomments = get.ycomments.data(data_dir)
save(ycomments, file = sprintf('%sycomments.RData', data_dir))

