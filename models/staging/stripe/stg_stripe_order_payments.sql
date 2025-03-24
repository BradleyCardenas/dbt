SELECT
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    CASE
        WHEN paymentmethod in ('stripe','paypal','credit_card','gift_card')
        THEN 'credit'
        ELSE 'cash'
    END AS payment_type,
    status,
    amount,
    CASE 
        WHEN status = 'success'
        THEN true
        ELSE false
    END AS is_completed_payment,
    created as created_date
FROM {{ source('stripe', 'payment') }}