select *
 from `workspace`.`default`.`car_sales_dataset_new` 
 limit 100;
----------------------------------------------------------

CREATE OR REPLACE TABLE `workspace`.`default`.`car_sales_processed` AS
WITH cleaned_data AS (
    SELECT
        year AS manufacture_year,
        make,
        model,
        trim,
        body AS body_type,
        transmission,
        vin,
        state,
        condition,
        odometer,
        color AS exterior_color,
        interior AS interior_color,
        seller,
        mmr AS market_value_mmr,
        sellingprice AS selling_price,

        TO_TIMESTAMP(
            REGEXP_REPLACE(saledate, '^[A-Za-z]{3} ', ''),
            'MMM dd yyyy HH:mm:ss'
        ) AS sale_timestamp

    FROM `workspace`.`default`.`car_sales_dataset_new`
    WHERE
        make IS NOT NULL
        AND model IS NOT NULL
        AND sellingprice IS NOT NULL
        AND mmr IS NOT NULL
        AND sellingprice > 0
        AND mmr > 0
        AND state RLIKE '^[a-z]{2}$'
)

SELECT
    manufacture_year,
    make,
    model,
    trim,
    body_type,
    transmission,
    vin,
    state AS region,
    condition,
    odometer,
    exterior_color,
    interior_color,
    seller,
    market_value_mmr,
    selling_price,

    1 AS units_sold,
    selling_price AS total_revenue,

    ROUND(
        ((selling_price - market_value_mmr) / selling_price) * 100,
        2
    ) AS profit_margin_percentage,

    CASE
        WHEN ((selling_price - market_value_mmr) / selling_price) * 100 >= 10
            THEN 'High Margin'
        WHEN ((selling_price - market_value_mmr) / selling_price) * 100 >= 0
            THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS profit_category,

    TO_DATE(sale_timestamp) AS sale_date,
    YEAR(sale_timestamp) AS sale_year,
    MONTH(sale_timestamp) AS sale_month,
    QUARTER(sale_timestamp) AS sale_quarter

FROM cleaned_data;
-----------------------------------------------------------------------------------------------------

SELECT *
FROM `workspace`.`default`.`car_sales_processed`
WHERE region <> 'ca'
LIMIT 100;

----------------------------------------------------------------------------------------------------
SELECT
    COUNT(DISTINCT region) AS number_of_regions
FROM `workspace`.`default`.`car_sales_processed`;

--------------------------------------------------------------------------------------------------------
SELECT *
FROM `workspace`.`default`.`car_sales_processed`
ORDER BY sale_date;
--------------------------------------------------------------------------------------------------------

SELECT *
 FROM car_sales_processed;

-------------------------------------------------------------------------------------------------------
SELECT
    region,
    COUNT(*) AS total_cars_sold
FROM `workspace`.`default`.`car_sales_processed`
GROUP BY region
ORDER BY total_cars_sold DESC;
--------------------------------------------------------------------------------------------------------
--Revenue by Car Make
SELECT 
    make,
    COUNT(*) AS cars_sold,
    SUM(total_revenue) AS total_revenue,
    ROUND(AVG(selling_price), 2) AS average_selling_price
FROM `workspace`.`default`.`car_sales_processed`
GROUP BY make
ORDER BY total_revenue DESC;
---------------------------------------------------------------------------------------------------------
--Top 10 Models by Revenue
SELECT
    make,
    model,
    COUNT(*) AS cars_sold,
    SUM(total_revenue) AS total_revenue
FROM `workspace`.`default`.`car_sales_processed`
GROUP BY make, model
ORDER BY total_revenue DESC
LIMIT 10;
------------------------------------------------------------------------------------------------------
-- Regional Performance
SELECT
    region,
    COUNT(*) AS cars_sold,
    SUM(total_revenue) AS total_revenue,
    ROUND(AVG(selling_price), 2) AS average_selling_price
FROM `workspace`.`default`.`car_sales_processed`
GROUP BY region
ORDER BY total_revenue DESC;
------------------------------------------------------------------------------------------------------
-- Average Selling Price Trend Over Time
SELECT
    sale_year,
    sale_month,
    COUNT(*) AS cars_sold,
    ROUND(AVG(selling_price), 2) AS average_selling_price,
    SUM(total_revenue) AS total_revenue
FROM `workspace`.`default`.`car_sales_processed`
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;
-----------------------------------------------------------------------------------------------------
-- Profit Category Analysis
SELECT
    profit_category,
    COUNT(*) AS cars_sold,
    SUM(total_revenue) AS total_revenue,
    ROUND(AVG(profit_margin_percentage), 2) AS average_profit_margin
FROM `workspace`.`default`.`car_sales_processed`
GROUP BY profit_category
ORDER BY cars_sold DESC;
----------------------------------------------------------------------------------------------------
-- Price vs Mileage vs Year
SELECT
    manufacture_year,
    COUNT(*) AS cars_sold,
    ROUND(AVG(odometer), 2) AS average_mileage,
    ROUND(AVG(selling_price), 2) AS average_selling_price
FROM `workspace`.`default`.`car_sales_processed`
GROUP BY manufacture_year
ORDER BY manufacture_year;
----------------------------------------------------------------------------------------------------