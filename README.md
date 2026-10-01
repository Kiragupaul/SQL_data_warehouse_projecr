# SQL Data Warehouse & Analytics Project!

Building a data warehouse with **SQL Server**, including ETL processes, data modelling, and analytics.

Welcome to the Data Warehouse and Analytics project repository! This project demonstrates a data warehousing and analytics solution, from building a data warehouse to generating actionable insights. It is designed as a portfolio project that highlights industry best practices in data engineering and analytics.

---

## 🏗️ Data Architecture

The warehouse follows the **Medallion Architecture**, with three layers:

| Layer | Purpose | Object type |
|-------|---------|-------------|
| **Bronze** | Raw data, loaded as-is from the source files | Tables |
| **Silver** | Cleaned, standardised, and validated data | Tables |
| **Gold** | Business-ready data modelled as a star schema for reporting | Views |

## 🔄 ETL Process

1. **Extract:** Source CSV files are loaded into the Bronze layer using a stored procedure (`bronze.load_bronze`).
2. **Transform:** The Silver layer cleans and standardises the data: removing duplicates, handling nulls, trimming text, and fixing invalid values.
3. **Load:** The Gold layer integrates the Silver tables into views for **customers**, **products**, and **sales**, ready for analysis.

To run the loads:
```sql
EXEC bronze.load_bronze;
EXEC silver.load_silver;
```

## 📊 BI: Analytics & Reporting

### Objective
Develop SQL-based analytics to deliver insights into:
- **Customer behaviour**
- **Product performance**
- **Sales trends**

These insights give stakeholders key business metrics, enabling strategic decision-making.

## 🛠️ Tech Stack

- **SQL Server** & **SSMS**
- **T-SQL**: stored procedures, views
- **Git & GitHub**: version control

## 📂 Repository Structure

```
├── datasets/   # Source data files
├── docs/       # Project documentation
├── scripts/    # SQL scripts for the Bronze, Silver and Gold layers
├── tests/      # Data quality checks
├── LICENSE
└── README.md
```

## 📜 License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

## 👋 About Me

I'm **Paul Kiragu Waititu**, a data analyst and data scientist with a foundation in Mathematics and Statistics and experience across agribusiness and healthcare operations.

I work across ingestion, cleaning, modelling, and presentation, helping non-technical stakeholders move from scattered information to confident action.

