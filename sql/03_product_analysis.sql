-- Top 10 Product Categories by Revenue

SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM public.order_items oi
JOIN public.orders o
    ON oi.order_id = o.order_id
JOIN public.products p
    ON oi.product_id = p.product_id
LEFT JOIN public.category_translation ct
    ON p.product_category_name =
       ct.product_category_name
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 10;
