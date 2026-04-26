-- ============================================================
-- PROYECTO FINAL - DQL (DATA QUERY LANGUAGE)
-- Consultas Analíticas y Reportes
-- Banco Agrícola RD - 2017-2026
-- ============================================================

USE DBBancoAgricolaDR;

-- ============================================================
-- CONSULTA 1: Conteo Total de Registros por Tabla
-- ============================================================
SELECT 'Empresa' AS Tabla, COUNT(*) AS TotalRegistros FROM Empresa
UNION ALL
SELECT 'Region', COUNT(*) FROM Region
UNION ALL
SELECT 'Sucursal', COUNT(*) FROM Sucursal
UNION ALL
SELECT 'Destino', COUNT(*) FROM Destino
UNION ALL
SELECT 'Periodo', COUNT(*) FROM Periodo
UNION ALL
SELECT 'TipoTransaccion', COUNT(*) FROM TipoTransaccion
UNION ALL
SELECT 'ResumenMensual', COUNT(*) FROM ResumenMensual;

-- ============================================================
-- CONSULTA 2: Listado Completo de Sucursales con Región
-- ============================================================
SELECT
  Sucursal_ID,
  Sucursal_Nombre,
  Region_Nombre,
  Sucursal_Estado,
  Sucursal_FechaRegistro
FROM Sucursal
ORDER BY Sucursal_Nombre ASC;

-- ============================================================
-- CONSULTA 3: Total de Desembolsos Históricos por Año
-- ============================================================
SELECT
  YEAR(Periodo_Fecha) AS Anio,
  SUM(ResumenMensual_DesembolsosRD) AS DesembolsosTotalRD,
  COUNT(DISTINCT Periodo_MesNumero) AS TotalMeses,
  ROUND(AVG(ResumenMensual_DesembolsosRD), 2) AS PromedioMensualRD
FROM ResumenMensual
GROUP BY YEAR(Periodo_Fecha)
ORDER BY Anio DESC;

-- ============================================================
-- CONSULTA 4: Total de Cobros Históricos por Año
-- ============================================================
SELECT
  YEAR(Periodo_Fecha) AS Anio,
  SUM(ResumenMensual_CobrosRD) AS CobrosTotalRD,
  COUNT(DISTINCT Periodo_MesNumero) AS TotalMeses,
  ROUND(AVG(ResumenMensual_CobrosRD), 2) AS PromedioMensualRD
FROM ResumenMensual
GROUP BY YEAR(Periodo_Fecha)
ORDER BY Anio DESC;

-- ============================================================
-- CONSULTA 5: Balance Neto Mensual - Últimos 12 Meses
-- ============================================================
SELECT
  Periodo_Anio,
  Periodo_MesNumero,
  Periodo_MesNombre,
  ResumenMensual_DesembolsosRD,
  ResumenMensual_CobrosRD,
  ResumenMensual_BalanceNetoRD,
  CASE
    WHEN ResumenMensual_BalanceNetoRD > 0 THEN 'Ganancia'
    WHEN ResumenMensual_BalanceNetoRD < 0 THEN 'Pérdida'
    ELSE 'Equilibrio'
  END AS EstatusFlujo
FROM ResumenMensual
ORDER BY Periodo_Fecha DESC
LIMIT 12;

-- ============================================================
-- CONSULTA 6: Rangos de Desembolsos por Trimestre
-- ============================================================
SELECT
  YEAR(Periodo_Fecha) AS Anio,
  CASE
    WHEN MONTH(Periodo_Fecha) IN (1, 2, 3) THEN 'Q1'
    WHEN MONTH(Periodo_Fecha) IN (4, 5, 6) THEN 'Q2'
    WHEN MONTH(Periodo_Fecha) IN (7, 8, 9) THEN 'Q3'
    ELSE 'Q4'
  END AS Trimestre,
  SUM(ResumenMensual_DesembolsosRD) AS DesembolsosTrimestralRD,
  COUNT(*) AS MesesRegistrados
FROM ResumenMensual
GROUP BY YEAR(Periodo_Fecha), Trimestre
ORDER BY Anio DESC, Trimestre DESC;

-- ============================================================
-- CONSULTA 7: Comparativa Desembolsos vs Cobros 2025
-- ============================================================
SELECT
  Periodo_MesNombre,
  ResumenMensual_DesembolsosRD,
  ResumenMensual_CobrosRD,
  ROUND((ResumenMensual_CobrosRD / ResumenMensual_DesembolsosRD * 100), 2) AS PorcentajeCobro,
  ROUND((ResumenMensual_DesembolsosRD - ResumenMensual_CobrosRD), 2) AS DiferenciaRD
FROM ResumenMensual
WHERE Periodo_Anio = 2025
ORDER BY Periodo_MesNumero ASC;

-- ============================================================
-- CONSULTA 8: Promedio de Desembolsos Mensuales por Año
-- ============================================================
SELECT
  YEAR(Periodo_Fecha) AS Anio,
  ROUND(AVG(ResumenMensual_DesembolsosRD), 2) AS PromedioDesembolsosMensualRD,
  MIN(ResumenMensual_DesembolsosRD) AS MenorDesembolsoRD,
  MAX(ResumenMensual_DesembolsosRD) AS MayorDesembolsoRD
FROM ResumenMensual
GROUP BY YEAR(Periodo_Fecha)
ORDER BY Anio DESC;

-- ============================================================
-- CONSULTA 9: Destinos Financiados (Top 10)
-- ============================================================
SELECT
  Destino_Nombre,
  Destino_Rubro,
  Destino_TipoOperacion,
  COUNT(*) AS VecesFinanciado,
  Destino_Estado
FROM Destino
GROUP BY Destino_Nombre, Destino_Rubro, Destino_TipoOperacion, Destino_Estado
ORDER BY VecesFinanciado DESC
LIMIT 10;

-- ============================================================
-- CONSULTA 10: Sucursales con Mayor Volumen de Transacciones
-- ============================================================
SELECT
  Sucursal_Nombre,
  Region_Nombre,
  COUNT(*) AS TotalTransacciones,
  Sucursal_Estado
FROM Sucursal
GROUP BY Sucursal_Nombre, Region_Nombre, Sucursal_Estado
ORDER BY TotalTransacciones DESC;

-- ============================================================
-- CONSULTA 11: Distribución de Destinos por Rubro
-- ============================================================
SELECT
  Destino_Rubro,
  COUNT(*) AS CantidadDestinos,
  GROUP_CONCAT(DISTINCT Destino_TipoOperacion) AS TiposOperacion
FROM Destino
WHERE Destino_Estado = 'Activo'
GROUP BY Destino_Rubro
ORDER BY CantidadDestinos DESC;

-- ============================================================
-- CONSULTA 12: Períodos Registrados por Año
-- ============================================================
SELECT
  Periodo_Anio,
  COUNT(*) AS TotalPeriodos,
  MIN(Periodo_Fecha) AS PrimerMes,
  MAX(Periodo_Fecha) AS UltimoMes
FROM Periodo
GROUP BY Periodo_Anio
ORDER BY Periodo_Anio DESC;

-- ============================================================
-- CONSULTA 13: Información de Empresa y sus Sucursales
-- ============================================================
SELECT
  e.Empresa_Codigo,
  e.Empresa_Nombre,
  COUNT(DISTINCT s.Sucursal_ID) AS TotalSucursales,
  COUNT(DISTINCT r.Region_ID) AS TotalRegiones,
  e.Empresa_Estado
FROM Empresa e
LEFT JOIN Sucursal s ON e.Empresa_Codigo = s.Empresa_Codigo
LEFT JOIN Region r ON s.Region_Nombre = r.Region_Nombre
GROUP BY e.Empresa_Codigo, e.Empresa_Nombre, e.Empresa_Estado;

-- ============================================================
-- CONSULTA 14: Desembolsos vs Cobros Histórico 2025
-- ============================================================
SELECT
  Periodo_MesNombre,
  FORMAT(ResumenMensual_DesembolsosRD, 2) AS DesembolsosFormato,
  FORMAT(ResumenMensual_CobrosRD, 2) AS CobrosFormato,
  FORMAT(ResumenMensual_BalanceNetoRD, 2) AS BalanceFormato
FROM ResumenMensual
WHERE Periodo_Anio = 2025
ORDER BY Periodo_MesNumero ASC;

-- ============================================================
-- CONSULTA 15: Acumulado Desembolsos y Cobros por Año
-- ============================================================
SELECT
  Periodo_Anio,
  SUM(ResumenMensual_DesembolsosRD) AS DesembolsosAcumuladosRD,
  SUM(ResumenMensual_CobrosRD) AS CobrosAcumuladosRD,
  SUM(ResumenMensual_BalanceNetoRD) AS BalanceAcumuladoRD,
  ROUND(SUM(ResumenMensual_CobrosRD) / SUM(ResumenMensual_DesembolsosRD) * 100, 2) AS TasaCobroPromedio
FROM ResumenMensual
GROUP BY Periodo_Anio
ORDER BY Periodo_Anio DESC;

-- ============================================================
-- CONSULTA 16: Variación Porcentual Mensual de Desembolsos 2025
-- ============================================================
SELECT
  rm1.Periodo_MesNombre AS MesActual,
  rm1.ResumenMensual_DesembolsosRD AS DesembolsosMesActual,
  ROUND(((rm1.ResumenMensual_DesembolsosRD - LAG(rm1.ResumenMensual_DesembolsosRD)
    OVER (ORDER BY rm1.Periodo_Fecha)) / LAG(rm1.ResumenMensual_DesembolsosRD)
    OVER (ORDER BY rm1.Periodo_Fecha)) * 100, 2) AS VariacionPorcentual
FROM ResumenMensual rm1
WHERE rm1.Periodo_Anio = 2025
ORDER BY rm1.Periodo_Fecha ASC;

-- ============================================================
-- CONSULTA 17: Consolidado de Regiones en Sucursales
-- ============================================================
SELECT
  Region_Nombre,
  COUNT(Sucursal_ID) AS CantidadSucursales,
  Region_Estado
FROM Sucursal
GROUP BY Region_Nombre, Region_Estado
ORDER BY CantidadSucursales DESC;

-- ============================================================
-- CONSULTA 18: Cobertura de Destinos por Tipo de Operación
-- ============================================================
SELECT
  Destino_TipoOperacion,
  COUNT(*) AS CantidadDestinos,
  GROUP_CONCAT(DISTINCT Destino_Rubro ORDER BY Destino_Rubro SEPARATOR ', ') AS RubrosAsociados
FROM Destino
GROUP BY Destino_TipoOperacion
ORDER BY CantidadDestinos DESC;

-- ============================================================
-- CONSULTA 19: Evolución de Desembolsos Últimos 24 Meses
-- ============================================================
SELECT
  DATE_FORMAT(Periodo_Fecha, '%Y-%m') AS MesAño,
  ResumenMensual_DesembolsosRD,
  ResumenMensual_CobrosRD,
  ROUND(AVG(ResumenMensual_DesembolsosRD) OVER (
    ORDER BY Periodo_Fecha
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ), 2) AS PromedioMovil3Meses
FROM ResumenMensual
ORDER BY Periodo_Fecha DESC
LIMIT 24;

-- ============================================================
-- CONSULTA 20: Estado Consolidado por Categoría
-- ============================================================
SELECT
  'Sucursales Activas' AS Categoria,
  COUNT(*) AS Total
FROM Sucursal
WHERE Sucursal_Estado = 'Activa'
UNION ALL
SELECT 'Destinos Activos', COUNT(*)
FROM Destino
WHERE Destino_Estado = 'Activo'
UNION ALL
SELECT 'Regiones Activas', COUNT(*)
FROM Region
WHERE Region_Estado = 'Activa'
UNION ALL
SELECT 'Períodos Registrados', COUNT(*)
FROM Periodo;

-- ============================================================
-- CONSULTA 21: Análisis Top 5 Meses con Mayor Desembolso
-- ============================================================
SELECT
  Periodo_MesNombre,
  Periodo_Anio,
  ResumenMensual_DesembolsosRD,
  RANK() OVER (ORDER BY ResumenMensual_DesembolsosRD DESC) AS Ranking
FROM ResumenMensual
ORDER BY ResumenMensual_DesembolsosRD DESC
LIMIT 5;

-- ============================================================
-- CONSULTA 22: Análisis Top 5 Meses con Mayor Cobro
-- ============================================================
SELECT
  Periodo_MesNombre,
  Periodo_Anio,
  ResumenMensual_CobrosRD,
  RANK() OVER (ORDER BY ResumenMensual_CobrosRD DESC) AS Ranking
FROM ResumenMensual
ORDER BY ResumenMensual_CobrosRD DESC
LIMIT 5;

-- ============================================================
-- CONSULTA 23: Índice de Cobranza por Año (Cobros/Desembolsos)
-- ============================================================
SELECT
  Periodo_Anio,
  SUM(ResumenMensual_CobrosRD) AS CobrosRD,
  SUM(ResumenMensual_DesembolsosRD) AS DesembolsosRD,
  ROUND(SUM(ResumenMensual_CobrosRD) / SUM(ResumenMensual_DesembolsosRD) * 100, 2) AS IndiceCobranza
FROM ResumenMensual
GROUP BY Periodo_Anio
ORDER BY Periodo_Anio DESC;

-- ============================================================
-- CONSULTA 24: Distribución de Destinos Activos por Rubro
-- ============================================================
SELECT
  Destino_Rubro,
  COUNT(*) AS DestinosActivos,
  ROUND(COUNT(*) / (SELECT COUNT(*) FROM Destino WHERE Destino_Estado = 'Activo') * 100, 2) AS PorcentajeDelTotal
FROM Destino
WHERE Destino_Estado = 'Activo'
GROUP BY Destino_Rubro
ORDER BY DestinosActivos DESC;

-- ============================================================
-- CONSULTA 25: Resumen Ejecutivo - KPIs Principales 2025
-- ============================================================
SELECT
  'Total Desembolsos 2025' AS KPI,
  FORMAT(SUM(ResumenMensual_DesembolsosRD), 2) AS Valor
FROM ResumenMensual
WHERE Periodo_Anio = 2025
UNION ALL
SELECT 'Total Cobros 2025', FORMAT(SUM(ResumenMensual_CobrosRD), 2)
FROM ResumenMensual
WHERE Periodo_Anio = 2025
UNION ALL
SELECT 'Balance Neto 2025', FORMAT(SUM(ResumenMensual_BalanceNetoRD), 2)
FROM ResumenMensual
WHERE Periodo_Anio = 2025
UNION ALL
SELECT 'Promedio Desembolso Mensual 2025', FORMAT(AVG(ResumenMensual_DesembolsosRD), 2)
FROM ResumenMensual
WHERE Periodo_Anio = 2025
UNION ALL
SELECT 'Índice Cobranza 2025 (%)', CONCAT(ROUND(SUM(ResumenMensual_CobrosRD) / SUM(ResumenMensual_DesembolsosRD) * 100, 2), '%')
FROM ResumenMensual
WHERE Periodo_Anio = 2025;

-- ============================================================
-- FIN DQL - CONSULTAS COMPLETADAS
-- ============================================================
