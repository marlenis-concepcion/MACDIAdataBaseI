/*
    ===============================================================
    VERIFICACION PARA DEMO - BancoAgricolaRD
    Ejecutar despues del script maestro o despues de:
    01_DDL + 02_DML + 04_Programacion + 03_DQL

    Objetivo:
    Confirmar rapidamente que las tablas NO estan vacias y que los
    datos del Banco Agricola fueron cargados correctamente.
    ===============================================================
*/

USE BancoAgricolaRD;
GO

SET NOCOUNT ON;
GO

PRINT '1) Conteo de registros por tabla principal';

SELECT 'Periodo' AS Tabla, COUNT(*) AS Registros FROM dbo.Periodo
UNION ALL
SELECT 'Sucursal', COUNT(*) FROM dbo.Sucursal
UNION ALL
SELECT 'Destino', COUNT(*) FROM dbo.Destino
UNION ALL
SELECT 'FuenteDato', COUNT(*) FROM dbo.FuenteDato
UNION ALL
SELECT 'FactCarteraPrestamo', COUNT(*) FROM dbo.FactCarteraPrestamo
UNION ALL
SELECT 'FactAreaFinanciada', COUNT(*) FROM dbo.FactAreaFinanciada
UNION ALL
SELECT 'FactDesembolsoCobro', COUNT(*) FROM dbo.FactDesembolsoCobro
UNION ALL
SELECT 'FactMontoDestino', COUNT(*) FROM dbo.FactMontoDestino
UNION ALL
SELECT 'AuditoriaOperacion', COUNT(*) FROM dbo.AuditoriaOperacion
UNION ALL
SELECT 'CarteraPrestamoHistorico', COUNT(*) FROM dbo.CarteraPrestamoHistorico;
GO

PRINT '2) Totales generales cargados';

SELECT
    (SELECT COUNT(*) FROM dbo.Sucursal) AS TotalSucursales,
    (SELECT COUNT(*) FROM dbo.Destino) AS TotalDestinos,
    (SELECT COUNT(*) FROM dbo.Periodo) AS TotalPeriodos,
    (SELECT COUNT(*) FROM dbo.FactCarteraPrestamo) AS RegistrosCartera,
    (SELECT COUNT(*) FROM dbo.FactAreaFinanciada) AS RegistrosAreas,
    (SELECT COUNT(*) FROM dbo.FactDesembolsoCobro) AS RegistrosDesembolsosCobros,
    (SELECT COUNT(*) FROM dbo.FactMontoDestino) AS RegistrosMontosDestino,
    (SELECT SUM(FactCarteraPrestamo_ValorRD) FROM dbo.FactCarteraPrestamo) AS TotalCarteraRD,
    (SELECT SUM(FactMontoDestino_ValoresRD) FROM dbo.FactMontoDestino) AS TotalMontosDestinoRD;
GO

PRINT '3) Top 10 sucursales por cartera';

SELECT TOP (10)
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
    SUM(c.FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s
    ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
GROUP BY s.Sucursal_Nombre, s.Sucursal_Region
ORDER BY TotalCarteraRD DESC;
GO

PRINT '4) Top 10 destinos por monto otorgado';

SELECT TOP (10)
    d.Destino_Nombre,
    d.Destino_Rubro,
    d.Destino_TipoOperacion,
    SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD,
    SUM(m.FactMontoDestino_Beneficiados) AS TotalBeneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d
    ON d.Destino_ID = m.FactMontoDestino_DestinoID
GROUP BY d.Destino_Nombre, d.Destino_Rubro, d.Destino_TipoOperacion
ORDER BY TotalValoresRD DESC;
GO

PRINT '5) Cartera anual';

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

PRINT '6) Desembolsos vs cobros por anio';

SELECT
    p.Periodo_Anio,
    SUM(d.FactDesembolsoCobro_DesembolsosRD) AS TotalDesembolsosRD,
    SUM(d.FactDesembolsoCobro_CobrosRD) AS TotalCobrosRD,
    SUM(d.FactDesembolsoCobro_BalanceNetoRD) AS BalanceNetoRD
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Periodo p
    ON p.Periodo_ID = d.FactDesembolsoCobro_PeriodoID
GROUP BY p.Periodo_Anio
ORDER BY p.Periodo_Anio;
GO

PRINT '7) Prueba de stored procedure';

EXEC dbo.SP_TopSucursales_Cartera @Anio = NULL, @Top = 5;
GO

PRINT '8) Prueba de vista';

SELECT TOP (10)
    *
FROM dbo.VW_CarteraPorSucursalAnio
ORDER BY TotalValorRD DESC;
GO
