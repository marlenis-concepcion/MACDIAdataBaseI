/*
    ===============================================================
    DQL DIDACTICO - EJEMPLOS COMPLETOS PARA DEMO Y ESTUDIO
    Proyecto: BancoAgricolaRD
    Motor: Microsoft SQL Server

    Objetivo:
    Este script muestra ejemplos de consultas SQL desde nivel basico
    hasta consultas mas completas usando SELECT, WHERE, ORDER BY,
    DISTINCT, TOP, funciones, JOIN, GROUP BY, HAVING, subconsultas,
    EXISTS, CASE, vistas, stored procedures y pruebas de triggers.

    Cada consulta tiene un comentario arriba explicando que datos trae.
    ===============================================================
*/

USE BancoAgricolaRD;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET NOCOUNT ON;
GO

/* ===============================================================
   1. SELECT BASICO
   =============================================================== */

-- 01. Trae las primeras 10 sucursales registradas en la dimension Sucursal.
SELECT TOP (10)
    Sucursal_ID,
    Sucursal_Nombre,
    Sucursal_Region,
    Sucursal_Estatus
FROM dbo.Sucursal;
GO

-- 02. Trae los primeros 10 periodos disponibles, mostrando anio, mes y fecha.
SELECT TOP (10)
    Periodo_ID,
    Periodo_Anio,
    Periodo_MesNumero,
    Periodo_MesNombre,
    Periodo_Fecha
FROM dbo.Periodo
ORDER BY Periodo_Anio, Periodo_MesNumero;
GO

-- 03. Trae los primeros 10 destinos de financiamiento agricola.
SELECT TOP (10)
    Destino_ID,
    Destino_Nombre,
    Destino_Rubro,
    Destino_TipoOperacion
FROM dbo.Destino;
GO

/* ===============================================================
   2. SELECT CON ALIAS Y COLUMNAS CALCULADAS
   =============================================================== */

-- 04. Trae registros de cartera con alias y calcula el valor promedio por prestamo.
SELECT TOP (10)
    FactCarteraPrestamo_ID AS CarteraID,
    FactCarteraPrestamo_CantidadPrestamos AS CantidadPrestamos,
    FactCarteraPrestamo_ValorRD AS ValorCarteraRD,
    FactCarteraPrestamo_ValorRD / NULLIF(FactCarteraPrestamo_CantidadPrestamos, 0) AS ValorPromedioPrestamoRD
FROM dbo.FactCarteraPrestamo
ORDER BY ValorPromedioPrestamoRD DESC;
GO

-- 05. Trae desembolsos, cobros y balance neto calculado por la tabla.
SELECT TOP (10)
    FactDesembolsoCobro_ID AS DesembolsoCobroID,
    FactDesembolsoCobro_DesembolsosRD AS DesembolsosRD,
    FactDesembolsoCobro_CobrosRD AS CobrosRD,
    FactDesembolsoCobro_BalanceNetoRD AS BalanceNetoRD
FROM dbo.FactDesembolsoCobro
ORDER BY BalanceNetoRD DESC;
GO

/* ===============================================================
   3. WHERE
   =============================================================== */

-- 06. Trae las sucursales que pertenecen a la region Sur.
SELECT
    Sucursal_ID,
    Sucursal_Nombre,
    Sucursal_Region
FROM dbo.Sucursal
WHERE Sucursal_Region = N'Sur'
ORDER BY Sucursal_Nombre;
GO

-- 07. Trae los periodos del anio 2025.
SELECT
    Periodo_ID,
    Periodo_Anio,
    Periodo_MesNombre,
    Periodo_Fecha
FROM dbo.Periodo
WHERE Periodo_Anio = 2025
ORDER BY Periodo_MesNumero;
GO

-- 08. Trae destinos relacionados con arroz.
SELECT
    Destino_ID,
    Destino_Nombre,
    Destino_Rubro,
    Destino_TipoOperacion
FROM dbo.Destino
WHERE Destino_Nombre LIKE N'%Arroz%'
ORDER BY Destino_Nombre;
GO

/* ===============================================================
   4. ORDER BY
   =============================================================== */

-- 09. Trae las 10 carteras mas altas registradas en la tabla de hechos.
SELECT TOP (10)
    FactCarteraPrestamo_ID,
    FactCarteraPrestamo_CantidadPrestamos,
    FactCarteraPrestamo_ValorRD
FROM dbo.FactCarteraPrestamo
ORDER BY FactCarteraPrestamo_ValorRD DESC;
GO

-- 10. Trae los destinos ordenados por tipo de operacion y nombre.
SELECT
    Destino_Nombre,
    Destino_Rubro,
    Destino_TipoOperacion
FROM dbo.Destino
ORDER BY Destino_TipoOperacion, Destino_Nombre;
GO

/* ===============================================================
   5. DISTINCT
   =============================================================== */

-- 11. Trae la lista unica de regiones existentes en la dimension Sucursal.
SELECT DISTINCT
    Sucursal_Region
FROM dbo.Sucursal
ORDER BY Sucursal_Region;
GO

-- 12. Trae la lista unica de tipos de operacion de los destinos.
SELECT DISTINCT
    Destino_TipoOperacion
FROM dbo.Destino
ORDER BY Destino_TipoOperacion;
GO

/* ===============================================================
   6. FUNCIONES AGREGADAS
   =============================================================== */

-- 13. Trae totales generales de cartera: registros, prestamos y monto.
SELECT
    COUNT(*) AS RegistrosCartera,
    SUM(FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos,
    SUM(FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
    AVG(FactCarteraPrestamo_ValorRD) AS PromedioCarteraPorRegistroRD,
    MIN(FactCarteraPrestamo_ValorRD) AS MenorCarteraRD,
    MAX(FactCarteraPrestamo_ValorRD) AS MayorCarteraRD
FROM dbo.FactCarteraPrestamo;
GO

-- 14. Trae totales generales de desembolsos, cobros y balance neto.
SELECT
    COUNT(*) AS RegistrosDesembolsoCobro,
    SUM(FactDesembolsoCobro_DesembolsosRD) AS TotalDesembolsosRD,
    SUM(FactDesembolsoCobro_CobrosRD) AS TotalCobrosRD,
    SUM(FactDesembolsoCobro_BalanceNetoRD) AS BalanceNetoRD
FROM dbo.FactDesembolsoCobro;
GO

/* ===============================================================
   7. GROUP BY
   =============================================================== */

-- 15. Trae el total de cartera por region.
SELECT
    s.Sucursal_Region,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
    SUM(c.FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Region
ORDER BY TotalCarteraRD DESC;
GO

-- 16. Trae el total de cartera por anio.
SELECT
    p.Periodo_Anio,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
    SUM(c.FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Periodo p
    ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
GROUP BY p.Periodo_Anio
ORDER BY p.Periodo_Anio;
GO

/* ===============================================================
   8. HAVING
   =============================================================== */

-- 17. Trae regiones cuya cartera total supera RD$ 500,000 millones.
SELECT
    s.Sucursal_Region,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Region
HAVING SUM(c.FactCarteraPrestamo_ValorRD) > 500000000000
ORDER BY TotalCarteraRD DESC;
GO

-- 18. Trae destinos con mas de RD$ 10,000 millones otorgados.
SELECT
    d.Destino_Nombre,
    SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d
    ON d.Destino_ID = m.FactMontoDestino_DestinoID
GROUP BY d.Destino_Nombre
HAVING SUM(m.FactMontoDestino_ValoresRD) > 10000000000
ORDER BY TotalValoresRD DESC;
GO

/* ===============================================================
   9. INNER JOIN
   =============================================================== */

-- 19. Trae cartera con nombre de sucursal y periodo usando INNER JOIN.
SELECT TOP (20)
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    p.Periodo_Anio,
    p.Periodo_MesNombre,
    c.FactCarteraPrestamo_CantidadPrestamos,
    c.FactCarteraPrestamo_ValorRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
INNER JOIN dbo.Periodo p
    ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
ORDER BY c.FactCarteraPrestamo_ValorRD DESC;
GO

-- 20. Trae montos por destino con nombre, rubro, tipo de operacion y periodo.
SELECT TOP (20)
    d.Destino_Nombre,
    d.Destino_Rubro,
    d.Destino_TipoOperacion,
    p.Periodo_Anio,
    p.Periodo_MesNombre,
    m.FactMontoDestino_ValoresRD,
    m.FactMontoDestino_Beneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d
    ON d.Destino_ID = m.FactMontoDestino_DestinoID
INNER JOIN dbo.Periodo p
    ON p.Periodo_ID = m.FactMontoDestino_PeriodoID
ORDER BY m.FactMontoDestino_ValoresRD DESC;
GO

/* ===============================================================
   10. LEFT JOIN
   =============================================================== */

-- 21. Trae todas las sucursales y muestra si tienen registros de desembolsos/cobros.
SELECT
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    COUNT(d.FactDesembolsoCobro_ID) AS RegistrosDesembolsoCobro
FROM dbo.Sucursal s
LEFT JOIN dbo.FactDesembolsoCobro d
    ON d.FactDesembolsoCobro_SucursalID = s.Sucursal_ID
GROUP BY s.Sucursal_Nombre, s.Sucursal_Region
ORDER BY RegistrosDesembolsoCobro DESC, s.Sucursal_Nombre;
GO

-- 22. Trae todos los periodos y marca cuantos registros de desembolso/cobro tienen.
SELECT
    p.Periodo_Anio,
    p.Periodo_MesNombre,
    COUNT(d.FactDesembolsoCobro_ID) AS RegistrosDesembolsoCobro
FROM dbo.Periodo p
LEFT JOIN dbo.FactDesembolsoCobro d
    ON d.FactDesembolsoCobro_PeriodoID = p.Periodo_ID
GROUP BY p.Periodo_Anio, p.Periodo_MesNumero, p.Periodo_MesNombre
ORDER BY p.Periodo_Anio, p.Periodo_MesNumero;
GO

/* ===============================================================
   11. SUBCONSULTAS
   =============================================================== */

-- 23. Trae sucursales cuya cartera total supera el promedio de cartera por sucursal.
SELECT
    s.Sucursal_Nombre,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Nombre
HAVING SUM(c.FactCarteraPrestamo_ValorRD) > (
    SELECT AVG(x.TotalCarteraRD)
    FROM (
        SELECT SUM(c2.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
        FROM dbo.FactCarteraPrestamo c2
        GROUP BY c2.FactCarteraPrestamo_SucursalID
    ) x
)
ORDER BY TotalCarteraRD DESC;
GO

-- 24. Trae destinos cuyo monto total supera el promedio por destino.
SELECT
    d.Destino_Nombre,
    SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d
    ON d.Destino_ID = m.FactMontoDestino_DestinoID
GROUP BY d.Destino_Nombre
HAVING SUM(m.FactMontoDestino_ValoresRD) > (
    SELECT AVG(y.TotalValoresRD)
    FROM (
        SELECT SUM(m2.FactMontoDestino_ValoresRD) AS TotalValoresRD
        FROM dbo.FactMontoDestino m2
        GROUP BY m2.FactMontoDestino_DestinoID
    ) y
)
ORDER BY TotalValoresRD DESC;
GO

/* ===============================================================
   12. EXISTS Y NOT EXISTS
   =============================================================== */

-- 25. Trae sucursales que tienen cartera y tambien desembolsos/cobros.
SELECT
    s.Sucursal_Nombre,
    s.Sucursal_Region
FROM dbo.Sucursal s
WHERE EXISTS (
    SELECT 1
    FROM dbo.FactCarteraPrestamo c
    WHERE c.FactCarteraPrestamo_SucursalID = s.Sucursal_ID
)
AND EXISTS (
    SELECT 1
    FROM dbo.FactDesembolsoCobro d
    WHERE d.FactDesembolsoCobro_SucursalID = s.Sucursal_ID
)
ORDER BY s.Sucursal_Nombre;
GO

-- 26. Trae periodos que tienen cartera, pero no tienen desembolsos/cobros.
SELECT
    p.Periodo_Anio,
    p.Periodo_MesNombre
FROM dbo.Periodo p
WHERE EXISTS (
    SELECT 1
    FROM dbo.FactCarteraPrestamo c
    WHERE c.FactCarteraPrestamo_PeriodoID = p.Periodo_ID
)
AND NOT EXISTS (
    SELECT 1
    FROM dbo.FactDesembolsoCobro d
    WHERE d.FactDesembolsoCobro_PeriodoID = p.Periodo_ID
)
ORDER BY p.Periodo_Anio, p.Periodo_MesNombre;
GO

/* ===============================================================
   13. CASE
   =============================================================== */

-- 27. Clasifica sucursales segun el monto total de cartera.
SELECT
    s.Sucursal_Nombre,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
    CASE
        WHEN SUM(c.FactCarteraPrestamo_ValorRD) >= 250000000000 THEN N'Cartera Muy Alta'
        WHEN SUM(c.FactCarteraPrestamo_ValorRD) >= 150000000000 THEN N'Cartera Alta'
        WHEN SUM(c.FactCarteraPrestamo_ValorRD) >= 75000000000 THEN N'Cartera Media'
        ELSE N'Cartera Baja'
    END AS ClasificacionCartera
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Nombre
ORDER BY TotalCarteraRD DESC;
GO

-- 28. Clasifica balance de desembolsos y cobros como positivo, negativo o neutro.
SELECT
    s.Sucursal_Nombre,
    SUM(d.FactDesembolsoCobro_BalanceNetoRD) AS BalanceNetoRD,
    CASE
        WHEN SUM(d.FactDesembolsoCobro_BalanceNetoRD) > 0 THEN N'Desembolsos mayores que cobros'
        WHEN SUM(d.FactDesembolsoCobro_BalanceNetoRD) < 0 THEN N'Cobros mayores que desembolsos'
        ELSE N'Balance neutro'
    END AS TipoBalance
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = d.FactDesembolsoCobro_SucursalID
GROUP BY s.Sucursal_Nombre
ORDER BY BalanceNetoRD DESC;
GO

/* ===============================================================
   14. FUNCIONES DE FECHA Y TEXTO
   =============================================================== */

-- 29. Trae periodos usando funciones de fecha para mostrar anio y mes desde Periodo_Fecha.
SELECT TOP (20)
    Periodo_Fecha,
    YEAR(Periodo_Fecha) AS AnioDesdeFecha,
    MONTH(Periodo_Fecha) AS MesDesdeFecha,
    DATENAME(MONTH, Periodo_Fecha) AS NombreMesSQL
FROM dbo.Periodo
ORDER BY Periodo_Fecha;
GO

-- 30. Trae sucursales mostrando texto en mayuscula y longitud del nombre.
SELECT
    Sucursal_Nombre,
    UPPER(Sucursal_Nombre) AS SucursalMayuscula,
    LEN(Sucursal_Nombre) AS LargoNombre
FROM dbo.Sucursal
ORDER BY LargoNombre DESC;
GO

/* ===============================================================
   15. FUNCIONES DE VENTANA
   =============================================================== */

-- 31. Trae ranking de sucursales por cartera dentro de cada anio.
SELECT
    p.Periodo_Anio,
    s.Sucursal_Nombre,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
    DENSE_RANK() OVER (
        PARTITION BY p.Periodo_Anio
        ORDER BY SUM(c.FactCarteraPrestamo_ValorRD) DESC
    ) AS RankingAnual
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
INNER JOIN dbo.Periodo p
    ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
GROUP BY p.Periodo_Anio, s.Sucursal_Nombre
ORDER BY p.Periodo_Anio, RankingAnual;
GO

-- 32. Trae evolucion anual de cartera con el monto del anio anterior.
SELECT
    anual.Periodo_Anio,
    anual.TotalCarteraRD,
    LAG(anual.TotalCarteraRD) OVER (ORDER BY anual.Periodo_Anio) AS TotalAnioAnterior,
    anual.TotalCarteraRD - LAG(anual.TotalCarteraRD) OVER (ORDER BY anual.Periodo_Anio) AS DiferenciaAnualRD
FROM (
    SELECT
        p.Periodo_Anio,
        SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Periodo p
        ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
    GROUP BY p.Periodo_Anio
) anual
ORDER BY anual.Periodo_Anio;
GO

/* ===============================================================
   16. CONSULTAS CON VISTAS
   =============================================================== */

-- 33. Trae datos desde la vista de cartera por sucursal y anio.
SELECT TOP (20)
    *
FROM dbo.VW_CarteraPorSucursalAnio
ORDER BY TotalValorRD DESC;
GO

-- 34. Trae datos desde la vista de desembolsos vs cobros mensual.
SELECT TOP (20)
    *
FROM dbo.VW_DesembolsosVsCobrosMensual
ORDER BY Periodo_Anio, Periodo_MesNumero;
GO

-- 35. Trae los destinos top usando la vista analitica de destinos.
SELECT TOP (20)
    *
FROM dbo.VW_DestinosTopFinanciamiento
ORDER BY TotalValoresRD DESC;
GO

/* ===============================================================
   17. STORED PROCEDURES
   =============================================================== */

-- 36. Ejecuta un stored procedure que trae resumen de cartera para el anio 2025.
EXEC dbo.SP_Resumen_Cartera_Por_Anio @Anio = 2025;
GO

-- 37. Ejecuta un stored procedure que trae las 5 sucursales con mayor cartera.
EXEC dbo.SP_TopSucursales_Cartera @Anio = NULL, @Top = 5;
GO

-- 38. Ejecuta un stored procedure que trae top 5 destinos financiados en 2025.
EXEC dbo.SP_TopDestinos_Financiados @Anio = 2025, @Top = 5;
GO

-- 39. Ejecuta un stored procedure que trae indicadores de marzo 2026.
EXEC dbo.SP_Indicadores_Periodo @Anio = 2026, @MesNumero = 3;
GO

/* ===============================================================
   18. TRIGGERS Y AUDITORIA
   =============================================================== */

-- 40. Trae las ultimas auditorias registradas por el trigger de FactDesembolsoCobro.
SELECT TOP (10)
    AuditoriaOperacion_ID,
    AuditoriaOperacion_TablaNombre,
    AuditoriaOperacion_Operacion,
    AuditoriaOperacion_RegistroID,
    AuditoriaOperacion_Fecha,
    AuditoriaOperacion_Usuario
FROM dbo.AuditoriaOperacion
ORDER BY AuditoriaOperacion_ID DESC;
GO

-- 41. Ejemplo controlado de trigger: actualiza temporalmente un registro de desembolso dentro de transaccion y luego hace ROLLBACK.
BEGIN TRANSACTION;

UPDATE dbo.FactDesembolsoCobro
SET FactDesembolsoCobro_DesembolsosRD = FactDesembolsoCobro_DesembolsosRD + 1
WHERE FactDesembolsoCobro_ID = 1;

SELECT TOP (5)
    AuditoriaOperacion_ID,
    AuditoriaOperacion_TablaNombre,
    AuditoriaOperacion_Operacion,
    AuditoriaOperacion_RegistroID,
    AuditoriaOperacion_Fecha
FROM dbo.AuditoriaOperacion
ORDER BY AuditoriaOperacion_ID DESC;

ROLLBACK TRANSACTION;
GO

-- 42. Trae historicos de cartera registrados por el trigger de FactCarteraPrestamo.
SELECT TOP (10)
    CarteraPrestamoHistorico_ID,
    CarteraPrestamoHistorico_FactCarteraPrestamoID,
    CarteraPrestamoHistorico_ValorRDAnterior,
    CarteraPrestamoHistorico_Fecha,
    CarteraPrestamoHistorico_Usuario
FROM dbo.CarteraPrestamoHistorico
ORDER BY CarteraPrestamoHistorico_ID DESC;
GO

/* ===============================================================
   19. CONSULTA INTEGRAL PARA DEMO
   =============================================================== */

-- 43. Trae una vista integral de cartera, areas financiadas y region por sucursal y periodo.
SELECT TOP (30)
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    p.Periodo_Anio,
    p.Periodo_MesNombre,
    c.FactCarteraPrestamo_ValorRD AS CarteraRD,
    c.FactCarteraPrestamo_CantidadPrestamos AS PrestamosCartera,
    a.FactAreaFinanciada_Tareas AS TareasFinanciadas,
    a.FactAreaFinanciada_ValorRD AS ValorAreasRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.FactAreaFinanciada a
    ON a.FactAreaFinanciada_SucursalID = c.FactCarteraPrestamo_SucursalID
   AND a.FactAreaFinanciada_PeriodoID = c.FactCarteraPrestamo_PeriodoID
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
INNER JOIN dbo.Periodo p
    ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
ORDER BY c.FactCarteraPrestamo_ValorRD DESC;
GO

-- 44. Trae resumen ejecutivo final con cantidades de tablas principales y montos acumulados.
SELECT
    (SELECT COUNT(*) FROM dbo.Periodo) AS TotalPeriodos,
    (SELECT COUNT(*) FROM dbo.Sucursal) AS TotalSucursales,
    (SELECT COUNT(*) FROM dbo.Destino) AS TotalDestinos,
    (SELECT COUNT(*) FROM dbo.FactCarteraPrestamo) AS RegistrosCartera,
    (SELECT COUNT(*) FROM dbo.FactAreaFinanciada) AS RegistrosAreas,
    (SELECT COUNT(*) FROM dbo.FactDesembolsoCobro) AS RegistrosDesembolsosCobros,
    (SELECT COUNT(*) FROM dbo.FactMontoDestino) AS RegistrosMontosDestino,
    (SELECT SUM(FactCarteraPrestamo_ValorRD) FROM dbo.FactCarteraPrestamo) AS TotalCarteraRD,
    (SELECT SUM(FactDesembolsoCobro_DesembolsosRD) FROM dbo.FactDesembolsoCobro) AS TotalDesembolsosRD,
    (SELECT SUM(FactDesembolsoCobro_CobrosRD) FROM dbo.FactDesembolsoCobro) AS TotalCobrosRD,
    (SELECT SUM(FactMontoDestino_ValoresRD) FROM dbo.FactMontoDestino) AS TotalMontosDestinoRD;
GO
