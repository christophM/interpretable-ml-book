# load libraries

library('mlbench')
library('knitr')
library('ggplot2')
library('dplyr')
library('tidyr')
library('rpart')
library('partykit')
library('party')
library('randomForest')


# define graphics theme
my_theme = function(legend.position='right'){
  theme_bw() %+replace%
    theme(legend.position=legend.position)
}


# set paths
data_dir = './data'
src_dir = './src'
