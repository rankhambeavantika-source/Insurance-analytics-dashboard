
-- =========================================================
-- 🛡️ INSURANCE ANALYTICS PROJECT
-- 🧹 02: DATA CLEANING
-- =========================================================

USE Inusrance_Analysis;

-- 🔍 1. Check Missing Values in Policy IDs
SELECT COUNT(*) AS missing_policy_ids
FROM policy_details
WHERE `Policy ID` IS NULL
   OR TRIM(`Policy ID`) = '';

-- 🔍 2. Check Missing Policy Status
SELECT COUNT(*) AS missing_policy_status
FROM policy_details
WHERE Status IS NULL
   OR TRIM(Status) = '';

-- 💰 3. Check Invalid Premium Amounts
SELECT COUNT(*) AS invalid_premium_amounts
FROM policy_details
WHERE `Premium Amount` IS NULL
   OR `Premium Amount` < 0;

-- 🏦 4. Check Invalid Coverage Amounts
SELECT COUNT(*) AS invalid_coverage_amounts
FROM policy_details
WHERE `Coverage Amount` IS NULL
   OR `Coverage Amount` < 0;

-- 📅 5. Check Missing Policy Dates
SELECT
    SUM(`Policy Start Date` IS NULL) AS missing_start_dates,
    SUM(`Policy End Date` IS NULL) AS missing_end_dates
FROM policy_details;

-- ⚠️ 6. Check Policy End Dates Before Start Dates
SELECT *
FROM policy_details
WHERE `Policy Start Date` IS NOT NULL
  AND `Policy End Date` IS NOT NULL
  AND `Policy End Date` < `Policy Start Date`;

-- 📊 7. Check Duplicate Policy IDs
SELECT
    `Policy ID`,
    COUNT(*) AS duplicate_count
FROM policy_details
GROUP BY `Policy ID`
HAVING COUNT(*) > 1;

-- ✅ END OF DATA CLEANING CHECKS
