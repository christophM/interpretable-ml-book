import re

import numpy as np
import pandas as pd
from sklearn.impute import SimpleImputer


def preprocess_bike_data(df: pd.DataFrame) -> pd.DataFrame:
    """Preprocesses the bike sharing dataset."""

    df["weekday"] = pd.Categorical(
        df["weekday"], categories=range(7), ordered=True
    ).rename_categories(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"])
    df["holiday"] = pd.Categorical(
        df["holiday"], categories=[0, 1], ordered=True
    ).rename_categories(["NO HOLIDAY", "HOLIDAY"])
    df["workingday"] = pd.Categorical(
        df["workingday"], categories=[0, 1], ordered=True
    ).rename_categories(["NO WORKING DAY", "WORKING DAY"])
    df["season"] = pd.Categorical(
        df["season"], categories=range(1, 5), ordered=True
    ).rename_categories(["WINTER", "SPRING", "SUMMER", "FALL"])
    df["weathersit"] = pd.Categorical(
        df["weathersit"], categories=range(1, 4), ordered=True
    ).rename_categories(["GOOD", "MISTY", "RAIN/SNOW/STORM"])
    df["mnth"] = pd.Categorical(
        df["mnth"], categories=range(1, 13), ordered=True
    ).rename_categories(
        [
            "JAN",
            "FEB",
            "MAR",
            "APR",
            "MAY",
            "JUN",
            "JUL",
            "AUG",
            "SEP",
            "OCT",
            "NOV",
            "DEC",
        ]
    )

    df["yr"] = np.where(df["yr"] == 0, 2011, 2012)
    df["yr"] = pd.Categorical(df["yr"])
    df["dteday"] = pd.to_datetime(df["dteday"])
    df["days_since_2011"] = (df["dteday"] - df["dteday"].min()).dt.days
    df["temp"] = df["temp"] * (39 - (-8)) + (-8)
    df["atemp"] = df["atemp"] * (50 - (16)) + (16)
    df["windspeed"] = 67 * df["windspeed"]
    df["hum"] = 100 * df["hum"]

    return df.drop(columns=["instant", "dteday", "registered", "casual", "atemp"])


def preprocess_ycomments(df: pd.DataFrame) -> pd.DataFrame:
    """Preprocesses the YouTube Spam Comments dataset."""

    def _clean_ycomments(html_string: str) -> str:
        if pd.isna(html_string):
            return html_string
        return re.sub("<.*?>", "", html_string)

    df["CONTENT"] = df["CONTENT"].apply(_clean_ycomments)
    df["CONTENT"] = (
        df["CONTENT"].astype(str).str.encode("ascii", "ignore").str.decode("ascii")
    )
    return df


def preprocess_rfcc(df: pd.DataFrame) -> pd.DataFrame:
    """Preprocesses the Risk Factors for Cervical Cancer dataset."""
    df = df.drop(columns=["Citology", "Schiller", "Hinselmann"])
    df["Biopsy"] = pd.Categorical(
        df["Biopsy"], categories=[0, 1], ordered=True
    ).rename_categories(["Healthy", "Cancer"])
    df = df[
        [
            "Age",
            "Number of sexual partners",
            "First sexual intercourse",
            "Num of pregnancies",
            "Smokes",
            "Smokes (years)",
            "Hormonal Contraceptives",
            "Hormonal Contraceptives (years)",
            "IUD",
            "IUD (years)",
            "STDs",
            "STDs (number)",
            "STDs: Number of diagnosis",
            "STDs: Time since first diagnosis",
            "STDs: Time since last diagnosis",
            "Biopsy",
        ]
    ]
    # Impute missing values using the most frequent value (mode)
    df = df.replace("?", np.nan)
    imputer = SimpleImputer(strategy="most_frequent")
    df.iloc[:, :-1] = imputer.fit_transform(df.iloc[:, :-1])
    df_imputed = pd.DataFrame(df, columns=df.columns[:-1])
    df_imputed = df_imputed.astype(float)
    df = pd.concat([df_imputed, df["Biopsy"]], axis=1)
    return df
