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


output <- opts_knit$get("rmarkdown.pandoc.to")
is.html = !is.null(output) && output == "html"
is.pdf = !is.null(output) && output == "latex"
is.epub = !is.null(output) && output == "epub3" 

opts_chunk$set(
  echo = FALSE,
  out.width = ifelse(is.pdf, "0.8\\textwidth", "\\textwidth"),
  fig.align = "center",
  message = FALSE,
  warning = FALSE,
  fig.path = "images/", 
  collapse = TRUE,
  dev = "jpeg",
  dpi = 150, 
  fig.height = 5, 
  fig.width = 7,
  dev.args = list(pointsize = 20)
)

