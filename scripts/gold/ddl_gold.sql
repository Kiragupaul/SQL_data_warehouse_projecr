/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
USE Datawarehouse;
GO
CREATE OR ALTER VIEW gold.dim_customers AS 
SELECT
ROW_NUMBER() OVER (ORDER BY ci.cst_id DESC) AS customer_key,
ci.cst_id as Customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name,
la.cntry AS country,
ci.cst_material_status AS marital_status,
CASE WHEN ci.cst_gndr !=ca.gen THEN ci.cst_gndr --CRM is the master for gender
             ELSE COALESCE(ca.gen,'n/a')
     END AS gender,
ca.bdate AS birthdate,
ci.cst_create_date AS create_date
 FROM silver.crm_cust_info as ci
 LEFT JOIN silver.erp_cust_az12 as ca
 ON ci.cst_key=ca.cid
 LEFT JOIN silver.erp_loc_a101 as la
 ON ci.cst_key=la.cid;

CREATE OR ALTER VIEW gold.dim_products AS
SELECT
        ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt,pn.prd_key ) AS product_key,
        pn.prd_id AS product_id,
        pn.prd_key AS product_number,
        pn.prd_nm AS product_name,
        pn.cat_id AS category_id,
        pc.cat AS category,
        pc.subcat AS sub_category,
        pc.maintenance,
       pn.prd_cost AS cost,
        pn.prd_line AS product_line,
        pn.prd_start_dt AS start_date
    FROM silver.crm_prd_info AS pn
    LEFT JOIN silver.erp_px_cat_g1v2 AS pc
        ON pn.cat_id = pc.id
    WHERE pn.prd_end_dt IS NULL;



CREATE OR ALTER VIEW gold.fact_sales AS
SELECT 
     sd.sls_ord_num AS order_number,
     pr.product_key,
     cu.customer_key,
     sd.sls_order_dt AS order_date,
     sd.sls_ship_dt AS ship_date,
     sd.sls_due_dt AS due_date,
     sd.sls_sales AS sales_amount,
     sd.sls_quantity as quantity,
     sd.sls_price AS price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products as pr
ON sd.sls_prd_key=pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id=cu.customer_id;

---------------------------------------
