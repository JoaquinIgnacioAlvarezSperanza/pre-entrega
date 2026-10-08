-- -----------------------------------------------------------------------------
-- PRE ENTREGA 5 - m5_consultas_joins
-- -----------------------------------------------------------------------------

USE ventas_tech_db

-- -----------------------------------------------------------------------------
-- CONSULTA 1 — INNER JOIN
-- -----------------------------------------------------------------------------

SELECT 
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta ASC;

-- -----------------------------------------------------------------------------
-- CONSULTA 2 — LEFT JOIN (clientes)
-- -----------------------------------------------------------------------------

SELECT 
    c.nombre AS nombre_cliente,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- -----------------------------------------------------------------------------
-- CONSULTA 3 — LEFT JOIN (productos)
-- -----------------------------------------------------------------------------

SELECT 
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- -----------------------------------------------------------------------------
-- CONSULTA 4 — UNION ALL
-- -----------------------------------------------------------------------------

SELECT 
    canal, 
    SUM(total_venta) AS total_por_canal
FROM (
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total_venta, 
        'Online' AS canal
    FROM ventas 
    WHERE id_venta <= 5

    UNION ALL

    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total_venta, 
        'Presencial' AS canal
    FROM ventas 
    WHERE id_venta > 5
) AS consolidado_ventas
GROUP BY canal;