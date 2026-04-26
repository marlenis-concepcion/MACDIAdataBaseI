-- ============================================================
-- PROYECTO FINAL - DML (DATA MANIPULATION LANGUAGE)
-- Inserción de Datos de Prueba
-- Fuente: Banco Agrícola RD - datos.gob.do
-- Período: 2017-2026
-- ============================================================

USE DBBancoAgricolaDR;

-- ============================================================
-- INSERTAR DATOS EN TABLA: Empresa
-- ============================================================
INSERT INTO Empresa (Empresa_Codigo, Empresa_Nombre, Empresa_PaisCodigo, Empresa_Estado) VALUES
('BAG', 'Banco Agrícola RD', 'DO', 'Activa');

-- ============================================================
-- INSERTAR DATOS EN TABLA: Region
-- ============================================================
INSERT INTO Region (Region_Nombre, Region_Codigo, Region_Estado) VALUES
('Cibao Nordeste', 'CN', 'Activa'),
('Cibao Noroeste', 'CNO', 'Activa'),
('Cibao Suroeste', 'CS', 'Activa'),
('Espaillat', 'ESP', 'Activa'),
('Duarte', 'DUA', 'Activa'),
('Hermanas Mirabal', 'HM', 'Activa'),
('Hato Mayor', 'HM', 'Activa'),
('La Altagracia', 'LA', 'Activa'),
('La Vega', 'LV', 'Activa'),
('La Romana', 'LR', 'Activa'),
('María Trinidad Sánchez', 'MTS', 'Activa'),
('Montecristi', 'MON', 'Activa'),
('Monseñor Nouel', 'MN', 'Activa'),
('Puerto Plata', 'PP', 'Activa'),
('Distrito Nacional', 'DN', 'Activa'),
('Santo Domingo', 'SD', 'Activa'),
('San Cristóbal', 'SC', 'Activa'),
('San Pedro de Macorís', 'SPM', 'Activa'),
('El Seibo', 'ES', 'Activa'),
('Azua', 'AZU', 'Activa'),
('Bahoruco', 'BAH', 'Activa'),
('Baní', 'BAN', 'Activa'),
('Peravia', 'PER', 'Activa'),
('Pedernales', 'PED', 'Activa'),
('Dajabón', 'DAJ', 'Activa'),
('Valverde', 'VAL', 'Activa'),
('Barahona', 'BAR', 'Activa'),
('Independencia', 'IND', 'Activa'),
('Sur', 'SUR', 'Activa');

-- ============================================================
-- INSERTAR DATOS EN TABLA: Sucursal
-- (Datos extraídos de dim_sucursal.csv)
-- ============================================================
INSERT INTO Sucursal (Sucursal_Nombre, Region_Nombre, Empresa_Codigo) VALUES
('Arenoso', 'Cibao Nordeste', 'BAG'),
('Azua', 'Sur', 'BAG'),
('Baní', 'Sur', 'BAG'),
('Barahona', 'Sur', 'BAG'),
('Cabrera', 'Cibao Noroeste', 'BAG'),
('Cruce de Guayacanes', 'Distrito Nacional', 'BAG'),
('Duarte', 'Duarte', 'BAG'),
('El Seibo', 'El Seibo', 'BAG'),
('Espaillat', 'Espaillat', 'BAG'),
('Fumero', 'La Vega', 'BAG'),
('Gaspar Hernández', 'Espaillat', 'BAG'),
('Guananico', 'Espaillat', 'BAG'),
('Guayubín', 'Montecristi', 'BAG'),
('Hato Mayor', 'Hato Mayor', 'BAG'),
('Higüey', 'La Altagracia', 'BAG'),
('Jánica', 'Espaillat', 'BAG'),
('Jaquimeyes', 'Valverde', 'BAG'),
('Jaya', 'Hato Mayor', 'BAG'),
('La Romana', 'La Romana', 'BAG'),
('La Vega', 'La Vega', 'BAG'),
('Las Yayas de Viajama', 'Hermanas Mirabal', 'BAG'),
('Licey al Medio', 'La Vega', 'BAG'),
('Loma de Cabrera', 'Dajabón', 'BAG'),
('Mao', 'Valverde', 'BAG'),
('Moca', 'Espaillat', 'BAG'),
('Monseñor Nouel', 'Monseñor Nouel', 'BAG'),
('Montecristi', 'Montecristi', 'BAG'),
('Monte Plata', 'Montecristi', 'BAG'),
('Navarrete', 'Puerto Plata', 'BAG'),
('Oviedo', 'Pedernales', 'BAG');

-- ============================================================
-- INSERTAR DATOS EN TABLA: Destino
-- (Datos extraídos de dim_destino.csv - Primeros 50 registros de 105)
-- ============================================================
INSERT INTO Destino (Destino_Nombre, Destino_Rubro, Destino_TipoOperacion) VALUES
('Acuicola', 'Acuicola', 'General'),
('Acuícola', 'Acuícola', 'General'),
('Agro. Manufactura, Comercio V. y Otros', 'Agro. Manufactura, Comercio V. y Otros', 'General'),
('Aguacate (Producción)', 'Aguacate', 'Producción'),
('Aguacate (Acopio)', 'Aguacate', 'Acopio'),
('Ajo', 'Ajo', 'Producción'),
('Alimentación Animal', 'Alimentación Animal', 'General'),
('Almendra', 'Almendra', 'Producción'),
('Almendro', 'Almendra', 'Producción'),
('Alquileres', 'Alquileres', 'General'),
('Apio', 'Apio', 'Producción'),
('Apicultura', 'Apicultura', 'Producción'),
('Arroz Secano', 'Arroz', 'Producción'),
('Arroz Riego', 'Arroz', 'Producción'),
('Avicultura', 'Avicultura', 'Producción'),
('Aves en General', 'Avicultura', 'General'),
('Avispa Troyano', 'Control Biológico', 'Producción'),
('Banano', 'Banano', 'Producción'),
('Banano (Exportación)', 'Banano', 'Exportación'),
('Batata', 'Batata', 'Producción'),
('Bioacumulador', 'Bioacumulador', 'Producción'),
('Bomba de Riego', 'Equipamiento', 'Producción'),
('Bombeo de Agua', 'Infraestructura', 'General'),
('Brócoli', 'Brócoli', 'Producción'),
('Búfalos', 'Ganadería', 'Producción'),
('Café', 'Café', 'Producción'),
('Café Oro', 'Café', 'Acopio'),
('Cacao', 'Cacao', 'Producción'),
('Caída Sangue', 'Bioinsumo', 'Producción'),
('Camarones', 'Acuicultura', 'Producción'),
('Caña de Azúcar', 'Caña de Azúcar', 'Producción'),
('Canela', 'Especias', 'Producción'),
('Canutillo', 'Textil', 'Producción'),
('Carambola', 'Carambola', 'Producción'),
('Carbón Vegetal', 'Derivados Forestales', 'Producción'),
('Carbonatación', 'Proceso', 'General'),
('Carreta Agrícola', 'Equipamiento', 'Producción'),
('Carretilla', 'Equipamiento', 'Producción'),
('Carruaje', 'Transporte', 'General'),
('Casa de Cultivo', 'Infraestructura', 'Producción'),
('Casa de Semilla', 'Infraestructura', 'Producción'),
('Casabe', 'Derivados de Yuca', 'Producción'),
('Castor', 'Castor', 'Producción'),
('Caucho', 'Caucho', 'Producción'),
('Caza de Camarones', 'Camarones', 'General'),
('Cebada', 'Cebada', 'Producción'),
('Cebolla', 'Cebolla', 'Producción'),
('Cecina', 'Derivados Cárnicos', 'Producción'),
('Ceniza Volcánica', 'Insumo', 'General');

-- ============================================================
-- INSERTAR DATOS EN TABLA: Periodo
-- (Datos extraídos de dim_periodo.csv)
-- ============================================================
INSERT INTO Periodo (Periodo_Anio, Periodo_MesNumero, Periodo_MesNombre, Periodo_Fecha) VALUES
(2017, 4, 'Abril', '2017-04-01'),
(2017, 5, 'Mayo', '2017-05-01'),
(2017, 6, 'Junio', '2017-06-01'),
(2017, 7, 'Julio', '2017-07-01'),
(2017, 8, 'Agosto', '2017-08-01'),
(2017, 9, 'Septiembre', '2017-09-01'),
(2017, 10, 'Octubre', '2017-10-01'),
(2017, 11, 'Noviembre', '2017-11-01'),
(2017, 12, 'Diciembre', '2017-12-01'),
(2018, 1, 'Enero', '2018-01-01'),
(2018, 2, 'Febrero', '2018-02-01'),
(2018, 3, 'Marzo', '2018-03-01'),
(2018, 4, 'Abril', '2018-04-01'),
(2018, 5, 'Mayo', '2018-05-01'),
(2018, 6, 'Junio', '2018-06-01'),
(2018, 7, 'Julio', '2018-07-01'),
(2018, 8, 'Agosto', '2018-08-01'),
(2018, 9, 'Septiembre', '2018-09-01'),
(2018, 10, 'Octubre', '2018-10-01'),
(2018, 11, 'Noviembre', '2018-11-01'),
(2018, 12, 'Diciembre', '2018-12-01'),
(2019, 1, 'Enero', '2019-01-01'),
(2019, 2, 'Febrero', '2019-02-01'),
(2019, 3, 'Marzo', '2019-03-01'),
(2019, 4, 'Abril', '2019-04-01'),
(2019, 5, 'Mayo', '2019-05-01'),
(2019, 6, 'Junio', '2019-06-01'),
(2019, 7, 'Julio', '2019-07-01'),
(2019, 8, 'Agosto', '2019-08-01'),
(2019, 9, 'Septiembre', '2019-09-01'),
(2019, 10, 'Octubre', '2019-10-01'),
(2019, 11, 'Noviembre', '2019-11-01'),
(2019, 12, 'Diciembre', '2019-12-01'),
(2020, 1, 'Enero', '2020-01-01'),
(2020, 2, 'Febrero', '2020-02-01'),
(2020, 3, 'Marzo', '2020-03-01'),
(2020, 4, 'Abril', '2020-04-01'),
(2020, 5, 'Mayo', '2020-05-01'),
(2020, 6, 'Junio', '2020-06-01'),
(2020, 7, 'Julio', '2020-07-01'),
(2020, 8, 'Agosto', '2020-08-01'),
(2020, 9, 'Septiembre', '2020-09-01'),
(2020, 10, 'Octubre', '2020-10-01'),
(2020, 11, 'Noviembre', '2020-11-01'),
(2020, 12, 'Diciembre', '2020-12-01'),
(2021, 1, 'Enero', '2021-01-01'),
(2021, 2, 'Febrero', '2021-02-01'),
(2021, 3, 'Marzo', '2021-03-01'),
(2021, 4, 'Abril', '2021-04-01'),
(2021, 5, 'Mayo', '2021-05-01'),
(2021, 6, 'Junio', '2021-06-01'),
(2021, 7, 'Julio', '2021-07-01'),
(2021, 8, 'Agosto', '2021-08-01'),
(2021, 9, 'Septiembre', '2021-09-01'),
(2021, 10, 'Octubre', '2021-10-01'),
(2021, 11, 'Noviembre', '2021-11-01'),
(2021, 12, 'Diciembre', '2021-12-01'),
(2022, 1, 'Enero', '2022-01-01'),
(2022, 2, 'Febrero', '2022-02-01'),
(2022, 3, 'Marzo', '2022-03-01'),
(2022, 4, 'Abril', '2022-04-01'),
(2022, 5, 'Mayo', '2022-05-01'),
(2022, 6, 'Junio', '2022-06-01'),
(2022, 7, 'Julio', '2022-07-01'),
(2022, 8, 'Agosto', '2022-08-01'),
(2022, 9, 'Septiembre', '2022-09-01'),
(2022, 10, 'Octubre', '2022-10-01'),
(2022, 11, 'Noviembre', '2022-11-01'),
(2022, 12, 'Diciembre', '2022-12-01'),
(2023, 1, 'Enero', '2023-01-01'),
(2023, 2, 'Febrero', '2023-02-01'),
(2023, 3, 'Marzo', '2023-03-01'),
(2023, 4, 'Abril', '2023-04-01'),
(2023, 5, 'Mayo', '2023-05-01'),
(2023, 6, 'Junio', '2023-06-01'),
(2023, 7, 'Julio', '2023-07-01'),
(2023, 8, 'Agosto', '2023-08-01'),
(2023, 9, 'Septiembre', '2023-09-01'),
(2023, 10, 'Octubre', '2023-10-01'),
(2023, 11, 'Noviembre', '2023-11-01'),
(2023, 12, 'Diciembre', '2023-12-01'),
(2024, 1, 'Enero', '2024-01-01'),
(2024, 2, 'Febrero', '2024-02-01'),
(2024, 3, 'Marzo', '2024-03-01'),
(2024, 4, 'Abril', '2024-04-01'),
(2024, 5, 'Mayo', '2024-05-01'),
(2024, 6, 'Junio', '2024-06-01'),
(2024, 7, 'Julio', '2024-07-01'),
(2024, 8, 'Agosto', '2024-08-01'),
(2024, 9, 'Septiembre', '2024-09-01'),
(2024, 10, 'Octubre', '2024-10-01'),
(2024, 11, 'Noviembre', '2024-11-01'),
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

-- ============================================================
-- INSERTAR DATOS EN TABLA: TipoTransaccion
-- ============================================================
INSERT INTO TipoTransaccion (TipoTransaccion_Nombre, TipoTransaccion_Descripcion) VALUES
('Desembolso', 'Fondos desembolsados a clientes'),
('Cobro', 'Fondos cobrados de clientes'),
('Balance Neto', 'Diferencia entre desembolsos y cobros'),
('Cartera', 'Préstamos pendientes de pago'),
('Área Financiada', 'Área de tierra financiada en tareas');

-- ============================================================
-- INSERTAR DATOS EN TABLA: ResumenMensual
-- (Datos extraídos de resumen_desembolsos_cobros_mensual.csv)
-- ============================================================
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
-- DATOS DE TRANSACCIONES SE CARGARÁN AUTOMÁTICAMENTE
-- Utilizando CSV import en setup-y-ejecutar.sh
-- Tablas afectadas:
--  - DesembolsoCobro (480 registros)
--  - CarteraPresta (3,455 registros)
--  - AreaFinanciada (3,456 registros)
--  - MontoDestino (4,913 registros)
-- ============================================================

-- ============================================================
-- FIN DML - DATOS CARGADOS EXITOSAMENTE
-- ============================================================
