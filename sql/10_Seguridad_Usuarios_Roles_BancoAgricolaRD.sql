/*
    ===============================================================
    SEGURIDAD, USUARIOS Y ROLES - BancoAgricolaRD

    Objetivo:
    Crear un rol de solo lectura para consultas academicas y demos,
    sin permisos de escritura sobre las tablas.

    Nota:
    Este script usa un usuario SIN LOGIN para portabilidad academica.
    En un ambiente real se puede asociar a un LOGIN de SQL Server.
    ===============================================================
*/

USE BancoAgricolaRD;
GO

SET NOCOUNT ON;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'RolConsultaBancoAgricola')
BEGIN
    CREATE ROLE RolConsultaBancoAgricola;
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'user_consulta_bancoagricola')
BEGIN
    CREATE USER user_consulta_bancoagricola WITHOUT LOGIN;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_role_members rm
    INNER JOIN sys.database_principals r ON r.principal_id = rm.role_principal_id
    INNER JOIN sys.database_principals m ON m.principal_id = rm.member_principal_id
    WHERE r.name = N'RolConsultaBancoAgricola'
      AND m.name = N'user_consulta_bancoagricola'
)
BEGIN
    ALTER ROLE RolConsultaBancoAgricola ADD MEMBER user_consulta_bancoagricola;
END;
GO

GRANT SELECT ON dbo.Periodo TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.Sucursal TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.Destino TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.FuenteDato TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.FactCarteraPrestamo TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.FactAreaFinanciada TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.FactDesembolsoCobro TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.FactMontoDestino TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.AuditoriaOperacion TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.CarteraPrestamoHistorico TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.VW_CarteraPorSucursalAnio TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.VW_DesembolsosVsCobrosMensual TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.VW_DestinosTopFinanciamiento TO RolConsultaBancoAgricola;
GRANT SELECT ON dbo.VW_AreasFinanciadasSucursal TO RolConsultaBancoAgricola;
GO

PRINT 'Permisos asignados al rol RolConsultaBancoAgricola.';
GO

-- Prueba controlada del usuario de consulta.
EXECUTE AS USER = 'user_consulta_bancoagricola';
SELECT TOP (5) * FROM dbo.VW_CarteraPorSucursalAnio ORDER BY TotalValorRD DESC;
REVERT;
GO
