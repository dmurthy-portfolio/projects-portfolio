# 🏏 IPL Score Prediction

This project focuses on predicting the **first innings score in IPL (Indian Premier League)** T20 cricket matches using historical match data and machine learning techniques. It uses match context like batting team, bowling team, current runs, wickets, overs, and more to make accurate score predictions.


## 📌 Features

- Exploratory Data Analysis (EDA)
- Data Cleaning and Preprocessing
- One-Hot Encoding for Categorical Variables
- Train-Test Split
- Regression Models (e.g., Linear Regression, Ridge)
- Model Evaluation (R² score, MAE, RMSE)
- Score Prediction for a Given Match Scenario

## 🚀 How It Works

The model is trained to predict the **final first-innings score** using:
- Batting and bowling teams
- Venue
- Current score, overs, wickets
- Runs and wickets in the previous 5 overs

## 🔧 Tech Stack

- Python
- Pandas
- NumPy
- Scikit-learn
- Matplotlib / Seaborn
- Jupyter Notebook

## 📊 Sample Input Features

- `Batting Team`: e.g., "Mumbai Indians"
- `Bowling Team`: e.g., "Chennai Super Kings"
- `Overs`: e.g., 12.3
- `Runs`: e.g., 102
- `Wickets`: e.g., 2
- `Runs in Last 5 Overs`: e.g., 45
- `Wickets in Last 5 Overs`: e.g., 1

## 📈 Model Performance

- R² Score: ~0.84
- Mean Absolute Error: ~10 runs
- Root Mean Squared Error: ~13 runs

> 📌 Note: Actual values may vary based on final model and dataset size.

## 📥 Dataset

The dataset used is based on **IPL match data from 2008 to 2017**, typically available on Kaggle.




