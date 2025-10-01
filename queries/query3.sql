SELECT
    product_id,
    product_name AS produto,
    unit_price AS preco
FROM products
ORDER BY preco DESC
LIMIT 10;
