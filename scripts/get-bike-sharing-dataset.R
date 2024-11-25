library(lubridate)
data_dir <- "../data/"

day_diff <- function(date1, date2) {
  as.numeric(difftime(as.Date(date1), as.Date(date2), units = "days"))
}

bike = read.csv(sprintf('%s/bike-sharing-daily.csv', data_dir), stringsAsFactors = FALSE)
# See http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset

bike$weekday = factor(bike$weekday, levels=0:6, labels = c('SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'))
bike$holiday = factor(bike$holiday, levels = c(0,1), labels = c('N', 'Y'))
bike$workday = factor(bike$workingday, levels = c(0,1), labels = c('N', 'Y'))
bike$workingday = NULL
bike$season = factor(bike$season, levels = 1:4, labels = c('WINTER', 'SPRING', 'SUMMER', 'FALL'))
bike$weather = factor(bike$weathersit, levels = 1:3, labels = c('GOOD', 'MISTY', 'BAD'))
bike$weathersit = NULL
bike$mnth = factor(bike$mnth, levels = 1:12, labels = c('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'))
bike$yr[bike$yr == 0] <- 2011
bike$yr[bike$yr == 1] <- 2012
bike$yr <- factor(bike$yr)
bike$days_since_2011 = day_diff(bike$dteday, min(as.Date(bike$dteday)))
bike <- bike[order(bike$days_since_2011), ]
bike$cnt_2d_bfr <- c(NA, NA, head(bike$cnt, -2))

# denormalize weather features:
# temp : Normalized temperature in Celsius. The values are derived via (t-t_min)/(t_max-t_min), t_min=-8, t_max=+39 (only in hourly scale)
bike$temp = bike$temp * (39 - (-8)) + (-8)
# atemp: Normalized feeling temperature in Celsius. The values are derived via (t-t_min)/(t_max-t_min), t_min=-16, t_max=+50 (only in hourly scale)
bike$atemp = bike$atemp * (50 - (16)) + (16)

#windspeed: Normalized wind speed. The values are divided to 67 (max)
bike$windspeed = 67 * bike$windspeed
#hum: Normalized humidity. The values are divided to 100 (max)
bike$hum = 100 * bike$hum
#dplyr::select(bike, -instant, -dteday, -registered, -casual, -atemp)

# Throwing out the two first days
bike = na.omit(bike)

save(bike, file = sprintf('%sbike.RData', data_dir))
write.csv(bike,file = sprintf('%sbike.csv', data_dir), row.names = FALSE)

