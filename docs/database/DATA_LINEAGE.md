# Data Lineage - BancoAgricolaRD

This document explains how data moves from the original public datasets into the cleaned files, SQL Server database, dashboard, and Power BI assets.

## 1. Lineage Summary

```text
datos/originales/*.csv
        |
        v
Data cleaning and normalization
        |
        v
datos/limpios/dim_*.csv and fact_*.csv
        |
        v
sql/02_DML_BancoAgricolaRD.sql
        |
        v
SQL Server database BancoAgricolaRD
        |
        +--> sql/03_DQL_25_Consultas_BancoAgricolaRD.sql
        +--> sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql
        +--> dashboard/dashboard_banco_agricola.html
        +--> powerbi/BancoAgricolaRD_PowerBI_Unificado.csv
```

## 2. Original Sources

| Original file | Business meaning | Target fact or dimension |
| --- | --- | --- |
| `cartera-de-prestamos-bagricola-2017-2026.csv` | Agricultural loan portfolio by branch and period. | `FactCarteraPrestamo`, `Sucursal`, `Periodo`, `FuenteDato` |
| `areas-financiadas-bagricola-2017-2026.csv` | Financed land areas, loan counts, and values. | `FactAreaFinanciada`, `Sucursal`, `Periodo`, `FuenteDato` |
| `desembolsos-y-cobros-bagricola-2025-2026.csv` | Disbursements and collections by branch and period. | `FactDesembolsoCobro`, `Sucursal`, `Periodo`, `FuenteDato` |
| `montos-otorgados-por-destino-bagricola-2017-2026.csv` | Granted amounts by agricultural destination. | `FactMontoDestino`, `Destino`, `Periodo`, `FuenteDato` |

## 3. Cleaning Rules Applied

| Rule | Description |
| --- | --- |
| Encoding normalization | Original files were read and clean outputs were generated in UTF-8. |
| Header normalization | Extra spaces and inconsistent header names were standardized. |
| Numeric conversion | Amounts, quantities, tasks, and beneficiary counts were converted to numeric types. |
| Period normalization | Year and month fields were converted into `Periodo_Anio`, `Periodo_MesNumero`, `Periodo_MesNombre`, and `Periodo_Fecha`. |
| Branch normalization | Variants such as Higuey/Higuey, Bani/Bani, Cotui/Cotui, and San Fco. Macoris were standardized. |
| Destination parsing | Destination text was split into destination name, rubro, and operation type where possible. |
| Duplicate aggregation | Records that represented the same entity and period after normalization were aggregated. |
| Surrogate keys | Integer IDs were created for period, branch, destination, source, and fact tables. |

## 4. Cleaned Files

| Clean file | Purpose |
| --- | --- |
| `dim_periodo.csv` | Normalized time dimension. |
| `dim_sucursal.csv` | Normalized branch dimension with regions. |
| `dim_destino.csv` | Normalized destination dimension with rubro and operation type. |
| `fact_cartera_prestamo.csv` | Loan portfolio fact records. |
| `fact_area_financiada.csv` | Financed area fact records. |
| `fact_desembolso_cobro.csv` | Disbursement and collection fact records. |
| `fact_monto_destino.csv` | Amount-by-destination fact records. |
| `resumen_desembolsos_cobros_mensual.csv` | Monthly summary for validation and dashboard use. |

## 5. SQL Loading Path

The cleaned data is embedded as SQL `INSERT` statements in:

```text
sql/02_DML_BancoAgricolaRD.sql
```

The full master script also contains the same load:

```text
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

Execution order:

```text
01_DDL_BancoAgricolaRD.sql
02_DML_BancoAgricolaRD.sql
04_Programacion_SP_Triggers_BancoAgricolaRD.sql
03_DQL_25_Consultas_BancoAgricolaRD.sql
```

Or:

```text
05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

## 6. Data Quality Controls

Controls are implemented through:

- Primary keys.
- Foreign keys.
- Unique constraints.
- Check constraints for valid months, years, statuses, regions, and non-negative values.
- Verification script: `sql/06_Verificacion_Demo_BancoAgricolaRD.sql`.
- Integrity test script: `sql/08_Pruebas_Integridad_BancoAgricolaRD.sql`.

## 7. Downstream Outputs

| Output | Source |
| --- | --- |
| Final report | Markdown documentation and project SQL outputs. |
| Dashboard HTML | Aggregated project data and KPIs. |
| Power BI CSV | Unified analytical CSV prepared from cleaned/model-ready data. |
| Presentation | Summarized project findings and deliverables. |

