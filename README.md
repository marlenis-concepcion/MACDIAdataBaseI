# Banco Agricola RD Database Project

Final project for **Database I** in the **Master's Degree in Data Science and Artificial Intelligence** at Universidad Autonoma de Santo Domingo (UASD). This repository contains a complete database solution built from open government datasets related to the Dominican Republic's Banco Agricola.

The project transforms raw CSV files into a normalized relational database model, SQL Server implementation scripts, analytical queries, database programming objects, diagrams, a web dashboard, and a Power BI-ready dataset.

---

## English Overview

This project analyzes agricultural financing data from the Dominican Republic using public datasets from the open data portal. The selected domain is Banco Agricola, focused on agricultural loan portfolios, financed land areas, disbursements, collections, and loan amounts granted by destination or productive category.

The main goal is to demonstrate a full database lifecycle:

- Dataset analysis and data cleaning.
- Conceptual, logical, and physical data modeling.
- SQL Server database creation with DDL.
- Normalized data insertion with DML.
- Analytical querying with DQL.
- Stored procedures and triggers.
- 1NF, 2NF, and 3NF normalization justification.
- Dashboard visualization for data interpretation.
- Power BI-ready consolidated dataset for online reporting.

This repository is designed as an academic deliverable, but it follows a professional data engineering workflow: raw data ingestion, data standardization, relational modeling, SQL implementation, documentation, and visualization.

## Resumen en Espanol

Este proyecto final desarrolla una solucion completa de base de datos usando datos abiertos del Banco Agricola de la Republica Dominicana. El objetivo es integrar varios archivos CSV, limpiar los datos, normalizarlos, disenar el modelo relacional, implementar la base de datos en SQL Server y construir visualizaciones para analizar el financiamiento agricola.

El proyecto cubre todo lo solicitado en la asignatura:

- Analisis del dataset.
- Limpieza y preparacion de datos.
- Modelo conceptual, logico y fisico.
- Script DDL con base de datos, tablas, PK, FK, UNIQUE, DEFAULT, CHECK, indices y vistas.
- Script DML con insercion de datos normalizados y 6 sentencias UPDATE.
- Script DQL con 25 consultas.
- Programacion en base de datos con stored procedures y triggers.
- Normalizacion en 1FN, 2FN y 3FN.
- Dashboard funcional.
- Archivo unico preparado para Power BI online.

La solucion convierte datos abiertos en una estructura analitica organizada y lista para consultas, reportes y presentacion academica.

---

## Datasets Used

The project integrates four datasets from the Banco Agricola data domain:

| Dataset | Spanish Name | Coverage | Purpose |
| --- | --- | --- | --- |
| Loan portfolio | Cartera de prestamos agricolas | 2017-2026 | Measures loan quantity and loan value by branch and period. |
| Financed areas | Areas financiadas por el Banco Agricola | 2017-2026 | Measures financed land tasks, loan counts, and value by branch and period. |
| Disbursements and collections | Desembolsos y cobros | 2025-2026 | Measures money disbursed and collected by branch and period. |
| Amounts by destination | Montos otorgados por destino agricola | 2017-2026 | Measures granted amounts, tasks, beneficiaries, and operations by productive destination. |

Important note: **the disbursements and collections dataset only contains 2025-2026 records**. If a dashboard filter is set to 2017-2024, that chart correctly shows no data.

## Project Metrics

| Metric | Value |
| --- | ---: |
| Original CSV rows | 12,436 |
| Normalized fact records | 12,304 |
| Periods | 108 |
| Normalized branches | 33 |
| Normalized destinations | 105 |
| SQL DQL queries | 25 |
| Stored procedures | 6 |
| Triggers | 3 |
| Regional UPDATE statements | 6 |

---

## Repository Structure

```text
.
├── .gitignore
├── README.md
├── README.txt
├── Tarea 5.3_Proyecto Final (1).pdf
├── dashboard/
│   └── dashboard_banco_agricola.html
├── datos/
│   ├── originales/
│   │   ├── areas-financiadas-bagricola-2017-2026.csv
│   │   ├── cartera-de-prestamos-bagricola-2017-2026.csv
│   │   ├── desembolsos-y-cobros-bagricola-2025-2026.csv
│   │   └── montos-otorgados-por-destino-bagricola-2017-2026.csv
│   ├── limpios/
│   │   ├── dim_destino.csv
│   │   ├── dim_periodo.csv
│   │   ├── dim_sucursal.csv
│   │   ├── fact_area_financiada.csv
│   │   ├── fact_cartera_prestamo.csv
│   │   ├── fact_desembolso_cobro.csv
│   │   ├── fact_monto_destino.csv
│   │   └── resumen_desembolsos_cobros_mensual.csv
│   └── resumen_dashboard.json
├── diagramas/
│   ├── 01_modelo_conceptual.mmd
│   ├── 01_modelo_conceptual.svg
│   ├── 02_modelo_logico.mmd
│   ├── 02_modelo_logico.svg
│   ├── 03_modelo_fisico.mmd
│   └── 03_modelo_fisico.svg
├── documento/
│   ├── Proyecto_Final_Banco_Agricola.md
│   └── Proyecto_Final_Banco_Agricola.pdf
├── herramientas/
│   └── generar_pdf_reporte.swift
├── powerbi/
│   ├── BancoAgricolaRD_PowerBI_Unificado.csv
│   └── Guia_PowerBI.md
└── sql/
    ├── 00_Ejecutar_en_orden_SQLCMD.sql
    ├── 01_DDL_BancoAgricolaRD.sql
    ├── 02_DML_BancoAgricolaRD.sql
    ├── 03_DQL_25_Consultas_BancoAgricolaRD.sql
    ├── 04_Programacion_SP_Triggers_BancoAgricolaRD.sql
    └── 05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

## EN_File Inventory

This section explains every file included in the repository in English. The `EN_` prefix is used here to identify the English inventory requested for GitHub review and portfolio presentation.

| EN_File | EN_Purpose |
| --- | --- |
| `.gitignore` | Git ignore rules for local system files such as `.DS_Store`, keeping the repository clean. |
| `README.md` | Main bilingual GitHub documentation. It describes the academic objective, datasets, database design, folder structure, SQL deliverables, dashboard, Power BI file, normalization, naming convention, and execution instructions. |
| `README.txt` | Plain text companion summary for quick review outside GitHub Markdown. |
| `Tarea 5.3_Proyecto Final (1).pdf` | Original assignment instructions provided for the final Database I project. It preserves the project statement, requirements, deliverables, and due dates. |
| `datos/originales/areas-financiadas-bagricola-2017-2026.csv` | Raw public dataset for financed land areas by Banco Agricola from 2017 to 2026. It is preserved as downloaded for source traceability. |
| `datos/originales/cartera-de-prestamos-bagricola-2017-2026.csv` | Raw public dataset for the agricultural loan portfolio from 2017 to 2026. It contains original branch, period, loan count, and portfolio amount values. |
| `datos/originales/desembolsos-y-cobros-bagricola-2025-2026.csv` | Raw public dataset for disbursements and collections. Its coverage is limited to 2025 and 2026, which explains the no-data behavior for earlier years in the dashboard. |
| `datos/originales/montos-otorgados-por-destino-bagricola-2017-2026.csv` | Raw public dataset for amounts granted by agricultural destination from 2017 to 2026. It supports the destination and productive-category analysis. |
| `datos/limpios/dim_periodo.csv` | Clean period dimension containing year, month number, month name, and period date values used by the normalized database. |
| `datos/limpios/dim_sucursal.csv` | Clean branch dimension with standardized Banco Agricola branch names, regions, and active status. |
| `datos/limpios/dim_destino.csv` | Clean destination dimension with financing destination names, rubro classification, operation type, and status. |
| `datos/limpios/fact_cartera_prestamo.csv` | Normalized fact dataset for loan portfolio amounts and loan counts by branch and period. |
| `datos/limpios/fact_area_financiada.csv` | Normalized fact dataset for financed tasks, loan counts, and value by branch and period. |
| `datos/limpios/fact_desembolso_cobro.csv` | Normalized fact dataset for disbursements, collections, and net balance by branch and period for 2025-2026. |
| `datos/limpios/fact_monto_destino.csv` | Normalized fact dataset for granted amounts, operations, tasks, and beneficiaries by destination and period. |
| `datos/limpios/resumen_desembolsos_cobros_mensual.csv` | Monthly summary used to validate and visualize disbursements versus collections. |
| `datos/resumen_dashboard.json` | Aggregated dashboard data embedded or referenced by the web visualization workflow. |
| `diagramas/01_modelo_conceptual.mmd` | Mermaid source for the conceptual entity relationship model. |
| `diagramas/01_modelo_conceptual.svg` | Rendered conceptual model diagram for documentation and presentation. |
| `diagramas/02_modelo_logico.mmd` | Mermaid source for the logical relational model with entities, keys, and relationships. |
| `diagramas/02_modelo_logico.svg` | Rendered logical model diagram for the final report and project review. |
| `diagramas/03_modelo_fisico.mmd` | Mermaid source for the physical SQL Server model, including normalized tables and relationships. |
| `diagramas/03_modelo_fisico.svg` | Rendered physical model diagram aligned with the SQL implementation. |
| `documento/Proyecto_Final_Banco_Agricola.md` | Full written project report in Markdown format. It explains the dataset, problem, variables, cleaning, modeling, normalization, SQL scripts, dashboard, and conclusions. |
| `documento/Proyecto_Final_Banco_Agricola.pdf` | Final PDF report generated from the Markdown document for academic submission. |
| `herramientas/generar_pdf_reporte.swift` | Utility script used to generate the PDF report from the Markdown documentation on macOS. |
| `dashboard/dashboard_banco_agricola.html` | Self-contained interactive web dashboard with KPIs, bar chart, pie chart, disbursement and collection analysis, filters, bilingual English/Spanish switch, and no-data messages. |
| `powerbi/BancoAgricolaRD_PowerBI_Unificado.csv` | Single flat CSV prepared for Power BI Online. It consolidates the analytical fields so the dashboard can be built without manual relationship modeling. |
| `powerbi/Guia_PowerBI.md` | Step-by-step Power BI guide explaining how to upload the unified CSV and create the required visuals. |
| `sql/00_Ejecutar_en_orden_SQLCMD.sql` | SQLCMD helper script that runs the separated SQL files in the recommended sequence. |
| `sql/01_DDL_BancoAgricolaRD.sql` | DDL script that creates the SQL Server database, tables, primary keys, foreign keys, unique constraints, defaults, checks, indexes, and views. |
| `sql/02_DML_BancoAgricolaRD.sql` | DML script that inserts normalized data into dimensions and fact tables, including the required regional UPDATE statements. |
| `sql/03_DQL_25_Consultas_BancoAgricolaRD.sql` | DQL script with 25 analytical queries using SELECT, WHERE, ORDER BY, GROUP BY, HAVING, joins, subqueries, and aggregate functions. |
| `sql/04_Programacion_SP_Triggers_BancoAgricolaRD.sql` | Database programming script with stored procedures and triggers for auditing, historical tracking, and validation. |
| `sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql` | Complete master SQL script that combines DDL, DML, stored procedures, triggers, and analytical queries into one executable file. |

## ES_Inventario de Archivos

Esta seccion explica todos los archivos incluidos en el repositorio en espanol. El prefijo `ES_` identifica el inventario en espanol solicitado para la revision academica.

| ES_Archivo | ES_Proposito |
| --- | --- |
| `.gitignore` | Reglas de Git para ignorar archivos locales del sistema como `.DS_Store` y mantener limpio el repositorio. |
| `README.md` | Documentacion principal bilingue para GitHub. Describe el objetivo academico, datasets, diseno de base de datos, estructura de carpetas, entregables SQL, dashboard, archivo Power BI, normalizacion, convencion de nombres e instrucciones de ejecucion. |
| `README.txt` | Resumen complementario en texto plano para revision rapida fuera de Markdown. |
| `Tarea 5.3_Proyecto Final (1).pdf` | Instrucciones originales del proyecto final de Base de Datos I. Conserva el enunciado, requisitos, entregables y fechas indicadas por la asignatura. |
| `datos/originales/areas-financiadas-bagricola-2017-2026.csv` | Dataset original de areas financiadas por el Banco Agricola desde 2017 hasta 2026. Se conserva sin modificar para trazabilidad de la fuente. |
| `datos/originales/cartera-de-prestamos-bagricola-2017-2026.csv` | Dataset original de cartera de prestamos agricolas desde 2017 hasta 2026. Contiene sucursal, periodo, cantidad de prestamos y valor de cartera. |
| `datos/originales/desembolsos-y-cobros-bagricola-2025-2026.csv` | Dataset original de desembolsos y cobros. Solo contiene datos de 2025 y 2026, por eso el dashboard muestra mensaje sin datos para anos anteriores. |
| `datos/originales/montos-otorgados-por-destino-bagricola-2017-2026.csv` | Dataset original de montos otorgados por destino agricola desde 2017 hasta 2026. Sostiene el analisis por destino, rubro y tipo de operacion. |
| `datos/limpios/dim_periodo.csv` | Dimension limpia de periodos con ano, numero de mes, nombre de mes y fecha del periodo. |
| `datos/limpios/dim_sucursal.csv` | Dimension limpia de sucursales con nombres estandarizados, region y estatus. |
| `datos/limpios/dim_destino.csv` | Dimension limpia de destinos con nombre, rubro, tipo de operacion y estatus. |
| `datos/limpios/fact_cartera_prestamo.csv` | Tabla de hechos normalizada para cartera de prestamos, cantidad de prestamos y valor por sucursal y periodo. |
| `datos/limpios/fact_area_financiada.csv` | Tabla de hechos normalizada para tareas financiadas, cantidad de prestamos y valor por sucursal y periodo. |
| `datos/limpios/fact_desembolso_cobro.csv` | Tabla de hechos normalizada para desembolsos, cobros y balance neto por sucursal y periodo durante 2025-2026. |
| `datos/limpios/fact_monto_destino.csv` | Tabla de hechos normalizada para montos otorgados, operaciones, tareas y beneficiados por destino y periodo. |
| `datos/limpios/resumen_desembolsos_cobros_mensual.csv` | Resumen mensual utilizado para validar y visualizar la relacion entre desembolsos y cobros. |
| `datos/resumen_dashboard.json` | Datos agregados utilizados por el flujo de visualizacion del dashboard web. |
| `diagramas/01_modelo_conceptual.mmd` | Fuente Mermaid del modelo conceptual entidad-relacion. |
| `diagramas/01_modelo_conceptual.svg` | Diagrama conceptual renderizado para documentacion y presentacion. |
| `diagramas/02_modelo_logico.mmd` | Fuente Mermaid del modelo logico relacional con entidades, claves y relaciones. |
| `diagramas/02_modelo_logico.svg` | Diagrama logico renderizado para el informe final y revision del proyecto. |
| `diagramas/03_modelo_fisico.mmd` | Fuente Mermaid del modelo fisico en SQL Server con tablas normalizadas y relaciones. |
| `diagramas/03_modelo_fisico.svg` | Diagrama fisico renderizado y alineado con la implementacion SQL. |
| `documento/Proyecto_Final_Banco_Agricola.md` | Informe completo del proyecto en Markdown. Explica dataset, problema, variables, limpieza, modelado, normalizacion, scripts SQL, dashboard y conclusiones. |
| `documento/Proyecto_Final_Banco_Agricola.pdf` | Informe final en PDF generado desde el documento Markdown para entrega academica. |
| `herramientas/generar_pdf_reporte.swift` | Script utilitario usado para generar el PDF del informe desde Markdown en macOS. |
| `dashboard/dashboard_banco_agricola.html` | Dashboard web interactivo y autocontenido con KPIs, grafico de barras, grafico de pastel, analisis de desembolsos y cobros, filtros, switch bilingue ingles/espanol y mensajes sin datos. |
| `powerbi/BancoAgricolaRD_PowerBI_Unificado.csv` | CSV unico y plano preparado para Power BI Online. Consolida los campos analiticos para construir el dashboard sin modelar relaciones manualmente. |
| `powerbi/Guia_PowerBI.md` | Guia paso a paso de Power BI para subir el CSV unificado y crear las visualizaciones requeridas. |
| `sql/00_Ejecutar_en_orden_SQLCMD.sql` | Script auxiliar SQLCMD para ejecutar los archivos SQL separados en el orden recomendado. |
| `sql/01_DDL_BancoAgricolaRD.sql` | Script DDL que crea la base de datos SQL Server, tablas, claves primarias, claves foraneas, restricciones UNIQUE, DEFAULT, CHECK, indices y vistas. |
| `sql/02_DML_BancoAgricolaRD.sql` | Script DML que inserta datos normalizados en dimensiones y tablas de hechos, incluyendo las sentencias UPDATE regionales requeridas. |
| `sql/03_DQL_25_Consultas_BancoAgricolaRD.sql` | Script DQL con 25 consultas analiticas que usan SELECT, WHERE, ORDER BY, GROUP BY, HAVING, joins, subconsultas y funciones agregadas. |
| `sql/04_Programacion_SP_Triggers_BancoAgricolaRD.sql` | Script de programacion en base de datos con stored procedures y triggers de auditoria, historicos y validacion. |
| `sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql` | Script maestro completo que integra DDL, DML, stored procedures, triggers y consultas analiticas en un solo archivo ejecutable. |

---

## What Each Folder Does

### `datos/originales`

Contains the original source CSV files. These files preserve the raw structure, encoding, naming differences, accents, spacing issues, and numeric formats from the downloaded datasets.

### `datos/limpios`

Contains cleaned and normalized CSV files generated for analysis and database loading. The cleaning process standardizes:

- Branch names, such as `Higuey` and `Higuey/Higuey` variants into one canonical branch.
- Month names and period references.
- Numeric values with thousands separators.
- Destination names into rubro and operation type.
- UTF-8 output for easier reuse in BI tools.

### `sql`

Contains all SQL Server scripts required for database implementation:

- `01_DDL_BancoAgricolaRD.sql`: creates the database, tables, constraints, indexes, and views.
- `02_DML_BancoAgricolaRD.sql`: loads normalized records and includes 6 UPDATE statements for branch regions.
- `03_DQL_25_Consultas_BancoAgricolaRD.sql`: contains 25 analytical queries.
- `04_Programacion_SP_Triggers_BancoAgricolaRD.sql`: contains stored procedures and triggers.
- `05_Script_Maestro_Completo_BancoAgricolaRD.sql`: contains everything in one executable master SQL script.
- `00_Ejecutar_en_orden_SQLCMD.sql`: SQLCMD helper file for running the separated scripts in order.

### `diagramas`

Contains conceptual, logical, and physical data model diagrams in SVG format and Mermaid source format. These diagrams document how entities relate to each other and how the relational database is implemented.

### `dashboard`

Contains an interactive HTML dashboard. It can be opened directly in a browser without installing Power BI, Tableau, or Excel.

The dashboard includes:

- KPI cards.
- Bar chart for top branches by loan portfolio.
- Pie chart by destination operation type.
- Disbursements vs collections chart.
- Table of top financed destinations.
- Year filter.
- English/Spanish language switch.
- No-data message for disbursement years outside 2025-2026.

### `powerbi`

Contains a single consolidated CSV file and a Power BI guide.

The file `BancoAgricolaRD_PowerBI_Unificado.csv` is intended for Power BI online. It avoids the need to create table relationships manually because it places the main analytical fields into one flat table.

### `documento`

Contains the final written project report in Markdown and PDF format. The report explains the dataset, problem description, variables, cleaning process, modeling decisions, normalization, SQL scripts, dashboard, findings, and execution instructions.

---

## Database Design

The SQL Server database is named:

```sql
BancoAgricolaRD
```

The normalized model uses dimension tables and fact tables.

### Dimension Tables

| Table | Purpose |
| --- | --- |
| `Periodo` | Stores year, month number, month name, and period date. |
| `Sucursal` | Stores branch names, regions, and status. |
| `Destino` | Stores financing destination, crop/product category, and operation type. |
| `FuenteDato` | Stores source dataset metadata and file traceability. |

### Fact Tables

| Table | Purpose |
| --- | --- |
| `FactCarteraPrestamo` | Stores loan portfolio value and loan count by branch and period. |
| `FactAreaFinanciada` | Stores financed tasks, loan count, and value by branch and period. |
| `FactDesembolsoCobro` | Stores disbursements, collections, and net balance by branch and period. |
| `FactMontoDestino` | Stores granted amounts, operations, tasks, and beneficiaries by destination and period. |

### Control Tables

| Table | Purpose |
| --- | --- |
| `AuditoriaOperacion` | Stores audit records generated by triggers. |
| `CarteraPrestamoHistorico` | Stores historical loan portfolio values before updates. |

---

## SQL Naming Convention

The database scripts follow the naming rule requested for the final project:

- Table names use CamelCase without spaces, for example `Periodo`, `Sucursal`, `FactCarteraPrestamo`, and `AuditoriaOperacion`.
- Column names use the structure `TableName_FieldName`, for example `Periodo_ID`, `Sucursal_Nombre`, `FactCarteraPrestamo_ValorRD`, and `AuditoriaOperacion_Fecha`.
- Physical table columns in the DDL, DML, stored procedures, triggers, and master script were aligned with this convention.

## Convencion de Nombres SQL

Los scripts de base de datos siguen la norma solicitada para el proyecto final:

- Las tablas usan CamelCase sin espacios, por ejemplo `Periodo`, `Sucursal`, `FactCarteraPrestamo` y `AuditoriaOperacion`.
- Los campos usan la estructura `NombreTabla_NombreCampo`, por ejemplo `Periodo_ID`, `Sucursal_Nombre`, `FactCarteraPrestamo_ValorRD` y `AuditoriaOperacion_Fecha`.
- Las columnas fisicas en DDL, DML, stored procedures, triggers y script maestro fueron alineadas con esta convencion.

---

## SQL Requirements Covered

### DDL

The DDL script includes:

- `CREATE DATABASE`
- `CREATE TABLE`
- Primary keys
- Foreign keys
- `UNIQUE` constraints
- `DEFAULT` constraints
- `CHECK` constraints
- Indexes
- Views

### DML

The DML script includes:

- Insertions for all dimension tables.
- Insertions for all fact tables.
- Organized and normalized records.
- 6 UPDATE statements for regional branch classification.

### DQL

The DQL script contains 25 queries using:

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`
- `JOIN`
- Subqueries
- `EXISTS`
- Aggregate functions
- Window functions

### Stored Procedures

The project includes these stored procedures:

| Procedure | Purpose |
| --- | --- |
| `SP_Resumen_Cartera_Por_Anio` | Returns annual loan portfolio totals. |
| `SP_TopSucursales_Cartera` | Returns top branches by portfolio value. |
| `SP_DesembolsosCobros_PorSucursal` | Returns disbursements and collections by branch. |
| `SP_TopDestinos_Financiados` | Returns top financed destinations. |
| `SP_Actualizar_CarteraValor` | Updates a portfolio value for a branch and period. |
| `SP_Indicadores_Periodo` | Returns several indicators for a selected period. |

### Triggers

The project includes three trigger types:

| Trigger | Type | Purpose |
| --- | --- | --- |
| `TR_FactDesembolsoCobro_Auditoria` | Audit | Logs insert, update, and delete operations. |
| `TR_FactCarteraPrestamo_Historico` | Historical | Saves previous loan portfolio values when updated. |
| `TR_FactMontoDestino_Validacion` | Validation | Prevents inconsistent beneficiary counts. |

---

## How To Run The SQL Project

Use Microsoft SQL Server Management Studio or Azure Data Studio connected to SQL Server.

Recommended separated execution order:

```text
1. sql/01_DDL_BancoAgricolaRD.sql
2. sql/02_DML_BancoAgricolaRD.sql
3. sql/04_Programacion_SP_Triggers_BancoAgricolaRD.sql
4. sql/03_DQL_25_Consultas_BancoAgricolaRD.sql
```

Alternative single-file execution:

```text
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

The master script contains the full project in one file.

---

## How To Use The Dashboard

Open this file in a browser:

```text
dashboard/dashboard_banco_agricola.html
```

No server is required. The dashboard is self-contained and uses embedded data.

Use the year selector to filter the dashboard. For disbursements and collections, use:

- `Todos`
- `2025`
- `2026`

If another year is selected, the dashboard will show a no-data message because that source dataset does not contain records for earlier years.

---

## How To Use Power BI Online

For Power BI online, upload this file:

```text
powerbi/BancoAgricolaRD_PowerBI_Unificado.csv
```

Suggested visuals:

| Visual | Fields |
| --- | --- |
| KPI card | `valor_cartera_rd` |
| KPI card | `cantidad_prestamos` |
| KPI card | `desembolsos_rd` |
| KPI card | `cobros_rd` |
| Bar chart | Axis: `sucursal_nombre`; Value: `valor_cartera_rd` |
| Pie chart | Legend: `tipo_operacion`; Value: `valores_destino_rd` |
| Clustered columns | Axis: `periodo_fecha`; Values: `desembolsos_rd`, `cobros_rd` |
| Table | `destino_nombre`, `rubro`, `tipo_operacion`, `valores_destino_rd`, `beneficiados` |
| Filter | `anio` |
| Filter | `tipo_registro` |

The detailed Power BI instructions are in:

```text
powerbi/Guia_PowerBI.md
```

---

## Normalization Summary

### First Normal Form

All fields are atomic. Dates, months, years, branches, destinations, amounts, tasks, and counts are stored in independent columns. Repeating text from raw CSV files was split into structured attributes.

### Second Normal Form

The model separates facts from dimensions. Branch attributes are stored in `Sucursal`, period attributes in `Periodo`, and destination attributes in `Destino`. Fact tables store measurable values and foreign keys.

### Third Normal Form

Non-key attributes depend only on their table key. For example:

- Branch region depends on `Sucursal`.
- Month name depends on `Periodo`.
- Destination rubro and operation type depend on `Destino`.
- Source file metadata depends on `FuenteDato`.

This avoids unnecessary repetition and improves data integrity.

---

## Main Analytical Questions

The database and dashboard help answer questions such as:

- Which branches concentrate the highest agricultural loan portfolio?
- How does the loan portfolio evolve by year?
- Which destinations receive the largest financed amounts?
- How are production and commercialization financing distributed?
- Which regions receive the most financing?
- What is the relationship between disbursements and collections?
- Which months show positive or negative net balances?
- How many beneficiaries are associated with each productive destination?
- Which branches or regions have the largest financed land areas?

---

## Deliverables Included

This repository includes all project deliverables:

- Complete PDF report.
- SQL Server scripts.
- Master SQL script.
- Conceptual, logical, and physical diagrams.
- Dashboard file.
- Power BI-ready dataset.
- Cleaned CSV files.
- Original CSV files.
- Power BI guide.
- Data dictionary and data lineage documentation.
- ERD explanation document.
- Quick start guide for Mac, Linux, and Windows.
- Demo presentation script.
- Teaching DQL script with examples from basic `SELECT` through joins, views, procedures, and triggers.
- Integrity test script.
- Backup and restore template.
- Security roles and read-only user script.
- Performance notes.
- Evidence folder checklist.

---

## Advanced Portfolio Additions

These files extend the project beyond the base academic requirements and make the repository easier to review, reproduce, and present:

| File | Purpose |
| --- | --- |
| `DATA_DICTIONARY.md` | Documents tables, columns, keys, constraints, views, procedures, triggers, and indexes. |
| `DATA_LINEAGE.md` | Explains how raw CSV files become clean data, SQL inserts, dashboard assets, and Power BI output. |
| `QUICK_START.md` | Gives fast execution commands for macOS Docker, Linux Docker, and Windows SQL Server. |
| `DEMO_PRESENTATION_SCRIPT_SPANISH.md` | Provides a Spanish live-demo speaking script and execution sequence. |
| `PERFORMANCE_NOTES.md` | Explains indexes, views, query patterns, and future optimization ideas. |
| `diagramas/DATABASE_ERD_README.md` | Explains the conceptual, logical, and physical ERD diagrams. |
| `evidencias/README.md` | Lists recommended screenshots and evidence files for submission or portfolio. |
| `sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql` | Teaching DQL examples covering basic to advanced SQL topics. |
| `sql/08_Pruebas_Integridad_BancoAgricolaRD.sql` | Validates non-empty tables, foreign keys, negative values, duplicates, totals, procedures, and views. |
| `sql/09_Backup_Restore_BancoAgricolaRD.sql` | Backup and restore template for SQL Server and Docker. |
| `sql/10_Seguridad_Usuarios_Roles_BancoAgricolaRD.sql` | Creates a read-only role and portable no-login user for academic review. |

---

## Suggested GitHub Description

Relational database and dashboard project using Dominican open data from Banco Agricola, including SQL Server scripts, normalization, diagrams, and Power BI-ready datasets.

## Descripcion sugerida para GitHub

Proyecto relacional de base de datos y dashboard usando datos abiertos del Banco Agricola de la Republica Dominicana, con scripts SQL Server, normalizacion, diagramas y archivos listos para Power BI.
