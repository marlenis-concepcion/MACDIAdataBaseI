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

---

## Suggested GitHub Description

Relational database and dashboard project using Dominican open data from Banco Agricola, including SQL Server scripts, normalization, diagrams, and Power BI-ready datasets.

## Descripcion sugerida para GitHub

Proyecto relacional de base de datos y dashboard usando datos abiertos del Banco Agricola de la Republica Dominicana, con scripts SQL Server, normalizacion, diagramas y archivos listos para Power BI.
