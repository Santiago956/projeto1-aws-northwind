SELECT
    od.order_id,
    p.product_name AS produto,
    p.unit_price AS preco_tabelado,
    od.unit_price AS preco_venda,
    p.unit_price - od.unit_price AS diferenca,
    od.quantity AS quantidade,
    od.discount AS desconto
FROM order_details AS od
JOIN products AS p
ON od.product_id = p.product_id
    AND p.unit_price > od.unit_price
ORDER BY diferenca DESC;
