
-- =========================================================
-- 🛡️ INSURANCE ANALYTICS PROJECT
-- 🔍 01: DATA VALIDATION
-- =========================================================

USE Inusrance_Analysis;

-- 📂 1. Check Available Tables
SHOW TABLES;

-- 📋 2. Check Policy Table Structure
DESCRIBE policy_details;

-- 👥 3. Check Customer Table Structure
DESCRIBE customer_info;

-- 📝 4. Check Claims Table Structure
DESCRIBE claims_details;

-- 💳 5. Check Payment History Table Structure
DESCRIBE payment_history;


-- =========================================================
-- 📊 6. CHECK TOTAL RECORDS IN EACH TABLE
-- =========================================================

-- 📄 Total Policies
SELECT COUNT(*) AS total_policies
FROM policy_details;

-- 👤 Total Customers
SELECT COUNT(*) AS total_customers
FROM customer_info;

-- 🏥 Total Claim Records
SELECT COUNT(*) AS total_claim_records
FROM claims_details;

-- 💰 Total Payment Records
SELECT COUNT(*) AS total_payment_records
FROM payment_history;


-- =========================================================
-- 🔎 7. CHECK DUPLICATE POLICY IDs
-- =========================================================

SELECT
    `Policy ID`,
    COUNT(*) AS duplicate_count
FROM policy_details
GROUP BY `Policy ID`
HAVING COUNT(*) > 1;


-- =========================================================
-- ⚠️ 8. CHECK MISSING POLICY IDs
-- =========================================================

SELECT COUNT(*) AS missing_policy_ids
FROM policy_details
WHERE `Policy ID` IS NULL
   OR TRIM(`Policy ID`) = '';


-- =========================================================
-- 📈 9. CHECK POLICY STATUS DISTRIBUTION
-- =========================================================

SELECT
    Status,
    COUNT(*) AS policy_count
FROM policy_details
GROUP BY Status
ORDER BY policy_count DESC;


-- =========================================================
-- 📅 10. CHECK POLICY DATE RANGE
-- =========================================================

SELECT
    MIN(`Policy Start Date`) AS earliest_start_date,
    MAX(`Policy Start Date`) AS latest_start_date,
    MIN(`Policy End Date`) AS earliest_end_date,
    MAX(`Policy End Date`) AS latest_end_date
FROM policy_details;


-- =========================================================
-- ✅ END OF DATA VALIDATION
-- =========================================================
