# 💳 Credit Card Transaction Analysis

## 📌 Project Overview

This project analyzes credit card transaction data to identify customer spending patterns, transaction trends, popular card types, expense categories, gender-wise spending, and city-wise performance.

The project uses **Python for Data Preparation & Exploratory Data Analysis (EDA)** and **MySQL for Data Analysis**.

---

## 🎯 Project Objectives

- Analyze overall credit card transactions
- Identify total and average transaction amounts
- Analyze spending by card type
- Analyze spending by expense category
- Compare male and female transaction behavior
- Identify top-performing cities
- Analyze monthly and yearly transaction trends
- Use SQL Window Functions for ranking and analysis
- Use CTEs for advanced analysis
- Use Subqueries and Joins
- Create Stored Procedures
- Create Triggers
- Perform data cleaning and visualization using Python

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Python | Data Preparation & EDA |
| Pandas | Data Cleaning & Analysis |
| NumPy | Numerical Operations |
| Matplotlib | Data Visualization |
| Seaborn | Data Visualization |
| MySQL | SQL Data Analysis |
| MySQL Workbench | Database Management |
| Jupyter Notebook | Python Analysis |
| GitHub | Project Portfolio |

---

## 📂 Dataset

The dataset contains **26,052 credit card transactions**.

### Main Columns

- `transaction_id` – Unique transaction ID
- `city` – City where the transaction occurred
- `transaction_date` – Date of transaction
- `card_type` – Type of credit card used
- `exp_type` – Expense category
- `gender` – Customer gender
- `amount` – Transaction amount

---

# 🐍 Python Project

## Data Preparation & EDA

Python was used for:

### 1. Data Loading
- Imported the CSV dataset using Pandas
- Checked dataset shape and structure

### 2. Data Cleaning
- Checked missing values
- Checked duplicate records
- Checked duplicate transaction IDs
- Converted transaction date into proper date format

### 3. Feature Engineering

Created additional fields such as:

- Year
- Month
- Month Name
- Day
- Day Name

### 4. Exploratory Data Analysis

Analyzed:

- Transaction distribution
- Card type performance
- Expense category performance
- Gender-wise spending
- Monthly transaction trends
- Monthly revenue trends
- Top 10 cities
- Average transaction amount

### 5. Visualizations

Created visualizations using:

- Matplotlib
- Seaborn

---

# 🗄️ SQL Project

Database used:

```sql
credit_card_transaction_analysis
