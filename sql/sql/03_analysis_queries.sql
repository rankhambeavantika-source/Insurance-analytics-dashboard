
-- =========================================================
-- 📊 INSURANCE ANALYTICS PROJECT
-- 📈 03: DATA ANALYSIS QUERIES
-- =========================================================

USE Inusrance_Analysis;

-- 📌 1. Total Number of Policies
SELECT COUNT(*) AS total_policies
FROM policy_details;

-- 📌 2. Policy Status Distribution
SELECT
    Status,
    COUNT(*) AS policy_count
FROM policy_details
GROUP BY Status
ORDER BY policy_count DESC;

-- 💰 3. Average Premium Amount
SELECT
    ROUND(AVG(`Premium Amount`), 2) AS average_premium
FROM policy_details;

-- 🛡️ 4. Average Coverage Amount
SELECT
    ROUND(AVG(`Coverage Amount`), 2) AS average_coverage
FROM policy_details;

-- 📊 5. Policies by Policy Type
SELECT
    `Policy Type`,
    COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Policy Type`
ORDER BY total_policies DESC;

-- 👥 6. Policies by Age Group
SELECT
    `Age Group`,
    COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Age Group`
ORDER BY `Age Group`;

-- 📅 7. Policies by End Year
SELECT
    `End Year`,
    COUNT(*) AS policies_ending
FROM policy_details
GROUP BY `End Year`
ORDER BY `End Year`;

-- 💳 8. Policies by Payment Frequency
SELECT
    `Payment Frequency`,
    COUNT(*) AS total_policies
FROM policy_details
GROUP BY `Payment Frequency`
ORDER BY total_policies DESC;

-- 🔍 9. Premium Amount by Policy Status
SELECT
    Status,
    ROUND(AVG(`Premium Amount`), 2) AS average_premium
FROM policy_details
GROUP BY Status
ORDER BY average_premium DESC;

-- ✅ END OF DATA ANALYSIS
