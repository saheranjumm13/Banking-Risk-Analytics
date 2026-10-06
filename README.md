# 🏦 Banking Risk Analytics

An end-to-end **Banking & Loan Risk Analytics** project combining **Python, MySQL, Machine Learning, and Power BI** to analyze loan applications, customer financial characteristics, and default risk.

---

## 📌 Project Overview

The project follows a complete analytics workflow:

```text
Raw Data
   ↓
Data Cleaning
   ↓
Missing Value Treatment
   ↓
Outlier Treatment
   ↓
Feature Engineering
   ↓
Exploratory Data Analysis
   ↓
Machine Learning
   ↓
Model Evaluation
   ↓
MySQL Risk Analysis
   ↓
Power BI Dashboard
```

The project is designed as a portfolio-level Data Science / Data Analytics project covering:

- Data preprocessing
- Exploratory data analysis
- Statistical analysis
- Feature engineering
- SQL database management
- Risk segmentation
- Loan default prediction
- Machine learning model comparison
- Interactive Power BI reporting

---

# 🎯 Project Objectives

The main objectives are to:

1. Analyze customer loan application data.
2. Identify patterns related to loan default.
3. Clean and prepare the dataset for analysis.
4. Handle missing values and outliers.
5. Create meaningful financial and demographic features.
6. Build machine learning models for default-risk classification.
7. Compare Logistic Regression, Random Forest, and XGBoost.
8. Store and analyze data using MySQL.
9. Create customer risk categories using SQL.
10. Build an interactive Banking Risk Analytics dashboard in Power BI.

---

# 🏦 Business Problem

Financial institutions need to understand the characteristics of customers who may have difficulty repaying loans.

This project analyzes factors such as:

- Customer income
- Credit amount
- Annuity
- Employment information
- Demographic characteristics
- Previous credit information
- Previous applications
- Installment/payment history
- Loan/default status

The `TARGET` variable in the main application dataset is used for loan-default classification.

```text
TARGET = 0 → No default
TARGET = 1 → Default
```

---

# 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data cleaning, EDA, feature engineering and ML |
| Pandas | Data manipulation |
| NumPy | Numerical computation |
| Matplotlib | Visualization |
| Seaborn | EDA and visualization |
| Scikit-learn | Machine learning |
| XGBoost | Gradient boosting |
| Jupyter Notebook | Python development |
| MySQL Server 8.0 | Database |
| MySQL Workbench | SQL development |
| Power BI | Interactive dashboard |
| Power Query | Data transformation |
| GitHub | Version control |

---

# 📂 Project Structure

```text
Banking-Risk-Analytics/
│
├── README.md
│
data
│
├── application_train_sample_10000.csv
├── application_train_cleaned_sample_10000.csv
├── application_train_feature_engineered_sample_10000.csv
├── bureau_sample_10000.csv
├── installments_payments_sample_10000.csv
└── HomeCredit_columns_description.csv
│
├── python/
│   ├── Banking_Risk_Analysis.ipynb
│   ├── model_comparison_results.csv
│   └── requirements.txt
│
├── sql/
│   └── banking_risk_analysis.sql
│
├── powerbi/
│   ├── Banking_Risk_Analytics.pbix
│   └── Banking_Risk_Analytics_Theme.json
│
└── screenshots/
    ├── dashboard.png
    └── model_results.png
```

---

# 📊 Dataset

The project uses the **Home Credit Default Risk** dataset.

The main datasets used during the project include:

### 1. `application_train`

Main loan application dataset containing customer and application information.

This dataset contains the `TARGET` variable used for default prediction.

### 2. `bureau`

Contains information about customers' previous credits reported by other financial institutions.

### 3. `previous_application`

Contains information about customers' previous loan applications.

### 4. `installments_payments`

Contains historical installment and payment information.

### 5. `HomeCredit_columns_description`

Provides descriptions of dataset columns.

---

## ⚠️ Dataset Size

The original datasets are very large.

Examples from the local project include:

```text
bureau
installments_payments
previous_application
application_train
application_train_cleaned
application_train_feature_engineered
```

The large raw/generated datasets are intentionally **not uploaded to GitHub** to avoid repository/file-size problems.

The `data/README.md` file documents the datasets and their purpose.

The Python notebook contains the preprocessing workflow required to reproduce the cleaned and feature-engineered data.

---

# 🧹 Data Cleaning

The Python workflow includes:

- Loading the dataset
- Inspecting dataset dimensions
- Checking data types
- Checking missing values
- Handling missing values
- Detecting and handling outliers
- Checking duplicate columns
- Encoding categorical variables
- Feature scaling
- Train/test splitting
- Saving cleaned data

Generated files:

```text
application_train_cleaned.csv
application_train_feature_engineered.csv
```

---

# 🔧 Feature Engineering

Feature engineering was performed to create additional variables useful for customer and loan-risk analysis.

Examples include:

### Age

```text
AGE
```

Created from the birth-day information.

### Employment duration

```text
EMPLOYMENT_YEARS
```

Created from employment-duration information.

Other engineered variables include financial/loan-related transformations and ratios used during analysis and modeling.

---

# 📈 Exploratory Data Analysis

The analysis focuses on:

## Customer Analytics

- Customer demographics
- Income analysis
- Employment information
- Financial characteristics

## Loan Analytics

- Loan amount
- Credit amount
- Annuity
- Contract type
- Loan-related characteristics

## Credit Risk Analytics

- Default distribution
- Customer risk categories
- Credit characteristics
- High-risk customer identification

## Repayment / Payment Analysis

Where applicable, the project dataset supports analysis of:

- Installment payments
- Payment history
- Delinquency-related information
- Previous applications

---

# 🤖 Machine Learning

Three classification models were implemented and compared.

## 1. Logistic Regression

Used as a baseline classification model for loan-default prediction.

## 2. Random Forest

An ensemble tree-based model used to capture nonlinear relationships between customer/application features and the target.

## 3. XGBoost

A gradient boosting classification model used for additional model comparison.

---

# 📊 Model Evaluation

The models were evaluated using:

- Accuracy
- Precision
- Recall
- F1 Score
- ROC-AUC

## Results

| Model | Accuracy | Precision | Recall | F1 Score | ROC-AUC |
|---|---:|---:|---:|---:|---:|
| Logistic Regression | 0.6795 | 0.1531 | 0.6554 | 0.2482 | 0.7288 |
| Random Forest | 0.7059 | 0.1638 | 0.6437 | 0.2611 | 0.7410 |
| XGBoost | 0.7079 | 0.1693 | 0.6705 | 0.2704 | 0.7604 |

These are the recorded results from the project's model-comparison workflow.

The results should be interpreted together with the class distribution and the selected evaluation metrics rather than accuracy alone.

---

# 🗄️ MySQL Database

## Database Server

```text
MySQL Server 8.0
```

## Database

```text
banking_risk
```
## MySQL username: root
## Database: banking_risk
## Password:MySQL@12345

The project uses MySQL Workbench for database management and SQL analysis.

### Main database objects used

```text
application_train
application_train_cleaned
banking_risk_summary
customer_risk_analysis
customer_risk_segments
vw_risk_dashboard
```

---

# 🔍 SQL Analysis

The SQL workflow includes:

- Database creation
- Selecting the project database
- Table inspection
- Record counting
- Target distribution
- Column inspection
- Missing-value analysis
- Financial summary statistics
- Customer risk categorization
- Risk-category counts
- Customer risk segmentation
- Dashboard-oriented summary queries/views

Example:

```sql
CREATE DATABASE banking_risk;

USE banking_risk;
```

Target distribution:

```sql
SELECT
    TARGET,
    COUNT(*) AS customers
FROM application_train
GROUP BY TARGET;
```

Risk-category analysis:

```sql
SELECT
    risk_category,
    TARGET,
    COUNT(*) AS customers
FROM banking_risk_summary
GROUP BY risk_category, TARGET
ORDER BY risk_category, TARGET;
```

---

# ⚠️ SQL Security

Database credentials are **not included** in this repository.

Do not upload:

- MySQL passwords
- API keys
- Private credentials
- Connection strings containing passwords

---

# 📊 Power BI Dashboard

The Power BI report is designed as a:

## `BANKING RISK ANALYTICS DASHBOARD`

The dashboard contains:

### KPI Cards

- Total Customers
- Defaulted Customers
- Default Rate

### Risk Analysis

- Customer Risk Distribution
- Risk Category slicer

### Financial Analysis

- Average Income by Risk Category
- Average Credit by Risk Category
- Average Annuity by Risk Category

### Summary Table

The dashboard includes a risk-category summary containing metrics such as:

- Risk category
- Total customers
- Defaulted customers
- Default rate percentage
- Average income
- Average credit
- Average annuity

---

# 📸 Power BI Dashboard Preview

The final interactive Power BI dashboard provides an overview of customer volume, defaults, default rate, risk distribution, and financial metrics by risk category.

![Banking Risk Analytics Dashboard](dashboard.PNG)

### Dashboard Highlights

- **Total Customers:** 5,826
- **Defaulted Customers:** 450
- **Default Rate:** 7.72%
- Customer risk distribution across Low, Medium, and High Risk
- Average income by risk category
- Average annuity by risk category
- Average credit by risk category
- Risk-category summary table
- `Risk_Category` slicer for interactive filtering

# 🎨 Power BI Theme

A custom Power BI theme is included:

```text
powerbi/Banking_Risk_Analytics_Theme.json
```

The theme can be imported into Power BI to maintain a consistent dashboard appearance.

---

# 🔄 Complete Project Workflow

```text
                  BANKING RISK ANALYTICS
                           │
                           ▼
                    Raw Loan Data
                           │
                           ▼
                    Data Cleaning
                           │
              ┌────────────┴────────────┐
              ▼                         ▼
       Missing Values              Outlier Treatment
              │                         │
              └────────────┬────────────┘
                           ▼
                  Feature Engineering
                           │
                           ▼
                     Python EDA
                           │
                           ▼
                 Machine Learning
                           │
             ┌─────────────┼─────────────┐
             ▼             ▼             ▼
          Logistic      Random        XGBoost
         Regression      Forest
             │             │             │
             └─────────────┼─────────────┘
                           ▼
                    Model Evaluation
                           │
                           ▼
                      MySQL Analysis
                           │
                           ▼
                    Risk Segmentation
                           │
                           ▼
                    Power BI Dashboard
```

---

# 📁 Important Project Files

## Python

```text
python/Banking_Risk_Analysis.ipynb
```

Contains:

- Data loading
- Cleaning
- EDA
- Missing-value treatment
- Outlier treatment
- Feature engineering
- Model training
- Model evaluation

## Model Results

```text
python/model_comparison_results.csv
```

Contains the recorded model evaluation results.

## SQL

```text
sql/banking_risk_analysis.sql
```

Contains the SQL database and risk-analysis workflow.

## Power BI

```text
powerbi/Banking_Risk_Analytics.pbix
```

Contains the interactive dashboard.

## Power BI Theme

```text
powerbi/Banking_Risk_Analytics_Theme.json
```

Contains the dashboard theme.

---

# 🚀 How to Run the Project

## Step 1 — Clone the Repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd Banking-Risk-Analytics
```

---

## Step 2 — Set Up Python

Create a virtual environment:

```bash
python -m venv venv
```

Activate it on Windows:

```bash
venv\Scripts\activate
```

Install dependencies:

```bash
pip install -r python/requirements.txt
```

---

## Step 3 — Run Jupyter Notebook

```bash
jupyter notebook
```

Open:

```text
python/Banking_Risk_Analysis.ipynb
```

---

# 🗄️ MySQL Setup

Install MySQL Server 8.0 and MySQL Workbench.

Create the database:

```sql
CREATE DATABASE banking_risk;

USE banking_risk;
```

Then execute the SQL workflow:

```text
sql/banking_risk_analysis.sql
```

If using a local MySQL installation, configure the connection using your own username and password.

Do not store the password in GitHub.

---

# 📊 Power BI Setup

Open:

```text
powerbi/Banking_Risk_Analytics.pbix
```

If Power BI asks for database credentials:

1. Select the MySQL data source.
2. Enter your local MySQL server details.
3. Select the `banking_risk` database.
4. Enter your own MySQL credentials.
5. Refresh the data.

---

# 📌 Key Project Outcomes

This project demonstrates practical skills in:

### Data Analytics

- Data cleaning
- Data validation
- EDA
- Statistical analysis
- Data visualization

### SQL

- Database creation
- Data exploration
- Aggregation
- CASE statements
- Risk segmentation
- Analytical queries
- Dashboard-oriented views

### Machine Learning

- Classification
- Feature engineering
- Feature scaling
- Model comparison
- Model evaluation

### Business Intelligence

- Power BI dashboards
- KPI cards
- Slicers
- Risk distribution
- Financial analysis
- Interactive reporting

---

# 🔐 Data Privacy & Repository Policy

The GitHub repository intentionally excludes:

- Large raw datasets
- Large cleaned datasets
- Large feature-engineered datasets
- Database passwords
- API keys
- Private credentials
- Personal sensitive information

The data-processing notebook documents how the datasets can be prepared.

---

# 📌 Future Improvements

Potential extensions include:

- Hyperparameter tuning
- Cross-validation
- Class-imbalance techniques
- ROC and Precision-Recall curves
- Feature importance analysis
- SHAP model explainability
- Advanced customer segmentation
- Early-warning indicators
- Automated ETL pipeline
- Additional Power BI dashboard pages
- Model deployment through an API
- Automated risk monitoring

---

# 👩‍💻 Author

**Saheranjum Makandar**

**Data Science Student | Machine Learning Enthusiast**

GitHub: `saheranjumm13`

---

# ⭐ Project Summary

**Banking Risk Analytics** demonstrates a complete workflow from raw financial data to business intelligence and machine learning:

```text
Python
   +
MySQL
   +
Machine Learning
   +
Power BI
   =
End-to-End Banking Risk Analytics
```

This project showcases practical experience in **Data Science, SQL, Machine Learning, Data Visualization, and Business Intelligence**.
