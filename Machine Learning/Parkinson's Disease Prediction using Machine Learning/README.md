# 🧠 Parkinson's Disease Prediction using Machine Learning

This project focuses on building a **machine learning model** to predict whether a person has **Parkinson's Disease** using a biomedical dataset of voice measurements. Parkinson’s disease affects the nervous system and this model aims to support early diagnosis using non-invasive data.


## 📌 Features

- Exploratory Data Analysis (EDA)
- Data Preprocessing (e.g., dropping non-feature columns)
- Feature Scaling with StandardScaler
- Model Building with Support Vector Machine (SVM)
- Model Evaluation (Accuracy, Confusion Matrix, Classification Report)
- Input prediction for new patient data

## 🧪 Dataset

- **Source**: [UCI ML Repository - Parkinson’s Disease Data Set](https://archive.ics.uci.edu/ml/datasets/parkinsons)
- **Records**: 195
- **Features**: 22 voice measurement attributes + 1 target (`status`)
- **Target**:
  - `1`: Patient has Parkinson's Disease
  - `0`: Healthy

### Sample Features
- MDVP:Fo(Hz) – Average vocal fundamental frequency
- MDVP:Jitter(%) – Variations in frequency
- MDVP:Shimmer – Variations in amplitude
- NHR, HNR – Noise-to-harmonics ratio
- RPDE, DFA – Nonlinear dynamical complexity measures

## 🚀 Model Workflow

1. Load and explore the dataset
2. Clean and preprocess the data
3. Train a **Support Vector Machine (SVM)** classifier
4. Evaluate the model using accuracy, confusion matrix, and classification report
5. Accept user input to make live predictions

## ⚙️ Technologies Used

- Python
- Pandas
- NumPy
- Scikit-learn
- Matplotlib
- Seaborn
- Jupyter Notebook

