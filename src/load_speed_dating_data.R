# Load and prepare speed dating data

speed_dating = read.csv(sprintf('%s/speed_dating_data.csv', data_dir))

speed_dating$gender = factor(speed_dating$gender, levels = c(0,1), labels=c('Female', 'Male'))
speed_dating$samerace = factor(speed_dating$samerace, levels = c(0,1), labels = c('no', 'yes'))
speed_dating$dec_o = factor(speed_dating$dec_o, levels = c(0,1), labels = c('no', 'yes'))
speed_dating$match = factor(speed_dating$match, levels = c(0,1), labels = c('no', 'yes'))
speed_dating$field_cd = as.factor(speed_dating$field_cd)
speed_dating$race = factor(speed_dating$race, levels = 1:6,
labels=c('Black/African American', 'European/Caucasian-American', 'Latino/Hispanic American', 'Asian/Pacific Islander/Asian-American', 'Native American', 'Other'))
speed_dating$goal = factor(speed_dating$goal, levels = 1:6, labels = c('Seemed like a fun night out', 'To meet new people', 'To get a date',
                                                                       'Looking for a serious relationship', 'To say I did it', 'Other'))
speed_dating$date = factor(speed_dating$date, levels = 1:7, labels = c('Several times a week','Twice a week', 'Once a week',
                                                                       'Twice a month', 'Once a month', 'Several times a year', 'Almost never'))


# Do mean imputation
speed_dating = mlr::impute(speed_dating, classes = list(integer = mlr::imputeMean(), factor = mlr::imputeMode()),
                           dummy.classes = "integer")$data


speed_dating_names_matches = c('(Intercept)' = 'Intercept',
                              'gender' = 'Gender',
                              'round' = 'Number of people in wave',
                              'order' = 'Number of date',
                              'age_o' = 'Age of partner',
                              'race_o' = 'Race of partner',
                              'int_corr' = 'Correlation of interests',
                              'samerace' = 'Partners same race',
                              'dec_o' = 'Decision of partner',
                              'field_cd' = 'Field of study',
                              'imprelig' = 'Importance of same religion',
                              'imprace' = 'Importance of same race',
                              'race' = 'Race',
                              'goal' = 'Goal of date',
                              'date' = 'Dating frequency',
                              'like' = 'Liked partner (1-10)')
