# 🛒 E-Commerce Sales & Customer Analytics Dashboard

## 📌 Project Overview

An end-to-end data analytics project simulating a real business scenario at
OlistMart — a Brazilian e-commerce company with 100,000+ orders across 27 states.

This project answers 3 critical business questions asked by the Head of E-Commerce:
1. **Why is revenue dropping in certain months?** — Trend & seasonality analysis
2. **Are customers coming back after first purchase?** — Cohort retention analysis
3. **Who are our most valuable customers?** — RFM segmentation

## 🎯 Business Problem

> *"We have 100,000+ orders but leadership is asking hard questions.
> Revenue peaked last year and is dropping. Most customers seem to buy
> once and never return. We need to identify our top customers and
> understand what is driving churn."*
> — Arjun Mehta, Head of E-Commerce, OlistMart

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Python (Pandas, NumPy) | Data cleaning, EDA, RFM analysis |
| Matplotlib, Seaborn | Data visualization |
| Scikit-learn | Revenue forecasting (Linear Regression) |
| MySQL | Business queries (15+ SQL queries) |
| Power BI (DAX) | Interactive 4-page dashboard |
| Excel | Stakeholder summary report |


## 🔑 Key Business Insights

### Revenue Analysis
- 📈 Total revenue: **R$16M** across 25 months — growing **22% YoY**
- 🏆 Peak month: **November 2017** at R$210K (Black Friday effect)
- 🗺️ **SP + RJ + MG** = 57% of all revenue — southern states dominate
- 📦 Top 3 categories drive **42% of total revenue** — concentration risk

### Customer Analytics (RFM)
- 👑 **Champions (2%)** generate **38% of total revenue**
- 🚨 **96.9% of customers** buy only once — critical retention crisis
- ⚠️ **7,340 At-Risk customers** hold R$3.4M revenue — urgent action needed
- 💀 **57% of customers** classified as Lost — not purchased in 6+ months

### Cohort Retention
- 📉 Month 1 retention: **only 9%** — industry benchmark is 20-30%
- 📉 Month 3 retention: **drops to 4%** — massive churn after first purchase
- 💡 Recommendation: Launch **30-day post-purchase email sequence**

### Operations
- 🚚 Avg delivery time: **12.5 days** across all states
- 🔴 Northern states (RR, AP, AM): **25-32% late delivery rate**
- ⭐ Every **5 extra delivery days = 0.4 drop in review score**
- 💡 Recommendation: Open regional warehouses in northern Brazil

### Revenue Forecast
- 📊 Linear Regression R² = **0.78** — strong predictive fit
- 🎯 Next 3 months forecast: **R$220K → R$228K → R$235K**
- 🏆 Annual target of **R$20M for 2019 is achievable**

---

## 🚀 How to Run This Project

### Prerequisites
```bash
pip install pandas numpy matplotlib seaborn scikit-learn openpyxl
```

### Steps
1. Download dataset from [Kaggle — Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Place all CSV files in `data/` folder
3. Run notebooks in order
4. Import `master_clean.csv` and `rfm_segments.csv` into MySQL
5. Run `sql/business_queries.sql` in MySQL Workbench
6. Open `P1_Ecommerce_Dashboard.pbix` in Power BI Desktop

## 📈 SQL Queries Covered

- Total revenue, orders, customers (executive KPIs)
- Monthly revenue trend
- Revenue by product category (Top 15)
- Revenue by customer state
- Payment type analysis
- Delivery performance by state
- Review score by category
- Customer repeat purchase rate
- Revenue by day of week
- Top 10 seller performance
- Year over year comparison
- High value customer identification
- Freight cost vs price analysis
- Monthly new vs returning customers

## 🎓 Concepts Demonstrated

`RFM Analysis` `Cohort Analysis` `Customer Segmentation` `Revenue Forecasting`
`Linear Regression` `Moving Average` `Star Schema` `DAX Measures`
`Time Intelligence` `EDA` `Data Cleaning` `SQL Window Functions`
`CASE WHEN` `Subqueries` `Power BI Drillthrough` `Conditional Formatting`

## 👤 About

**Karthik M** — Data Analyst  
📧 karthik23004@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/karthik-m-data-analyst)  
🐙 [GitHub](https://github.com/karthik-data-analyst)  

*MCA Graduate | SQL · Python · Power BI · Excel*


⭐ If you found this project useful, please give it a star!
