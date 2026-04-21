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
SELECT p.Periodo_Anio, SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD, SUM(c.FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
GROUP BY p.Periodo_Anio
ORDER BY p.Periodo_Anio;

-- 02. Top 10 sucursales por valor total de cartera.
SELECT TOP (10) s.Sucursal_Nombre, SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Nombre
ORDER BY TotalCarteraRD DESC;

-- 03. Cartera de 2026 por sucursal.
SELECT s.Sucursal_Nombre, p.Periodo_MesNombre, c.FactCarteraPrestamo_CantidadPrestamos, c.FactCarteraPrestamo_ValorRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
WHERE p.Periodo_Anio = 2026
ORDER BY c.FactCarteraPrestamo_ValorRD DESC;

-- 04. Meses con desembolsos mayores que cobros.
SELECT p.Periodo_Anio, p.Periodo_MesNombre, SUM(d.FactDesembolsoCobro_DesembolsosRD) AS Desembolsos, SUM(d.FactDesembolsoCobro_CobrosRD) AS Cobros
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Periodo p ON p.Periodo_ID = d.FactDesembolsoCobro_PeriodoID
GROUP BY p.Periodo_Anio, p.Periodo_MesNumero, p.Periodo_MesNombre
HAVING SUM(d.FactDesembolsoCobro_DesembolsosRD) > SUM(d.FactDesembolsoCobro_CobrosRD)
ORDER BY p.Periodo_Anio, p.Periodo_MesNumero;

-- 05. Balance neto por sucursal en desembolsos y cobros.
SELECT s.Sucursal_Nombre, SUM(d.FactDesembolsoCobro_DesembolsosRD) AS Desembolsos, SUM(d.FactDesembolsoCobro_CobrosRD) AS Cobros,
       SUM(d.FactDesembolsoCobro_BalanceNetoRD) AS BalanceNeto
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = d.FactDesembolsoCobro_SucursalID
GROUP BY s.Sucursal_Nombre
ORDER BY BalanceNeto DESC;

-- 06. Sucursales con mas de RD$ 10,000 millones en cartera historica.
SELECT s.Sucursal_Nombre, SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Nombre
HAVING SUM(c.FactCarteraPrestamo_ValorRD) > 10000000000
ORDER BY TotalCarteraRD DESC;

-- 07. Promedio mensual de cartera por region.
SELECT s.Sucursal_Region, AVG(c.FactCarteraPrestamo_ValorRD) AS PromedioMensualRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Region
ORDER BY PromedioMensualRD DESC;

-- 08. Destinos con mayor financiamiento total.
SELECT TOP (15) d.Destino_Nombre, d.Destino_TipoOperacion, SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.FactMontoDestino_DestinoID
GROUP BY d.Destino_Nombre, d.Destino_TipoOperacion
ORDER BY TotalValoresRD DESC;

-- 09. Distribucion de montos por tipo de operacion.
SELECT d.Destino_TipoOperacion, SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD,
       SUM(m.FactMontoDestino_Beneficiados) AS TotalBeneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.FactMontoDestino_DestinoID
GROUP BY d.Destino_TipoOperacion
ORDER BY TotalValoresRD DESC;

-- 10. Tareas financiadas por region y año.
SELECT s.Sucursal_Region, p.Periodo_Anio, SUM(a.FactAreaFinanciada_Tareas) AS TotalTareas
FROM dbo.FactAreaFinanciada a
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = a.FactAreaFinanciada_SucursalID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = a.FactAreaFinanciada_PeriodoID
GROUP BY s.Sucursal_Region, p.Periodo_Anio
ORDER BY p.Periodo_Anio, TotalTareas DESC;

-- 11. Años cuyo valor de cartera supera el promedio historico anual.
SELECT anual.Periodo_Anio, anual.TotalCarteraRD
FROM (
    SELECT p.Periodo_Anio, SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
    GROUP BY p.Periodo_Anio
) anual
WHERE anual.TotalCarteraRD > (
    SELECT AVG(x.TotalCarteraRD)
    FROM (
        SELECT p2.Periodo_Anio, SUM(c2.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
        FROM dbo.FactCarteraPrestamo c2
        INNER JOIN dbo.Periodo p2 ON p2.Periodo_ID = c2.FactCarteraPrestamo_PeriodoID
        GROUP BY p2.Periodo_Anio
    ) x
)
ORDER BY anual.TotalCarteraRD DESC;

-- 12. Sucursales que aparecen tanto en cartera como en desembolsos.
SELECT s.Sucursal_Nombre
FROM dbo.Sucursal s
WHERE EXISTS (SELECT 1 FROM dbo.FactCarteraPrestamo c WHERE c.FactCarteraPrestamo_SucursalID = s.Sucursal_ID)
  AND EXISTS (SELECT 1 FROM dbo.FactDesembolsoCobro d WHERE d.FactDesembolsoCobro_SucursalID = s.Sucursal_ID)
ORDER BY s.Sucursal_Nombre;

-- 13. Ranking de sucursales por cartera dentro de cada año.
SELECT p.Periodo_Anio, s.Sucursal_Nombre, SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
       DENSE_RANK() OVER (PARTITION BY p.Periodo_Anio ORDER BY SUM(c.FactCarteraPrestamo_ValorRD) DESC) AS RankingAnual
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY p.Periodo_Anio, s.Sucursal_Nombre;

-- 14. Valor promedio por prestamo en cartera.
SELECT s.Sucursal_Nombre,
       SUM(c.FactCarteraPrestamo_ValorRD) / NULLIF(SUM(c.FactCarteraPrestamo_CantidadPrestamos), 0) AS ValorPromedioPorPrestamo
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Nombre
ORDER BY ValorPromedioPorPrestamo DESC;

-- 15. Destinos de produccion financiados en 2025.
SELECT d.Destino_Nombre, SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.FactMontoDestino_DestinoID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.FactMontoDestino_PeriodoID
WHERE p.Periodo_Anio = 2025
  AND d.Destino_TipoOperacion LIKE N'%Producci%'
GROUP BY d.Destino_Nombre
ORDER BY TotalValoresRD DESC;

-- 16. Rubros con mas beneficiados.
SELECT TOP (10) d.Destino_Rubro, SUM(m.FactMontoDestino_Beneficiados) AS TotalBeneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.FactMontoDestino_DestinoID
GROUP BY d.Destino_Rubro
ORDER BY TotalBeneficiados DESC;

-- 17. Meses sin datos de desembolsos, pero con cartera.
SELECT DISTINCT p.Periodo_Anio, p.Periodo_MesNombre
FROM dbo.Periodo p
WHERE EXISTS (SELECT 1 FROM dbo.FactCarteraPrestamo c WHERE c.FactCarteraPrestamo_PeriodoID = p.Periodo_ID)
  AND NOT EXISTS (SELECT 1 FROM dbo.FactDesembolsoCobro d WHERE d.FactDesembolsoCobro_PeriodoID = p.Periodo_ID)
ORDER BY p.Periodo_Anio, p.Periodo_MesNombre;

-- 18. Comparacion de cartera y areas financiadas por sucursal y periodo.
SELECT s.Sucursal_Nombre, p.Periodo_Anio, p.Periodo_MesNombre,
       c.FactCarteraPrestamo_ValorRD AS CarteraRD, a.FactAreaFinanciada_ValorRD AS AreasRD, a.FactAreaFinanciada_Tareas
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.FactAreaFinanciada a ON a.FactAreaFinanciada_SucursalID = c.FactCarteraPrestamo_SucursalID AND a.FactAreaFinanciada_PeriodoID = c.FactCarteraPrestamo_PeriodoID
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
ORDER BY p.Periodo_Anio, p.Periodo_MesNumero, s.Sucursal_Nombre;

-- 19. Mes con mayor cartera total.
SELECT TOP (1) p.Periodo_Anio, p.Periodo_MesNombre, SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
GROUP BY p.Periodo_Anio, p.Periodo_MesNumero, p.Periodo_MesNombre
ORDER BY TotalCarteraRD DESC;

-- 20. Porcentaje de participacion de cada region en la cartera.
SELECT s.Sucursal_Region,
       SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
       100.0 * SUM(c.FactCarteraPrestamo_ValorRD) / SUM(SUM(c.FactCarteraPrestamo_ValorRD)) OVER () AS PorcentajeParticipacion
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Region
ORDER BY TotalCarteraRD DESC;

-- 21. Fuentes de datos cargadas y cantidad de registros relacionados.
SELECT f.FuenteDato_Nombre,
       f.FuenteDato_Archivo,
       CASE f.FuenteDato_ID
            WHEN 1 THEN (SELECT COUNT(*) FROM dbo.FactCarteraPrestamo)
            WHEN 2 THEN (SELECT COUNT(*) FROM dbo.FactAreaFinanciada)
            WHEN 3 THEN (SELECT COUNT(*) FROM dbo.FactDesembolsoCobro)
            WHEN 4 THEN (SELECT COUNT(*) FROM dbo.FactMontoDestino)
       END AS RegistrosCargados
FROM dbo.FuenteDato f
ORDER BY f.FuenteDato_ID;

-- 22. Sucursales por debajo del promedio general de cartera.
SELECT s.Sucursal_Nombre, SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Nombre
HAVING SUM(c.FactCarteraPrestamo_ValorRD) < (
    SELECT AVG(t.TotalCarteraRD)
    FROM (
        SELECT SUM(c2.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
        FROM dbo.FactCarteraPrestamo c2
        GROUP BY c2.FactCarteraPrestamo_SucursalID
    ) t
)
ORDER BY TotalCarteraRD;

-- 23. Evolucion anual del financiamiento por destino.
SELECT p.Periodo_Anio, SUM(m.FactMontoDestino_ValoresRD) AS TotalDestinosRD,
       LAG(SUM(m.FactMontoDestino_ValoresRD)) OVER (ORDER BY p.Periodo_Anio) AS TotalAnioAnterior
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.FactMontoDestino_PeriodoID
GROUP BY p.Periodo_Anio
ORDER BY p.Periodo_Anio;

-- 24. Indicadores generales del proyecto.
SELECT
    (SELECT COUNT(*) FROM dbo.Sucursal) AS TotalSucursales,
    (SELECT COUNT(*) FROM dbo.Destino) AS TotalDestinos,
    (SELECT COUNT(*) FROM dbo.Periodo) AS TotalPeriodos,
    (SELECT SUM(FactCarteraPrestamo_ValorRD) FROM dbo.FactCarteraPrestamo) AS TotalCarteraRD,
    (SELECT SUM(FactMontoDestino_ValoresRD) FROM dbo.FactMontoDestino) AS TotalMontosDestinoRD;

-- 25. Vista integrada de cartera anual.
SELECT *
FROM dbo.VW_CarteraPorSucursalAnio
WHERE Periodo_Anio BETWEEN 2024 AND 2026
ORDER BY Periodo_Anio DESC, TotalValorRD DESC;
GO
