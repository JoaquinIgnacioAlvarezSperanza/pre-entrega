-- -----------------------------------------------------------------------------
-- PRE ENTREGA 4 - m4_consultas_negocio
-- -----------------------------------------------------------------------------

USE ventas_tech_db

-- -----------------------------------------------------------------------------
-- CONSULTA 1
-- -----------------------------------------------------------------------------

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);


-- -----------------------------------------------------------------------------
-- CONSULTA 2
-- -----------------------------------------------------------------------------

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


-- -----------------------------------------------------------------------------
-- CONSULTA 3
-- -----------------------------------------------------------------------------

SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


-- -----------------------------------------------------------------------------
-- CONSULTA 4
-- -----------------------------------------------------------------------------

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    AVG(SUM(cantidad * precio_unitario)) OVER () AS promedio_mensual_general,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > AVG(SUM(cantidad * precio_unitario)) OVER () 
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS estado_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);



-- -----------------------------------------------------------------------------
-- HALLAZGOS
-- -----------------------------------------------------------------------------


-- Hallazgo 1: El id_producto 1 es el principal generador de dinero de la empresa,
--             aportando $3.600,00 con solo 3 unidades vendidas. 

-- Hallazgo 2: El id_producto 2 es el artículo con mayor volumen de ventas físicas 
--             pero debido a su bajo precio unitario aporta solo el 5,65% de la
--             facturación total.

-- Hallazgo 3: Todos los clientes volvieron a comprar (2 veces cada uno), pero las ventas dependen mayoritariamente
--             de los clientes id_cliente 1 (gastó $2.640) y del id_cliente 5 (gastó $2.100)