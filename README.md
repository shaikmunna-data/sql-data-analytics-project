# 📊 SQL Data Analytics Project

This project demonstrates **practical SQL-based data analytics** using a structured **Bronze → Silver → Gold** data model.
It includes real-world exploratory data analysis (EDA), advanced analytics, reporting SQL scripts, and a clear analytics roadmap.

# 🎯 Project Goal
The goal of this project is to perform:

### ✔ Exploratory Data Analysis (EDA)

- Understanding tables, relationships, keys
- Exploring date ranges, measures, big numbers
- Ranking, magnitude, dimension-level insights

### ✔ Advanced Analytics

- Trend and change-over-time analysis
- Cumulative and running totals
- Customer and product performance
- Part-to-whole proportions
- Data segmentation
- Detailed SQL reports

## 📁 Repository Structure

```└── sql-data-analytics-project
    ├── LICENSE
    ├── README.md
    ├── datasets                            # All data sources used in the project
    │   ├── DataWarehouseAnalytics.bak      # Backup of full data warehouse 
    │   ├── bronze                          # Raw source CSVs
    │   │   ├── bronze.crm_cust_info.csv
    │   │   ├── bronze.crm_prd_info.csv
    │   │   ├── bronze.crm_sales_details.csv
    │   │   ├── bronze.erp_cust_az12.csv
    │   │   ├── bronze.erp_loc_a101.csv
    │   │   └── bronze.erp_px_cat_g1v2.csv
    │   ├── gold                            # Final analytical datasets 
    │   │   ├── gold.dim_customers.csv
    │   │   ├── gold.dim_products.csv
    │   │   └── gold.fact_sales.csv
    │   └── silver                          # Cleaned & standardized data  
    │       ├── silver.crm_cust_info.csv
    │       ├── silver.crm_prd_info.csv
    │       ├── silver.crm_sales_details.csv
    │       ├── silver.erp_cust_az12.csv
    │       ├── silver.erp_loc_a101.csv
    │       └── silver.erp_px_cat_g1v2.csv
    ├── docs                                # Documentation & diagrams  
    │   ├── data_analytics_overview.drawio
    │   └── data_analytics_overview.png
    └── scripts                             # SQL scripts for setup & analytics 
        ├── 00_create_database.sql          # Creates the DW database  
        ├── 01_bronze_layer_setup.sql       # Creates Bronze tables + loads bronze CSVs 
        ├── 02_silver_layer_setup.sql       # Creates Silver tables + loads silver CSVs
        ├── 03_gold_layer_setup.sql         # Creates Gold tables + loads gold CSVs  
        └── analytics                       # Query scripts for analysis  
            ├── advanced                    # Deeper analytical SQL  
            │   ├── 01_change_over_time_analysis.sql
            │   ├── 02_cumulative_analysis.sql
            │   ├── 03_performance_analysis.sql
            │   ├── 04_part_to_whole_analysis.sql
            │   ├── 05_data_segmentation.sql
            │   ├── 06_report_customers.sql
            │   └── 07_report_products.sql
            └── exploratory                 # Basic understanding of data  
                ├── 01_database_exploration.sql
                ├── 02_dimensions_exploration.sql
                ├── 03_date_range_exploration.sql
                ├── 04_measures_exploration.sql
                ├── 05_magnitude_analysis.sql
                └── 06_ranking_analysis.sql 
```
## 📦 Data Source

All CSV files and .bak database backup were sourced from my previous project  [modern-sql-dwh-project](https://github.com/shaikmunna-data/modern-sql-dwh-project), where the original data warehouse and datasets were created.

## 📈 Analytics Scope

Analytics are performed on the **Gold Layer**, which is clean and analysis-ready. Bronze and Silver layers exist to store raw and intermediate data for completensess.

## 🛡️ License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.


## ☀️About Me

Hi, I'm **Shaik Munna**.  
I am developing strong skills in Data Analytics, with a focus on SQL, data cleaning, and building structured analytical datasets.  
I am committed to improving my analytical abilities and working on projects that turn data into clear, meaningful insights.