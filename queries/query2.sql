SELECT
    e.employee_id,
    (e.first_name::VARCHAR(20) || ' ' || e.last_name::VARCHAR(20)) AS name,
    COUNT(o.order_id) AS qntd_vendas,
    ROUND(SUM((od.unit_price * od.quantity) - od.discount), 2) AS total
FROM orders AS o
JOIN employees AS e ON (e.employee_id = o.employee_id)
JOIN order_details AS od ON (od.order_id = o.order_id)
WHERE EXTRACT(YEAR FROM o.order_date) = (
    SELECT 
        MAX(EXTRACT(YEAR FROM order_date))
    FROM orders
)
GROUP BY ALL
ORDER BY total DESC;
