/*
    ===============================================================
    UNIVERSIDAD AUTONOMA DE SANTO DOMINGO (UASD)
    Maestria en Ciencia de Datos e Inteligencia Artificial
    Asignatura: Base de Datos I - INF-8236
    Proyecto Final - Banco Agricola de la Republica Dominicana
    Motor objetivo: Microsoft SQL Server
    Base de datos: BancoAgricolaRD
    ===============================================================
*/

USE master;
GO

IF DB_ID(N'BancoAgricolaRD') IS NOT NULL
BEGIN
    ALTER DATABASE BancoAgricolaRD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BancoAgricolaRD;
END
GO

CREATE DATABASE BancoAgricolaRD;
GO

USE BancoAgricolaRD;
GO

SET NOCOUNT ON;
GO

CREATE TABLE dbo.Periodo
(
    Periodo_ID          INT IDENTITY(1,1) NOT NULL,
    Periodo_Anio        SMALLINT NOT NULL,
    Periodo_MesNumero   TINYINT NOT NULL,
    Periodo_MesNombre   NVARCHAR(20) NOT NULL,
    Periodo_Fecha       DATE NOT NULL,
    Periodo_Estatus     NVARCHAR(15) NOT NULL CONSTRAINT DF_Periodo_Estatus DEFAULT N'Activo',
    Periodo_Observacion NVARCHAR(200) NULL,
    CONSTRAINT PK_Periodo PRIMARY KEY CLUSTERED (Periodo_ID),
    CONSTRAINT UQ_Periodo_AnioMes UNIQUE (Periodo_Anio, Periodo_MesNumero),
    CONSTRAINT CK_Periodo_Mes CHECK (Periodo_MesNumero BETWEEN 1 AND 12),
    CONSTRAINT CK_Periodo_Anio CHECK (Periodo_Anio BETWEEN 2017 AND 2026),
    CONSTRAINT CK_Periodo_Estatus CHECK (Periodo_Estatus IN (N'Activo', N'Inactivo'))
);
GO

CREATE TABLE dbo.Sucursal
(
    Sucursal_ID       INT IDENTITY(1,1) NOT NULL,
    Sucursal_Nombre   NVARCHAR(100) NOT NULL,
    Sucursal_Region   NVARCHAR(40) NOT NULL CONSTRAINT DF_Sucursal_Region DEFAULT N'Sin clasificar',
    Sucursal_Estatus  NVARCHAR(15) NOT NULL CONSTRAINT DF_Sucursal_Estatus DEFAULT N'Activo',
    CONSTRAINT PK_Sucursal PRIMARY KEY CLUSTERED (Sucursal_ID),
    CONSTRAINT UQ_Sucursal_Nombre UNIQUE (Sucursal_Nombre),
    CONSTRAINT CK_Sucursal_Region CHECK (Sucursal_Region IN
        (N'Sin clasificar', N'Metropolitana', N'Este', N'Sur', N'Cibao Norte', N'Cibao Nordeste', N'Cibao Noroeste')),
    CONSTRAINT CK_Sucursal_Estatus CHECK (Sucursal_Estatus IN (N'Activo', N'Inactivo'))
);
GO

CREATE TABLE dbo.Destino
(
    Destino_ID             INT IDENTITY(1,1) NOT NULL,
    Destino_Nombre         NVARCHAR(180) NOT NULL,
    Destino_Rubro          NVARCHAR(120) NOT NULL,
    Destino_TipoOperacion  NVARCHAR(80) NOT NULL CONSTRAINT DF_Destino_Tipo DEFAULT N'General',
    Destino_Estatus        NVARCHAR(15) NOT NULL CONSTRAINT DF_Destino_Estatus DEFAULT N'Activo',
    CONSTRAINT PK_Destino PRIMARY KEY CLUSTERED (Destino_ID),
    CONSTRAINT UQ_Destino_Nombre UNIQUE (Destino_Nombre),
    CONSTRAINT CK_Destino_Estatus CHECK (Destino_Estatus IN (N'Activo', N'Inactivo'))
);
GO

CREATE TABLE dbo.FuenteDato
(
    FuenteDato_ID          INT IDENTITY(1,1) NOT NULL,
    FuenteDato_Nombre      NVARCHAR(140) NOT NULL,
    FuenteDato_Archivo     NVARCHAR(180) NOT NULL,
    FuenteDato_Descripcion NVARCHAR(300) NOT NULL,
    FuenteDato_FechaCarga  DATETIME2(0) NOT NULL CONSTRAINT DF_FuenteDato_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FuenteDato PRIMARY KEY CLUSTERED (FuenteDato_ID),
    CONSTRAINT UQ_FuenteDato_Archivo UNIQUE (FuenteDato_Archivo)
);
GO

CREATE TABLE dbo.FactCarteraPrestamo
(
    FactCarteraPrestamo_ID          INT IDENTITY(1,1) NOT NULL,
    FactCarteraPrestamo_SucursalID         INT NOT NULL,
    FactCarteraPrestamo_PeriodoID          INT NOT NULL,
    FactCarteraPrestamo_CantidadPrestamos  INT NOT NULL,
    FactCarteraPrestamo_ValorRD            DECIMAL(18,2) NOT NULL,
    FactCarteraPrestamo_FuenteDatoID       INT NOT NULL,
    FactCarteraPrestamo_FechaCarga         DATETIME2(0) NOT NULL CONSTRAINT DF_FactCartera_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactCarteraPrestamo PRIMARY KEY CLUSTERED (FactCarteraPrestamo_ID),
    CONSTRAINT FK_FactCartera_Sucursal FOREIGN KEY (FactCarteraPrestamo_SucursalID) REFERENCES dbo.Sucursal(Sucursal_ID),
    CONSTRAINT FK_FactCartera_Periodo FOREIGN KEY (FactCarteraPrestamo_PeriodoID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactCartera_FuenteDato FOREIGN KEY (FactCarteraPrestamo_FuenteDatoID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactCartera_SucursalPeriodo UNIQUE (FactCarteraPrestamo_SucursalID, FactCarteraPrestamo_PeriodoID),
    CONSTRAINT CK_FactCartera_Cantidad CHECK (FactCarteraPrestamo_CantidadPrestamos >= 0),
    CONSTRAINT CK_FactCartera_Valor CHECK (FactCarteraPrestamo_ValorRD >= 0)
);
GO

CREATE TABLE dbo.FactAreaFinanciada
(
    FactAreaFinanciada_ID   INT IDENTITY(1,1) NOT NULL,
    FactAreaFinanciada_SucursalID         INT NOT NULL,
    FactAreaFinanciada_PeriodoID          INT NOT NULL,
    FactAreaFinanciada_Tareas              DECIMAL(18,2) NOT NULL,
    FactAreaFinanciada_CantidadPrestamos  INT NOT NULL,
    FactAreaFinanciada_ValorRD            DECIMAL(18,2) NOT NULL,
    FactAreaFinanciada_FuenteDatoID       INT NOT NULL,
    FactAreaFinanciada_FechaCarga         DATETIME2(0) NOT NULL CONSTRAINT DF_FactArea_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactAreaFinanciada PRIMARY KEY CLUSTERED (FactAreaFinanciada_ID),
    CONSTRAINT FK_FactArea_Sucursal FOREIGN KEY (FactAreaFinanciada_SucursalID) REFERENCES dbo.Sucursal(Sucursal_ID),
    CONSTRAINT FK_FactArea_Periodo FOREIGN KEY (FactAreaFinanciada_PeriodoID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactArea_FuenteDato FOREIGN KEY (FactAreaFinanciada_FuenteDatoID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactArea_SucursalPeriodo UNIQUE (FactAreaFinanciada_SucursalID, FactAreaFinanciada_PeriodoID),
    CONSTRAINT CK_FactArea_Tareas CHECK (FactAreaFinanciada_Tareas >= 0),
    CONSTRAINT CK_FactArea_Cantidad CHECK (FactAreaFinanciada_CantidadPrestamos >= 0),
    CONSTRAINT CK_FactArea_Valor CHECK (FactAreaFinanciada_ValorRD >= 0)
);
GO

CREATE TABLE dbo.FactDesembolsoCobro
(
    FactDesembolsoCobro_ID  INT IDENTITY(1,1) NOT NULL,
    FactDesembolsoCobro_SucursalID         INT NOT NULL,
    FactDesembolsoCobro_PeriodoID          INT NOT NULL,
    FactDesembolsoCobro_DesembolsosRD      DECIMAL(18,2) NOT NULL,
    FactDesembolsoCobro_CobrosRD           DECIMAL(18,2) NOT NULL,
    FactDesembolsoCobro_BalanceNetoRD     AS (FactDesembolsoCobro_DesembolsosRD - FactDesembolsoCobro_CobrosRD) PERSISTED,
    FactDesembolsoCobro_FuenteDatoID       INT NOT NULL,
    FactDesembolsoCobro_FechaCarga         DATETIME2(0) NOT NULL CONSTRAINT DF_FactDesembolso_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactDesembolsoCobro PRIMARY KEY CLUSTERED (FactDesembolsoCobro_ID),
    CONSTRAINT FK_FactDesembolso_Sucursal FOREIGN KEY (FactDesembolsoCobro_SucursalID) REFERENCES dbo.Sucursal(Sucursal_ID),
    CONSTRAINT FK_FactDesembolso_Periodo FOREIGN KEY (FactDesembolsoCobro_PeriodoID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactDesembolso_FuenteDato FOREIGN KEY (FactDesembolsoCobro_FuenteDatoID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactDesembolso_SucursalPeriodo UNIQUE (FactDesembolsoCobro_SucursalID, FactDesembolsoCobro_PeriodoID),
    CONSTRAINT CK_FactDesembolso_Desembolsos CHECK (FactDesembolsoCobro_DesembolsosRD >= 0),
    CONSTRAINT CK_FactDesembolso_Cobros CHECK (FactDesembolsoCobro_CobrosRD >= 0)
);
GO

CREATE TABLE dbo.FactMontoDestino
(
    FactMontoDestino_ID  INT IDENTITY(1,1) NOT NULL,
    FactMontoDestino_DestinoID       INT NOT NULL,
    FactMontoDestino_PeriodoID       INT NOT NULL,
    FactMontoDestino_Cantidad         INT NOT NULL,
    FactMontoDestino_ValoresRD       DECIMAL(18,2) NOT NULL,
    FactMontoDestino_Tareas           DECIMAL(18,2) NOT NULL,
    FactMontoDestino_Beneficiados     INT NOT NULL,
    FactMontoDestino_FuenteDatoID    INT NOT NULL,
    FactMontoDestino_FechaCarga      DATETIME2(0) NOT NULL CONSTRAINT DF_FactMontoDestino_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactMontoDestino PRIMARY KEY CLUSTERED (FactMontoDestino_ID),
    CONSTRAINT FK_FactMontoDestino_Destino FOREIGN KEY (FactMontoDestino_DestinoID) REFERENCES dbo.Destino(Destino_ID),
    CONSTRAINT FK_FactMontoDestino_Periodo FOREIGN KEY (FactMontoDestino_PeriodoID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactMontoDestino_FuenteDato FOREIGN KEY (FactMontoDestino_FuenteDatoID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactMontoDestino_DestinoPeriodo UNIQUE (FactMontoDestino_DestinoID, FactMontoDestino_PeriodoID),
    CONSTRAINT CK_FactMontoDestino_Cantidad CHECK (FactMontoDestino_Cantidad >= 0),
    CONSTRAINT CK_FactMontoDestino_Valores CHECK (FactMontoDestino_ValoresRD >= 0),
    CONSTRAINT CK_FactMontoDestino_Tareas CHECK (FactMontoDestino_Tareas >= 0),
    CONSTRAINT CK_FactMontoDestino_Beneficiados CHECK (FactMontoDestino_Beneficiados >= 0)
);
GO

CREATE TABLE dbo.CarteraPrestamoHistorico
(
    CarteraPrestamoHistorico_ID             INT IDENTITY(1,1) NOT NULL,
    CarteraPrestamoHistorico_FactCarteraPrestamoID               INT NOT NULL,
    CarteraPrestamoHistorico_SucursalID              INT NOT NULL,
    CarteraPrestamoHistorico_PeriodoID               INT NOT NULL,
    CarteraPrestamoHistorico_CantidadPrestamosAnterior   INT NOT NULL,
    CarteraPrestamoHistorico_ValorRDAnterior             DECIMAL(18,2) NOT NULL,
    CarteraPrestamoHistorico_Fecha          DATETIME2(0) NOT NULL CONSTRAINT DF_CarteraHistorico_Fecha DEFAULT SYSDATETIME(),
    CarteraPrestamoHistorico_Usuario        NVARCHAR(128) NOT NULL CONSTRAINT DF_CarteraHistorico_Usuario DEFAULT SUSER_SNAME(),
    CarteraPrestamoHistorico_Motivo                   NVARCHAR(250) NULL,
    CONSTRAINT PK_CarteraPrestamoHistorico PRIMARY KEY CLUSTERED (CarteraPrestamoHistorico_ID)
);
GO

CREATE TABLE dbo.AuditoriaOperacion
(
    AuditoriaOperacion_ID       INT IDENTITY(1,1) NOT NULL,
    AuditoriaOperacion_TablaNombre       NVARCHAR(120) NOT NULL,
    AuditoriaOperacion_Operacion          NVARCHAR(20) NOT NULL,
    AuditoriaOperacion_RegistroID        INT NULL,
    AuditoriaOperacion_DatosAnteriores   NVARCHAR(MAX) NULL,
    AuditoriaOperacion_DatosNuevos       NVARCHAR(MAX) NULL,
    AuditoriaOperacion_Usuario  NVARCHAR(128) NOT NULL CONSTRAINT DF_Auditoria_Usuario DEFAULT SUSER_SNAME(),
    AuditoriaOperacion_Fecha    DATETIME2(0) NOT NULL CONSTRAINT DF_Auditoria_Fecha DEFAULT SYSDATETIME(),
    CONSTRAINT PK_AuditoriaOperacion PRIMARY KEY CLUSTERED (AuditoriaOperacion_ID),
    CONSTRAINT CK_Auditoria_Operacion CHECK (AuditoriaOperacion_Operacion IN (N'INSERT', N'UPDATE', N'DELETE'))
);
GO

CREATE INDEX IX_FactCartera_Periodo ON dbo.FactCarteraPrestamo(FactCarteraPrestamo_PeriodoID) INCLUDE (FactCarteraPrestamo_ValorRD, FactCarteraPrestamo_CantidadPrestamos);
CREATE INDEX IX_FactCartera_Sucursal ON dbo.FactCarteraPrestamo(FactCarteraPrestamo_SucursalID) INCLUDE (FactCarteraPrestamo_ValorRD);
CREATE INDEX IX_FactArea_Periodo ON dbo.FactAreaFinanciada(FactAreaFinanciada_PeriodoID) INCLUDE (FactAreaFinanciada_Tareas, FactAreaFinanciada_ValorRD);
CREATE INDEX IX_FactDesembolso_Periodo ON dbo.FactDesembolsoCobro(FactDesembolsoCobro_PeriodoID) INCLUDE (FactDesembolsoCobro_DesembolsosRD, FactDesembolsoCobro_CobrosRD, FactDesembolsoCobro_BalanceNetoRD);
CREATE INDEX IX_FactMontoDestino_Periodo ON dbo.FactMontoDestino(FactMontoDestino_PeriodoID) INCLUDE (FactMontoDestino_ValoresRD, FactMontoDestino_Cantidad, FactMontoDestino_Beneficiados);
CREATE INDEX IX_Destino_Rubro ON dbo.Destino(Destino_Rubro, Destino_TipoOperacion);
GO

CREATE VIEW dbo.VW_CarteraPorSucursalAnio
AS
SELECT
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    p.Periodo_Anio,
    SUM(c.FactCarteraPrestamo_CantidadPrestamos) AS TotalPrestamos,
    SUM(c.FactCarteraPrestamo_ValorRD) AS TotalValorRD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.FactCarteraPrestamo_SucursalID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.FactCarteraPrestamo_PeriodoID
GROUP BY s.Sucursal_Nombre, s.Sucursal_Region, p.Periodo_Anio;
GO

CREATE VIEW dbo.VW_DesembolsosVsCobrosMensual
AS
SELECT
    p.Periodo_Anio,
    p.Periodo_MesNumero,
    p.Periodo_MesNombre,
    SUM(d.FactDesembolsoCobro_DesembolsosRD) AS TotalDesembolsosRD,
    SUM(d.FactDesembolsoCobro_CobrosRD) AS TotalCobrosRD,
    SUM(d.FactDesembolsoCobro_BalanceNetoRD) AS BalanceNetoRD
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Periodo p ON p.Periodo_ID = d.FactDesembolsoCobro_PeriodoID
GROUP BY p.Periodo_Anio, p.Periodo_MesNumero, p.Periodo_MesNombre;
GO

CREATE VIEW dbo.VW_DestinosTopFinanciamiento
AS
SELECT
    d.Destino_Nombre,
    d.Destino_Rubro,
    d.Destino_TipoOperacion,
    p.Periodo_Anio,
    SUM(m.FactMontoDestino_ValoresRD) AS TotalValoresRD,
    SUM(m.FactMontoDestino_Cantidad) AS TotalOperaciones,
    SUM(m.FactMontoDestino_Beneficiados) AS TotalBeneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.FactMontoDestino_DestinoID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.FactMontoDestino_PeriodoID
GROUP BY d.Destino_Nombre, d.Destino_Rubro, d.Destino_TipoOperacion, p.Periodo_Anio;
GO

CREATE VIEW dbo.VW_AreasFinanciadasSucursal
AS
SELECT
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    p.Periodo_Anio,
    SUM(a.FactAreaFinanciada_Tareas) AS TotalTareas,
    SUM(a.FactAreaFinanciada_CantidadPrestamos) AS TotalPrestamos,
    SUM(a.FactAreaFinanciada_ValorRD) AS TotalValorRD
FROM dbo.FactAreaFinanciada a
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = a.FactAreaFinanciada_SucursalID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = a.FactAreaFinanciada_PeriodoID
GROUP BY s.Sucursal_Nombre, s.Sucursal_Region, p.Periodo_Anio;
GO
