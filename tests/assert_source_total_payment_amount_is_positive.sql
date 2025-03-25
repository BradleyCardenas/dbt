SELECT
    orderid as order_id,
    SUM(amount) as total_amount
FROM {{ source('stripe', 'payment')}}
GROUP BY order_id
HAVING total_amount < 0