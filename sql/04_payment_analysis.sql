-- Payment Method Analysis

SELECT
    payment_type,
    COUNT(*) AS total_payment_records,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS payment_percentage
FROM public.payments
GROUP BY payment_type
ORDER BY total_payment_records DESC;

-- Credit Card Installment Analysis

SELECT
    payment_installments,
    COUNT(*) AS total_transactions,
    ROUND(AVG(payment_value), 2) AS average_payment_value,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM public.payments
WHERE payment_type = 'credit_card'
GROUP BY payment_installments
ORDER BY payment_installments;

-- Investigate zero installment records

SELECT *
FROM public.payments
WHERE payment_type = 'credit_card'
  AND payment_installments = 0;

-- Payment Record Validation
-- Compare payment records with unique orders

SELECT
    COUNT(*) AS total_payment_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(*) - COUNT(DISTINCT order_id)
        AS additional_payment_records,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM public.payments;

-- Orders with Multiple Payment Records

SELECT
    COUNT(*) AS orders_with_multiple_payments
FROM (
    SELECT order_id
    FROM public.payments
    GROUP BY order_id
    HAVING COUNT(*) > 1
) AS multiple_payments;

-- Payment Discrepancy Investigation

WITH payment_per_order AS (
    SELECT
        order_id,
        SUM(payment_value) AS payment_value
    FROM public.payments
    GROUP BY order_id
),

items_per_order AS (
    SELECT
        order_id,
        SUM(price + freight_value) AS order_value
    FROM public.order_items
    GROUP BY order_id
),

comparison AS (
    SELECT
        o.order_id,
        p.payment_value,
        i.order_value,
        p.payment_value - i.order_value AS difference
    FROM public.orders o
    JOIN payment_per_order p
        ON o.order_id = p.order_id
    JOIN items_per_order i
        ON o.order_id = i.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
)

SELECT
    COUNT(*) AS discrepancy_orders,
    ROUND(AVG(ABS(difference)), 2)
        AS average_absolute_difference,
    ROUND(MAX(ABS(difference)), 2)
        AS maximum_absolute_difference,
    ROUND(MIN(difference), 2)
        AS largest_negative_difference
FROM comparison
WHERE ABS(difference) > 0.01;


-- Delivered Orders Without Payment Records

SELECT
    o.order_id,
    o.order_status,
    ROUND(
        SUM(oi.price + oi.freight_value), 2
    ) AS order_value
FROM public.orders o
JOIN public.order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN public.payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND p.order_id IS NULL
GROUP BY
    o.order_id,
    o.order_status;

-- Payment Reconciliation Findings
-- 96,470 delivered orders were analyzed.
-- 96,170 orders have matching payment and order values.
-- 299 orders have payment discrepancies.
-- 1 delivered order has no payment record.
-- No delivered orders are missing order items.
-- Discrepancies are retained for investigation.

-- Payment Discrepancy Investigation
-- 299 delivered orders have payment discrepancies.
-- Average absolute difference: R$10.80.
-- Maximum absolute difference: R$182.81.
-- Largest negative difference: -R$51.62.
-- Further investigation is required to identify the causes.

-- Revenue vs Payment Reconciliation
-- Revenue breakdown includes all delivered orders.
-- Payment reconciliation excludes 1 delivered order
-- without a payment record.
-- Missing payment order value: R$143.46.
-- This explains the R$143.46 difference between
-- revenue breakdown and payment reconciliation.