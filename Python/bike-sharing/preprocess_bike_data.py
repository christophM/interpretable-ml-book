# Imports
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Setting up the path
DIR = "../../data/"
DATA = "bike-sharing-daily.csv"

# Label Lists
weekdays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
holidays = ['NO HOLIDAY', 'HOLIDAY']
working_day = ['NO WORKING DAY', 'WORKING DAY']
season = ['WINTER', 'SPRING', 'SUMMER', 'FALL']
weathersit = ['GOOD', 'MISTY', 'RAIN/SNOW/STORM']
months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC']

# Function to create a dictionary mapping index of list to the respective label
def create_dictionary(label_list, start_at_zero=True):
  d = {}
  if start_at_zero:
    for idx, val in enumerate(label_list):
      d[idx] = val
  else:
    for idx, val in enumerate(label_list):
      d[idx+1] = val
  return d

# Function that denormalizes temperture
def inverse_min_max(row, tmin, tmax):
  return row * (tmax - tmin) + tmin

def data_pipeline():
    
    # Reading in the data
    day_bike_rentals = pd.read_csv(DIR+DATA)
    
    # Mapping numerical codes with actual values
    day_bike_rentals['weekday'] = day_bike_rentals['weekday'].map(create_dictionary(weekdays))
    day_bike_rentals['holiday'] = day_bike_rentals['holiday'].map(create_dictionary(holidays))
    day_bike_rentals['workingday'] = day_bike_rentals['workingday'].map(create_dictionary(working_day))
    day_bike_rentals['season'] = day_bike_rentals['season'].map(create_dictionary(season, start_at_zero=False))
    day_bike_rentals['weathersit'] = day_bike_rentals['weathersit'].map(create_dictionary(weathersit, start_at_zero=False))
    day_bike_rentals['mnth'] = day_bike_rentals['mnth'].map(create_dictionary(months, start_at_zero=False))
    
    # Reversing min_max
    day_bike_rentals['temp'] = day_bike_rentals['temp'].apply(inverse_min_max, args=(-8, 39))
    day_bike_rentals['atemp'] = day_bike_rentals['atemp'].apply(inverse_min_max, args=(-16, 50))
    
    # Unnormalizing the data
    day_bike_rentals['windspeed'] = day_bike_rentals['windspeed'].apply(lambda row: row * 67)
    day_bike_rentals['hum'] = day_bike_rentals['hum'].apply(lambda row: row * 100)
    
    # Converting labels into actual year
    day_bike_rentals['yr'] = day_bike_rentals['yr'].apply(lambda row: 2011 if row == 0 else 2012)
    
    # Converting 'dteday' to datetime object
    day_bike_rentals['dteday'] = pd.to_datetime(day_bike_rentals['dteday'])

    # Calculating days since 2011
    day_bike_rentals['days_since_2011'] = (day_bike_rentals['dteday'] - day_bike_rentals['dteday'].min()).dt.days
    
    # Feature selecting
    day_bike_rentals = day_bike_rentals[[col for col in day_bike_rentals.columns if col not in ['instant', 'dteday', 'registered', 'casual', 'atemp']]]

    # Dummifying categorical features
    day_bike_rentals = pd.concat([day_bike_rentals, pd.get_dummies(day_bike_rentals[['season', 'holiday','workingday', 'weathersit']], drop_first=True)], axis=1)
    
    # Returning the cleaned data
    return day_bike_rentals