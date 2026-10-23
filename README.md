# 🛡️ Insurance Analytics | SQL & Excel Dashboard

![MySQL](https://img.shields.io/badge/MySQL-Data%20Analysis-4479A1?logo=mysql&logoColor=white)
![Excel](https://img.shields.io/badge/Microsoft%20Excel-Dashboard-217346?logo=microsoftexcel&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success)

![Insurance Policy Analytics Dashboard](images/01_full_dashboard.png)

### 🔗 Quick Links

- 📗 [Excel Dashboard (Insurance Dashboard.xlsx)](https://github.com/rankhambeavantika-source/Insurance-analytics-dashboard/blob/main/Insurance%20Dashboard.xlsx)
- 🐬 [SQL Analysis File (insurance_data_analsysis.sql)](https://github.com/rankhambeavantika-source/Insurance-analytics-dashboard/blob/main/insurance_data_analsysis.sql)

---

## 📌 Project Overview

This project analyzes insurance data using **MySQL** and **Microsoft Excel** to identify business trends, understand policy performance, and generate actionable insights. The workflow covers data validation, cleaning, SQL analysis, and an interactive Excel dashboard built for business reporting.

---

## 🎯 Project Objectives

- ✅ Validate and clean insurance data
- 📋 Analyze policy status and distribution
- 💰 Evaluate premium and coverage amounts
- 👥 Explore customer demographics and age groups
- 🧾 Analyze claims and payment information
- 📊 Build an interactive Excel dashboard for business reporting

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| 🐬 **MySQL** | Data validation, cleaning checks, and SQL analysis |
| 📗 **Microsoft Excel** | PivotTables, charts, KPIs, dashboard design, and interactive reporting |

---

## 📊 Dashboard Highlights

- 📌 Policy status distribution
- 👤 Customer and policy metrics
- 💵 Premium and coverage analysis
- 🎂 Customer age-group analysis
- 📅 Policy ending year trends
- 🖱️ Interactive slicers: **Policy Type, Status, Gender, Payment Mode** (plus Active / Inactive and a 2014–2026 date calendar)

---

## 🖼️ Dashboard Walkthrough

📥 Open the Excel file: [Insurance Dashboard.xlsx](https://github.com/rankhambeavantika-source/Insurance-analytics-dashboard/blob/main/Insurance%20Dashboard.xlsx)

### 🔢 KPI Cards
![KPI Cards](images/02_kpi_cards.png)

| KPI | Value |
|-----|-------|
| 👥 Total Customers | **5,000** |
| 📄 Total Policies | **5,000** |
| 💰 Claims Amount | **251.4 M** |
| 💎 Avg. Coverage Amount | **254.56 K** |
| 📉 Avg. Premium Growth Rate | **-12.48%** |
| 🛡️ Average Premium Amount | **1.05 K** |

### 📈 Premium Growth Trend Over Year
![Premium Growth Trend](images/03_premium_growth_trend.png)

### 🎂 Policy Count by Age Group
![Policy Count by Age Group](images/04_policy_count_by_age_group.png)

### 🚻 Policy Count by Gender
![Policy Count by Gender](images/05_policy_count_by_gender.png)

### 🏷️ Policy Type vs Policy Count
![Policy Type vs Policy Count](images/06_policy_type_vs_policy_count.png)

### 📋 Policy Status (Bar)
![Policy Status Bar](images/07_policy_status_bar.png)

### 📅 Policies by Year
![Policies by Year](images/08_policies_by_year.png)

### 🥧 Policy Status (Active vs Inactive)
![Policy Status Pie](images/09_policy_status_pie.png)

### 🍩 Gender Wise Policy Count
![Gender Wise Policy Count](images/10_gender_wise_policy_count.png)

---

## ❓ 22 Business Questions & Answers

### 🔢 A. KPI Questions

| # | Question | Answer |
|---|----------|--------|
| 1 | **KPI Question:** What are the headline KPIs of the portfolio? | 5,000 customers • 5,000 policies • 251.4 M claims • 254.56 K avg. coverage • -12.48% avg. premium growth • 1.05 K avg. premium |
| 2 | What is the total number of customers available in the policy database? | **5,000** customers |
| 3 | What is the total number of policies issued? | **5,000** policies |
| 4 | What is the total claim amount generated from all policies? | **251.4 M** |
| 5 | What is the average coverage amount per policy? | **254.56 K** |
| 6 | What is the average premium amount collected per policy? | **1.05 K** |

### 📋 B. Policy Status Questions

| # | Question | Answer |
|---|----------|--------|
| 7 | What percentage of policies are currently active? | **33.64%** (1,682 of 5,000) |
| 8 | How many policies are in active, lapsed, and terminated status? | **Active: 1,682 • Terminated: 1,678 • Lapsed: 1,640** |
| 9 | Which policy status has the highest number of policies? | **Active** (1,682), only just ahead of Terminated (1,678) |
| 10 | What is the ratio between active policies and inactive policies? | Active **1,682** : Inactive **3,318** (Lapsed + Terminated) ≈ **1 : 1.97** (33.64% vs 66.36%) |

### 🎂 C. Age Group Questions

| # | Question | Answer |
|---|----------|--------|
| 11 | Which age group has the highest number of policies? | **28–37** with **790** policies |
| 12 | Identify the top three age groups by policy count. | 🥇 **28–37** (790) • 🥈 **58–67** (764) • 🥉 **38–47** (737) |

*(Lowest: 78–87 with 570 policies.)*

### 🚻 D. Gender Questions

| # | Question | Answer |
|---|----------|--------|
| 13 | Which gender has the highest policy participation? | **Other** with **1,699** policies (34%), followed by Male 1,677 and Female 1,624 |
| 14 | What is the difference between male and female policy counts? | Male 1,677 − Female 1,624 = **53 policies** (Males are ahead) |

### 🏷️ E. Policy Type Questions

| # | Question | Answer |
|---|----------|--------|
| 15 | Which policy type has the maximum number of policies? | **Health** with **1,316** policies (26.3%) |
| 16 | Which policy type has the minimum number of policies? | **Auto** with **1,214** policies (24.3%) |
| 17 | Compare Auto and Health policy counts. | Health 1,316 vs Auto 1,214 → Health leads by **102 policies (~8.4% higher)** |
| 18 | What is the total number of policies across all policy types? | 1,214 + 1,316 + 1,234 + 1,236 = **5,000** |

### 📉 F. Premium Growth & Trend Questions

| # | Question | Answer |
|---|----------|--------|
| 19 | What is the average premium growth rate over all years? | **-12.48%** |
| 20 | Is the premium growth trend increasing or decreasing over time? | **Decreasing.** Premium moves between ~510–562 K until 2022, then drops to **475.48 K in 2024**; the trendline slopes downward |
| 21 | Calculate the difference between the highest and lowest premium growth values. | Highest **562.43 K (2022)** − Lowest **475.48 K (2024)** = **86.95 K** |
| 22 | What is the yearly trend of policies ending from 2016 to 2034? | Rises steadily from **25 (2016)** to a peak of **526 (2025)**, then declines every year to **33 (2034)** — a bell-shaped curve |

---

## 💡 Business Insights

1. **⚠️ Only 1 in 3 policies is active.** 33.64% of policies are Active, while 66.36% are Lapsed or Terminated. Retention and renewal are the biggest business risk.
2. **⚖️ Status split is nearly even.** Active (1,682), Terminated (1,678) and Lapsed (1,640) are almost identical, so the company is losing about as many policies as it keeps. Early-warning and win-back campaigns for lapsed customers are worth prioritizing (1,640 recoverable policies).
3. **📉 Premium growth is declining.** Average premium growth is -12.48%, and premium fell from the 2022 peak (562.43 K) to the lowest point in 2024 (475.48 K), a drop of about 15.5%. Pricing, product mix and renewals need review.
4. **🏥 Health is the strongest product.** Health leads with 1,316 policies (26.3%), while Auto is lowest with 1,214 (24.3%). The portfolio is well balanced, but cross-selling Health to Auto/Life customers is a clear opportunity.
5. **🎯 Core customers are 28–37 and 58–67.** The two biggest age groups hold 790 and 764 policies. Target young professionals with Health/Life bundles and seniors with retirement and health plans. The 78–87 group (570) is the smallest.
6. **👥 Gender distribution is balanced.** Other (1,699), Male (1,677) and Female (1,624) are within ~75 policies of each other, so marketing can be gender-neutral and focus on age and product instead.
7. **📅 Renewal workload peaks around 2025.** Policies ending reach a peak of 526 in 2025, and 2025–2027 alone cover 1,401 policies (~28% of the book). A strong renewal strategy in this window protects revenue.
8. **🧾 Claims need a closer look.** Total claims of 251.4 M (about 50.3 K per policy, roughly 19.8% of total coverage) are very large compared to the 1.05 K average premium. Validate claim vs. premium data and review claim-heavy segments to protect profitability.

---

## 🗂️ Repository Structure

```
Insurance-analytics-dashboard/
│
├── Insurance Dashboard.xlsx
├── insurance_data_analsysis.sql
├── README.md
└── images/
    ├── 01_full_dashboard.png
    ├── 02_kpi_cards.png
    ├── 03_premium_growth_trend.png
    ├── 04_policy_count_by_age_group.png
    ├── 05_policy_count_by_gender.png
    ├── 06_policy_type_vs_policy_count.png
    ├── 07_policy_status_bar.png
    ├── 08_policies_by_year.png
    ├── 09_policy_status_pie.png
    └── 10_gender_wise_policy_count.png
```

---

## 🔍 SQL Analysis

The SQL work includes:

- 🧪 Data validation
- ❓ Missing-value checks
- 🔁 Duplicate checks
- 📋 Policy status analysis
- 💰 Premium and coverage analysis
- 💡 22 business-focused questions

📂 Full SQL script: [insurance_data_analsysis.sql](https://github.com/rankhambeavantika-source/Insurance-analytics-dashboard/blob/main/insurance_data_analsysis.sql)

---

## 🚀 Business Value

This project demonstrates how SQL and Excel can be used together to validate data, analyze insurance operations, summarize key metrics, and communicate insights clearly through a dashboard.

---

## 🔮 Future Improvements

- 📈 Build a Power BI dashboard
- 🎨 Develop an interactive Tableau visualization
- ➕ Extend the analysis with additional business KPIs

---

## 👩‍💻 Author

**Avantika Rankhambe**

- 🔗 LinkedIn: [Avantika Rankhambe](https://www.linkedin.com/in/avantika-rankhambe-746808275)
- 🐙 GitHub: [rankhambeavantika-source](https://github.com/rankhambeavantika-source)
- 📧 Email: [rankhambeavantika@gmail.com](mailto:rankhambeavantika@gmail.com)

---

⭐ If you found this project useful, feel free to star the repository!
