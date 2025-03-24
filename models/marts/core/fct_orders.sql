WITH orders as (
    SELECT * FROM {{ ref('stg_jaffle_shop_orders') }}
),
payment_type_orders as (
    SELECT * FROM {{ ref('int_payment_type_amount_per_order') }}
)
SELECT 
    ord.order_id,
    ord.customer_id,
    ord.order_date,
    pto.cash_amount,
    pto.credit_amount,
    pto.total_amount,
    CASE 
        WHEN status = 'completed'
        THEN 1 
        ELSE 0
    END as is_order_completed
FROM orders as ord
LEFT JOIN payment_type_orders as pto ON ord.order_id = pto.order_id