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
        Tabla_Nombre,
        Operacion,
        Registro_ID,
        Datos_Anteriores,
        Datos_Nuevos
    )
    SELECT
        N'FactDesembolsoCobro',
        CASE
            WHEN i.DesembolsoCobro_ID IS NOT NULL AND d.DesembolsoCobro_ID IS NULL THEN N'INSERT'
            WHEN i.DesembolsoCobro_ID IS NOT NULL AND d.DesembolsoCobro_ID IS NOT NULL THEN N'UPDATE'
            ELSE N'DELETE'
        END,
        COALESCE(i.DesembolsoCobro_ID, d.DesembolsoCobro_ID),
        CASE WHEN d.DesembolsoCobro_ID IS NULL THEN NULL ELSE
            CONCAT(N'Sucursal_ID=', d.Sucursal_ID, N'; Periodo_ID=', d.Periodo_ID,
                   N'; Desembolsos_RD=', d.Desembolsos_RD, N'; Cobros_RD=', d.Cobros_RD)
        END,
        CASE WHEN i.DesembolsoCobro_ID IS NULL THEN NULL ELSE
            CONCAT(N'Sucursal_ID=', i.Sucursal_ID, N'; Periodo_ID=', i.Periodo_ID,
                   N'; Desembolsos_RD=', i.Desembolsos_RD, N'; Cobros_RD=', i.Cobros_RD)
        END
    FROM inserted i
    FULL OUTER JOIN deleted d
        ON d.DesembolsoCobro_ID = i.DesembolsoCobro_ID;
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
        Cartera_ID,
        Sucursal_ID,
        Periodo_ID,
        Cantidad_Prestamos_Ant,
        Valor_RD_Ant,
        Motivo
    )
    SELECT
        d.Cartera_ID,
        d.Sucursal_ID,
        d.Periodo_ID,
        d.Cantidad_Prestamos,
        d.Valor_RD,
        N'Valor anterior guardado automaticamente por trigger'
    FROM deleted d
    INNER JOIN inserted i ON i.Cartera_ID = d.Cartera_ID
    WHERE d.Cantidad_Prestamos <> i.Cantidad_Prestamos
       OR d.Valor_RD <> i.Valor_RD;
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
        WHERE Beneficiados > Cantidad
          AND Cantidad > 0
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
           SUM(c.Cantidad_Prestamos) AS Total_Prestamos,
           SUM(c.Valor_RD) AS Total_Cartera_RD
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
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
           SUM(c.Valor_RD) AS Total_Cartera_RD,
           SUM(c.Cantidad_Prestamos) AS Total_Prestamos
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
    WHERE @Anio IS NULL OR p.Periodo_Anio = @Anio
    GROUP BY s.Sucursal_Nombre, s.Sucursal_Region
    ORDER BY Total_Cartera_RD DESC;
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
           d.Desembolsos_RD,
           d.Cobros_RD,
           d.Balance_Neto_RD
    FROM dbo.FactDesembolsoCobro d
    INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = d.Sucursal_ID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = d.Periodo_ID
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
           SUM(m.Valores_RD) AS Total_Valores_RD,
           SUM(m.Beneficiados) AS Total_Beneficiados
    FROM dbo.FactMontoDestino m
    INNER JOIN dbo.Destino de ON de.Destino_ID = m.Destino_ID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.Periodo_ID
    WHERE @Anio IS NULL OR p.Periodo_Anio = @Anio
    GROUP BY de.Destino_Nombre, de.Destino_TipoOperacion
    ORDER BY Total_Valores_RD DESC;
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
    SET c.Valor_RD = @NuevoValor_RD
    FROM dbo.FactCarteraPrestamo c
    INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
    INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
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
        (SELECT SUM(Valor_RD) FROM dbo.FactCarteraPrestamo c WHERE c.Periodo_ID = p.Periodo_ID) AS Cartera_RD,
        (SELECT SUM(Tareas) FROM dbo.FactAreaFinanciada a WHERE a.Periodo_ID = p.Periodo_ID) AS Tareas,
        (SELECT SUM(Desembolsos_RD) FROM dbo.FactDesembolsoCobro d WHERE d.Periodo_ID = p.Periodo_ID) AS Desembolsos_RD,
        (SELECT SUM(Cobros_RD) FROM dbo.FactDesembolsoCobro d WHERE d.Periodo_ID = p.Periodo_ID) AS Cobros_RD,
        (SELECT SUM(Valores_RD) FROM dbo.FactMontoDestino m WHERE m.Periodo_ID = p.Periodo_ID) AS Monto_Destinos_RD
    FROM dbo.Periodo p
    WHERE p.Periodo_Anio = @Anio
      AND p.Periodo_MesNumero = @MesNumero;
END;
GO

-- Pruebas sugeridas:
-- EXEC dbo.SP_Resumen_Cartera_Por_Anio @Anio = 2025;
-- EXEC dbo.SP_TopSucursales_Cartera @Anio = NULL, @Top = 10;
-- EXEC dbo.SP_TopDestinos_Financiados @Anio = 2025, @Top = 10;
