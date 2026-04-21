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
    Cartera_ID          INT IDENTITY(1,1) NOT NULL,
    Sucursal_ID         INT NOT NULL,
    Periodo_ID          INT NOT NULL,
    Cantidad_Prestamos  INT NOT NULL,
    Valor_RD            DECIMAL(18,2) NOT NULL,
    FuenteDato_ID       INT NOT NULL,
    Fecha_Carga         DATETIME2(0) NOT NULL CONSTRAINT DF_FactCartera_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactCarteraPrestamo PRIMARY KEY CLUSTERED (Cartera_ID),
    CONSTRAINT FK_FactCartera_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES dbo.Sucursal(Sucursal_ID),
    CONSTRAINT FK_FactCartera_Periodo FOREIGN KEY (Periodo_ID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactCartera_FuenteDato FOREIGN KEY (FuenteDato_ID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactCartera_SucursalPeriodo UNIQUE (Sucursal_ID, Periodo_ID),
    CONSTRAINT CK_FactCartera_Cantidad CHECK (Cantidad_Prestamos >= 0),
    CONSTRAINT CK_FactCartera_Valor CHECK (Valor_RD >= 0)
);
GO

CREATE TABLE dbo.FactAreaFinanciada
(
    AreaFinanciada_ID   INT IDENTITY(1,1) NOT NULL,
    Sucursal_ID         INT NOT NULL,
    Periodo_ID          INT NOT NULL,
    Tareas              DECIMAL(18,2) NOT NULL,
    Cantidad_Prestamos  INT NOT NULL,
    Valor_RD            DECIMAL(18,2) NOT NULL,
    FuenteDato_ID       INT NOT NULL,
    Fecha_Carga         DATETIME2(0) NOT NULL CONSTRAINT DF_FactArea_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactAreaFinanciada PRIMARY KEY CLUSTERED (AreaFinanciada_ID),
    CONSTRAINT FK_FactArea_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES dbo.Sucursal(Sucursal_ID),
    CONSTRAINT FK_FactArea_Periodo FOREIGN KEY (Periodo_ID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactArea_FuenteDato FOREIGN KEY (FuenteDato_ID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactArea_SucursalPeriodo UNIQUE (Sucursal_ID, Periodo_ID),
    CONSTRAINT CK_FactArea_Tareas CHECK (Tareas >= 0),
    CONSTRAINT CK_FactArea_Cantidad CHECK (Cantidad_Prestamos >= 0),
    CONSTRAINT CK_FactArea_Valor CHECK (Valor_RD >= 0)
);
GO

CREATE TABLE dbo.FactDesembolsoCobro
(
    DesembolsoCobro_ID  INT IDENTITY(1,1) NOT NULL,
    Sucursal_ID         INT NOT NULL,
    Periodo_ID          INT NOT NULL,
    Desembolsos_RD      DECIMAL(18,2) NOT NULL,
    Cobros_RD           DECIMAL(18,2) NOT NULL,
    Balance_Neto_RD     AS (Desembolsos_RD - Cobros_RD) PERSISTED,
    FuenteDato_ID       INT NOT NULL,
    Fecha_Carga         DATETIME2(0) NOT NULL CONSTRAINT DF_FactDesembolso_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactDesembolsoCobro PRIMARY KEY CLUSTERED (DesembolsoCobro_ID),
    CONSTRAINT FK_FactDesembolso_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES dbo.Sucursal(Sucursal_ID),
    CONSTRAINT FK_FactDesembolso_Periodo FOREIGN KEY (Periodo_ID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactDesembolso_FuenteDato FOREIGN KEY (FuenteDato_ID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactDesembolso_SucursalPeriodo UNIQUE (Sucursal_ID, Periodo_ID),
    CONSTRAINT CK_FactDesembolso_Desembolsos CHECK (Desembolsos_RD >= 0),
    CONSTRAINT CK_FactDesembolso_Cobros CHECK (Cobros_RD >= 0)
);
GO

CREATE TABLE dbo.FactMontoDestino
(
    MontoDestino_ID  INT IDENTITY(1,1) NOT NULL,
    Destino_ID       INT NOT NULL,
    Periodo_ID       INT NOT NULL,
    Cantidad         INT NOT NULL,
    Valores_RD       DECIMAL(18,2) NOT NULL,
    Tareas           DECIMAL(18,2) NOT NULL,
    Beneficiados     INT NOT NULL,
    FuenteDato_ID    INT NOT NULL,
    Fecha_Carga      DATETIME2(0) NOT NULL CONSTRAINT DF_FactMontoDestino_FechaCarga DEFAULT SYSDATETIME(),
    CONSTRAINT PK_FactMontoDestino PRIMARY KEY CLUSTERED (MontoDestino_ID),
    CONSTRAINT FK_FactMontoDestino_Destino FOREIGN KEY (Destino_ID) REFERENCES dbo.Destino(Destino_ID),
    CONSTRAINT FK_FactMontoDestino_Periodo FOREIGN KEY (Periodo_ID) REFERENCES dbo.Periodo(Periodo_ID),
    CONSTRAINT FK_FactMontoDestino_FuenteDato FOREIGN KEY (FuenteDato_ID) REFERENCES dbo.FuenteDato(FuenteDato_ID),
    CONSTRAINT UQ_FactMontoDestino_DestinoPeriodo UNIQUE (Destino_ID, Periodo_ID),
    CONSTRAINT CK_FactMontoDestino_Cantidad CHECK (Cantidad >= 0),
    CONSTRAINT CK_FactMontoDestino_Valores CHECK (Valores_RD >= 0),
    CONSTRAINT CK_FactMontoDestino_Tareas CHECK (Tareas >= 0),
    CONSTRAINT CK_FactMontoDestino_Beneficiados CHECK (Beneficiados >= 0)
);
GO

CREATE TABLE dbo.CarteraPrestamoHistorico
(
    Historico_ID             INT IDENTITY(1,1) NOT NULL,
    Cartera_ID               INT NOT NULL,
    Sucursal_ID              INT NOT NULL,
    Periodo_ID               INT NOT NULL,
    Cantidad_Prestamos_Ant   INT NOT NULL,
    Valor_RD_Ant             DECIMAL(18,2) NOT NULL,
    Fecha_Historico          DATETIME2(0) NOT NULL CONSTRAINT DF_CarteraHistorico_Fecha DEFAULT SYSDATETIME(),
    Usuario_Historico        NVARCHAR(128) NOT NULL CONSTRAINT DF_CarteraHistorico_Usuario DEFAULT SUSER_SNAME(),
    Motivo                   NVARCHAR(250) NULL,
    CONSTRAINT PK_CarteraPrestamoHistorico PRIMARY KEY CLUSTERED (Historico_ID)
);
GO

CREATE TABLE dbo.AuditoriaOperacion
(
    Auditoria_ID       INT IDENTITY(1,1) NOT NULL,
    Tabla_Nombre       NVARCHAR(120) NOT NULL,
    Operacion          NVARCHAR(20) NOT NULL,
    Registro_ID        INT NULL,
    Datos_Anteriores   NVARCHAR(MAX) NULL,
    Datos_Nuevos       NVARCHAR(MAX) NULL,
    Usuario_Operacion  NVARCHAR(128) NOT NULL CONSTRAINT DF_Auditoria_Usuario DEFAULT SUSER_SNAME(),
    Fecha_Operacion    DATETIME2(0) NOT NULL CONSTRAINT DF_Auditoria_Fecha DEFAULT SYSDATETIME(),
    CONSTRAINT PK_AuditoriaOperacion PRIMARY KEY CLUSTERED (Auditoria_ID),
    CONSTRAINT CK_Auditoria_Operacion CHECK (Operacion IN (N'INSERT', N'UPDATE', N'DELETE'))
);
GO

CREATE INDEX IX_FactCartera_Periodo ON dbo.FactCarteraPrestamo(Periodo_ID) INCLUDE (Valor_RD, Cantidad_Prestamos);
CREATE INDEX IX_FactCartera_Sucursal ON dbo.FactCarteraPrestamo(Sucursal_ID) INCLUDE (Valor_RD);
CREATE INDEX IX_FactArea_Periodo ON dbo.FactAreaFinanciada(Periodo_ID) INCLUDE (Tareas, Valor_RD);
CREATE INDEX IX_FactDesembolso_Periodo ON dbo.FactDesembolsoCobro(Periodo_ID) INCLUDE (Desembolsos_RD, Cobros_RD, Balance_Neto_RD);
CREATE INDEX IX_FactMontoDestino_Periodo ON dbo.FactMontoDestino(Periodo_ID) INCLUDE (Valores_RD, Cantidad, Beneficiados);
CREATE INDEX IX_Destino_Rubro ON dbo.Destino(Destino_Rubro, Destino_TipoOperacion);
GO

CREATE VIEW dbo.VW_CarteraPorSucursalAnio
AS
SELECT
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    p.Periodo_Anio,
    SUM(c.Cantidad_Prestamos) AS Total_Prestamos,
    SUM(c.Valor_RD) AS Total_Valor_RD
FROM dbo.FactCarteraPrestamo c
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = c.Sucursal_ID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = c.Periodo_ID
GROUP BY s.Sucursal_Nombre, s.Sucursal_Region, p.Periodo_Anio;
GO

CREATE VIEW dbo.VW_DesembolsosVsCobrosMensual
AS
SELECT
    p.Periodo_Anio,
    p.Periodo_MesNumero,
    p.Periodo_MesNombre,
    SUM(d.Desembolsos_RD) AS Total_Desembolsos_RD,
    SUM(d.Cobros_RD) AS Total_Cobros_RD,
    SUM(d.Balance_Neto_RD) AS Balance_Neto_RD
FROM dbo.FactDesembolsoCobro d
INNER JOIN dbo.Periodo p ON p.Periodo_ID = d.Periodo_ID
GROUP BY p.Periodo_Anio, p.Periodo_MesNumero, p.Periodo_MesNombre;
GO

CREATE VIEW dbo.VW_DestinosTopFinanciamiento
AS
SELECT
    d.Destino_Nombre,
    d.Destino_Rubro,
    d.Destino_TipoOperacion,
    p.Periodo_Anio,
    SUM(m.Valores_RD) AS Total_Valores_RD,
    SUM(m.Cantidad) AS Total_Operaciones,
    SUM(m.Beneficiados) AS Total_Beneficiados
FROM dbo.FactMontoDestino m
INNER JOIN dbo.Destino d ON d.Destino_ID = m.Destino_ID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = m.Periodo_ID
GROUP BY d.Destino_Nombre, d.Destino_Rubro, d.Destino_TipoOperacion, p.Periodo_Anio;
GO

CREATE VIEW dbo.VW_AreasFinanciadasSucursal
AS
SELECT
    s.Sucursal_Nombre,
    s.Sucursal_Region,
    p.Periodo_Anio,
    SUM(a.Tareas) AS Total_Tareas,
    SUM(a.Cantidad_Prestamos) AS Total_Prestamos,
    SUM(a.Valor_RD) AS Total_Valor_RD
FROM dbo.FactAreaFinanciada a
INNER JOIN dbo.Sucursal s ON s.Sucursal_ID = a.Sucursal_ID
INNER JOIN dbo.Periodo p ON p.Periodo_ID = a.Periodo_ID
GROUP BY s.Sucursal_Nombre, s.Sucursal_Region, p.Periodo_Anio;
GO
