# Load and prepare speed dating data

speed_dating = read.csv(sprintf('%s/speed_dating_data.csv', data_dir))

speed_dating$gender = factor(speed_dating$gender, levels = c(0,1), labels=c('Female', 'Male'))
speed_dating$samerace = factor(speed_dating$samerace, levels = c(0,1), labels = c('no', 'yes'))
speed_dating$dec_o = factor(speed_dating$dec_o, levels = c(0,1), labels = c('no', 'yes'))
speed_dating$match = factor(speed_dating$match, levels = c(0,1), labels = c('no', 'yes'))
speed_dating$field_cd = as.factor(speed_dating$field_cd)
speed_dating$race = factor(speed_dating$race, levels = 1:6,
labels=c('Black/African American', 'European/Caucasian-American', 'Latino/Hispanic American', 'Asian/Pacific Islander/Asian-American', 'Native American', 'Other'))
#speed_dating$goal = factor(speed_dating$goal, levels = 1:6, labels = c('Seemed like a fun night out', 'To meet new people', 'To get a date',
#                                                                       'Looking for a serious relationship', 'To say I did it', 'Other'))

 speed_dating$goal = factor(speed_dating$goal, levels = 1:6, labels = c('for fun', 'meet new people', 'date',
                                                                            'relationship', 'experience', 'other'))

speed_dating$date = factor(speed_dating$date, levels = 1:7, labels = c('Several times a week','Twice a week', 'Once a week',
                                                                       'Twice a month', 'Once a month', 'Several times a year', 'Almost never'))



## Select columns for later
features_of_interest = c('gender', 'round', 'order', 'age_o', 'race_o', 'int_corr', 'samerace', 'imprelig', 'imprace',  'goal', 'date')
target_var_class = 'match'
target_var_regress = 'like'


speed_dating_both = na.omit(speed_dating[c(features_of_interest,  target_var_regress, target_var_class)])
speed_dating_regression = na.omit(speed_dating[c(features_of_interest,  target_var_regress)])
speed_dating_classification = na.omit(speed_dating[c(features_of_interest,  target_var_class)])
speed_dating_classification[,target_var_class] = factor(speed_dating_classification[,target_var_class], levels = c('yes', 'no'))


set.seed(123)
train_size <- floor(0.8 * nrow(speed_dating_classification))
train_ind <- sample(seq_len(nrow(speed_dating_classification)), size = train_size)
train_speed_dating_classification <- speed_dating_classification[train_ind, ]
test_speed_dating_classification <- speed_dating_classification[-train_ind, ]



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
