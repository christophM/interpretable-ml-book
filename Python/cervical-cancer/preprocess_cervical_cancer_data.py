# Imports
import pandas as pd

# Reading in the data


def data_pipeline():
    DIR = "../../data/"
    DATA = "cervical.csv"
    cervical = pd.read_csv(DIR+DATA)

    # Converting target into binary variable
    cervical['Biopsy'] = cervical['Biopsy'].apply(lambda row: 1 if row=='Cancer' else 0)

    return cervical