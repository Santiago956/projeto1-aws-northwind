WITH categorias AS (
    SELECT
        c.category_name AS categoria,
        EXTRACT(YEAR FROM o.order_date) AS ano,
        ROUND(SUM((od.unit_price*od.quantity)-od.discount),2) AS total
    FROM categories AS c
    JOIN products AS p ON(c.category_id=p.category_id)
    JOIN order_details AS od ON(od.product_id = p.product_id)
    JOIN orders AS o ON(o.order_id = od.order_id)
    GROUP BY 1, 2
),

rank AS (
    SELECT
        RANK() OVER(PARTITION BY ano ORDER BY total) AS ranking,
        categoria,
        ano,
        total
    FROM categorias
)

SELECT
    ranking,
    categoria,
    ano,
    total
FROM rank
WHERE ranking <= 5;
