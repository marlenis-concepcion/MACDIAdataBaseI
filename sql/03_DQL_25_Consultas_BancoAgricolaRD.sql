/*
    ===============================================================
    DQL - 25 consultas del proyecto BancoAgricolaRD
    Incluye SELECT, WHERE, ORDER BY, GROUP BY, HAVING, JOIN,
    subconsultas y funciones agregadas.
    ===============================================================
*/

USE BancoAgricolaRD;
GO

-- 01. Total de cartera por año.
SELECT p.Periodo_Anio, SUM(c.Valor_RD) AS Total_Cartera_RD, SUM(c.Cantidad_Prestamos) AS Total_Prestamos
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
GROUP BY p.Periodo_Anio
ORDER BY p.Periodo_Anio;

-- 02. Top 10 sucursales por valor total de cartera.
SELECT TOP (10) s.Sucursal_Nombre, SUM(c.Valor_RD) AS Total_Cartera_RD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
GROUP BY s.Sucursal_Nombre
ORDER BY Total_Cartera_RD DESC;

-- 03. Cartera de 2026 por sucursal.
SELECT s.Sucursal_Nombre, p.Periodo_MesNombre, c.Cantidad_Prestamos, c.Valor_RD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
WHERE p.Periodo_Anio = 2026
ORDER BY c.Valor_RD DESC;

-- 04. Meses con desembolsos mayores que cobros.
SELECT p.Periodo_Anio, p.Periodo_MesNombre, SUM(d.Desembolsos_RD) AS Desembolsos, SUM(d.Cobros_RD) AS Cobros
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Periodo p ON p.Periodo_ID = d.Periodo_ID
GROUP BY p.Periodo_Anio, p.Periodo_MesNumero, p.Periodo_MesNombre
HAVING SUM(d.Desembolsos_RD) > SUM(d.Cobros_RD)
ORDER BY p.Periodo_Anio, p.Periodo_MesNumero;

-- 05. Balance neto por sucursal en desembolsos y cobros.
SELECT s.Sucursal_Nombre, SUM(d.Desembolsos_RD) AS Desembolsos, SUM(d.Cobros_RD) AS Cobros,
       SUM(d.Balance_Neto_RD) AS Balance_Neto
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = d.Sucursal_ID
GROUP BY s.Sucursal_Nombre
ORDER BY Balance_Neto DESC;

-- 06. Sucursales con mas de RD$ 10,000 millones en cartera historica.
SELECT s.Sucursal_Nombre, SUM(c.Valor_RD) AS Total_Cartera_RD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
GROUP BY s.Sucursal_Nombre
HAVING SUM(c.Valor_RD) > 10000000000
ORDER BY Total_Cartera_RD DESC;

-- 07. Promedio mensual de cartera por region.
SELECT s.Sucursal_Region, AVG(c.Valor_RD) AS Promedio_Mensual_RD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
GROUP BY s.Sucursal_Region
ORDER BY Promedio_Mensual_RD DESC;

-- 08. Destinos con mayor financiamiento total.
SELECT TOP (15) d.Destino_Nombre, d.Destino_TipoOperacion, SUM(m.Valores_RD) AS Total_Valores_RD
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.Destino_ID
GROUP BY d.Destino_Nombre, d.Destino_TipoOperacion
ORDER BY Total_Valores_RD DESC;

-- 09. Distribucion de montos por tipo de operacion.
SELECT d.Destino_TipoOperacion, SUM(m.Valores_RD) AS Total_Valores_RD,
       SUM(m.Beneficiados) AS Total_Beneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.Destino_ID
GROUP BY d.Destino_TipoOperacion
ORDER BY Total_Valores_RD DESC;

-- 10. Tareas financiadas por region y año.
SELECT s.Sucursal_Region, p.Periodo_Anio, SUM(a.Tareas) AS Total_Tareas
FROM dbo.FactAreaFinanciada a
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = a.Sucursal_ID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = a.Periodo_ID
GROUP BY s.Sucursal_Region, p.Periodo_Anio
ORDER BY p.Periodo_Anio, Total_Tareas DESC;

-- 11. Años cuyo valor de cartera supera el promedio historico anual.
SELECT anual.Periodo_Anio, anual.Total_Cartera_RD
FROM (
    SELECT p.Periodo_Anio, SUM(c.Valor_RD) AS Total_Cartera_RD
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
    GROUP BY p.Periodo_Anio
) anual
WHERE anual.Total_Cartera_RD > (
    SELECT AVG(x.Total_Cartera_RD)
    FROM (
        SELECT p2.Periodo_Anio, SUM(c2.Valor_RD) AS Total_Cartera_RD
        FROM dbo.FactCarteraPrestamo c2
        INNER JOIN dbo.Periodo p2 ON p2.Periodo_ID = c2.Periodo_ID
        GROUP BY p2.Periodo_Anio
    ) x
)
ORDER BY anual.Total_Cartera_RD DESC;

-- 12. Sucursales que aparecen tanto en cartera como en desembolsos.
SELECT s.Sucursal_Nombre
FROM dbo.Sucursal s
WHERE EXISTS (SELECT 1 FROM dbo.FactCarteraPrestamo c WHERE c.Sucursal_ID = s.Sucursal_ID)
  AND EXISTS (SELECT 1 FROM dbo.FactDesembolsoCobro d WHERE d.Sucursal_ID = s.Sucursal_ID)
ORDER BY s.Sucursal_Nombre;

-- 13. Ranking de sucursales por cartera dentro de cada año.
SELECT p.Periodo_Anio, s.Sucursal_Nombre, SUM(c.Valor_RD) AS Total_Cartera_RD,
       DENSE_RANK() OVER (PARTITION BY p.Periodo_Anio ORDER BY SUM(c.Valor_RD) DESC) AS Ranking_Anual
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
GROUP BY p.Periodo_Anio, s.Sucursal_Nombre;

-- 14. Valor promedio por prestamo en cartera.
SELECT s.Sucursal_Nombre,
       SUM(c.Valor_RD) / NULLIF(SUM(c.Cantidad_Prestamos), 0) AS Valor_Promedio_Por_Prestamo
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
GROUP BY s.Sucursal_Nombre
ORDER BY Valor_Promedio_Por_Prestamo DESC;

-- 15. Destinos de produccion financiados en 2025.
SELECT d.Destino_Nombre, SUM(m.Valores_RD) AS Total_Valores_RD
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.Destino_ID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.Periodo_ID
WHERE p.Periodo_Anio = 2025
  AND d.Destino_TipoOperacion LIKE N'%Producci%'
GROUP BY d.Destino_Nombre
ORDER BY Total_Valores_RD DESC;

-- 16. Rubros con mas beneficiados.
SELECT TOP (10) d.Destino_Rubro, SUM(m.Beneficiados) AS Total_Beneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.Destino_ID
GROUP BY d.Destino_Rubro
ORDER BY Total_Beneficiados DESC;

-- 17. Meses sin datos de desembolsos, pero con cartera.
SELECT DISTINCT p.Periodo_Anio, p.Periodo_MesNombre
FROM dbo.Periodo p
WHERE EXISTS (SELECT 1 FROM dbo.FactCarteraPrestamo c WHERE c.Periodo_ID = p.Periodo_ID)
  AND NOT EXISTS (SELECT 1 FROM dbo.FactDesembolsoCobro d WHERE d.Periodo_ID = p.Periodo_ID)
ORDER BY p.Periodo_Anio, p.Periodo_MesNombre;

-- 18. Comparacion de cartera y areas financiadas por sucursal y periodo.
SELECT s.Sucursal_Nombre, p.Periodo_Anio, p.Periodo_MesNombre,
       c.Valor_RD AS Cartera_RD, a.Valor_RD AS Areas_RD, a.Tareas
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.FactAreaFinanciada a ON a.Sucursal_ID = c.Sucursal_ID AND a.Periodo_ID = c.Periodo_ID
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
ORDER BY p.Periodo_Anio, p.Periodo_MesNumero, s.Sucursal_Nombre;

-- 19. Mes con mayor cartera total.
SELECT TOP (1) p.Periodo_Anio, p.Periodo_MesNombre, SUM(c.Valor_RD) AS Total_Cartera_RD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
GROUP BY p.Periodo_Anio, p.Periodo_MesNumero, p.Periodo_MesNombre
ORDER BY Total_Cartera_RD DESC;

-- 20. Porcentaje de participacion de cada region en la cartera.
SELECT s.Sucursal_Region,
       SUM(c.Valor_RD) AS Total_Cartera_RD,
       100.0 * SUM(c.Valor_RD) / SUM(SUM(c.Valor_RD)) OVER () AS Porcentaje_Participacion
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
GROUP BY s.Sucursal_Region
ORDER BY Total_Cartera_RD DESC;

-- 21. Fuentes de datos cargadas y cantidad de registros relacionados.
SELECT f.FuenteDato_Nombre,
       f.FuenteDato_Archivo,
       CASE f.FuenteDato_ID
            WHEN 1 THEN (SELECT COUNT(*) FROM dbo.FactCarteraPrestamo)
            WHEN 2 THEN (SELECT COUNT(*) FROM dbo.FactAreaFinanciada)
            WHEN 3 THEN (SELECT COUNT(*) FROM dbo.FactDesembolsoCobro)
            WHEN 4 THEN (SELECT COUNT(*) FROM dbo.FactMontoDestino)
       END AS Registros_Cargados
FROM dbo.FuenteDato f
ORDER BY f.FuenteDato_ID;

-- 22. Sucursales por debajo del promedio general de cartera.
SELECT s.Sucursal_Nombre, SUM(c.Valor_RD) AS Total_Cartera_RD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
GROUP BY s.Sucursal_Nombre
HAVING SUM(c.Valor_RD) < (
    SELECT AVG(t.Total_Cartera_RD)
    FROM (
        SELECT SUM(c2.Valor_RD) AS Total_Cartera_RD
        FROM dbo.FactCarteraPrestamo c2
        GROUP BY c2.Sucursal_ID
    ) t
)
ORDER BY Total_Cartera_RD;

-- 23. Evolucion anual del financiamiento por destino.
SELECT p.Periodo_Anio, SUM(m.Valores_RD) AS Total_Destinos_RD,
       LAG(SUM(m.Valores_RD)) OVER (ORDER BY p.Periodo_Anio) AS Total_Anio_Anterior
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.Periodo_ID
GROUP BY p.Periodo_Anio
ORDER BY p.Periodo_Anio;

-- 24. Indicadores generales del proyecto.
SELECT
    (SELECT COUNT(*) FROM dbo.Sucursal) AS Total_Sucursales,
    (SELECT COUNT(*) FROM dbo.Destino) AS Total_Destinos,
    (SELECT COUNT(*) FROM dbo.Periodo) AS Total_Periodos,
    (SELECT SUM(Valor_RD) FROM dbo.FactCarteraPrestamo) AS Total_Cartera_RD,
    (SELECT SUM(Valores_RD) FROM dbo.FactMontoDestino) AS Total_Montos_Destino_RD;

-- 25. Vista integrada de cartera anual.
SELECT *
FROM dbo.VW_CarteraPorSucursalAnio
WHERE Periodo_Anio BETWEEN 2024 AND 2026
ORDER BY Periodo_Anio DESC, Total_Valor_RD DESC;
GO
