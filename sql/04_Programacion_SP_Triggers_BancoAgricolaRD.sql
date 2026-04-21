/*
    ===============================================================
    Programacion en base de datos - BancoAgricolaRD
    Stored Procedures: 6
    Triggers: auditoria, historicos y validacion
    Ejecutar despues de 02_DML_BancoAgricolaRD.sql
    ===============================================================
*/

USE BancoAgricolaRD;
GO

CREATE OR ALTER TRIGGER dbo.TR_FactDesembolsoCobro_Auditoria
ON dbo.FactDesembolsoCobro
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.AuditoriaOperacion
    (
        AuditoriaOperacion_TablaNombre,
        AuditoriaOperacion_Operacion,
        AuditoriaOperacion_RegistroID,
        AuditoriaOperacion_DatosAnteriores,
        AuditoriaOperacion_DatosNuevos
    )
    SELECT
        N'FactDesembolsoCobro',
        CASE
            WHEN i.FactDesembolsoCobro_ID IS NOT NULL AND d.FactDesembolsoCobro_ID IS NULL THEN N'INSERT'
            WHEN i.FactDesembolsoCobro_ID IS NOT NULL AND d.FactDesembolsoCobro_ID IS NOT NULL THEN N'UPDATE'
            ELSE N'DELETE'
        END,
        COALESCE(i.FactDesembolsoCobro_ID, d.FactDesembolsoCobro_ID),
        CASE WHEN d.FactDesembolsoCobro_ID IS NULL THEN NULL ELSE
            CONCAT(N'SucursalID=', d.FactDesembolsoCobro_SucursalID, N'; PeriodoID=', d.FactDesembolsoCobro_PeriodoID,
                   N'; DesembolsosRD=', d.FactDesembolsoCobro_DesembolsosRD, N'; CobrosRD=', d.FactDesembolsoCobro_CobrosRD)
        END,
        CASE WHEN i.FactDesembolsoCobro_ID IS NULL THEN NULL ELSE
            CONCAT(N'SucursalID=', i.FactDesembolsoCobro_SucursalID, N'; PeriodoID=', i.FactDesembolsoCobro_PeriodoID,
                   N'; DesembolsosRD=', i.FactDesembolsoCobro_DesembolsosRD, N'; CobrosRD=', i.FactDesembolsoCobro_CobrosRD)
        END
    FROM inserted i
    FULL OUTER JOIN deleted d
        ON d.FactDesembolsoCobro_ID = i.FactDesembolsoCobro_ID;
END;
GO

CREATE OR ALTER TRIGGER dbo.TR_FactCarteraPrestamo_Historico
ON dbo.FactCarteraPrestamo
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.CarteraPrestamoHistorico
    (
        CarteraPrestamoHistorico_FactCarteraPrestamoID,
        CarteraPrestamoHistorico_SucursalID,
        CarteraPrestamoHistorico_PeriodoID,
        CarteraPrestamoHistorico_CantidadPrestamosAnterior,
        CarteraPrestamoHistorico_ValorRDAnterior,
        CarteraPrestamoHistorico_Motivo
    )
    SELECT
        d.FactCarteraPrestamo_ID,
        d.FactCarteraPrestamo_SucursalID,
        d.FactCarteraPrestamo_PeriodoID,
        d.FactCarteraPrestamo_CantidadPrestamos,
        d.FactCarteraPrestamo_ValorRD,
        N'Valor anterior guardado automaticamente por trigger'
    FROM deleted d
    INNER JOIN inserted i ON i.FactCarteraPrestamo_ID = d.FactCarteraPrestamo_ID
    WHERE d.FactCarteraPrestamo_CantidadPrestamos <> i.FactCarteraPrestamo_CantidadPrestamos
       OR d.FactCarteraPrestamo_ValorRD <> i.FactCarteraPrestamo_ValorRD;
END;
GO

CREATE OR ALTER TRIGGER dbo.TR_FactMontoDestino_Validacion
ON dbo.FactMontoDestino
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE FactMontoDestino_Beneficiados > FactMontoDestino_Cantidad
          AND FactMontoDestino_Cantidad > 0
    )
    BEGIN
        THROW 51001, 'Validacion: los beneficiados no pueden superar la cantidad de operaciones para el destino.', 1;
    END;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_Resumen_Cartera_Por_Anio
    @Anio SMALLINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.Periodo_Anio,
           SUM(c.FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos,
           SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
    WHERE p.Periodo_Anio = @Anio
    GROUP BY p.Periodo_Anio;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_TopSucursales_Cartera
    @Anio SMALLINT = NULL,
    @Top INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@Top)
           s.Sucursal_Nombre,
           s.Sucursal_Region,
           SUM(c.FactCarteraPrestamo_ValorRD) AS TotalCarteraRD,
           SUM(c.FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
    WHERE @Anio IS NULL OR p.Periodo_Anio = @Anio
    GROUP BY s.Sucursal_Nombre, s.Sucursal_Region
    ORDER BY TotalCarteraRD DESC;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_DesembolsosCobros_PorSucursal
    @Sucursal_Nombre NVARCHAR(100),
    @Anio SMALLINT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT s.Sucursal_Nombre,
           p.Periodo_Anio,
           p.Periodo_MesNumero,
           p.Periodo_MesNombre,
           d.FactDesembolsoCobro_DesembolsosRD,
           d.FactDesembolsoCobro_CobrosRD,
           d.FactDesembolsoCobro_BalanceNetoRD
    FROM dbo.FactDesembolsoCobro d
    INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = d.FactDesembolsoCobro_SucursalID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = d.FactDesembolsoCobro_PeriodoID
    WHERE s.Sucursal_Nombre = @Sucursal_Nombre
      AND (@Anio IS NULL OR p.Periodo_Anio = @Anio)
    ORDER BY p.Periodo_Anio, p.Periodo_MesNumero;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_TopDestinos_Financiados
    @Anio SMALLINT = NULL,
    @Top INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@Top)
           de.Destino_Nombre,
           de.Destino_TipoOperacion,
           SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD,
           SUM(m.FactMontoDestino_Beneficiados) AS TotalBeneficiados
    FROM dbo.FactMontoDestino m
    INNER JOIN dbo.Destino de ON de.Destino_ID = m.FactMontoDestino_DestinoID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.FactMontoDestino_PeriodoID
    WHERE @Anio IS NULL OR p.Periodo_Anio = @Anio
    GROUP BY de.Destino_Nombre, de.Destino_TipoOperacion
    ORDER BY TotalValoresRD DESC;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_Actualizar_CarteraValor
    @Sucursal_Nombre NVARCHAR(100),
    @Anio SMALLINT,
    @MesNumero TINYINT,
    @NuevoValor_RD DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET c.FactCarteraPrestamo_ValorRD = @NuevoValor_RD
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
    WHERE s.Sucursal_Nombre = @Sucursal_Nombre
      AND p.Periodo_Anio = @Anio
      AND p.Periodo_MesNumero = @MesNumero;
END;
GO

CREATE OR ALTER PROCEDURE dbo.SP_Indicadores_Periodo
    @Anio SMALLINT,
    @MesNumero TINYINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        p.Periodo_Anio,
        p.Periodo_MesNombre,
        (SELECT SUM(FactCarteraPrestamo_ValorRD) FROM dbo.FactCarteraPrestamo c WHERE c.FactCarteraPrestamo_PeriodoID = p.Periodo_ID) AS CarteraRD,
        (SELECT SUM(FactAreaFinanciada_Tareas) FROM dbo.FactAreaFinanciada a WHERE a.FactAreaFinanciada_PeriodoID = p.Periodo_ID) AS Tareas,
        (SELECT SUM(FactDesembolsoCobro_DesembolsosRD) FROM dbo.FactDesembolsoCobro d WHERE d.FactDesembolsoCobro_PeriodoID = p.Periodo_ID) AS DesembolsosRD,
        (SELECT SUM(FactDesembolsoCobro_CobrosRD) FROM dbo.FactDesembolsoCobro d WHERE d.FactDesembolsoCobro_PeriodoID = p.Periodo_ID) AS CobrosRD,
        (SELECT SUM(FactMontoDestino_ValoresRD) FROM dbo.FactMontoDestino m WHERE m.FactMontoDestino_PeriodoID = p.Periodo_ID) AS MontoDestinosRD
    FROM dbo.Periodo p
    WHERE p.Periodo_Anio = @Anio
      AND p.Periodo_MesNumero = @MesNumero;
END;
GO

-- Pruebas sugeridas:
-- EXEC dbo.SP_Resumen_Cartera_Por_Anio @Anio = 2025;
-- EXEC dbo.SP_TopSucursales_Cartera @Anio = NULL, @Top = 10;
-- EXEC dbo.SP_TopDestinos_Financiados @Anio = 2025, @Top = 10;
