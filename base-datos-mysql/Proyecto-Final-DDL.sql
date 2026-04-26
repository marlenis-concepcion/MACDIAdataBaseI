-- ============================================================
-- PROYECTO FINAL - DDL (DATA DEFINITION LANGUAGE)
-- Base de Datos: DBBancoAgricolaDR
-- Sistema: Análisis de Desembolsos y Cartera de Préstamos
-- Banco Agrícola RD - 2017-2026
-- ============================================================
-- Estudiante: Marlenis Judith Concepcion Cuevas
-- Tutora: Mtra. Rosmery Alberto M.
-- Período Académico: 2026
-- ============================================================

USE mysql;
DROP DATABASE IF EXISTS DBBancoAgricolaDR;
CREATE DATABASE DBBancoAgricolaDR CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE DBBancoAgricolaDR;

-- ============================================================
-- TABLA 1: Empresa (Maestro)
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

-- ============================================================
-- TABLA 2: Region (Maestro)
-- ============================================================
CREATE TABLE Region (
  Region_ID INT PRIMARY KEY AUTO_INCREMENT,
  Region_Nombre VARCHAR(50) UNIQUE NOT NULL,
  Region_Codigo VARCHAR(10) UNIQUE,
  Region_Estado ENUM('Activa', 'Inactiva') DEFAULT 'Activa',
  INDEX idx_Region_Nombre (Region_Nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLA 3: Sucursal (Maestro)
-- ============================================================
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

-- ============================================================
-- TABLA 4: Destino (Maestro) - Rubros de Financiamiento
-- ============================================================
CREATE TABLE Destino (
  Destino_ID INT PRIMARY KEY AUTO_INCREMENT,
  Destino_Nombre VARCHAR(150) UNIQUE NOT NULL,
  Destino_Rubro VARCHAR(100),
  Destino_TipoOperacion VARCHAR(50),
  Destino_Estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
  INDEX idx_Destino_Nombre (Destino_Nombre),
  INDEX idx_Destino_Rubro (Destino_Rubro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLA 5: Periodo (Maestro) - Períodos Mensuales
-- ============================================================
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

-- ============================================================
-- TABLA 6: TipoTransaccion (Maestro)
-- ============================================================
CREATE TABLE TipoTransaccion (
  TipoTransaccion_ID INT PRIMARY KEY AUTO_INCREMENT,
  TipoTransaccion_Nombre VARCHAR(50) UNIQUE NOT NULL,
  TipoTransaccion_Descripcion VARCHAR(255),
  INDEX idx_TipoTransaccion_Nombre (TipoTransaccion_Nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- TABLA 7: DesembolsoCobro (Transaccional)
-- ============================================================
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

-- ============================================================
-- TABLA 8: CarteraPresta (Transaccional)
-- ============================================================
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

-- ============================================================
-- TABLA 9: AreaFinanciada (Transaccional)
-- ============================================================
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

-- ============================================================
-- TABLA 10: MontoDestino (Transaccional)
-- ============================================================
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

-- ============================================================
-- TABLA 11: ResumenMensual (Analítica)
-- ============================================================
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

-- ============================================================
-- TABLA 12: AuditoriaTransacciones (Control)
-- ============================================================
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
-- FIN DDL - ESTRUCTURA COMPLETADA
-- ============================================================
