WITH fct_orders as (
    SELECT * FROM {{ ref('fct_orders') }}
),
dim_customers as (
    SELECT * FROM {{ ref('dim_customers') }}
),
total_amount_per_customer_on_orders_complete as (
    SELECT
        cust.customer_id,
        cust.first_name,
        SUM(total_amount) as global_paid_amount
    FROM fct_orders as ord
    LEFT JOIN dim_customers as cust ON ord.customer_id = cust.customer_id
    WHERE ord.is_order_completed = 1
    GROUP BY cust.customer_id, first_name
    ORDER BY global_paid_amount DESC
),
customer_range_per_paid_amount as (
    SELECT * FROM {{ ref('seed_customer_range_per_paid_amount')}}
)
SELECT
    tac.customer_id,
    tac.first_name,
    tac.global_paid_amount,
    crp.classification
FROM total_amount_per_customer_on_orders_complete as tac
LEFT JOIN customer_range_per_paid_amount as crp ON tac.global_paid_amount >= crp.min_range and tac.global_paid_amount <= crp.max_range