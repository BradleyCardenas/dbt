WITH fct_orders as (
    SELECT * FROM {{ ref('fct_orders') }}
),
dim_customers as (
    SELECT * FROM {{ ref('dim_customers') }}
)
SELECT
    cust.customer_id,
    cust.first_name,
    SUM(total_amount) as global_paid_amount
FROM fct_orders as ord
LEFT JOIN dim_customers as cust ON ord.customer_id = cust.customer_id
WHERE ord.is_order_completed = 1
GROUP BY cust.customer_id, first_name
ORDER BY global_paid_amount DESC