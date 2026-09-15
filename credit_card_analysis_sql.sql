CREATE DATABASE credit_card_analysis;

USE credit_card_analysis;

### Create table
CREATE TABLE credit_card_transactions (
    transaction_id INT PRIMARY KEY,
    city VARCHAR(100),
    transaction_date DATE,
    card_type VARCHAR(20),
    exp_type VARCHAR(30),
    gender CHAR(1),
    amount DECIMAL(15,2),
    year INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    day_name VARCHAR(20)
);

DESCRIBE credit_card_transactions;


#### Total transactions
SELECT
    COUNT(*) AS total_transactions
FROM credit_card_transactions;

###Total transaction amount
SELECT
    SUM(amount) AS total_transaction_amount
FROM credit_card_transactions;


### Average transaction amount
SELECT
    ROUND(AVG(amount), 2) AS average_transaction_amount
FROM credit_card_transactions;

### Minimum and maximum transaction
SELECT
    MIN(amount) AS minimum_transaction,
    MAX(amount) AS maximum_transaction
FROM credit_card_transactions;

### GROUP BY ANALYSIS

### Transactions by card type
SELECT
    card_type,
    COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY card_type
ORDER BY total_transactions DESC;

### Amount by card type
SELECT
    card_type,
    SUM(amount) AS total_amount
FROM credit_card_transactions
GROUP BY card_type
ORDER BY total_amount DESC;

### Average amount by card type
SELECT
    card_type,
    ROUND(AVG(amount), 2) AS average_amount
FROM credit_card_transactions
GROUP BY card_type
ORDER BY average_amount DESC;

#### Transactions by expense type
SELECT
    exp_type,
    COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY exp_type
ORDER BY total_transactions DESC;

####Amount by expense type
SELECT
    exp_type,
    SUM(amount) AS total_amount
FROM credit_card_transactions
GROUP BY exp_type
ORDER BY total_amount DESC;

### CITY ANALYSIS

### Top 10 cities by transaction amount
SELECT
    city,
    SUM(amount) AS total_amount
FROM credit_card_transactions
GROUP BY city
ORDER BY total_amount DESC
LIMIT 10;

#### Top 10 cities by transaction count
SELECT
    city,
    COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY city
ORDER BY total_transactions DESC
LIMIT 10;

### GENDER ANALYSIS
### Gender-wise transactions
SELECT
    gender,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount
FROM credit_card_transactions
GROUP BY gender;


#### DATE ANALYSIS
#### Year-wise transactions
SELECT
    year,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM credit_card_transactions
GROUP BY year
ORDER BY year;

### Monthly transactions
SELECT
    year,
    month,
    COUNT(*) AS total_transactions
FROM credit_card_transactions
GROUP BY year, month
ORDER BY year, month;

#### Monthly transaction amount
SELECT
    year,
    month,
    SUM(amount) AS total_amount
FROM credit_card_transactions
GROUP BY year, month
ORDER BY year, month;

######## Rank card types by spending
SELECT
    card_type,
    SUM(amount) AS total_amount,
    RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS spending_rank
FROM credit_card_transactions
GROUP BY card_type;

### Rank cities by transaction amount
SELECT
    city,
    SUM(amount) AS total_amount,
    RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS city_rank
FROM credit_card_transactions
GROUP BY city;

### Top 10 cities using ROW_NUMBER
SELECT *
FROM (
    SELECT
        city,
        SUM(amount) AS total_amount,
        ROW_NUMBER() OVER (
            ORDER BY SUM(amount) DESC
        ) AS rn
    FROM credit_card_transactions
    GROUP BY city
) AS ranked_cities
WHERE rn <= 10;

### Expense type ranking
SELECT
    exp_type,
    SUM(amount) AS total_amount,
    DENSE_RANK() OVER (
        ORDER BY SUM(amount) DESC
    ) AS expense_rank
FROM credit_card_transactions
GROUP BY exp_type;

###CTE
### High-value expense categories
WITH expense_summary AS (
    SELECT
        exp_type,
        SUM(amount) AS total_amount
    FROM credit_card_transactions
    GROUP BY exp_type
)
SELECT
    exp_type,
    total_amount
FROM expense_summary
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM expense_summary
)
ORDER BY total_amount DESC;


#### SUBQUERY

###Transactions above average
SELECT
    transaction_id,
    city,
    card_type,
    exp_type,
    amount
FROM credit_card_transactions
WHERE amount > (
    SELECT AVG(amount)
    FROM credit_card_transactions
)
ORDER BY amount DESC;



###LAG FUNCTION
### Month-over-month transaction comparison
WITH monthly_data AS (
    SELECT
        year,
        month,
        COUNT(*) AS total_transactions
    FROM credit_card_transactions
    GROUP BY year, month
)
SELECT
    year,
    month,
    total_transactions,
    LAG(total_transactions) OVER (
        ORDER BY year, month
    ) AS previous_month_transactions
FROM monthly_data
ORDER BY year, month;

#### Month-over-month growth %
WITH monthly_data AS (
    SELECT
        year,
        month,
        COUNT(*) AS total_transactions
    FROM credit_card_transactions
    GROUP BY year, month
),
previous_data AS (
    SELECT
        year,
        month,
        total_transactions,
        LAG(total_transactions) OVER (
            ORDER BY year, month
        ) AS previous_month_transactions
    FROM monthly_data
)
SELECT
    year,
    month,
    total_transactions,
    previous_month_transactions,
    ROUND(
        (
            total_transactions - previous_month_transactions
        ) / previous_month_transactions * 100,
        2
    ) AS mom_growth_percentage
FROM previous_data
ORDER BY year, month;

### Running total
SELECT
    transaction_date,
    amount,
    SUM(amount) OVER (
        ORDER BY transaction_date, transaction_id
    ) AS running_total
FROM credit_card_transactions
ORDER BY transaction_date, transaction_id;


#### Procedure for card analysis
DELIMITER //

CREATE PROCEDURE card_analysis()
BEGIN

    SELECT
        card_type,
        COUNT(*) AS total_transactions,
        SUM(amount) AS total_amount,
        ROUND(AVG(amount), 2) AS average_amount
    FROM credit_card_transactions
    GROUP BY card_type
    ORDER BY total_amount DESC;

END //

DELIMITER ;

CALL card_analysis();

#### TRIGGER