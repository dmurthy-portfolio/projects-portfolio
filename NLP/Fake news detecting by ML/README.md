# 📰 Fake News Detection using Machine Learning

This project uses natural language processing (NLP) and machine learning to classify news articles as **fake** or **real**. It leverages text data preprocessing, vectorization, and classification algorithms to build an effective fake news detection system.

## 🎯 Objective

- Analyze news content to identify fake news.
- Apply machine learning models to classify text as real or fake.
- Evaluate model performance using standard classification metrics.

## 📁 Files

- `Fake News Detection using Machine Learning.ipynb`: Main Jupyter notebook containing the entire workflow including text preprocessing, vectorization, modeling, and evaluation.

## 🛠️ Technologies Used

- **Python 3**
- **Pandas / NumPy** – Data manipulation
- **Scikit-learn** – Machine learning and evaluation
- **NLTK / re** – Text preprocessing
- **TfidfVectorizer / CountVectorizer** – Text vectorization
- **Jupyter Notebook** – Development environment

## 🔍 Workflow Overview

1. **Data Loading & Cleaning**
   - Remove nulls, duplicates
   - Clean text using regex and NLTK

2. **Text Preprocessing**
   - Lowercasing
   - Removing punctuation, stopwords
   - Tokenization & stemming/lemmatization (optional)

3. **Feature Extraction**
   - TF-IDF or Count Vectorizer

4. **Model Training**
   - Naive Bayes, Logistic Regression, SVM, or others

5. **Evaluation**
   - Accuracy, Precision, Recall, F1-score
   - Confusion Matrix

6. **Prediction**
   - Test the model on new/unseen articles

## 📊 Example Output

| Model              | Accuracy | F1 Score |
|-------------------|----------|----------|
| Logistic Regression | 0.95     | 0.94     |
| Multinomial NB     | 0.93     | 0.92     |

## 🚀 How to Run

1. Clone the repository or download the notebook.
2. Install dependencies:
   ```bash
   pip install pandas numpy scikit-learn nltk
