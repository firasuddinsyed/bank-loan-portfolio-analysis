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
| 7 | Platform grew from **526 loans (2008) to 95,851 (2016)** — 182x growth in
