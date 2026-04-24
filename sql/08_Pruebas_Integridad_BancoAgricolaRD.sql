/*
    ===============================================================
    PRUEBAS DE INTEGRIDAD - BancoAgricolaRD

    Objetivo:
    Validar que la base de datos este cargada, consistente y lista
    para demo academico.
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

PRINT '1) Validar que las tablas principales no esten vacias';

SELECT 'Periodo' AS Prueba, CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END AS Resultado, COUNT(*) AS Registros FROM dbo.Periodo
UNION ALL SELECT 'Sucursal', CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END, COUNT(*) FROM dbo.Sucursal
UNION ALL SELECT 'Destino', CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END, COUNT(*) FROM dbo.Destino
UNION ALL SELECT 'FuenteDato', CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END, COUNT(*) FROM dbo.FuenteDato
UNION ALL SELECT 'FactCarteraPrestamo', CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END, COUNT(*) FROM dbo.FactCarteraPrestamo
UNION ALL SELECT 'FactAreaFinanciada', CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END, COUNT(*) FROM dbo.FactAreaFinanciada
UNION ALL SELECT 'FactDesembolsoCobro', CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END, COUNT(*) FROM dbo.FactDesembolsoCobro
UNION ALL SELECT 'FactMontoDestino', CASE WHEN COUNT(*) > 0 THEN 'OK' ELSE 'FALLA' END, COUNT(*) FROM dbo.FactMontoDestino;
GO

PRINT '2) Validar llaves foraneas sin huerfanos';

SELECT 'FactCarteraPrestamo -> Sucursal' AS Prueba, COUNT(*) AS Huerfanos
FROM dbo.FactCarteraPrestamo f
LEFT JOIN dbo.Sucursal d ON d.Sucursal_ID = f.FactCarteraPrestamo_SucursalID
WHERE d.Sucursal_ID IS NULL
UNION ALL
SELECT 'FactCarteraPrestamo -> Periodo', COUNT(*)
FROM dbo.FactCarteraPrestamo f
LEFT JOIN dbo.Periodo d ON d.Periodo_ID = f.FactCarteraPrestamo_PeriodoID
WHERE d.Periodo_ID IS NULL
UNION ALL
SELECT 'FactAreaFinanciada -> Sucursal', COUNT(*)
FROM dbo.FactAreaFinanciada f
LEFT JOIN dbo.Sucursal d ON d.Sucursal_ID = f.FactAreaFinanciada_SucursalID
WHERE d.Sucursal_ID IS NULL
UNION ALL
SELECT 'FactAreaFinanciada -> Periodo', COUNT(*)
FROM dbo.FactAreaFinanciada f
LEFT JOIN dbo.Periodo d ON d.Periodo_ID = f.FactAreaFinanciada_PeriodoID
WHERE d.Periodo_ID IS NULL
UNION ALL
SELECT 'FactDesembolsoCobro -> Sucursal', COUNT(*)
FROM dbo.FactDesembolsoCobro f
LEFT JOIN dbo.Sucursal d ON d.Sucursal_ID = f.FactDesembolsoCobro_SucursalID
WHERE d.Sucursal_ID IS NULL
UNION ALL
SELECT 'FactDesembolsoCobro -> Periodo', COUNT(*)
FROM dbo.FactDesembolsoCobro f
LEFT JOIN dbo.Periodo d ON d.Periodo_ID = f.FactDesembolsoCobro_PeriodoID
WHERE d.Periodo_ID IS NULL
UNION ALL
SELECT 'FactMontoDestino -> Destino', COUNT(*)
FROM dbo.FactMontoDestino f
LEFT JOIN dbo.Destino d ON d.Destino_ID = f.FactMontoDestino_DestinoID
WHERE d.Destino_ID IS NULL
UNION ALL
SELECT 'FactMontoDestino -> Periodo', COUNT(*)
FROM dbo.FactMontoDestino f
LEFT JOIN dbo.Periodo d ON d.Periodo_ID = f.FactMontoDestino_PeriodoID
WHERE d.Periodo_ID IS NULL;
GO

PRINT '3) Validar valores negativos en medidas';

SELECT 'Cartera valor negativo' AS Prueba, COUNT(*) AS RegistrosInvalidos FROM dbo.FactCarteraPrestamo WHERE FactCarteraPrestamo_ValorRD < 0
UNION ALL SELECT 'Cartera cantidad negativa', COUNT(*) FROM dbo.FactCarteraPrestamo WHERE FactCarteraPrestamo_CantidadPrestamos < 0
UNION ALL SELECT 'Area tareas negativas', COUNT(*) FROM dbo.FactAreaFinanciada WHERE FactAreaFinanciada_Tareas < 0
UNION ALL SELECT 'Area valor negativo', COUNT(*) FROM dbo.FactAreaFinanciada WHERE FactAreaFinanciada_ValorRD < 0
UNION ALL SELECT 'Desembolsos negativos', COUNT(*) FROM dbo.FactDesembolsoCobro WHERE FactDesembolsoCobro_DesembolsosRD < 0
UNION ALL SELECT 'Cobros negativos', COUNT(*) FROM dbo.FactDesembolsoCobro WHERE FactDesembolsoCobro_CobrosRD < 0
UNION ALL SELECT 'Monto destino negativo', COUNT(*) FROM dbo.FactMontoDestino WHERE FactMontoDestino_ValoresRD < 0
UNION ALL SELECT 'Beneficiados negativos', COUNT(*) FROM dbo.FactMontoDestino WHERE FactMontoDestino_Beneficiados < 0;
GO

PRINT '4) Validar rangos de periodo';

SELECT
    MIN(Periodo_Anio) AS AnioMinimo,
    MAX(Periodo_Anio) AS AnioMaximo,
    MIN(Periodo_MesNumero) AS MesMinimo,
    MAX(Periodo_MesNumero) AS MesMaximo,
    COUNT(*) AS TotalPeriodos
FROM dbo.Periodo;
GO

PRINT '5) Validar duplicados logicos por restricciones UNIQUE';

SELECT 'Periodo anio-mes duplicado' AS Prueba, COUNT(*) AS Duplicados
FROM (
    SELECT Periodo_Anio, Periodo_MesNumero
    FROM dbo.Periodo
    GROUP BY Periodo_Anio, Periodo_MesNumero
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'Sucursal nombre duplicado', COUNT(*)
FROM (
    SELECT Sucursal_Nombre
    FROM dbo.Sucursal
    GROUP BY Sucursal_Nombre
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'Destino nombre duplicado', COUNT(*)
FROM (
    SELECT Destino_Nombre
    FROM dbo.Destino
    GROUP BY Destino_Nombre
    HAVING COUNT(*) > 1
) x;
GO

PRINT '6) Validar totales principales esperados para demo';

SELECT
    (SELECT COUNT(*) FROM dbo.FactCarteraPrestamo) AS RegistrosCartera,
    (SELECT COUNT(*) FROM dbo.FactAreaFinanciada) AS RegistrosAreas,
    (SELECT COUNT(*) FROM dbo.FactDesembolsoCobro) AS RegistrosDesembolsosCobros,
    (SELECT COUNT(*) FROM dbo.FactMontoDestino) AS RegistrosMontosDestino,
    (SELECT SUM(FactCarteraPrestamo_ValorRD) FROM dbo.FactCarteraPrestamo) AS TotalCarteraRD,
    (SELECT SUM(FactMontoDestino_ValoresRD) FROM dbo.FactMontoDestino) AS TotalMontosDestinoRD;
GO

PRINT '7) Validar stored procedures basicos';

EXEC dbo.SP_Resumen_Cartera_Por_Anio @Anio = 2025;
EXEC dbo.SP_TopSucursales_Cartera @Anio = NULL, @Top = 3;
EXEC dbo.SP_TopDestinos_Financiados @Anio = 2025, @Top = 3;
GO

PRINT '8) Validar vistas principales';

SELECT TOP (5) * FROM dbo.VW_CarteraPorSucursalAnio ORDER BY TotalValorRD DESC;
SELECT TOP (5) * FROM dbo.VW_DesembolsosVsCobrosMensual ORDER BY Periodo_Anio, Periodo_MesNumero;
SELECT TOP (5) * FROM dbo.VW_DestinosTopFinanciamiento ORDER BY TotalValoresRD DESC;
GO

