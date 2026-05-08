#  E-Commerce Sales Analysis — Olist Dataset

**Author:** Kalali Bhupathi Goud  
**LinkedIn:** [linkedin.com/in/bhupathi-goud-kalali-17428b409](https://www.linkedin.com/in/bhupathi-goud-kalali-17428b409)  
**GitHub:** [github.com/bhupathi-goud](https://github.com/bhupathi-goud)  

---

##  Overview
End-to-end data analysis of 100,000+ orders from the Olist Brazilian 
E-Commerce dataset — covering data cleaning, SQL querying, exploratory 
analysis, and an interactive Power BI dashboard.

---

## 📊 Key Metrics
| Metric | Value |
|--------|-------|
|  Total Revenue | R$16.01M |
|  Total Orders | 96,000+ |
|  On-Time Delivery Rate | 92% |
|  Avg Review Score | 4.07 / 5.0 |
|  Avg Delivery Days | 12.5 days |

---

##  Tools & Technologies
| Tool | Purpose |
|------|---------|
| Python (Pandas, NumPy) | Data cleaning & EDA |
| PostgreSQL + SQL | Data storage & business queries |
| Power BI + DAX | Interactive 7-page dashboard |
| Matplotlib & Seaborn | Data visualizations |
| Jupyter Notebook | Development environment |

---

## Project Structure

ecommerce-sales-analysis/
├── ecommerce_pythondatacleaning.ipynb  ← Data cleaning pipeline
├── ecommerce_EDA.ipynb                 ← EDA + visualizations
├── sql_ecommerce.sql                   ← All SQL queries
├── Ecommerce_Sales_Analysis.pptx       ← Project presentation
├── Ecommerce_Project_Report.docx       ← Full project report
├── dashboard.png                       ← Power BI dashboard screenshot
└── README.md

---

## Data Cleaning Highlights
- Loaded 8 CSV files (100K+ records) via kagglehub API
- Handled missing values in delivery date and category columns
- Converted 5 timestamp columns to datetime format
- Removed duplicates across orders, products, customers tables
- Feature engineering: delivery_days, on_time flag, month/year/quarter

---

## SQL Analysis (PostgreSQL)
- Designed 6-table normalized schema
- 11+ business queries: Revenue, Orders, Top States, Categories, Payments
- Advanced SQL: DATE_TRUNC, EXTRACT, LAG() window function, CTEs
- Multi-table JOINs across all 6 tables

---

## Power BI Dashboard — Olist 360° (7 Pages)
- **Page 1:** Overview — KPIs, Revenue trend, Top States, Payments
- **Page 2:** Sales Trends — Monthly/Quarterly, YoY comparison
- **Page 3:** Customer Analysis — State breakdown, New vs Repeat
- **Page 4:** Product Analysis — Top categories, Treemap
- **Page 5:** Delivery & Logistics — Delivery days by state
- **Page 6:** Payment Analysis — Payment type split, Installments
- **Page 7:** Summary — Key insights & recommendations

---

## Key Business Insights
- **São Paulo = 43%** of total revenue (R$5.1M) — heavy geographic concentration
- **health_beauty** is #1 revenue category
- **November 2017** = peak sales month (Black Friday effect confirmed)
- **Credit card = 73.9%** of all payment transactions
- **Northern states** (AM, RR, AP) average 25+ day delivery vs 8 days for SP
- **92% on-time delivery** — 8% late orders = ~7,700 impacted customers

---

## Business Recommendations
1. **Expand logistics** in North/Northeast states to reduce 25+ day delivery times
2. **Pre-stock top categories** before November for Black Friday spike
3. **Launch loyalty programs** — only 3% repeat customer rate currently
4. **Target mid-tier categories** in SP to unlock R$2M+ additional revenue

---

## How to Run
1. Clone this repo: `git clone https://github.com/bhupathi-goud/ecommerce-sales-analysis`
2. Install requirements: `pip install pandas numpy matplotlib seaborn scikit-learn`
3. Open `ecommerce_pythondatacleaning.ipynb` first, then `ecommerce_EDA.ipynb`
4. For SQL: import cleaned CSVs into PostgreSQL and run `sql_ecommerce.sql`
5. For dashboard: open `.pbix` file in Power BI Desktop

---

##  Contact
- **Email:** anussc2004@gmail.com
- **LinkedIn:** [linkedin.com/in/bhupathi-goud-kalali-17428b409](https://www.linkedin.com/in/bhupathi-goud-kalali-17428b409)
- **GitHub:** [github.com/bhupathi-goud](https://github.com/bhupathi-goud)
