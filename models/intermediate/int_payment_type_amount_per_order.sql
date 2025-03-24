with order_payments as (
    SELECT * FROM {{ ref('stg_stripe_order_payments') }}
)

SELECT
    order_id,
    SUM (
        CASE 
            WHEN payment_type = 'cash' AND status = 'success'
            THEN amount
            ELSE 0
        END
    ) as cash_amount,
    SUM (
        CASE 
            WHEN payment_type = 'credit' and status = 'success'
            THEN amount
            ELSE 0
        END
    ) as credit_amount,
    SUM (
        CASE
            WHEN status = 'success'
            THEN amount
        END
    ) as total_amount
FROM order_payments
GROUP BY order_id