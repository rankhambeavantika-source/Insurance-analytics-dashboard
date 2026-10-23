-- ############################################################
--  INSURANCE ANALYSIS : FINAL SCRIPT
--  PART 1 : DATA VALIDATION   (only checks, nothing is changed)
--  PART 2 : DATA CLEANING     (backup + fixes)
--  PART 3 : ANSWERS Q2 - Q22  (Q1 is just the "KPI Question" header)
--
--  Before you start: customer_info must be re-imported from the
--  corrected CSV (commas inside Name wrapped in quotes).
--  Window functions (LAG) need MySQL 8.0+
-- ############################################################

USE Inusrance_Analysis;


-- ============================================================
-- PART 1 : DATA VALIDATION
-- ============================================================

-- 1.1 Tables and structure
SHOW TABLES;
DESCRIBE policy_details;
DESCRIBE customer_info;
DESCRIBE claims_details;
DESCRIBE payment_history;
DESCRIBE policy_data;

-- 1.2 Row counts
SELECT 'policy_details' AS table_name, COUNT(*) AS total_rows FROM policy_details
UNION ALL SELECT 'policy_data',     COUNT(*) FROM policy_data
UNION ALL SELECT 'customer_info',   COUNT(*) FROM customer_info
UNION ALL SELECT 'claims_details',  COUNT(*) FROM claims_details
UNION ALL SELECT 'payment_history', COUNT(*) FROM payment_history;

-- 1.3 Sample rows
SELECT * FROM policy_details LIMIT 5;
SELECT * FROM customer_info  LIMIT 5;
SELECT * FROM claims_details LIMIT 5;

-- 1.4 Missing values : policy_details
SELECT
    COUNT(*) AS total_rows,
    SUM(`Policy ID`   IS NULL OR TRIM(`Policy ID`)   = '') AS missing_policy_id,
    SUM(`Policy Type` IS NULL OR TRIM(`Policy Type`) = '') AS missing_policy_type,
    SUM(`Coverage Amount`   IS NULL) AS missing_coverage,
    SUM(`Premium Amount`    IS NULL) AS missing_premium,
    SUM(`Policy Start Date` IS NULL) AS missing_start_date,
    SUM(`Policy End Date`   IS NULL) AS missing_end_date,
    SUM(`Payment Frequency` IS NULL OR TRIM(`Payment Frequency`) = '') AS missing_frequency,
    SUM(`Status`      IS NULL OR TRIM(`Status`)      = '') AS missing_status,
    SUM(`Customer ID` IS NULL OR TRIM(`Customer ID`) = '') AS missing_customer_id
FROM policy_details;

-- 1.5 Missing values : customer_info
SELECT
    COUNT(*) AS total_rows,
    SUM(`Customer ID` IS NULL OR TRIM(`Customer ID`) = '') AS missing_customer_id,
    SUM(`Name`   IS NULL OR TRIM(`Name`)   = '') AS missing_name,
    SUM(`Gender` IS NULL OR TRIM(`Gender`) = '') AS missing_gender,
    SUM(`Age`    IS NULL) AS missing_age,
    SUM(`Marital Status` IS NULL OR TRIM(`Marital Status`) = '') AS missing_marital
FROM customer_info;

-- 1.6 Missing values : claims_details
SELECT
    COUNT(*) AS total_claims,
    SUM(`Claim ID`  IS NULL OR TRIM(`Claim ID`)  = '') AS missing_claim_id,
    SUM(`Policy ID` IS NULL OR TRIM(`Policy ID`) = '') AS missing_policy_id,
    SUM(`Claim Amount` IS NULL) AS missing_claim_amount,
    SUM(`Claim Status` IS NULL OR TRIM(`Claim Status`) = '') AS missing_claim_status,
    SUM(`Settlement Date` IS NULL OR TRIM(`Settlement Date`) = '') AS missing_settlement_date
FROM claims_details;

-- 1.7 Duplicates
SELECT `Policy ID`, COUNT(*) AS occurrences
FROM policy_details GROUP BY `Policy ID` HAVING COUNT(*) > 1;

SELECT `Customer ID`, COUNT(*) AS occurrences
FROM customer_info GROUP BY `Customer ID` HAVING COUNT(*) > 1;

SELECT `Claim ID`, COUNT(*) AS occurrences
FROM claims_details GROUP BY `Claim ID` HAVING COUNT(*) > 1;

-- 1.8 Customer ID prefix check (CLM... = wrongly loaded rows)
SELECT LEFT(`Customer ID`, 4) AS id_prefix, COUNT(*) AS total_rows
FROM customer_info
GROUP BY LEFT(`Customer ID`, 4);

-- 1.9 Invalid values in customer_info (zip codes / dates in Gender etc. = shifted columns)
SELECT
    COUNT(*) AS total_rows,
    SUM(`Customer ID` NOT LIKE 'CUST%') AS invalid_customer_ids,
    SUM(`Gender` NOT IN ('Male', 'Female', 'Other') OR `Gender` IS NULL) AS invalid_gender,
    SUM(`Age` IS NULL OR `Age` < 18 OR `Age` > 100) AS invalid_age,
    SUM(`Marital Status` NOT IN ('Single', 'Married', 'Divorced', 'Widowed')
        OR `Marital Status` IS NULL) AS invalid_marital_status
FROM customer_info;

-- 1.10 Spelling / hidden spaces in text columns
SELECT DISTINCT `Status`            FROM policy_details;
SELECT DISTINCT `Policy Type`       FROM policy_details;
SELECT DISTINCT `Payment Frequency` FROM policy_details;
SELECT DISTINCT `Claim Status`      FROM claims_details;
SELECT DISTINCT `Gender`            FROM customer_info;
SELECT DISTINCT `Marital Status`    FROM customer_info;

SELECT
    SUM(CHAR_LENGTH(`Status`)      <> CHAR_LENGTH(TRIM(`Status`)))      AS status_with_spaces,
    SUM(CHAR_LENGTH(`Policy Type`) <> CHAR_LENGTH(TRIM(`Policy Type`))) AS type_with_spaces
FROM policy_details;

SELECT SUM(CHAR_LENGTH(`Claim Status`) <> CHAR_LENGTH(TRIM(`Claim Status`))) AS claim_status_with_spaces
FROM claims_details;

-- 1.11 Dates
SELECT `Policy Start Date`, `Policy End Date` FROM policy_details LIMIT 5;

SELECT
    MIN(`Policy Start Date`) AS earliest_start, MAX(`Policy Start Date`) AS latest_start,
    MIN(`Policy End Date`)   AS earliest_end,   MAX(`Policy End Date`)   AS latest_end
FROM policy_details;

SELECT COUNT(*) AS end_before_start
FROM policy_details
WHERE `Policy End Date` < `Policy Start Date`;

-- 1.12 Amounts
SELECT
    SUM(`Coverage Amount` <= 0) AS bad_coverage,
    SUM(`Premium Amount`  <= 0) AS bad_premium
FROM policy_details;

SELECT SUM(`Claim Amount` < 0) AS negative_claims FROM claims_details;

-- 1.13 Relationships between tables
SELECT COUNT(*) AS policies_without_customer
FROM policy_details p
LEFT JOIN customer_info c ON TRIM(p.`Customer ID`) = TRIM(c.`Customer ID`)
WHERE c.`Customer ID` IS NULL;

SELECT COUNT(*) AS claims_without_policy
FROM claims_details cl
LEFT JOIN policy_details p ON TRIM(cl.`Policy ID`) = TRIM(p.`Policy ID`)
WHERE p.`Policy ID` IS NULL;


-- ============================================================
-- PART 2 : DATA CLEANING
-- ============================================================

-- 2.1 Backups (run once, before any change)
CREATE TABLE IF NOT EXISTS customer_info_backup  AS SELECT * FROM customer_info;
CREATE TABLE IF NOT EXISTS policy_details_backup AS SELECT * FROM policy_details;
CREATE TABLE IF NOT EXISTS claims_details_backup AS SELECT * FROM claims_details;

-- 2.2 Convert text dates to DATE (safe to run again if already DATE)
ALTER TABLE policy_details
    MODIFY COLUMN `Policy Start Date` DATE,
    MODIFY COLUMN `Policy End Date`   DATE;

-- 2.3 Remove extra spaces from text columns

-- 2.3 Remove extra spaces from text columns

SET SQL_SAFE_UPDATES = 0;

UPDATE policy_details
SET `Status`      = TRIM(`Status`),
    `Policy Type` = TRIM(`Policy Type`),
    `Customer ID` = TRIM(`Customer ID`),
    `Policy ID`   = TRIM(`Policy ID`);

UPDATE claims_details
SET `Claim Status` = TRIM(`Claim Status`),
    `Policy ID`    = TRIM(`Policy ID`);

UPDATE customer_info
SET `Customer ID` = TRIM(`Customer ID`);

SET SQL_SAFE_UPDATES = 1;

-- 2.4 Clean customer view : keeps only valid rows (drops CLM / shifted rows)
--     If customer_info was re-imported correctly, this removes nothing.
CREATE OR REPLACE VIEW customer_clean AS
SELECT *
FROM customer_info
WHERE `Customer ID` LIKE 'CUST%'
  AND `Gender` IN ('Male', 'Female', 'Other')
  AND `Age` BETWEEN 18 AND 100
  AND `Marital Status` IN ('Single', 'Married', 'Divorced', 'Widowed');

-- 2.5 Check after cleaning
SELECT
    (SELECT COUNT(*) FROM customer_info)  AS customer_rows_before,
    (SELECT COUNT(*) FROM customer_clean) AS customer_rows_after_cleaning;

SELECT DISTINCT `Gender` FROM customer_clean;


-- ============================================================
-- PART 3 : ANSWERS (Q2 - Q22)
-- ============================================================

-- Q2. Total number of customers in the policy database
SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM policy_details;

-- Q3. Total number of policies issued
SELECT COUNT(DISTINCT `Policy ID`) AS total_policies
FROM policy_details;

-- Q4. Total claim amount generated from all policies (JOIN claims to policies)
SELECT SUM(cl.`Claim Amount`) AS total_claim_amount
FROM claims_details cl
JOIN policy_details p
    ON TRIM(cl.`Policy ID`) = TRIM(p.`Policy ID`);

-- Q5. Average coverage amount per policy
SELECT ROUND(AVG(`Coverage Amount`), 2) AS avg_coverage_amount
FROM policy_details;

-- Q6. Average premium amount collected per policy
SELECT ROUND(AVG(`Premium Amount`), 2) AS avg_premium_amount
FROM policy_details;

-- Q7. Percentage of policies that are active
SELECT ROUND(100 * SUM(`Status` = 'Active') / COUNT(*), 2) AS active_policy_pct
FROM policy_details;

-- Q8. Policies in Active, Lapsed and Terminated status
SELECT `Status`, COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Status`;

-- Q9. Status with the highest number of policies
SELECT `Status`, COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Status`
ORDER BY total_policies DESC
LIMIT 1;

-- Q10. Ratio of active to inactive policies
SELECT
    SUM(`Status` = 'Active')  AS active_policies,
    SUM(`Status` <> 'Active') AS inactive_policies,
    ROUND(SUM(`Status` = 'Active') / SUM(`Status` <> 'Active'), 2) AS active_to_inactive_ratio
FROM policy_details;

-- Q11. Age group with the highest number of policies
-- (change the buckets if your Excel dashboard used different age groups)
USE Inusrance_Analysis;

CREATE OR REPLACE VIEW customer_clean AS
SELECT *
FROM customer_info
WHERE `Customer ID` LIKE 'CUST%'
  AND `Gender` IN ('Male', 'Female', 'Other')
  AND `Age` BETWEEN 18 AND 100
  AND `Marital Status` IN ('Single', 'Married', 'Divorced', 'Widowed');

SELECT
    (SELECT COUNT(*) FROM customer_info)  AS customer_rows_before,
    (SELECT COUNT(*) FROM customer_clean) AS customer_rows_after_cleaning;
DESCRIBE customer_info;
-- Q12. Top three age groups by policy count
WITH policy_age AS (
    SELECT
        p.`Policy ID`,
        CASE
            WHEN c.`Age` BETWEEN 18 AND 30 THEN '18-30'
            WHEN c.`Age` BETWEEN 31 AND 45 THEN '31-45'
            WHEN c.`Age` BETWEEN 46 AND 60 THEN '46-60'
            ELSE '60+'
        END AS age_group
    FROM policy_details p
    JOIN customer_clean c
        ON TRIM(p.`Customer ID`) = TRIM(c.`Customer ID`)
    WHERE c.`Age` IS NOT NULL
)
SELECT age_group, COUNT(*) AS total_policies
FROM policy_age
GROUP BY age_group
ORDER BY total_policies DESC
LIMIT 3;

-- Q13. Gender with the highest policy participation
SELECT c.`Gender`, COUNT(*) AS total_policies
FROM policy_details p
JOIN customer_clean c
    ON TRIM(p.`Customer ID`) = TRIM(c.`Customer ID`)
GROUP BY c.`Gender`
ORDER BY total_policies DESC;

-- Q14. Difference between male and female policy counts
SELECT
    SUM(c.`Gender` = 'Male')   AS male_policies,
    SUM(c.`Gender` = 'Female') AS female_policies,
    ABS(SUM(c.`Gender` = 'Male') - SUM(c.`Gender` = 'Female')) AS difference
FROM policy_details p
JOIN customer_clean c
    ON TRIM(p.`Customer ID`) = TRIM(c.`Customer ID`);

-- Q15. Policy type with the maximum number of policies
SELECT `Policy Type`, COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Policy Type`
ORDER BY total_policies DESC
LIMIT 1;

-- Q16. Policy type with the minimum number of policies
SELECT `Policy Type`, COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Policy Type`
ORDER BY total_policies ASC
LIMIT 1;

-- Q17. Compare Auto and Health policy counts
SELECT
    SUM(`Policy Type` = 'Auto')   AS auto_policies,
    SUM(`Policy Type` = 'Health') AS health_policies,
    ABS(SUM(`Policy Type` = 'Auto') - SUM(`Policy Type` = 'Health')) AS difference
FROM policy_details;

-- Q18. Total number of policies across all policy types
SELECT `Policy Type`, COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Policy Type`
WITH ROLLUP;

-- Q19. Average premium growth rate over all years
-- Growth = year-over-year % change in average premium (by policy start year)
WITH yearly AS (
    SELECT YEAR(`Policy Start Date`) AS yr,
           AVG(`Premium Amount`)     AS avg_premium
    FROM policy_details
    GROUP BY YEAR(`Policy Start Date`)
),
growth AS (
    SELECT yr,
           100 * (avg_premium - LAG(avg_premium) OVER (ORDER BY yr))
               / LAG(avg_premium) OVER (ORDER BY yr) AS growth_pct
    FROM yearly
)
SELECT ROUND(AVG(growth_pct), 2) AS avg_premium_growth_pct
FROM growth
WHERE growth_pct IS NOT NULL;

-- Q20. Is the premium growth trend increasing or decreasing?
-- (a) year-wise growth
WITH yearly AS (
    SELECT YEAR(`Policy Start Date`) AS yr,
           AVG(`Premium Amount`)     AS avg_premium
    FROM policy_details
    GROUP BY YEAR(`Policy Start Date`)
)
SELECT yr,
       ROUND(avg_premium, 2) AS avg_premium,
       ROUND(100 * (avg_premium - LAG(avg_premium) OVER (ORDER BY yr))
             / LAG(avg_premium) OVER (ORDER BY yr), 2) AS growth_pct
FROM yearly
ORDER BY yr;

-- (b) overall direction : last year growth vs first year growth
WITH yearly AS (
    SELECT YEAR(`Policy Start Date`) AS yr, AVG(`Premium Amount`) AS avg_premium
    FROM policy_details
    GROUP BY YEAR(`Policy Start Date`)
),
growth AS (
    SELECT yr,
           100 * (avg_premium - LAG(avg_premium) OVER (ORDER BY yr))
               / LAG(avg_premium) OVER (ORDER BY yr) AS growth_pct
    FROM yearly
)
SELECT CASE
    WHEN (SELECT growth_pct FROM growth WHERE growth_pct IS NOT NULL ORDER BY yr DESC LIMIT 1)
       > (SELECT growth_pct FROM growth WHERE growth_pct IS NOT NULL ORDER BY yr ASC  LIMIT 1)
    THEN 'Increasing' ELSE 'Decreasing'
END AS growth_trend;

-- Q21. Difference between highest and lowest premium growth rates
WITH yearly AS (
    SELECT YEAR(`Policy Start Date`) AS yr,
           AVG(`Premium Amount`)     AS avg_premium
    FROM policy_details
    GROUP BY YEAR(`Policy Start Date`)
),
growth AS (
    SELECT yr,
           100 * (avg_premium - LAG(avg_premium) OVER (ORDER BY yr))
               / LAG(avg_premium) OVER (ORDER BY yr) AS growth_pct
    FROM yearly
)
SELECT
    ROUND(MAX(growth_pct), 2) AS highest_growth_pct,
    ROUND(MIN(growth_pct), 2) AS lowest_growth_pct,
    ROUND(MAX(growth_pct) - MIN(growth_pct), 2) AS difference
FROM growth
WHERE growth_pct IS NOT NULL;

-- Q22. Yearly trend of policies ending, 2016 to 2034
SELECT YEAR(`Policy End Date`) AS end_year,
       COUNT(*)                AS policies_ending
FROM policy_details
WHERE YEAR(`Policy End Date`) BETWEEN 2016 AND 2034
GROUP BY YEAR(`Policy End Date`)
ORDER BY end_year;