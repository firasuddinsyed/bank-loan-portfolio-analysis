USE bank_loan_db;

-- ═══════════════════════════════════════
-- PHASE 2 — KPI QUERIES
-- Query 1: Core portfolio KPIs
-- ═══════════════════════════════════════
SELECT
    COUNT(*)                                    AS total_applications,
    ROUND(SUM(funded_amnt) / 1000000, 2)        AS total_funded_millions,
    ROUND(SUM(total_pymnt) / 1000000, 2)        AS total_received_millions,
    ROUND(AVG(int_rate), 2)                     AS avg_interest_rate,
    ROUND(AVG(dti), 2)                          AS avg_dti
FROM financial_loan;

-- Query 2: Good vs Bad loan segmentation
SELECT
    CASE 
        WHEN loan_status IN ('Fully Paid', 'Current') THEN 'Good Loan'
        ELSE 'Bad Loan'
    END AS loan_category,
    COUNT(*)                                    AS total_loans,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage,
    ROUND(SUM(funded_amnt) / 1000000, 2)        AS funded_millions,
    ROUND(SUM(total_pymnt) / 1000000, 2)        AS received_millions
FROM financial_loan
GROUP BY loan_category;

-- Query 3: Monthly trend (applications + funded amount)
SELECT
    DATE_FORMAT(issue_d, '%Y-%m')               AS month,
    COUNT(*)                                    AS applications,
    ROUND(SUM(funded_amnt) / 1000000, 2)        AS funded_millions,
    ROUND(SUM(total_pymnt) / 1000000, 2)        AS received_millions
FROM financial_loan
GROUP BY DATE_FORMAT(issue_d, '%Y-%m')
ORDER BY month;

-- Query 4: Month-over-Month change using LAG
SELECT
    month,
    applications,
    funded_millions,
    LAG(applications) OVER (ORDER BY month)     AS prev_month_apps,
    ROUND(
        (applications - LAG(applications) OVER (ORDER BY month)) * 100.0 /
        LAG(applications) OVER (ORDER BY month), 2
    )                                           AS mom_change_pct
FROM (
    SELECT
        DATE_FORMAT(issue_d, '%Y-%m')           AS month,
        COUNT(*)                                AS applications,
        ROUND(SUM(funded_amnt) / 1000000, 2)   AS funded_millions
    FROM financial_loan
    GROUP BY DATE_FORMAT(issue_d, '%Y-%m')
) monthly
ORDER BY month;

-- Query 5: Default rate by loan grade
SELECT
    grade,
    COUNT(*)                                        AS total_loans,
    SUM(is_bad_loan)                                AS bad_loans,
    ROUND(SUM(is_bad_loan) * 100.0 / COUNT(*), 2)  AS default_rate_pct,
    ROUND(AVG(int_rate), 2)                         AS avg_interest_rate,
    ROUND(SUM(funded_amnt) / 1000000, 2)            AS funded_millions
FROM financial_loan
GROUP BY grade
ORDER BY grade;

-- Query 6: Default rate by purpose
SELECT
    purpose,
    COUNT(*)                                        AS total_loans,
    SUM(is_bad_loan)                                AS bad_loans,
    ROUND(SUM(is_bad_loan) * 100.0 / COUNT(*), 2)  AS default_rate_pct,
    ROUND(SUM(funded_amnt) / 1000000, 2)            AS funded_millions
FROM financial_loan
GROUP BY purpose
ORDER BY default_rate_pct DESC;

-- Query 7: Default rate by state (top 15 by volume)
SELECT
    addr_state,
    COUNT(*)                                        AS total_loans,
    SUM(is_bad_loan)                                AS bad_loans,
    ROUND(SUM(is_bad_loan) * 100.0 / COUNT(*), 2)  AS default_rate_pct,
    ROUND(SUM(funded_amnt) / 1000000, 2)            AS funded_millions
FROM financial_loan
GROUP BY addr_state
ORDER BY total_loans DESC
LIMIT 15;

-- Query 8: DTI band analysis
SELECT
    CASE
        WHEN dti < 10  THEN '0-10'
        WHEN dti < 20  THEN '10-20'
        WHEN dti < 30  THEN '20-30'
        WHEN dti < 40  THEN '30-40'
        ELSE '40+'
    END                                             AS dti_band,
    COUNT(*)                                        AS total_loans,
    ROUND(SUM(is_bad_loan) * 100.0 / COUNT(*), 2)  AS default_rate_pct,
    ROUND(AVG(int_rate), 2)                         AS avg_interest_rate
FROM financial_loan
GROUP BY dti_band
ORDER BY dti_band;

-- Query 9: Revenue and yield by grade
SELECT
    grade,
    term,
    COUNT(*)                                        AS total_loans,
    ROUND(AVG(int_rate), 2)                         AS avg_int_rate,
    ROUND(SUM(total_rec_int) / 1000000, 2)          AS interest_received_millions,
    ROUND(SUM(recoveries) / 1000000, 2)             AS recoveries_millions,
    ROUND(SUM(total_pymnt) / 1000000, 2)            AS total_received_millions,
    ROUND(SUM(funded_amnt) / 1000000, 2)            AS funded_millions
FROM financial_loan
GROUP BY grade, term
ORDER BY grade, term;

-- Query 10: Home ownership vs default rate
SELECT
    home_ownership,
    COUNT(*)                                        AS total_loans,
    SUM(is_bad_loan)                                AS bad_loans,
    ROUND(SUM(is_bad_loan) * 100.0 / COUNT(*), 2)  AS default_rate_pct,
    ROUND(AVG(int_rate), 2)                         AS avg_int_rate,
    ROUND(SUM(funded_amnt) / 1000000, 2)            AS funded_millions
FROM financial_loan
GROUP BY home_ownership
ORDER BY total_loans DESC;

-- Query 11: Employment length vs default rate
SELECT
    emp_length,
    COUNT(*)                                        AS total_loans,
    SUM(is_bad_loan)                                AS bad_loans,
    ROUND(SUM(is_bad_loan) * 100.0 / COUNT(*), 2)  AS default_rate_pct,
    ROUND(AVG(int_rate), 2)                         AS avg_int_rate
FROM financial_loan
GROUP BY emp_length, emp_length_num
ORDER BY emp_length_num;

-- Query 12: Yearly summary for trend page
SELECT
    YEAR(issue_d)                                   AS year,
    COUNT(*)                                        AS total_applications,
    ROUND(SUM(funded_amnt) / 1000000, 2)            AS funded_millions,
    ROUND(SUM(total_pymnt) / 1000000, 2)            AS received_millions,
    ROUND(SUM(is_bad_loan) * 100.0 / COUNT(*), 2)  AS default_rate_pct,
    ROUND(AVG(int_rate), 2)                         AS avg_int_rate
FROM financial_loan
GROUP BY YEAR(issue_d)
ORDER BY year;
