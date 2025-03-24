WITH customers AS (
    SELECT * FROM {{ ref('stg_jaffle_shop_customers') }}
)

SELECT 
    customer_id,
    first_name,
    last_name
FROM customers