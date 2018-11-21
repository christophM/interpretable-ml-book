library("knitr")
library('tm')
library('rpart')
library('mlr')
library('dplyr')
library('ggplot2')
library('tidyr')
library('partykit')
library('memoise')
library('pre')
library('iml')


opts_chunk$set(
  echo = FALSE,
  message = FALSE,
  warning = FALSE,
  fig.path = "images/", 
  collapse = TRUE,
  dev = "CairoPNG",
  dpi = 150, 
  fig.height = 5, 
  fig.width = 7,
  dev.args = list(pointsize = 20)
)

output <- opts_knit$get("rmarkdown.pandoc.to")
