BANCO AGRICOLA RD DATABASE PROJECT
PROYECTO FINAL BASE DE DATOS I

English:
This repository contains a complete relational database project built from open government datasets related to the Dominican Republic's Banco Agricola. It includes raw data, cleaned data, a normalized SQL Server database model, DDL, DML, DQL, stored procedures, triggers, conceptual/logical/physical diagrams, a final PDF report, an HTML dashboard, and a Power BI-ready consolidated CSV.

Espanol:
Este repositorio contiene un proyecto completo de base de datos relacional construido con datos abiertos del Banco Agricola de la Republica Dominicana. Incluye datos originales, datos limpios, modelo normalizado para SQL Server, DDL, DML, DQL, stored procedures, triggers, diagramas conceptual/logico/fisico, documento PDF final, dashboard HTML y un CSV consolidado listo para Power BI online.

ACADEMIC CONTEXT / CONTEXTO ACADEMICO

- University / Universidad: Universidad Autonoma de Santo Domingo (UASD)
- Program / Programa: Maestria en Ciencias de Datos e Inteligencia Artificial
- Course / Asignatura: Base de Datos I
- Project / Proyecto: Final integrador
- Topic / Tema: Banco Agricola RD open data

PROJECT PURPOSE / PROPOSITO DEL PROYECTO

English:
The project demonstrates the full lifecycle of a database solution: selecting a dataset, analyzing its structure, cleaning and preparing data, designing conceptual/logical/physical models, implementing a SQL Server database, loading normalized data, writing analytical queries, adding stored procedures and triggers, justifying normalization, and producing a dashboard for visual analysis.

Espanol:
El proyecto demuestra el ciclo completo de una solucion de base de datos: seleccion del dataset, analisis de estructura, limpieza y preparacion, diseno conceptual/logico/fisico, implementacion en SQL Server, carga normalizada, consultas analiticas, stored procedures, triggers, justificacion de normalizacion y dashboard visual.

DATASETS USED / DATASETS UTILIZADOS

1. Cartera de prestamos agricolas
   - Coverage / Cobertura: 2017-2026
   - Purpose / Uso: cantidad de prestamos y valor RD$ por sucursal y periodo.

2. Areas financiadas por el Banco Agricola
   - Coverage / Cobertura: 2017-2026
   - Purpose / Uso: tareas financiadas, prestamos y valor RD$ por sucursal y periodo.

3. Desembolsos y cobros
   - Coverage / Cobertura: 2025-2026
   - Purpose / Uso: desembolsos RD$, cobros RD$ y balance neto por sucursal y periodo.
   - Important / Importante: este archivo solo trae 2025-2026. Si se filtra 2017-2024 no hay datos para esta grafica.

4. Montos otorgados por destino agricola
   - Coverage / Cobertura: 2017-2026
   - Purpose / Uso: valores otorgados, cantidad, tareas y beneficiados por destino productivo.

PROJECT METRICS / METRICAS DEL PROYECTO

- Original CSV rows / Filas originales: 12,436
- Normalized fact records / Registros factuales normalizados: 12,304
- Periods / Periodos: 108
- Branches / Sucursales: 33
- Destinations / Destinos: 105
- DQL queries / Consultas DQL: 25
- Stored procedures: 6
- Triggers: 3
- UPDATE statements / Sentencias UPDATE: 6

MAIN FOLDERS / CARPETAS PRINCIPALES

- dashboard/
  Contains the interactive HTML dashboard. It can be opened directly in a browser.
  Contiene el dashboard HTML interactivo. Se abre directamente en el navegador.

- datos/originales/
  Contains the original downloaded CSV files.
  Contiene los CSV originales descargados.

- datos/limpios/
  Contains normalized and cleaned CSV files used for loading and analysis.
  Contiene los CSV limpios y normalizados usados para carga y analisis.

- diagramas/
  Contains conceptual, logical, and physical model diagrams in SVG and Mermaid.
  Contiene los diagramas conceptual, logico y fisico en SVG y Mermaid.

- documento/
  Contains the final report in PDF and Markdown.
  Contiene el informe final en PDF y Markdown.

- powerbi/
  Contains the Power BI guide and a single consolidated CSV for Power BI online.
  Contiene la guia Power BI y un unico CSV consolidado para Power BI online.

- sql/
  Contains separated SQL scripts and one master SQL script.
  Contiene scripts SQL separados y un script maestro completo.

KEY FILES / ARCHIVOS CLAVE

- documento/Proyecto_Final_Banco_Agricola.pdf
  Final written project report.
  Documento final del proyecto.

- dashboard/dashboard_banco_agricola.html
  Functional dashboard.
  Dashboard funcional.

- powerbi/BancoAgricolaRD_PowerBI_Unificado.csv
  Single file for Power BI online.
  Archivo unico para subir a Power BI online.

- sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
  Complete SQL master script with DDL, DML, stored procedures, triggers, and DQL.
  Script maestro con DDL, DML, stored procedures, triggers y DQL.

- sql/01_DDL_BancoAgricolaRD.sql
  Database creation script.
  Script de creacion de base de datos.

- sql/02_DML_BancoAgricolaRD.sql
  Data load script.
  Script de carga de datos.

- sql/03_DQL_25_Consultas_BancoAgricolaRD.sql
  Analytical query script.
  Script de consultas analiticas.

- sql/04_Programacion_SP_Triggers_BancoAgricolaRD.sql
  Stored procedures and triggers.
  Stored procedures y triggers.

SQL EXECUTION ORDER / ORDEN DE EJECUCION SQL

Separated files / Archivos separados:

1. sql/01_DDL_BancoAgricolaRD.sql
2. sql/02_DML_BancoAgricolaRD.sql
3. sql/04_Programacion_SP_Triggers_BancoAgricolaRD.sql
4. sql/03_DQL_25_Consultas_BancoAgricolaRD.sql

Single master file / Archivo maestro unico:

sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql

DATABASE MODEL / MODELO DE BASE DE DATOS

Database name / Nombre de base de datos:
BancoAgricolaRD

Dimension tables / Tablas dimension:
- Periodo
- Sucursal
- Destino
- FuenteDato

Fact tables / Tablas de hechos:
- FactCarteraPrestamo
- FactAreaFinanciada
- FactDesembolsoCobro
- FactMontoDestino

Control tables / Tablas de control:
- AuditoriaOperacion
- CarteraPrestamoHistorico

SQL FEATURES COVERED / ELEMENTOS SQL CUBIERTOS

- CREATE DATABASE
- CREATE TABLE
- Primary keys
- Foreign keys
- UNIQUE constraints
- DEFAULT constraints
- CHECK constraints
- Indexes
- Views
- INSERT statements
- UPDATE statements
- SELECT queries
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- JOINs
- Subqueries
- Aggregate functions
- Stored procedures
- Audit trigger
- Historical trigger
- Validation trigger

POWER BI ONLINE USAGE / USO EN POWER BI ONLINE

Upload this file:
powerbi/BancoAgricolaRD_PowerBI_Unificado.csv

Suggested visuals / Visuales sugeridos:

- KPI card: valor_cartera_rd
- KPI card: cantidad_prestamos
- KPI card: desembolsos_rd
- KPI card: cobros_rd
- Bar chart: sucursal_nombre vs valor_cartera_rd
- Pie chart: tipo_operacion vs valores_destino_rd
- Clustered columns: periodo_fecha with desembolsos_rd and cobros_rd
- Table: destino_nombre, rubro, tipo_operacion, valores_destino_rd, beneficiados
- Filters: anio, tipo_registro

DASHBOARD USAGE / USO DEL DASHBOARD

Open:
dashboard/dashboard_banco_agricola.html

The dashboard includes:
- KPI cards
- Top branches by loan portfolio
- Destination operation type pie chart
- Disbursements vs collections chart
- Top financed destinations table
- Year filter
- No-data message for disbursement years outside 2025-2026

NORMALIZATION / NORMALIZACION

1NF / 1FN:
All fields are atomic. Numeric values, periods, branches, destinations, and measures are stored in separate columns.

2NF / 2FN:
Descriptive fields were separated into dimensions. Facts only store measures and foreign keys.

3NF / 3FN:
Non-key attributes depend only on their table key. Region depends on branch, month name depends on period, and rubro/type depends on destination.

MAIN ANALYTICAL QUESTIONS / PREGUNTAS ANALITICAS

- Which branches concentrate the largest agricultural loan portfolio?
- Which destinations receive the largest amounts?
- How do disbursements compare with collections?
- Which years show the strongest portfolio values?
- How many beneficiaries are associated with each destination?
- How are production and commercialization financing distributed?
- Which regions receive more agricultural financing?

DELIVERABLES INCLUDED / ENTREGABLES INCLUIDOS

- Complete PDF report
- SQL scripts
- Master SQL script
- Conceptual, logical, and physical diagrams
- Functional dashboard
- Power BI-ready CSV
- Cleaned CSV files
- Original CSV files
- Power BI guide

GITHUB DESCRIPTION / DESCRIPCION PARA GITHUB

English:
Relational database and dashboard project using Dominican open data from Banco Agricola, including SQL Server scripts, normalization, diagrams, and Power BI-ready datasets.

Espanol:
Proyecto relacional de base de datos y dashboard usando datos abiertos del Banco Agricola de la Republica Dominicana, con scripts SQL Server, normalizacion, diagramas y archivos listos para Power BI.

