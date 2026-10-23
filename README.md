# Insurance-analytics-dashboard
Insurance analytics project: SQL data cleaning and analysis, Excel dashboard, Power BI and Tableau coming soon.
<h1 align="center">🛡️ Insurance Data Analysis Dashboard</h1>

<p align="center">
  <i>Understand Customers &nbsp;|&nbsp; Track Policies &nbsp;|&nbsp; Analyze Trends</i>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL-MySQL-4479A1?logo=mysql&logoColor=white" alt="MySQL">
  <img src="https://img.shields.io/badge/Excel-Dashboard-217346?logo=microsoftexcel&logoColor=white" alt="Excel">
  <img src="https://img.shields.io/badge/Power%20BI-Planned-F2C811?logo=powerbi&logoColor=black" alt="Power BI">
  <img src="https://img.shields.io/badge/Tableau-Planned-E97627?logo=tableau&logoColor=white" alt="Tableau">
  <img src="https://img.shields.io/badge/Status-In%20Progress-blue" alt="Status">
</p>

---

## 📌 Project Overview
This project analyses insurance data using **SQL (MySQL)** and **Microsoft Excel** to uncover insights about **policies, customers, claims and payments**. The data is validated and cleaned in SQL, business questions are answered with SQL queries, and the results are presented in an interactive Excel dashboard.

## 📊 Dashboard Preview
![Insurance Policy Analytics Dashboard](excel/screenshots/dashboard.png)

## 🎯 Key Metrics
| 📈 Metric | 🔢 Value |
|---|---|
| 👥 Total customers | **5,000** |
| 📄 Total policies | **5,000** |
| 💰 Total claims amount | **251.4 M** |
| 💎 Average coverage amount | **254.56 K** |
| 🏷️ Average premium | **1.05 K** |
| 📉 Average premium growth rate | **-12.48%** |

## 💡 Business Insights
| 🔎 Area | 📌 Finding | 🎯 Business Meaning |
|---|---|---|
| **Policy status** | Active **1,682** (33.6%), Terminated **1,678**, Lapsed **1,640**. Active-to-inactive ratio is about **0.51** | Only one in three policies is active, so retention is the biggest risk |
| **Age groups** | **28-37** has the most policies (**790**), followed by **58-67** (**764**) and **38-47** (**737**). **78-87** is lowest (**570**) | Two strong segments: young adults and pre-retirees. Target both |
| **Gender** | Other **1,699**, Male **1,677**, Female **1,624** (about 34% / 34% / 32%) | Participation is balanced; Male and Female differ by only **53** policies |
| **Policy types** | Health is highest (**1,316**), Auto is lowest (**1,214**). Life (**1,234**) and Property (**1,236**) are almost equal | Portfolio is well balanced; Auto has the most room to grow (**102** behind Health) |
| **Claims** | Total claims of **251.4 M** against total coverage of about **1.27 B** (5,000 × 254.56 K) | Claims are roughly one-fifth of total coverage |
| **Premium trend** | Yearly premium stayed between **475 K and 562 K**, peaking in **2016** and **2022**, then falling to **475 K** in **2024** | Premium income has been declining since 2022 |
| **Policy endings** | Endings rise from **25** (2016) to a peak of **526** (2025), then fall to **33** (2034). About **45%** of all policies end between 2023 and 2027 | A large wave of renewals is due; renewal management is critical |

### ✅ Recommendations
1. 🔁 **Improve retention:** two out of three policies are inactive, so use renewal reminders and flexible payment options to win back lapsed and terminated customers.
2. 🎯 **Target key age groups:** focus marketing on ages **28-37** and **58-67**.
3. 🚗 **Grow weaker products:** promote Auto policies and cross-sell to existing Health, Life and Property customers.
4. 📅 **Plan around policy endings:** run renewal campaigns for policies ending in 2026-2027.
5. 📉 **Review pricing:** investigate the premium decline since 2022.

## 🛠️ Tools Used
- 🗄️ **SQL (MySQL 8.0+)**
- 📗 **Microsoft Excel**
- 📊 **PivotTables and PivotCharts**
- 🎛️ **Interactive dashboard with slicers**

## 🎯 Project Objectives
- ✅ Analyse policy status and policy types
- ✅ Understand customer demographics (age group and gender)
- ✅ Analyse insurance claims and payment history
- ✅ Create an interactive Excel dashboard
- ✅ Answer the business analysis questions (KPIs, segmentation and trends) using SQL

## 🔄 Workflow
1. 🔍 **Data validation:** checked structure, row counts, missing values, duplicates, invalid values and orphan records
2. 🧹 **Data cleaning:** converted text dates to `DATE`, trimmed hidden spaces, fixed misaligned customer records, and created a `customer_clean` view
3. 🧮 **Analysis:** answered the business questions with SQL using joins, aggregation, `CASE`, `ROLLUP` and the `LAG()` window function
4. 📊 **Visualisation:** built PivotCharts, KPI cards and slicers in an Excel dashboard

## 🗂️ SQL Scripts
| Step | 📄 File | Description |
|---|---|---|
| 1️⃣ | [`01_data_validation.sql`](sql/01_data_validation.sql) | Read-only data quality checks |
| 2️⃣ | [`02_data_cleaning.sql`](sql/02_data_cleaning.sql) | Backups, date conversion, `TRIM` fixes, clean customer view |
| 3️⃣ | [`03_analysis_queries.sql`](sql/03_analysis_queries.sql) | KPIs, policy status, customer segments, policy types and premium trends |

## ⚠️ Data Quality Challenges
| 🚧 Challenge | 💡 Resolution |
|---|---|
| Dates stored as text | Converted to `DATE` with `ALTER TABLE` |
| Commas inside names shifted columns (Gender held zip codes) | Detected invalid rows and filtered them through a clean view |
| Claim IDs (`CLM...`) loaded into the customer table | Counted IDs by prefix and kept only valid `CUST` IDs |
| MySQL safe update mode (Error 1175) | Disabled for the session during updates, then re-enabled |
| Undefined age groups and growth rate | Documented assumptions below |

## 📝 Assumptions
- 👶 Age groups in SQL: 18-30, 31-45, 46-60 and 60+ (the Excel dashboard uses 10-year bands)
- 📈 Premium growth rate: year-over-year percentage change in premium, grouped by policy start year

## 📁 Project Files
```
insurance-analytics-dashboard/
├── 📄 README.md
├── 📂 data/
│   └── README.md          Dataset schema (raw data not included)
├── 📂 excel/
│   └── screenshots/       Dashboard screenshots
└── 📂 sql/
    ├── 01_data_validation.sql
    ├── 02_data_cleaning.sql
    └── 03_analysis_queries.sql
```
> 🔒 The raw dataset is not included because it contains personal information.

## 💼 Key Skills Demonstrated
`Data Cleaning` · `SQL Queries` · `Data Analysis` · `Excel Dashboards` · `Data Visualization` · `Business Insights`

## 🗺️ Roadmap
- [x] 📗 Excel dashboard
- [x] 🗄️ SQL data validation, cleaning and analysis
- [ ] 📊 Power BI dashboard
- [ ] 📈 Tableau dashboard

## 👩‍💻 Author
**Your Name**
Data Analytics Portfolio Project

🔗 [LinkedIn]www.linkedin.com/in/avantika-rankhambe-746808275
✉️rankhambeavantika@gmail.com

---
<p align="center">⭐ If you found this project useful, please give it a star!</p>
