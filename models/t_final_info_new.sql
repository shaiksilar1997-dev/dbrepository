WITH customers AS (
    SELECT *
    FROM {{ ref('t_customers') }}
),

orders AS (
    SELECT *
    FROM {{ ref('t_orders') }}
),

customer_orders AS (
    SELECT *
    FROM {{ ref('t_customer_orders') }}
),

final AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        COALESCE(co.number_of_orders, 0) AS number_of_orders
    FROM customers c
    LEFT JOIN customer_orders co
        ON c.customer_id = co.customer_id
)

SELECT * FROM final