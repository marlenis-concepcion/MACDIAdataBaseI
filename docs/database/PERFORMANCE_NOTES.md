# Performance Notes - BancoAgricolaRD

This document explains performance-related decisions in the Banco Agricola RD database.

## 1. Performance Goals

The database is designed to support:

- Analytical queries by year and month.
- Rankings by branch and destination.
- Aggregations over portfolio, financed area, disbursement, collection, and granted amount facts.
- Dashboard and Power BI reporting.
- Repeatable academic demo execution.

## 2. Modeling Decisions

The model separates dimensions and facts:

- Dimensions reduce repeated descriptive values.
- Facts store numeric measures and foreign keys.
- This structure makes joins predictable and aggregation easier.

The model follows 1NF, 2NF, and 3NF, which reduces redundancy and improves consistency.

## 3. Indexes Created

| Index | Table | Why it helps |
| --- | --- | --- |
| `IX_FactCartera_Periodo` | `FactCarteraPrestamo` | Speeds annual and monthly portfolio analysis. |
| `IX_FactCartera_Sucursal` | `FactCarteraPrestamo` | Speeds top branch queries. |
| `IX_FactArea_Periodo` | `FactAreaFinanciada` | Speeds financed area analysis by period. |
| `IX_FactDesembolso_Periodo` | `FactDesembolsoCobro` | Speeds disbursement and collection comparisons. |
| `IX_FactMontoDestino_Periodo` | `FactMontoDestino` | Speeds destination financing analysis by period. |
| `IX_Destino_Rubro` | `Destino` | Speeds filtering and grouping by rubro and operation type. |

## 4. Views Created

Views predefine common analytical patterns:

- `VW_CarteraPorSucursalAnio`
- `VW_DesembolsosVsCobrosMensual`
- `VW_DestinosTopFinanciamiento`
- `VW_AreasFinanciadasSucursal`

These views make reporting easier and reduce repeated query logic.

## 5. Query Patterns

Most analytical queries use:

- Joins from facts to dimensions.
- Filters by `Periodo_Anio`.
- Grouping by branch, region, destination, or year.
- Aggregates such as `SUM`, `COUNT`, `AVG`, `MIN`, and `MAX`.

These patterns are supported by the indexes on foreign keys and included measure columns.

## 6. Demo Performance

The current dataset size is academic and lightweight:

```text
FactCarteraPrestamo: 3455 records
FactAreaFinanciada: 3456 records
FactDesembolsoCobro: 480 records
FactMontoDestino: 4913 records
```

This means the database should run quickly in:

- Docker SQL Server on macOS.
- Docker SQL Server on Linux.
- Native SQL Server on Windows.

## 7. Future Optimization Ideas

If the dataset grows, recommended improvements include:

- Add composite indexes for high-frequency query patterns.
- Add indexed views for stable dashboard aggregates.
- Partition fact tables by year.
- Add database maintenance jobs.
- Add statistics update scripts.
- Add query execution plan review for the heaviest DQL queries.

