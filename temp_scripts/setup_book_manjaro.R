install.packages('ggplot2')
install.packages('dplyr')
install.packages('tidyr')
install.packages('mlr')

# install gfortran (package manager) --> needed for partykit
# ln -s /usr/bin/gfortran-5 /usr/bin/gfortran

install.packages("randomForest")
install.packages("caret")
install.packages("pre")

devtools::install_github("christophM/iml")

install.packages('partykit')

setwd("manuscript")
bookdown::render_book('', 'bookdown::gitbook')

