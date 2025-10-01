WITH vendas_2020 AS (
    SELECT
        s.company_name AS empresa,
        SUM((od.unit_price*od.quantity) - od.discount) AS total_2020
    FROM suppliers AS s
    JOIN products AS p ON(p.supplier_id = s.supplier_id)
    JOIN order_details AS od ON (p.product_id = od.product_id)
    JOIN orders AS o ON (od.order_id = o.order_id)
    WHERE EXTRACT(YEAR FROM o.order_date) = 2020
    GROUP BY 1
),
vendas_2021 AS (
    SELECT
        s.company_name AS empresa,
        SUM((od.unit_price*od.quantity) - od.discount) AS total_2021
    FROM suppliers AS s
    JOIN products AS p ON(p.supplier_id = s.supplier_id)
    JOIN order_details AS od ON (p.product_id = od.product_id)
    JOIN orders AS o ON (od.order_id = o.order_id)
    WHERE EXTRACT(YEAR FROM o.order_date) = 2021
    GROUP BY 1
)

SELECT 
    v20.empresa,
    ROUND(v20.total_2020,2) AS vendas_2020,
    ROUND(v21.total_2021,2) AS vendas_2021,
    ROUND(v21.total_2021 - v20.total_2020, 2) AS diferenca
FROM vendas_2020 AS v20 
JOIN vendas_2021 AS v21 ON(v21.empresa = v20.empresa)
ORDER BY diferenca DESC;
