# Bank Loan Portfolio Health Analyzer

**Tools:** MySQL · Power BI · DAX · Python · SQL  
**Domain:** Finance / Banking  
**Dataset:** LendingClub Loan Data 2007–2018 (500,000 loans · 23 columns)

---

## Business Problem

A bank needs to understand the health of its existing loan portfolio. Where is default risk concentrated? Which borrower segments are driving charge-offs? How has portfolio performance changed over time?

This project analyzes 500,000 LendingClub loans using SQL for data exploration and Power BI for interactive visualization — framed from the perspective of an internal bank analyst, not just a data science exercise.

---

## Key Findings

| # | Finding | Impact |
|---|---------|--------|
| 1 | Grade G loans default at **39.86%** vs Grade A at **3.67%** — a 10x risk difference | Risk segmentation |
| 2 | **$490M unrecovered** on charged-off loans ($1.06B funded, only $567M received) | Revenue at risk |
| 3 | Small business loans carry **19.56% default rate** — highest by purpose | Portfolio concentration |
| 4 | NY leads default rate at **14.23%** among high-volume states; TX at 12.95% | Geographic risk |
| 5 | Renters default at **15.03%** vs mortgage holders at **11.37%** — 3.66pt gap | Borrower risk |
| 6 | **20-30 DTI band** has both highest default rate (15.01%) AND largest count (151K loans) | Systemic risk |
| 7 | Platform grew from **526 loans (2008) to 95,851 (2016)** — 182x growth in 8 years | Business growth |
| 8 | Unknown employment borrowers default at **16.06%** — highest of any segment | Hidden risk |

---

## Dashboard (4 Pages)

### Page 1 — Executive Summary
![Executive Summary](dashboard/screenshots/page1_executive_summary.png)

### Page 2 — Portfolio Overview
![Portfolio Overview](dashboard/screenshots/page2_portfolio_overview.png)

### Page 3 — Borrower Risk Analysis
![Borrower Risk](dashboard/screenshots/page3_borrower_risk.png)

### Page 4 — Trends & Forecast
![Trends and Forecast](dashboard/screenshots/page4_trends_forecast.png)

---

## Project Structure

├── sql/
│   └── bank_loan_queries.sql     # 12 SQL queries covering all KPIs
├── notebooks/
│   └── Bank_Loan_Project.ipynb   # Python EDA and data cleaning
├── dashboard/
│   └── Bank_Loan_Analysis.pbix   # Power BI dashboard file
│   └── screenshots/              # Dashboard page previews
└── data/
└── data_dictionary.md        # Column definitions for all 23 fields

---

## Technical Approach

**Phase 1 — Python EDA**
- Sampled 500K rows from 2.26M record dataset
- Cleaned data types (int_rate, issue_d, term, emp_length)
- Engineered `is_bad_loan` and `emp_length_num` derived columns
- Validated distributions: 47.58% Fully Paid, 38.93% Current, 11.86% Charged Off

**Phase 2 — SQL Analysis (MySQL)**
- 12 queries covering portfolio KPIs, MoM trends, segmentation by grade/state/purpose
- LAG() window functions for month-over-month change calculation
- DTI band analysis, home ownership vs default correlation
- Yearly summary for trend analysis

**Phase 3 — Power BI Dashboard**
- Connected Power BI directly to MySQL database
- 7 DAX measures including Good Loan %, Bad Loan %, MTD calculations
- Conditional formatting: green→red gradient on grade risk bars
- AI Forecast visual with 95% confidence interval on Page 4
- Synced slicers across all 4 pages

---

## Dataset

**Source:** [LendingClub Loan Data — Kaggle](https://www.kaggle.com/datasets/wordsforthewise/lending-club)  
**Size:** 2.26M rows · 145 columns (sampled to 500K · 23 columns)  
**Period:** 2007–2018  
**Note:** Raw data not included due to file size. Download from Kaggle link above.

---

## How to Run

1. Download dataset from Kaggle link above
2. Run `notebooks/Bank_Loan_Project.ipynb` to clean and sample data
3. Import `loan_data_clean.csv` into MySQL as `bank_loan_db.financial_loan`
4. Run `sql/bank_loan_queries.sql` to validate all KPIs
5. Open `dashboard/Bank_Loan_Analysis.pbix` in Power BI Desktop

---

*Firasuddin Syed · Dallas, TX · [LinkedIn](https://linkedin.com/in/firasuddin-syed) · [GitHub](https://github.com/firasuddinsyed)*
