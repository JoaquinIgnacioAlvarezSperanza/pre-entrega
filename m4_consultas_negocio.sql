SELECT
   MONTH(fecha_venta) AS mes,
   SUM(cantidad * precio_unitario) AS total_facturado,
   COUNT(id_venta) AS cantidad_pedidos,
   AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
;

SELECT TOP 5
   id_producto,
   SUM(cantidad) AS unidades_vendidas,
   SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
;

SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
;

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE WHEN SUM(cantidad * precio_unitario) > AVG(cantidad * precio_unitario) 
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS estado_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
;

-- 1° Hallazgo: El id_producto 1 es el producto que mas factura ($3.600) pero no el mas vendido.
-- 2° Hallazgo: El id_producto 2 es el ultimo producto que mas factura en el top 5 ($360) pero es el
--              que vende en mayor cantidad.
-- 3° Hallazgo: Todos los clientes volvieron a comprar (2 veces cada uno), pero las ventas dependen mayoritariamente
--              de los clientes id_cliente 1 (gastó $2.640) y del id_cliente 5 (gastó $2.100)