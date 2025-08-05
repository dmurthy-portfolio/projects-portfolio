# 🍷 Wine Quality Prediction

This project focuses on predicting the **quality of wine** based on various physicochemical features. It utilizes a machine learning approach to classify wine samples as **high or low quality** based on a range of input features.


## 📌 Features

- Exploratory Data Analysis (EDA)
- Data Preprocessing and Cleaning
- Feature Scaling (StandardScaler)
- Binary Classification Target Creation
- Model Training using Logistic Regression
- Model Evaluation (Accuracy, Confusion Matrix, Classification Report)

## 🔧 Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-learn
- Jupyter Notebook

## 🎯 Problem Statement

The goal is to build a model that predicts whether a given wine sample is of **good quality** (rating ≥ 7) or not (rating < 7) based on chemical properties like:
- Fixed acidity
- Volatile acidity
- Citric acid
- Residual sugar
- Chlorides
- Free sulfur dioxide
- Total sulfur dioxide
- Density
- pH
- Sulphates
- Alcohol

## 📈 Target Variable

The original `quality` column (integer 0–10) is converted into a binary classification target:
- **1** for good quality (≥ 7)
- **0** for not good quality (< 7)

## ⚙️ Model

- **Logistic Regression** was used as the baseline classification model.
- Evaluation metrics include:
  - Accuracy Score
  - Confusion Matrix
  - Classification Report


