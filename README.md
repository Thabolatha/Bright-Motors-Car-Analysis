# Bright-Motors-Car-Analysis

## Project Overview

This project analyzes historical car sales data for Bright Motors, a vehicle dealership company seeking to improve sales performance, optimize inventory decisions, and support dealership expansion. The analysis was completed as part of the BrightLearn Data Analytics case study, where the objective was to provide actionable insights and strategic recommendations for the new Head of Sales.

The main goal of this project was to identify high-performing car brands, profitable regions, customer purchasing preferences, pricing behavior, and inventory opportunities that can improve overall dealership profitability and long-term business growth.

---

## Business Objectives

The project aimed to answer the following key business questions:

* Which car makes and models generate the highest revenue?
* Which regions show the strongest sales performance?
* What customer purchasing preferences can be identified?
* How do mileage, selling price, and manufacture year relate to each other?
* Which vehicles generate stronger or weaker profit margins?
* What recommendations can improve dealership profitability and efficiency?

---

## Tools Used

* Databricks SQL
* Microsoft Excel
* Canva
* Miro
* GitHub

---

## Dataset Description

The dataset contains vehicle sales information including:

* Manufacture year
* Make
* Model
* Trim
* Body type
* Transmission
* VIN
* Region / State
* Vehicle condition
* Odometer reading
* Exterior color
* Interior color
* Seller
* Market value (MMR)
* Selling price
* Sale date

### Important Note

The dataset did not contain:

* Fuel type
* Cost price
* Units sold

Therefore, the analysis was adjusted based only on the available columns to ensure accuracy and realistic business reporting.

---

## Data Cleaning and Processing

The raw data was cleaned and transformed in Databricks to create a reliable processed table for analysis.

### Key processing steps included:

* Removed invalid region values and corrected region inconsistencies
* Converted sale dates into proper date format
* Created sale year, sale month, and sale quarter columns
* Created a processed table for business reporting
* Replaced missing transmission values where necessary
* Standardized body type and manufacturer fields
* Calculated total revenue using selling price
* Calculated profit margin using selling price and market value (MMR)
* Categorized vehicles into High Margin, Medium Margin, and Low Margin groups

This process ensured accurate reporting, stronger visual analysis, and better business decision-making.

---

## Key Calculations

### Total Revenue

Since each row represents one vehicle sale:

```sql
total_revenue = selling_price
```

### Profit Margin Percentage

```sql
profit_margin_percentage =
((selling_price - market_value_mmr) / selling_price) * 100
```

### Profit Category Classification

* High Margin → 10% and above
* Medium Margin → 0% to 9.99%
* Low Margin → Below 0%

---

## Analysis Performed

The following business analyses were completed:

* Revenue by Make
* Top Models by Revenue
* Regional Sales Performance
* Average Selling Price Trend
* Profit Category Distribution
* Body Type Preference
* Transmission Preference
* Mileage vs Selling Price Relationship
* Cars Sold by Manufacture Year

---

## Key Insights

Ford generated the highest total revenue, followed by strong-performing brands such as Nissan, Chevrolet, Toyota, and BMW. This shows that a large portion of revenue is concentrated among a few dominant brands.

California showed the strongest regional sales performance, followed by Florida, Pennsylvania, and Texas, making these regions strong opportunities for dealership expansion and targeted marketing investment.

Sedans and SUVs were the most preferred body types, while automatic transmission vehicles dominated customer demand. This indicates strong customer preference for practical, convenient, and reliable vehicle options.

The profit margin analysis showed that many vehicles fall into the Low Margin category, highlighting the need for stronger pricing strategies and improved margin control.

Lower-mileage vehicles consistently achieved higher selling prices, confirming that mileage strongly influences customer purchasing decisions and overall vehicle value.

Vehicles manufactured between 2012 and 2014 showed stronger performance, suggesting customers prioritize newer and reliable vehicles with better resale value.


