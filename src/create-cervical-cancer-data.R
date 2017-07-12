#==============================================================================
# Preparing dataset for cervical cancer classification
#==============================================================================
# Source:
# http://archive.ics.uci.edu/ml/datasets/Cervical+cancer+%28Risk+Factors%29
# Paper: http://www.inescporto.pt/~jsc/publications/conferences/2017KelwinIBPRIA.pdf

cervical = read.csv(sprintf('%s/risk_factors_cervical_cancer.csv', data_dir), na.strings = c('?'), stringsAsFactors = FALSE)
cervical = select(cervical, -Citology, -Schiller, -Hinselmann)
cervical$Biopsy = factor(cervical$Biopsy, levels = c(1, 0), labels=c('Cancer', 'Healthy'))

# NA imputation
imputer = imputeMode()
# split training and test



cervical_impute = mlr::impute(cervical, classes = list(numeric = imputeMode()))
cervical = cervical_impute$data



cervical_task = mlr::makeClassifTask(id='cervical', data = cervical, target = 'Biopsy')
