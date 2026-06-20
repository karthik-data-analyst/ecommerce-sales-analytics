create database olist_db;
use olist_db;

select count(*) as Total_rows from ecommerce;

SELECT
    COUNT(DISTINCT order_id)          AS total_orders,
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    ROUND(SUM(revenue), 2)            AS c,
    ROUND(AVG(revenue), 2)            AS avg_order_revenue,
    ROUND(AVG(review_score), 2)       AS avg_review_score
FROM ecommerce;


SELECT
    order_yearmonth,
    COUNT(DISTINCT order_id)  AS orders_count,
    ROUND(SUM(revenue), 2)    AS monthly_revenue,
    ROUND(AVG(revenue), 2)    AS avg_order_value
FROM ecommerce
GROUP BY order_yearmonth
ORDER BY order_yearmonth ASC;


SELECT
    product_category_name_english          AS category,
    COUNT(DISTINCT order_id)               AS total_orders,
    ROUND(SUM(revenue), 2)                 AS total_revenue,
    ROUND(AVG(revenue), 2)                 AS avg_revenue_per_order,
    ROUND(AVG(review_score), 2)            AS avg_review_score

FROM ecommerce
WHERE product_category_name_english != 'unknown'
GROUP BY product_category_name_english
ORDER BY total_revenue DESC
LIMIT 15;

-- Which states generate most revenue?
SELECT
    customer_state                    AS state,
    COUNT(DISTINCT customer_unique_id) AS unique_customers,
    COUNT(DISTINCT order_id)           AS total_orders,
    ROUND(SUM(revenue), 2)             AS total_revenue,
    ROUND(SUM(revenue) * 100.0 /(SELECT SUM(revenue) FROM ecommerce), 2)AS revenue_pct
FROM ecommerce
GROUP BY customer_state
ORDER BY total_revenue DESC;


-- Which exact products are our best sellers?

SELECT
    product_id,
    product_category_name_english     AS category,
    COUNT(DISTINCT order_id)           AS times_ordered,
    ROUND(SUM(revenue), 2)             AS total_revenue,
    ROUND(AVG(price), 2)               AS avg_price,
    ROUND(AVG(review_score), 2)        AS avg_review

FROM ecommerce
GROUP BY product_id, product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;


-- How do customers prefer to pay?


SELECT
    payment_type,
    COUNT(DISTINCT order_id)            AS total_orders,
    ROUND(SUM(payment_value), 2)        AS total_payment_value,
    ROUND(AVG(payment_installments), 1) AS avg_installments,
    ROUND(AVG(payment_value), 2)        AS avg_payment

FROM ecommerce
GROUP BY payment_type
ORDER BY total_orders DESC;

--  How fast do we deliver and how often are we late?

SELECT
    customer_state                          AS state,
    COUNT(DISTINCT order_id)                AS total_orders,
    ROUND(AVG(delivery_days), 1)            AS avg_delivery_days,
    SUM(is_late)                            AS late_orders,
    ROUND(SUM(is_late) * 100.0 /COUNT(DISTINCT order_id), 2)      AS late_pct
FROM ecommerce
GROUP BY customer_state
ORDER BY late_pct DESC
LIMIT 10;

-- Which categories have unhappy customers?

SELECT
    product_category_name_english     AS category,
    COUNT(*)                           AS review_count,
    ROUND(AVG(review_score), 2)        AS avg_score,
    SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END)        AS bad_reviews,
    SUM(CASE WHEN review_score = 5 THEN 1 ELSE 0 END)        AS five_star_reviews
FROM ecommerce
WHERE product_category_name_english != 'unknown'
GROUP BY product_category_name_english
HAVING COUNT(*) >= 100          
ORDER BY avg_score ASC
LIMIT 10;

-- Do customers come back after first purchase?

SELECT
    order_count_bucket,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER(), 2) AS pct_of_customers

FROM (
    SELECT
        customer_unique_id,
        CASE
            WHEN COUNT(DISTINCT order_id) = 1 THEN '1 order only'
            WHEN COUNT(DISTINCT order_id) = 2 THEN '2 orders'
            WHEN COUNT(DISTINCT order_id) = 3 THEN '3 orders'
            ELSE '4 or more orders'
        END AS order_count_bucket
    FROM ecommerce
    GROUP BY customer_unique_id
) AS customer_orders

GROUP BY order_count_bucket
ORDER BY order_count_bucket;


-- Which days get most orders?

SELECT
    order_dayofweek                    AS day_of_week,
    COUNT(DISTINCT order_id)           AS total_orders,
    ROUND(SUM(revenue), 2)             AS total_revenue,
    ROUND(AVG(revenue), 2)             AS avg_order_value
FROM ecommerce
GROUP BY order_dayofweek
ORDER BY total_orders DESC;


-- Who are our best performing sellers?


SELECT
    seller_id,
    seller_state,
    COUNT(DISTINCT order_id)           AS total_orders,
    ROUND(SUM(revenue), 2)             AS total_revenue,
    ROUND(AVG(review_score), 2)        AS avg_review_score,
    ROUND(AVG(delivery_days), 1)       AS avg_delivery_days

FROM ecommerce
GROUP BY seller_id, seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- How did revenue compare between 2017 and 2018?


SELECT
    order_year                         AS year,
    COUNT(DISTINCT order_id)           AS total_orders,
    ROUND(SUM(revenue), 2)             AS total_revenue,
    ROUND(AVG(revenue), 2)             AS avg_order_value,
    COUNT(DISTINCT customer_unique_id) AS unique_customers

FROM ecommerce
WHERE order_year IN (2017, 2018)
GROUP BY order_year
ORDER BY order_year;

--  Who are our most valuable customers?

SELECT
    customer_unique_id,
    customer_state,
    COUNT(DISTINCT order_id)           AS total_orders,
    ROUND(SUM(revenue), 2)             AS total_spent,
    ROUND(AVG(revenue), 2)             AS avg_order_value,
    ROUND(AVG(review_score), 2)        AS avg_review_score,
    MIN(order_yearmonth)               AS first_purchase,
    MAX(order_yearmonth)               AS last_purchase

FROM ecommerce
GROUP BY customer_unique_id, customer_state
ORDER BY total_spent DESC
LIMIT 20;

-- Are customers paying too much for shipping?


SELECT
    product_category_name_english      AS category,
    ROUND(AVG(price), 2)               AS avg_product_price,
    ROUND(AVG(freight_value), 2)       AS avg_freight_cost,
    ROUND(AVG(freight_value) * 100.0 /
          AVG(price), 2)               AS freight_to_price_pct,
    COUNT(DISTINCT order_id)           AS total_orders

FROM ecommerce
WHERE product_category_name_english != 'unknown'
GROUP BY product_category_name_english
HAVING COUNT(DISTINCT order_id) >= 50
ORDER BY freight_to_price_pct DESC
LIMIT 10;


SELECT
    order_yearmonth,
    COUNT(DISTINCT customer_unique_id) AS total_customers,

    COUNT(DISTINCT CASE
        WHEN first_order = order_yearmonth
        THEN customer_unique_id END)   AS new_customers,

    COUNT(DISTINCT CASE
        WHEN first_order != order_yearmonth
        THEN customer_unique_id END)   AS returning_customers

FROM (
    SELECT
        customer_unique_id,
        order_yearmonth,
        MIN(order_yearmonth) OVER
            (PARTITION BY customer_unique_id)  AS first_order
    FROM ecommerce
) AS customer_history

GROUP BY order_yearmonth
ORDER BY order_yearmonth;

 


