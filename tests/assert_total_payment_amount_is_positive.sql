/*
Test: int_payment_type_amount_per_order

Description: Check if the total_amount attribute inside 
int_payment_type_amount_per_order has only non-negatives values
*/

SELECT 
    order_id,
    SUM(total_amount) as total_amount,
FROM {{ ref('int_payment_type_amount_per_order') }}
GROUP BY order_id
HAVING total_amount < 0