# 🗄️ BASE DE DATOS - PROYECTO FINAL
## Banco Agrícola RD - Análisis de Desembolsos y Cartera de Préstamos

**UASD - Base de Datos I (INF-8236-C2)**  
**Estudiante:** Marlenis Judith Concepcion Cuevas  
**Tutora:** Mtra. Rosmery Alberto M.  
**Período:** 2026  
**Fuente de Datos:** [datos.gob.do](https://datos.gob.do) - Banco Agrícola RD  
**Norma:** APPA (Ley 200-04 - Acceso a la Información Pública)

---

## 📊 Descripción General

Sistema integral de análisis de desembolsos y cartera de préstamos del Banco Agrícola RD (2017-2026), implementado en MySQL 8.0 con Docker. Base de datos normalizada (3NF) con 12 tablas, funciones SQL, stored procedures, triggers activos y vistas analíticas.

---

## 🚀 Ejecución Rápida

### Opción 1: Script Automático (Recomendado)

```bash
cd <PATH>/base-datos-mysql
./setup-y-ejecutar.sh
```

> **Nota:** Reemplaza `<PATH>` con la ruta donde clonaste el repositorio

**Resultado esperado:**
```
✅ BASE DE DATOS LISTA
📊 12 Tablas creadas
📈 108 Períodos (2017-2026)
💰 Desembolsos históricos cargados
```

### Opción 2: Manual

```bash
# 1. Crear contenedor
docker run -d --name mysql_bagricola \
  -e MYSQL_ROOT_PASSWORD=P@ssw0rd1234 \
  -e MYSQL_DATABASE=DBBancoAgricolaDR \
  -p 3306:3306 \
  mysql:8.0

# 2. Esperar 20 segundos
sleep 20

# 3. Cargar Script Maestro
cat Marlenis-Concepcion-Proyecto-Final-Script-Maestro.sql | \
  docker exec -i mysql_bagricola mysql -u root -pP@ssw0rd1234 DBBancoAgricolaDR

# 4. Verificar
docker exec mysql_bagricola mysql -u root -pP@ssw0rd1234 DBBancoAgricolaDR -e \
  "SELECT COUNT(*) FROM ResumenMensual;"
```

---

## 📁 Estructura de Archivos

```
base-datos-mysql/
├── setup-y-ejecutar.sh                    (Script bash automático - 20 pasos)
├── .env.example                           (Variables de entorno)
├── .gitignore                             (Archivos a ignorar)
│
├── Marlenis-Concepcion-Proyecto-Final-Script-Maestro.sql
│   ├── DDL (12 tablas normalizadas)
│   ├── DML (Datos maestros + 108 períodos)
│   ├── 2 Funciones SQL
│   ├── 5 Stored Procedures
│   ├── 4 Triggers Activos
│   ├── 3 Vistas Analíticas
│   └── 25+ Consultas DQL
│
├── Proyecto-Final-DDL.sql                 (Definición de tablas)
├── Proyecto-Final-DML.sql                 (Datos de prueba)
├── Proyecto-Final-DQL.sql                 (Consultas analíticas)
│
└── README-BASE-DATOS.md                   (Este archivo)
```

---

## 🗃️ Estructura de Base de Datos

### 12 Tablas Totales

#### Tablas Maestras (6)
| Tabla | Registros | Descripción |
|-------|-----------|------------|
| **Empresa** | 1 | Banco Agrícola RD |
| **Region** | 6+ | Regiones del país |
| **Sucursal** | 15 | Sucursales operativas |
| **Destino** | 50 | Rubros de financiamiento |
| **Periodo** | 108 | Períodos 2017-2026 |
| **TipoTransaccion** | 5 | Tipos de operación |

#### Tablas Transaccionales (3)
| Tabla | Descripción | FK |
|-------|------------|-----|
| **DesembolsoCobro** | Desembolsos y cobros mensual | Sucursal, Período |
| **CarteraPresta** | Cartera de préstamos | Sucursal, Período |
| **AreaFinanciada** | Áreas de tierra financiada | Sucursal, Período |

#### Tablas Analíticas (3)
| Tabla | Descripción |
|-------|------------|
| **MontoDestino** | Montos por destino/rubro |
| **ResumenMensual** | Resumen consolidado mensual |
| **AuditoriaTransacciones** | Auditoría de cambios |

---

## 🔧 Objetos Avanzados

### 2 Funciones SQL
```sql
-- Calcula promedio de desembolsos por año
FN_CalcularDesembolsoPromedio(pAnio)

-- Calcula índice de cobranza por año
FN_CalcularIndiceCobranza(pAnio)
```

### 5 Stored Procedures
```sql
SP_InsertarAuditoria()              -- Registra cambios
SP_ConsultarDesembolsosPorAnio()    -- Reporte mensual
SP_ConsultarSumarseralesPorRegion() -- Análisis regional
SP_GenerarReportePeriodo()          -- Reporte operativo
SP_AnalisisDesembolsoCobroPeriodo() -- Análisis temporal
```

### 4 Triggers Activos
```sql
TR_ResumenMensual_InsertAudit           -- Audita ResumenMensual
TR_DesembolsoCobro_InsertAudit          -- Audita DesembolsoCobro
TR_CarteraPresta_InsertAudit            -- Audita CarteraPresta
TR_AreaFinanciada_InsertAudit           -- Audita AreaFinanciada
```

### 3 Vistas Analíticas
```sql
VW_ResumenAnual                    -- Consolidado anual (KPIs)
VW_EstructuraOrganizacional        -- Empresa, regiones, sucursales
VW_CoberturaPorDestino             -- Destinos y rubros
```

---

## 📊 Datos de Ejemplo (2025)

### Desembolsos y Cobros
```
Mes      | Desembolsos    | Cobros        | Balance
---------|----------------|---------------|------------------
Enero    | RD$2,100.49M   | RD$2,341.22M  | -RD$240.74M
Febrero  | RD$2,054.63M   | RD$1,987.65M  | +RD$67.97M
Marzo    | RD$2,245.91M   | RD$2,123.46M  | +RD$122.45M
```

### Índice de Cobranza 2025
```
Total Desembolsos: RD$27,315,366,789
Total Cobros:      RD$26,325,473,521
Índice:            96.38%
```

---

## 🔐 Convención de Nomenclatura

### Tablas
- **PascalCase:** `Empresa`, `Sucursal`, `ResumenMensual`

### Columnas
- **Patrón:** `NombreTabla_NombreCampo`
- Ejemplos:
  - `Empresa_Codigo` (PK)
  - `Periodo_Fecha` (Field)
  - `DesembolsoCobro_DesembolsosRD` (Amount)

### Foreign Keys
- **Por tabla referenciada:** `Sucursal_ID` referencia a `Sucursal`
- **Integridad referencial:** Todas las FK con CONSTRAINT

### Índices
- **Búsqueda:** `idx_Tabla_Campo`
- **Dates:** `idx_ResumenMensual_Fecha`
- **Ranges:** `idx_Periodo_Anio_Mes`

---

## 📋 Configuración de Entorno

### Crear Archivo `.env`

```bash
cp .env.example .env
```

**Contenido .env:**
```
CONTAINER_NAME=mysql_bagricola
DB_ROOT_PASSWORD=P@ssw0rd1234
DB_NAME=DBBancoAgricolaDR
DB_USER=root
DB_PORT=3306
SCRIPT_MAESTRO=Marlenis-Concepcion-Proyecto-Final-Script-Maestro.sql
STARTUP_WAIT=20
```

---

## 🧪 Verificación de Datos

### 1. Conectar a la base de datos

```bash
docker exec -it mysql_bagricola mysql -u root -pP@ssw0rd1234 DBBancoAgricolaDR
```

### 2. Contar registros

```sql
SELECT 'Empresa' AS Tabla, COUNT(*) AS Registros FROM Empresa
UNION ALL SELECT 'Sucursal', COUNT(*) FROM Sucursal
UNION ALL SELECT 'Destino', COUNT(*) FROM Destino
UNION ALL SELECT 'Período', COUNT(*) FROM Periodo
UNION ALL SELECT 'Resumen Mensual', COUNT(*) FROM ResumenMensual;
```

### 3. Ejecutar función

```sql
SELECT FN_CalcularDesembolsoPromedio(2025) AS 'Promedio 2025';
```

### 4. Consultar vista

```sql
SELECT * FROM VW_ResumenAnual ORDER BY Anio DESC;
```

---

## 📈 Consultas Principales (DQL)

### KPI: Desembolsos por Año

```sql
SELECT
  Periodo_Anio AS Anio,
  FORMAT(SUM(ResumenMensual_DesembolsosRD), 2) AS TotalDesembolsos,
  ROUND(AVG(ResumenMensual_DesembolsosRD), 2) AS PromedioMensual
FROM ResumenMensual
GROUP BY Periodo_Anio
ORDER BY Periodo_Anio DESC;
```

### KPI: Índice de Cobranza

```sql
SELECT
  Periodo_Anio,
  FORMAT(SUM(ResumenMensual_CobrosRD), 2) AS Cobros,
  FORMAT(SUM(ResumenMensual_DesembolsosRD), 2) AS Desembolsos,
  ROUND(SUM(ResumenMensual_CobrosRD) / 
        SUM(ResumenMensual_DesembolsosRD) * 100, 2) AS IndiceCobranza
FROM ResumenMensual
GROUP BY Periodo_Anio;
```

### Desembolsos Mensuales 2025

```sql
CALL SP_ConsultarDesembolsosPorAnio(2025);
```

---

## 🔒 Seguridad y Mejores Prácticas

✅ **Nomenclatura Consistente**
- NombreTabla_NombreCampo en todas las columnas
- FK por tabla referenciada (no por tabla que usa)

✅ **Integridad Referencial**
- FOREIGN KEY constraints en todas las relaciones
- CHECK constraints para valores válidos
- UNIQUE constraints para identificadores

✅ **Auditoría Automática**
- 4 Triggers registrando INSERT en tablas transaccionales
- Tabla AuditoriaTransacciones con timestamp
- Usuario que realizó la operación

✅ **Optimización**
- Índices en claves foráneas
- Índices en campos de búsqueda (Fecha, Código)
- Índices compuestos para rangos (Año, Mes)

✅ **Sin Rutas Locales**
- Variables de entorno para configuración
- .env no se sube a Git
- Paths relativos en scripts

✅ **Datos Verificados**
- Integridad referencial garantizada
- Períodos únicos (año + mes)
- Valores numéricos validados

---

## 📱 Redes Sociales del Autor

- 🔗 **LinkedIn:** https://www.linkedin.com/in/marlenis-judith-c-561117a3/
- 📸 **Instagram:** https://www.instagram.com/marlenisj.concepcionc/
- 🐙 **GitHub:** https://github.com/marlenis-concepcion

---

## 📚 Documentación Adicional

- **Proyecto Final Completo:** Ver README.md en directorio padre
- **Datos Originales:** `../datos/originales/` CSV files (original)
- **Datos Limpios:** `../datos/limpios/` CSV files (limpiados)
- **Diagramas:** `../diagramas/` ER y DFD diagrams
- **Presentación:** `../Presentacion_Final_Banco_Agricola_RD.pptx`

---

## 🎓 Notas Técnicas

| Aspecto | Detalles |
|---------|----------|
| **Motor** | MySQL 8.0 (ARM64 native) |
| **Contenedor** | Docker para portabilidad |
| **Sintaxis** | MySQL 100% (no SQL Server) |
| **Normalización** | 3FN (Tercera Forma Normal) |
| **Período Datos** | 2017-2026 (108 períodos) |
| **Registros** | 200+ en maestras, 12,573 en hechos |
| **Funciones** | 2 funciones de cálculo |
| **Procedimientos** | 5 con lógica de negocio |
| **Triggers** | 4 para auditoría |
| **Vistas** | 3 vistas analíticas |

---

## 📞 Soporte

Para preguntas sobre la estructura o funcionamiento:
- Revisar comentarios en archivos .sql
- Ejecutar consultas en sección **Verificación de Datos**
- Consultar vistas con `SELECT * FROM VW_*`

---

**Última actualización:** 26 de Abril de 2026  
**Versión:** 1.0 (Completa)  
**Estado:** ✅ Operativo y Verificado  
**Autor:** Marlenis Judith Concepcion Cuevas  
**Fuente de Datos:** [datos.gob.do](https://datos.gob.do) - Banco Agrícola RD
