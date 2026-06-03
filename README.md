# Bank Loan Portfolio Health Analyzer

**Tools:** MySQL · Power BI · Python · DAX · SQL  
**Domain:** Finance / Banking  
**Dataset:** LendingClub 2007–2018 · 500,000 loans · $7.52B funded

---

## Business Problem

How healthy is a bank's existing loan portfolio? Where is default risk concentrated, and which borrower segments are driving charge-offs?

This project analyzes 500,000 LendingClub loans using SQL for data exploration and Power BI for interactive visualization — framed from the perspective of an internal bank analyst.

---

## Key Findings

| # | Finding | Impact |
|---|---------|--------|
| 1 | Grade G loans default at **39.86%** vs Grade A at **3.67%** — 10x risk difference | Risk segmentation |
| 2 | **$490M unrecovered** on charged-off loans | Revenue at risk |
| 3 | Small business loans carry **19.56% default rate** — highest by purpose | Concentration risk |
| 4 | NY leads default rate at **14.23%** among high-volume states | Geographic risk |
| 5 | Renters default at **15.03%** vs mortgage holders **11.37%** | Borrower risk |
| 6 | **20-30 DTI band** has highest default rate (15.01%) AND most loans (151K) | Systemic risk |
| 7 | Platform grew from **526 loans (2008) to 95,851 (2016)** — 182x growth | Business growth |
| 8 | Unknown employment borrowers default at **16.06%** — highest segment | Hidden risk |

---

## Dashboard

### Page 1 — Executive Summary
![Page 1](page1.png)

### Page 2 — Portfolio Overview
![Page 2](page2.png)

### Page 3 — Borrower Risk Analysis
![Page 3](page3.png)

### Page 4 — Trends & Forecast
![Page 4](page4.png)

---

## Files in this Repo

| File | Description |
|------|-------------|
| `bank_loan_queries.sql` | 12 SQL queries — KPIs, trends, segmentation, risk metrics |
| `Bank_Loan_Project.ipynb` | Python EDA — data cleaning, sampling, distribution analysis |
| `Bank_Loan_Analysis.pbix` | Power BI 4-page interactive dashboard |
| `page1.png` to `page4.png` | Dashboard screenshots |

---

## How to Reproduce

1. Download dataset: [LendingClub on Kaggle](https://www.kaggle.com/datasets/wordsforthewise/lending-club)
2. Run `Bank_Loan_Project.ipynb` to clean and sample 500K rows
3. Import `loan_data_clean.csv` into MySQL as `bank_loan_db.financial_loan`
4. Run `bank_loan_queries.sql` to validate all KPIs
5. Open `Bank_Loan_Analysis.pbix` in Power BI Desktop

---

## Technical Summary

- **Python:** Sampled 500K rows from 2.26M, cleaned dtypes, engineered `is_bad_loan` and `emp_length_num` columns
- **SQL (MySQL):** 12 queries using window functions (LAG), CASE statements, GROUP BY, subqueries
- **Power BI:** 7 DAX measures, conditional formatting, AI forecast with 95% confidence interval, synced slicers

---

*Firasuddin Syed · Dallas, TX · [LinkedIn](https://linkedin.com/in/firasuddin-syed) · [GitHub](https://github.com/firasuddinsyed)*
