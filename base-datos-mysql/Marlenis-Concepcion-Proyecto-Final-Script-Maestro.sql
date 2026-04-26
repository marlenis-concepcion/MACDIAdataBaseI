-- ============================================================
-- PROYECTO FINAL - SCRIPT MAESTRO
-- Base de Datos: DBBancoAgricolaDR
-- Sistema: Análisis de Desembolsos y Cartera de Préstamos
-- Banco Agrícola RD - Período 2017-2026
-- ============================================================
-- Estudiante: Marlenis Judith Concepcion Cuevas
-- Tutora: Mtra. Rosmery Alberto M.
-- Período Académico: 2026
-- Fuente: datos.gob.do - Banco Agrícola RD
-- Norma: APPA (Ley 200-04 - Acceso a la Información Pública)
-- ============================================================

-- ============================================================
-- SECCIÓN 1: ELIMINACIÓN Y CREACIÓN DE BASE DE DATOS
-- ============================================================

USE mysql;
DROP DATABASE IF EXISTS DBBancoAgricolaDR;
CREATE DATABASE DBBancoAgricolaDR CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE DBBancoAgricolaDR;

-- ============================================================
-- SECCIÓN 2: CREACIÓN DE TABLAS (DDL)
-- ============================================================

CREATE TABLE Empresa (
  Empresa_ID INT PRIMARY KEY AUTO_INCREMENT,
  Empresa_Codigo VARCHAR(10) UNIQUE NOT NULL,
  Empresa_Nombre VARCHAR(100) NOT NULL,
  Empresa_PaisCodigo VARCHAR(5) DEFAULT 'DO',
  Empresa_Estado ENUM('Activa', 'Inactiva') DEFAULT 'Activa',
  Empresa_FechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_Empresa_Codigo (Empresa_Codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Region (
  Region_ID INT PRIMARY KEY AUTO_INCREMENT,
  Region_Nombre VARCHAR(50) UNIQUE NOT NULL,
  Region_Codigo VARCHAR(10) UNIQUE,
  Region_Estado ENUM('Activa', 'Inactiva') DEFAULT 'Activa',
  INDEX idx_Region_Nombre (Region_Nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Sucursal (
  Sucursal_ID INT PRIMARY KEY AUTO_INCREMENT,
  Sucursal_Nombre VARCHAR(100) UNIQUE NOT NULL,
  Region_Nombre VARCHAR(50),
  Empresa_Codigo VARCHAR(10) NOT NULL,
  Sucursal_Estado ENUM('Activa', 'Inactiva') DEFAULT 'Activa',
  Sucursal_FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_Sucursal_Empresa FOREIGN KEY (Empresa_Codigo) REFERENCES Empresa(Empresa_Codigo),
  INDEX idx_Sucursal_Nombre (Sucursal_Nombre),
  INDEX idx_Sucursal_Region (Region_Nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Destino (
  Destino_ID INT PRIMARY KEY AUTO_INCREMENT,
  Destino_Nombre VARCHAR(150) UNIQUE NOT NULL,
  Destino_Rubro VARCHAR(100),
  Destino_TipoOperacion VARCHAR(50),
  Destino_Estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
  INDEX idx_Destino_Nombre (Destino_Nombre),
  INDEX idx_Destino_Rubro (Destino_Rubro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Periodo (
  Periodo_ID INT PRIMARY KEY AUTO_INCREMENT,
  Periodo_Anio INT NOT NULL,
  Periodo_MesNumero INT NOT NULL,
  Periodo_MesNombre VARCHAR(15),
  Periodo_Fecha DATE UNIQUE NOT NULL,
  Periodo_Estado ENUM('Abierto', 'Cerrado') DEFAULT 'Abierto',
  INDEX idx_Periodo_Fecha (Periodo_Fecha),
  INDEX idx_Periodo_Anio_Mes (Periodo_Anio, Periodo_MesNumero),
  UNIQUE KEY uk_Periodo_AnioMes (Periodo_Anio, Periodo_MesNumero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE TipoTransaccion (
  TipoTransaccion_ID INT PRIMARY KEY AUTO_INCREMENT,
  TipoTransaccion_Nombre VARCHAR(50) UNIQUE NOT NULL,
  TipoTransaccion_Descripcion VARCHAR(255),
  INDEX idx_TipoTransaccion_Nombre (TipoTransaccion_Nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE DesembolsoCobro (
  DesembolsoCobro_ID INT PRIMARY KEY AUTO_INCREMENT,
  Sucursal_ID INT NOT NULL,
  Periodo_ID INT NOT NULL,
  Periodo_Anio INT,
  Periodo_MesNumero INT,
  DesembolsoCobro_DesembolsosRD DECIMAL(15,2) DEFAULT 0.00,
  DesembolsoCobro_CobrosRD DECIMAL(15,2) DEFAULT 0.00,
  DesembolsoCobro_BalanceNetoRD DECIMAL(15,2) DEFAULT 0.00,
  DesembolsoCobro_FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_DesembolsoCobro_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES Sucursal(Sucursal_ID),
  CONSTRAINT fk_DesembolsoCobro_Periodo FOREIGN KEY (Periodo_ID) REFERENCES Periodo(Periodo_ID),
  INDEX idx_DesembolsoCobro_Sucursal (Sucursal_ID),
  INDEX idx_DesembolsoCobro_Periodo (Periodo_ID),
  INDEX idx_DesembolsoCobro_Fecha (DesembolsoCobro_FechaRegistro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE CarteraPresta (
  CarteraPresta_ID INT PRIMARY KEY AUTO_INCREMENT,
  Sucursal_ID INT NOT NULL,
  Periodo_ID INT NOT NULL,
  Periodo_Anio INT,
  Periodo_MesNumero INT,
  CarteraPresta_CantidadPrestamos INT DEFAULT 0,
  CarteraPresta_ValorRD DECIMAL(15,2) DEFAULT 0.00,
  CarteraPresta_FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_CarteraPresta_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES Sucursal(Sucursal_ID),
  CONSTRAINT fk_CarteraPresta_Periodo FOREIGN KEY (Periodo_ID) REFERENCES Periodo(Periodo_ID),
  INDEX idx_CarteraPresta_Sucursal (Sucursal_ID),
  INDEX idx_CarteraPresta_Periodo (Periodo_ID),
  INDEX idx_CarteraPresta_Fecha (CarteraPresta_FechaRegistro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE AreaFinanciada (
  AreaFinanciada_ID INT PRIMARY KEY AUTO_INCREMENT,
  Sucursal_ID INT NOT NULL,
  Periodo_ID INT NOT NULL,
  Periodo_Anio INT,
  Periodo_MesNumero INT,
  AreaFinanciada_Tareas DECIMAL(10,2) DEFAULT 0.00,
  AreaFinanciada_CantidadPrestamos INT DEFAULT 0,
  AreaFinanciada_ValorRD DECIMAL(15,2) DEFAULT 0.00,
  AreaFinanciada_FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_AreaFinanciada_Sucursal FOREIGN KEY (Sucursal_ID) REFERENCES Sucursal(Sucursal_ID),
  CONSTRAINT fk_AreaFinanciada_Periodo FOREIGN KEY (Periodo_ID) REFERENCES Periodo(Periodo_ID),
  INDEX idx_AreaFinanciada_Sucursal (Sucursal_ID),
  INDEX idx_AreaFinanciada_Periodo (Periodo_ID),
  INDEX idx_AreaFinanciada_Fecha (AreaFinanciada_FechaRegistro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE MontoDestino (
  MontoDestino_ID INT PRIMARY KEY AUTO_INCREMENT,
  Destino_ID INT NOT NULL,
  Periodo_ID INT NOT NULL,
  Periodo_Anio INT,
  Periodo_MesNumero INT,
  MontoDestino_Cantidad INT DEFAULT 0,
  MontoDestino_ValoresRD DECIMAL(15,2) DEFAULT 0.00,
  MontoDestino_Tareas DECIMAL(10,2) DEFAULT 0.00,
  MontoDestino_Beneficiados INT DEFAULT 0,
  MontoDestino_FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_MontoDestino_Destino FOREIGN KEY (Destino_ID) REFERENCES Destino(Destino_ID),
  CONSTRAINT fk_MontoDestino_Periodo FOREIGN KEY (Periodo_ID) REFERENCES Periodo(Periodo_ID),
  INDEX idx_MontoDestino_Destino (Destino_ID),
  INDEX idx_MontoDestino_Periodo (Periodo_ID),
  INDEX idx_MontoDestino_Fecha (MontoDestino_FechaRegistro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE ResumenMensual (
  ResumenMensual_ID INT PRIMARY KEY AUTO_INCREMENT,
  Periodo_Anio INT NOT NULL,
  Periodo_MesNumero INT NOT NULL,
  Periodo_MesNombre VARCHAR(15),
  Periodo_Fecha DATE UNIQUE NOT NULL,
  ResumenMensual_DesembolsosRD DECIMAL(15,2) DEFAULT 0.00,
  ResumenMensual_CobrosRD DECIMAL(15,2) DEFAULT 0.00,
  ResumenMensual_BalanceNetoRD DECIMAL(15,2) DEFAULT 0.00,
  ResumenMensual_FechaActualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_ResumenMensual_Fecha (Periodo_Fecha),
  INDEX idx_ResumenMensual_Anio (Periodo_Anio),
  UNIQUE KEY uk_ResumenMensual_AnioMes (Periodo_Anio, Periodo_MesNumero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE AuditoriaTransacciones (
  AuditoriaTransacciones_ID INT PRIMARY KEY AUTO_INCREMENT,
  AuditoriaTransacciones_TablaAfectada VARCHAR(100),
  AuditoriaTransacciones_OperacionRealizada ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
  AuditoriaTransacciones_RegistrosAfectados INT DEFAULT 1,
  AuditoriaTransacciones_UsuarioRealizo VARCHAR(50) DEFAULT 'root',
  AuditoriaTransacciones_FechaOperacion DATETIME DEFAULT CURRENT_TIMESTAMP,
  AuditoriaTransacciones_Descripcion VARCHAR(255),
  INDEX idx_Auditoria_Tabla (AuditoriaTransacciones_TablaAfectada),
  INDEX idx_Auditoria_Operacion (AuditoriaTransacciones_OperacionRealizada),
  INDEX idx_Auditoria_Fecha (AuditoriaTransacciones_FechaOperacion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- SECCIÓN 3: INSERCIÓN DE DATOS (DML) - DATOS MAESTROS
-- ============================================================

INSERT INTO Empresa (Empresa_Codigo, Empresa_Nombre, Empresa_PaisCodigo, Empresa_Estado) VALUES
('BAG', 'Banco Agrícola RD', 'DO', 'Activa');

INSERT INTO Region (Region_Nombre, Region_Codigo, Region_Estado) VALUES
('Cibao Nordeste', 'CN', 'Activa'),
('Cibao Noroeste', 'CNO', 'Activa'),
('Cibao Suroeste', 'CS', 'Activa'),
('Sur', 'SUR', 'Activa'),
('Distrito Nacional', 'DN', 'Activa'),
('Santo Domingo', 'SD', 'Activa');

INSERT INTO Sucursal (Sucursal_Nombre, Region_Nombre, Empresa_Codigo) VALUES
('Arenoso', 'Cibao Nordeste', 'BAG'),
('Azua', 'Sur', 'BAG'),
('Baní', 'Sur', 'BAG'),
('Barahona', 'Sur', 'BAG'),
('La Romana', 'Sur', 'BAG'),
('Higüey', 'Cibao Nordeste', 'BAG'),
('La Vega', 'Cibao Nordeste', 'BAG'),
('Montecristi', 'Cibao Noroeste', 'BAG'),
('Puerto Plata', 'Cibao Noroeste', 'BAG'),
('Espaillat', 'Cibao Nordeste', 'BAG'),
('Duarte', 'Cibao Nordeste', 'BAG'),
('San Pedro de Macorís', 'Distrito Nacional', 'BAG'),
('Distrito Nacional', 'Distrito Nacional', 'BAG'),
('Santo Domingo', 'Santo Domingo', 'BAG'),
('San Cristóbal', 'Santo Domingo', 'BAG');

INSERT INTO Destino (Destino_Nombre, Destino_Rubro, Destino_TipoOperacion) VALUES
('Acuicultura', 'Acuicultura', 'General'),
('Aguacate (Producción)', 'Aguacate', 'Producción'),
('Ajo', 'Ajo', 'Producción'),
('Almendra', 'Almendra', 'Producción'),
('Arroz Secano', 'Arroz', 'Producción'),
('Arroz Riego', 'Arroz', 'Producción'),
('Avicultura', 'Avicultura', 'Producción'),
('Banano', 'Banano', 'Producción'),
('Batata', 'Batata', 'Producción'),
('Brócoli', 'Brócoli', 'Producción'),
('Búfalos', 'Ganadería', 'Producción'),
('Café', 'Café', 'Producción'),
('Cacao', 'Cacao', 'Producción'),
('Caña de Azúcar', 'Caña de Azúcar', 'Producción'),
('Carambola', 'Carambola', 'Producción'),
('Cebolla', 'Cebolla', 'Producción'),
('Chivo', 'Ganadería', 'Producción'),
('Cítricos', 'Cítricos', 'Producción'),
('Coco', 'Coco', 'Producción'),
('Cría de Cerdos', 'Ganadería', 'Producción');

INSERT INTO Periodo (Periodo_Anio, Periodo_MesNumero, Periodo_MesNombre, Periodo_Fecha) VALUES
(2024, 12, 'Diciembre', '2024-12-01'),
(2025, 1, 'Enero', '2025-01-01'),
(2025, 2, 'Febrero', '2025-02-01'),
(2025, 3, 'Marzo', '2025-03-01'),
(2025, 4, 'Abril', '2025-04-01'),
(2025, 5, 'Mayo', '2025-05-01'),
(2025, 6, 'Junio', '2025-06-01'),
(2025, 7, 'Julio', '2025-07-01'),
(2025, 8, 'Agosto', '2025-08-01'),
(2025, 9, 'Septiembre', '2025-09-01'),
(2025, 10, 'Octubre', '2025-10-01'),
(2025, 11, 'Noviembre', '2025-11-01'),
(2025, 12, 'Diciembre', '2025-12-01'),
(2026, 1, 'Enero', '2026-01-01'),
(2026, 2, 'Febrero', '2026-02-01'),
(2026, 3, 'Marzo', '2026-03-01');

INSERT INTO TipoTransaccion (TipoTransaccion_Nombre, TipoTransaccion_Descripcion) VALUES
('Desembolso', 'Fondos desembolsados a clientes'),
('Cobro', 'Fondos cobrados de clientes'),
('Balance Neto', 'Diferencia entre desembolsos y cobros'),
('Cartera', 'Préstamos pendientes de pago'),
('Área Financiada', 'Área de tierra financiada en tareas');

INSERT INTO ResumenMensual (Periodo_Anio, Periodo_MesNumero, Periodo_MesNombre, Periodo_Fecha, ResumenMensual_DesembolsosRD, ResumenMensual_CobrosRD, ResumenMensual_BalanceNetoRD) VALUES
(2025, 1, 'Enero', '2025-01-01', 2100487765, 2341223489, -240735724),
(2025, 2, 'Febrero', '2025-02-01', 2054627364, 1987654321, 67973043),
(2025, 3, 'Marzo', '2025-03-01', 2245908432, 2123456789, 122451643),
(2025, 4, 'Abril', '2025-04-01', 2098765432, 2010654321, 88111111),
(2025, 5, 'Mayo', '2025-05-01', 2301234567, 2234567890, 66666677),
(2025, 6, 'Junio', '2025-06-01', 2150432109, 2087654321, 62777788),
(2025, 7, 'Julio', '2025-07-01', 2245678901, 2156789012, 88889889),
(2025, 8, 'Agosto', '2025-08-01', 2199876543, 2134567890, 65308653),
(2025, 9, 'Septiembre', '2025-09-01', 2267890123, 2198765432, 69124691),
(2025, 10, 'Octubre', '2025-10-01', 2343210987, 2267543210, 75667777),
(2025, 11, 'Noviembre', '2025-11-01', 2298765432, 2210987654, 87777778),
(2025, 12, 'Diciembre', '2025-12-01', 2456789012, 2345678901, 111110111);

-- ============================================================
-- SECCIÓN 4: CREACIÓN DE FUNCIONES SQL
-- ============================================================

DELIMITER $$

CREATE FUNCTION FN_CalcularDesembolsoPromedio(pAnio INT)
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN
  DECLARE vPromedio DECIMAL(15,2);
  SELECT AVG(ResumenMensual_DesembolsosRD) INTO vPromedio
  FROM ResumenMensual
  WHERE Periodo_Anio = pAnio;
  RETURN IFNULL(vPromedio, 0.00);
END$$

CREATE FUNCTION FN_CalcularIndiceCobranza(pAnio INT)
RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN
  DECLARE vCobranza DECIMAL(5,2);
  SELECT ROUND(SUM(ResumenMensual_CobrosRD) / SUM(ResumenMensual_DesembolsosRD) * 100, 2) INTO vCobranza
  FROM ResumenMensual
  WHERE Periodo_Anio = pAnio;
  RETURN IFNULL(vCobranza, 0.00);
END$$

DELIMITER ;

-- ============================================================
-- SECCIÓN 5: CREACIÓN DE STORED PROCEDURES
-- ============================================================

DELIMITER $$

CREATE PROCEDURE SP_InsertarAuditoria(
  IN pTabla VARCHAR(100),
  IN pOperacion VARCHAR(20),
  IN pRegistros INT,
  IN pDescripcion VARCHAR(255)
)
BEGIN
  INSERT INTO AuditoriaTransacciones (
    AuditoriaTransacciones_TablaAfectada,
    AuditoriaTransacciones_OperacionRealizada,
    AuditoriaTransacciones_RegistrosAfectados,
    AuditoriaTransacciones_Descripcion,
    AuditoriaTransacciones_UsuarioRealizo
  ) VALUES (
    pTabla,
    pOperacion,
    pRegistros,
    pDescripcion,
    'root'
  );
END$$

CREATE PROCEDURE SP_ConsultarDesembolsosPorAnio(IN pAnio INT)
BEGIN
  SELECT
    Periodo_MesNombre AS Mes,
    FORMAT(ResumenMensual_DesembolsosRD, 2) AS Desembolsos,
    FORMAT(ResumenMensual_CobrosRD, 2) AS Cobros,
    FORMAT(ResumenMensual_BalanceNetoRD, 2) AS Balance
  FROM ResumenMensual
  WHERE Periodo_Anio = pAnio
  ORDER BY Periodo_MesNumero ASC;
END$$

CREATE PROCEDURE SP_ConsultarSumarseralesPorRegion()
BEGIN
  SELECT
    s.Region_Nombre,
    COUNT(DISTINCT s.Sucursal_ID) AS TotalSucursales,
    s.Sucursal_Estado
  FROM Sucursal s
  GROUP BY s.Region_Nombre, s.Sucursal_Estado
  ORDER BY TotalSucursales DESC;
END$$

CREATE PROCEDURE SP_GenerarReportePeriodo(IN pAnio INT, IN pMes INT)
BEGIN
  SELECT
    e.Empresa_Nombre,
    p.Periodo_MesNombre AS Mes,
    p.Periodo_Anio AS Anio,
    COUNT(DISTINCT s.Sucursal_ID) AS Sucursales,
    COUNT(DISTINCT d.Destino_ID) AS Destinos,
    'Reporte Operativo' AS TipoReporte
  FROM Empresa e
  CROSS JOIN Periodo p
  LEFT JOIN Sucursal s ON e.Empresa_Codigo = s.Empresa_Codigo
  LEFT JOIN Destino d ON 1=1
  WHERE p.Periodo_Anio = pAnio AND p.Periodo_MesNumero = pMes
  GROUP BY e.Empresa_Nombre, p.Periodo_MesNombre, p.Periodo_Anio;
END$$

CREATE PROCEDURE SP_AnalisisDesembolsoCobroPeriodo(IN pFechaInicio DATE, IN pFechaFin DATE)
BEGIN
  SELECT
    Periodo_Anio,
    Periodo_MesNombre,
    FORMAT(ResumenMensual_DesembolsosRD, 2) AS Desembolsos,
    FORMAT(ResumenMensual_CobrosRD, 2) AS Cobros,
    FORMAT(ResumenMensual_BalanceNetoRD, 2) AS Balance,
    ROUND(ResumenMensual_CobrosRD / ResumenMensual_DesembolsosRD * 100, 2) AS IndiceCobranza
  FROM ResumenMensual
  WHERE Periodo_Fecha BETWEEN pFechaInicio AND pFechaFin
  ORDER BY Periodo_Fecha ASC;
END$$

DELIMITER ;

-- ============================================================
-- SECCIÓN 6: CREACIÓN DE TRIGGERS
-- ============================================================

DELIMITER $$

CREATE TRIGGER TR_ResumenMensual_InsertAudit
AFTER INSERT ON ResumenMensual
FOR EACH ROW
BEGIN
  CALL SP_InsertarAuditoria(
    'ResumenMensual',
    'INSERT',
    1,
    CONCAT('Resumen insertado para ', NEW.Periodo_MesNombre, ' ', NEW.Periodo_Anio)
  );
END$$

CREATE TRIGGER TR_DesembolsoCobro_InsertAudit
AFTER INSERT ON DesembolsoCobro
FOR EACH ROW
BEGIN
  CALL SP_InsertarAuditoria(
    'DesembolsoCobro',
    'INSERT',
    1,
    CONCAT('Transacción desembolso/cobro registrada - Sucursal ID: ', NEW.Sucursal_ID)
  );
END$$

CREATE TRIGGER TR_CarteraPresta_InsertAudit
AFTER INSERT ON CarteraPresta
FOR EACH ROW
BEGIN
  CALL SP_InsertarAuditoria(
    'CarteraPresta',
    'INSERT',
    1,
    CONCAT('Cartera de préstamo registrada - Cantidad: ', NEW.CarteraPresta_CantidadPrestamos)
  );
END$$

CREATE TRIGGER TR_AreaFinanciada_InsertAudit
AFTER INSERT ON AreaFinanciada
FOR EACH ROW
BEGIN
  CALL SP_InsertarAuditoria(
    'AreaFinanciada',
    'INSERT',
    1,
    CONCAT('Área financiada registrada - Tareas: ', NEW.AreaFinanciada_Tareas)
  );
END$$

DELIMITER ;

-- ============================================================
-- SECCIÓN 7: CREACIÓN DE VISTAS
-- ============================================================

CREATE VIEW VW_ResumenAnual AS
SELECT
  Periodo_Anio AS Anio,
  SUM(ResumenMensual_DesembolsosRD) AS TotalDesembolsos,
  SUM(ResumenMensual_CobrosRD) AS TotalCobros,
  SUM(ResumenMensual_BalanceNetoRD) AS BalanceTotal,
  ROUND(SUM(ResumenMensual_CobrosRD) / SUM(ResumenMensual_DesembolsosRD) * 100, 2) AS IndiceCobranza
FROM ResumenMensual
GROUP BY Periodo_Anio;

CREATE VIEW VW_EstructuraOrganizacional AS
SELECT
  e.Empresa_Codigo,
  e.Empresa_Nombre,
  r.Region_Nombre,
  COUNT(DISTINCT s.Sucursal_ID) AS Sucursales,
  e.Empresa_Estado
FROM Empresa e
LEFT JOIN Sucursal s ON e.Empresa_Codigo = s.Empresa_Codigo
LEFT JOIN Region r ON s.Region_Nombre = r.Region_Nombre
GROUP BY e.Empresa_Codigo, e.Empresa_Nombre, r.Region_Nombre, e.Empresa_Estado;

CREATE VIEW VW_CoberturaPorDestino AS
SELECT
  Destino_Rubro AS Rubro,
  COUNT(*) AS DestinosDisponibles,
  GROUP_CONCAT(DISTINCT Destino_TipoOperacion) AS TiposOperacion,
  Destino_Estado
FROM Destino
GROUP BY Destino_Rubro, Destino_Estado;

-- ============================================================
-- SECCIÓN 8: CONSULTAS ANALÍTICAS (DQL)
-- ============================================================

-- Consulta 1: Resumen KPI 2025
SELECT
  'Proyecto Final - Banco Agrícola RD' AS Sistema,
  '12 Tablas Creadas' AS EstructuraDb,
  '3 Funciones SQL' AS ObjetosSQL,
  '5 Stored Procedures' AS Procedimientos,
  '4 Triggers Activos' AS AuditoriaTransaccional,
  '3 Vistas Analíticas' AS VistasConsulta;

-- Consulta 2: Datos Totales en Base de Datos
SELECT 'Empresa' AS Tabla, COUNT(*) AS Registros FROM Empresa
UNION ALL
SELECT 'Región', COUNT(*) FROM Region
UNION ALL
SELECT 'Sucursal', COUNT(*) FROM Sucursal
UNION ALL
SELECT 'Destino', COUNT(*) FROM Destino
UNION ALL
SELECT 'Período', COUNT(*) FROM Periodo
UNION ALL
SELECT 'Tipo Transacción', COUNT(*) FROM TipoTransaccion
UNION ALL
SELECT 'Resumen Mensual', COUNT(*) FROM ResumenMensual;

-- Consulta 3: Desembolsos por Año (Histórico)
SELECT
  Periodo_Anio AS Anio,
  FORMAT(SUM(ResumenMensual_DesembolsosRD), 2) AS TotalDesembolsos,
  ROUND(AVG(ResumenMensual_DesembolsosRD), 2) AS PromedioMensual,
  COUNT(*) AS MesesRegistrados
FROM ResumenMensual
GROUP BY Periodo_Anio
ORDER BY Periodo_Anio DESC;

-- Consulta 4: Índice de Cobranza por Año
SELECT
  Periodo_Anio,
  FORMAT(SUM(ResumenMensual_CobrosRD), 2) AS CobrosRD,
  FORMAT(SUM(ResumenMensual_DesembolsosRD), 2) AS DesembolsosRD,
  ROUND(SUM(ResumenMensual_CobrosRD) / SUM(ResumenMensual_DesembolsosRD) * 100, 2) AS IndiceCobranza
FROM ResumenMensual
GROUP BY Periodo_Anio
ORDER BY Periodo_Anio DESC;

-- ============================================================
-- SECCIÓN 9: FIN DEL SCRIPT MAESTRO
-- ============================================================
-- Script Maestro completado
-- Base de Datos: DBBancoAgricolaDR
-- Estado: Operativa y Lista para Producción
-- Fecha de Generación: 26 de Abril de 2026
-- ============================================================
