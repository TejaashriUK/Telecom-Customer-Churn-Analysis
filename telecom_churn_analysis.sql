
-- ============================================================
-- TELECOM CUSTOMER CHURN ANALYSIS
-- Database: telecom_churn_analysis
-- Table: telecom_customers
-- Tool: PostgreSQL
-- ============================================================


-- ============================================================
-- SECTION 1: CUSTOMER OVERVIEW
-- ============================================================

-- Q1. Total number of customers

SELECT
    COUNT(*) AS total_customers
FROM telecom_customers;


-- Q2. Overall customer churn distribution and percentage

SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM telecom_customers),
        2
    ) AS percentage
FROM telecom_customers
GROUP BY Churn
ORDER BY Churn;


-- ============================================================
-- SECTION 2: DEMOGRAPHIC ANALYSIS
-- ============================================================

-- Q3. Customer churn by gender

SELECT
    Gender,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY Gender, Churn
ORDER BY Gender, Churn;


-- Q4. Customer churn by senior citizen status

SELECT
    SeniorCitizen,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY SeniorCitizen, Churn
ORDER BY SeniorCitizen, Churn;


-- ============================================================
-- SECTION 3: SERVICE AND CONTRACT ANALYSIS
-- ============================================================

-- Q5. Customer churn by contract type

SELECT
    Contract,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY Contract, Churn
ORDER BY Contract, Churn;


-- Q6. Customer churn by internet service

SELECT
    InternetService,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY InternetService, Churn
ORDER BY InternetService, Churn;


-- Q7. Customer churn by payment method

SELECT
    PaymentMethod,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY PaymentMethod, Churn
ORDER BY PaymentMethod, Churn;


-- Q8. Customer churn by technical support availability

SELECT
    TechSupport,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY TechSupport, Churn
ORDER BY TechSupport, Churn;


-- Q9. Customer churn by online security availability

SELECT
    OnlineSecurity,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY OnlineSecurity, Churn
ORDER BY OnlineSecurity, Churn;


-- Q10. Customer churn by online backup availability

SELECT
    OnlineBackup,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY OnlineBackup, Churn
ORDER BY OnlineBackup, Churn;


-- ============================================================
-- SECTION 4: TENURE AND CHARGES ANALYSIS
-- ============================================================

-- Q11. Customer churn by tenure group

SELECT
    CASE
        WHEN Tenure <= 12 THEN '0-1 Year'
        WHEN Tenure <= 24 THEN '1-2 Years'
        WHEN Tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY tenure_group, Churn
ORDER BY tenure_group, Churn;


-- Q12. Customer churn by monthly charge group

SELECT
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges < 70 THEN 'Medium Charges'
        ELSE 'High Charges'
    END AS charge_group,
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
GROUP BY charge_group, Churn
ORDER BY charge_group, Churn;


-- Q13. Average tenure and charges by churn status

SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(Tenure), 2) AS avg_tenure,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM telecom_customers
GROUP BY Churn
ORDER BY Churn;


-- ============================================================
-- SECTION 5: CUSTOMER RISK ANALYSIS
-- ============================================================

-- Q14. Identify customers without additional support services

SELECT
    Churn,
    COUNT(*) AS customer_count
FROM telecom_customers
WHERE
    InternetService <> 'No'
    AND TechSupport = 'No'
    AND OnlineSecurity = 'No'
    AND OnlineBackup = 'No'
GROUP BY Churn
ORDER BY Churn;


-- Q15. Calculate churn rate across tenure groups

SELECT
    CASE
        WHEN Tenure <= 12 THEN '0-1 Year'
        WHEN Tenure <= 24 THEN '1-2 Years'
        WHEN Tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(
        CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END
    ) AS churned_customers,
    ROUND(
        SUM(
            CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM telecom_customers
GROUP BY tenure_group
ORDER BY tenure_group;


-- ============================================================
-- END OF TELECOM CUSTOMER CHURN ANALYSIS
-- Total: 15 unique analytical queries
-- ============================================================
