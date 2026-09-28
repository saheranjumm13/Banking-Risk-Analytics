CREATE DATABASE banking_risk;
USE banking_risk
SELECT DATABASE();

USE banking_risk;
SHOW TABLES;
SELECT * FROM application_train LIMIT 10;
DESCRIBE application_train;
SELECT COUNT(*) AS total_records FROM application_train;
SELECT TARGET,COUNT(*) AS customers FROM application_train GROUP BY TARGET;

SELECT
    COUNT(*) AS total_rows,
    SUM(AMT_INCOME_TOTAL IS NULL) AS missing_income,
    SUM(AMT_CREDIT IS NULL) AS missing_credit,
    SUM(AMT_ANNUITY IS NULL) AS missing_annuity,
    SUM(NAME_CONTRACT_TYPE IS NULL) AS missing_contract_type
FROM application_train;

SELECT
    ROUND(MIN(AMT_CREDIT), 2) AS min_credit,
    ROUND(MAX(AMT_CREDIT), 2) AS max_credit,
    ROUND(AVG(AMT_CREDIT), 2) AS avg_credit,
    ROUND(MIN(AMT_INCOME_TOTAL), 2) AS min_income,
    ROUND(MAX(AMT_INCOME_TOTAL), 2) AS max_income,
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS avg_income
FROM application_train;

SELECT 
    SK_ID_CURR,
    COUNT(*) AS duplicate_count
FROM application_train
GROUP BY SK_ID_CURR
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS invalid_income
FROM application_train
WHERE AMT_INCOME_TOTAL <= 0;

SELECT
    COUNT(*) AS invalid_credit
FROM application_train
WHERE AMT_CREDIT <= 0;

SELECT
    COUNT(*) AS invalid_annuity
FROM application_train
WHERE AMT_ANNUITY <= 0;

SELECT
    COUNT(*) AS total_applications,
    SUM(TARGET) AS total_defaults,
    ROUND(AVG(TARGET) * 100, 2) AS default_rate_percentage
FROM application_train;

SELECT
    NAME_CONTRACT_TYPE,
    COUNT(*) AS total_applications,
    SUM(TARGET) AS defaults,
    ROUND(AVG(TARGET) * 100, 2) AS default_rate_percentage
FROM application_train
GROUP BY NAME_CONTRACT_TYPE
ORDER BY default_rate_percentage DESC;

SELECT
    CASE
        WHEN AMT_INCOME_TOTAL < 100000 THEN 'Low Income'
        WHEN AMT_INCOME_TOTAL < 250000 THEN 'Medium Income'
        WHEN AMT_INCOME_TOTAL < 500000 THEN 'High Income'
        ELSE 'Very High Income'
    END AS income_group,

    COUNT(*) AS customers,

    SUM(TARGET) AS defaults,

    ROUND(AVG(TARGET) * 100, 2) AS default_rate
FROM application_train
GROUP BY income_group
ORDER BY default_rate DESC;

SELECT
    SK_ID_CURR,
    AMT_INCOME_TOTAL,
    AMT_CREDIT,

    ROUND(
        AMT_CREDIT / NULLIF(AMT_INCOME_TOTAL, 0),
        2
    ) AS credit_income_ratio,

    TARGET
FROM application_train
LIMIT 20;

SELECT 
    SK_ID_CURR,
    COUNT(*) AS duplicate_count
FROM application_train
GROUP BY SK_ID_CURR
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS invalid_income
FROM application_train
WHERE AMT_INCOME_TOTAL <= 0;

SELECT
    COUNT(*) AS invalid_credit
FROM application_train
WHERE AMT_CREDIT <= 0;

SELECT
    COUNT(*) AS total_applications,
    SUM(TARGET) AS total_defaults,
    ROUND(AVG(TARGET) * 100, 2) AS default_rate_percentage
FROM application_train;

CREATE OR REPLACE VIEW customer_risk_analysis AS
SELECT
    SK_ID_CURR AS customer_id,

    AMT_INCOME_TOTAL AS income,
    AMT_CREDIT AS credit_amount,
    AMT_ANNUITY AS annual_annuity,

    CASE
        WHEN AMT_INCOME_TOTAL < 100000 THEN 'Low Income'
        WHEN AMT_INCOME_TOTAL < 250000 THEN 'Medium Income'
        WHEN AMT_INCOME_TOTAL < 500000 THEN 'High Income'
        ELSE 'Very High Income'
    END AS income_group,

    ROUND(
        AMT_CREDIT / NULLIF(AMT_INCOME_TOTAL, 0),
        2
    ) AS credit_income_ratio,

    CASE
        WHEN TARGET = 1 THEN 'Default'
        ELSE 'Non-Default'
    END AS loan_status,

    TARGET AS default_flag

FROM application_train;

SELECT *
FROM customer_risk_analysis
LIMIT 10;

CREATE OR REPLACE VIEW customer_risk_segments AS
SELECT
    customer_id,
    income,
    credit_amount,
    credit_income_ratio,
    loan_status,

    CASE
        WHEN default_flag = 1 THEN 'High Risk'

        WHEN credit_income_ratio >= 5 THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_segment

FROM customer_risk_analysis;

SELECT *
FROM customer_risk_segments
LIMIT 20;

SELECT
    risk_segment,
    COUNT(*) AS customer_count
FROM customer_risk_segments
GROUP BY risk_segment
ORDER BY customer_count DESC;

SELECT
    risk_segment,
    COUNT(*) AS customers,
    SUM(
        CASE
            WHEN loan_status = 'Default' THEN 1
            ELSE 0
        END
    ) AS defaults,

    ROUND(
        AVG(
            CASE
                WHEN loan_status = 'Default' THEN 1
                ELSE 0
            END
        ) * 100,
        2
    ) AS default_rate

FROM customer_risk_segments
GROUP BY risk_segment
ORDER BY default_rate DESC;

SELECT
    income_group,
    COUNT(*) AS customers,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate
FROM customer_risk_analysis
GROUP BY income_group
ORDER BY default_rate DESC;

SELECT
    customer_id,
    income,
    credit_amount,

    RANK() OVER (
        ORDER BY credit_amount DESC
    ) AS credit_rank,

    DENSE_RANK() OVER (
        ORDER BY credit_amount DESC
    ) AS dense_credit_rank,

    ROW_NUMBER() OVER (
        ORDER BY credit_amount DESC
    ) AS row_number_rank

FROM customer_risk_analysis
LIMIT 20;

SELECT
    customer_id,
    income,
    credit_amount,
    credit_income_ratio,
    loan_status
FROM customer_risk_analysis
ORDER BY credit_amount DESC
LIMIT 10;

SELECT
    customer_id,
    income,
    credit_amount,
    credit_income_ratio,
    loan_status
FROM customer_risk_analysis
WHERE credit_income_ratio >= 5
ORDER BY credit_income_ratio DESC
LIMIT 20;

CREATE OR REPLACE VIEW banking_risk_summary AS
SELECT
    customer_id,
    income,
    credit_amount,
    annual_annuity,
    income_group,
    credit_income_ratio,
    loan_status,
    default_flag,

    CASE
        WHEN default_flag = 1 THEN 'High Risk'
        WHEN credit_income_ratio >= 5 THEN 'Medium Risk'
        WHEN credit_income_ratio >= 3 THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS risk_segment

FROM customer_risk_analysis;

SELECT *
FROM banking_risk_summary
LIMIT 10;

SELECT
    customer_id,
    income,
    credit_amount,
    RANK() OVER (ORDER BY credit_amount DESC) AS credit_rank,
    DENSE_RANK() OVER (ORDER BY credit_amount DESC) AS dense_credit_rank,
    ROW_NUMBER() OVER (ORDER BY credit_amount DESC) AS row_number_rank
FROM customer_risk_analysis
LIMIT 20;

WITH customer_summary AS (
    SELECT
        income_group,
        COUNT(*) AS customers,
        SUM(default_flag) AS defaults,
        ROUND(AVG(default_flag) * 100, 2) AS default_rate
    FROM customer_risk_analysis
    GROUP BY income_group
)
SELECT *
FROM customer_summary
ORDER BY default_rate DESC;

WITH customer_summary AS (
    SELECT
        income_group,
        COUNT(*) AS customers,
        SUM(default_flag) AS defaults,
        ROUND(AVG(default_flag) * 100, 2) AS default_rate
    FROM customer_risk_analysis
    GROUP BY income_group
)
SELECT
    income_group,
    customers,
    defaults,
    default_rate,
    RANK() OVER (
        ORDER BY default_rate DESC
    ) AS risk_rank
FROM customer_summary;

WITH customer_summary AS (
    SELECT
        income_group,
        COUNT(*) AS customers,
        ROUND(AVG(default_flag) * 100, 2) AS default_rate
    FROM customer_risk_analysis
    GROUP BY income_group
)
SELECT
    income_group,
    customers,
    default_rate,

    LAG(default_rate) OVER (
        ORDER BY default_rate
    ) AS previous_default_rate

FROM customer_summary;

WITH customer_summary AS (
    SELECT
        income_group,
        COUNT(*) AS customers,
        ROUND(AVG(default_flag) * 100, 2) AS default_rate
    FROM customer_risk_analysis
    GROUP BY income_group
)
SELECT
    income_group,
    customers,
    default_rate,

    LEAD(default_rate) OVER (
        ORDER BY default_rate
    ) AS next_default_rate

FROM customer_summary;

WITH customer_summary AS (
    SELECT
        income_group,
        COUNT(*) AS customers
    FROM customer_risk_analysis
    GROUP BY income_group
)
SELECT
    income_group,
    customers,

    SUM(customers) OVER (
        ORDER BY customers
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_customers

FROM customer_summary;

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

USE banking_risk;
SHOW TABLES;

SELECT COUNT(*) AS total_records
FROM application_train_cleaned;

SELECT *
FROM application_train_cleaned
LIMIT 10;

SELECT
    TARGET,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM application_train_cleaned),
        2
    ) AS percentage
FROM application_train_cleaned
GROUP BY TARGET;

SELECT
    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage
FROM application_train_cleaned;

SELECT
    ROUND(MIN(AMT_INCOME_TOTAL), 2) AS minimum_income,
    ROUND(MAX(AMT_INCOME_TOTAL), 2) AS maximum_income,
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS average_income
FROM application_train_cleaned;

SELECT
    ROUND(MIN(AMT_CREDIT), 2) AS minimum_credit,
    ROUND(MAX(AMT_CREDIT), 2) AS maximum_credit,
    ROUND(AVG(AMT_CREDIT), 2) AS average_credit
FROM application_train_cleaned;

SELECT
    NAME_CONTRACT_TYPE,
    COUNT(*) AS total_customers,
    SUM(TARGET) AS defaulted_customers,
    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage
FROM application_train_cleaned
GROUP BY NAME_CONTRACT_TYPE
ORDER BY default_rate_percentage DESC;

SELECT
    CASE
        WHEN AMT_INCOME_TOTAL < 100000 THEN 'Low Income'
        WHEN AMT_INCOME_TOTAL < 250000 THEN 'Medium Income'
        WHEN AMT_INCOME_TOTAL < 500000 THEN 'High Income'
        ELSE 'Very High Income'
    END AS income_category,

    COUNT(*) AS customers,

    SUM(TARGET) AS defaulted_customers,

    ROUND(
        AVG(TARGET) * 100,
        2
    ) AS default_rate_percentage

FROM application_train_cleaned

GROUP BY income_category

ORDER BY default_rate_percentage DESC;

USE banking_risk;

DROP VIEW IF EXISTS banking_risk_summary;

SHOW FULL TABLES
WHERE Tables_in_banking_risk = 'banking_risk_summary';

CREATE TABLE banking_risk_summary AS
SELECT
    SK_ID_CURR,
    TARGET,
    AMT_INCOME_TOTAL,
    AMT_CREDIT,
    AMT_ANNUITY,

    CASE
        WHEN TARGET = 1 THEN 'High Risk'

        WHEN TARGET = 0
             AND AMT_CREDIT > AMT_INCOME_TOTAL * 5
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS risk_category

FROM application_train_cleaned;

DESCRIBE banking_risk_summary;

SELECT *
FROM banking_risk_summary
LIMIT 10;

SELECT
    risk_category,
    COUNT(*) AS customers
FROM banking_risk_summary
GROUP BY risk_category;

SELECT
    risk_category,
    TARGET,
    COUNT(*) AS customers
FROM banking_risk_summary
GROUP BY risk_category, TARGET
ORDER BY risk_category, TARGET;

SELECT
    risk_category,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM banking_risk_summary),
        2
    ) AS percentage
FROM banking_risk_summary
GROUP BY risk_category
ORDER BY customers DESC;

SELECT
    risk_category,
    COUNT(*) AS customers,
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS average_income,
    ROUND(AVG(AMT_CREDIT), 2) AS average_credit,
    ROUND(AVG(AMT_ANNUITY), 2) AS average_annuity
FROM banking_risk_summary
GROUP BY risk_category
ORDER BY customers DESC;

SELECT
    COUNT(*) AS total_customers,
    SUM(TARGET) AS defaulted_customers,
    COUNT(*) - SUM(TARGET) AS non_defaulted_customers,
    ROUND(AVG(TARGET) * 100, 2) AS default_rate_percentage
FROM banking_risk_summary;

CREATE OR REPLACE VIEW vw_risk_dashboard AS

SELECT
    risk_category,
    COUNT(*) AS total_customers,
    SUM(TARGET) AS defaulted_customers,
    ROUND(AVG(TARGET) * 100, 2) AS default_rate_percentage,
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS average_income,
    ROUND(AVG(AMT_CREDIT), 2) AS average_credit,
    ROUND(AVG(AMT_ANNUITY), 2) AS average_annuity

FROM banking_risk_summary

GROUP BY risk_category;

CREATE OR REPLACE VIEW vw_risk_dashboard AS
SELECT
    risk_category,
    COUNT(*) AS total_customers,
    SUM(TARGET) AS defaulted_customers,
    ROUND(AVG(TARGET) * 100, 2) AS default_rate_percentage,
    ROUND(AVG(AMT_INCOME_TOTAL), 2) AS average_income,
    ROUND(AVG(AMT_CREDIT), 2) AS average_credit,
    ROUND(AVG(AMT_ANNUITY), 2) AS average_annuity
FROM banking_risk_summary
GROUP BY risk_category;

SHOW FULL TABLES
WHERE Tables_in_banking_risk = 'vw_risk_dashboard';

SELECT *
FROM vw_risk_dashboard;

