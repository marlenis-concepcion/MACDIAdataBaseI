# Database ERD Explanation - BancoAgricolaRD

This document explains the conceptual, logical, and physical diagrams included in this folder.

## 1. Diagram Files

| File | Purpose |
| --- | --- |
| `01_modelo_conceptual.mmd` | Mermaid source for conceptual model. |
| `01_modelo_conceptual.svg` | Rendered conceptual model. |
| `02_modelo_logico.mmd` | Mermaid source for logical model. |
| `02_modelo_logico.svg` | Rendered logical model. |
| `03_modelo_fisico.mmd` | Mermaid source for physical model. |
| `03_modelo_fisico.svg` | Rendered physical model. |

## 2. Conceptual Model

The conceptual model shows the main business objects:

- Periods.
- Branches.
- Destinations.
- Source datasets.
- Portfolio facts.
- Financed area facts.
- Disbursement and collection facts.
- Destination amount facts.

It focuses on meaning, not SQL details.

## 3. Logical Model

The logical model organizes the solution into:

- Dimension tables.
- Fact tables.
- Control tables.

Main relationships:

```text
Periodo 1:* FactCarteraPrestamo
Periodo 1:* FactAreaFinanciada
Periodo 1:* FactDesembolsoCobro
Periodo 1:* FactMontoDestino

Sucursal 1:* FactCarteraPrestamo
Sucursal 1:* FactAreaFinanciada
Sucursal 1:* FactDesembolsoCobro

Destino 1:* FactMontoDestino
FuenteDato 1:* Fact tables
```

## 4. Physical Model

The physical model aligns with SQL Server implementation.

It includes:

- Table names.
- Primary keys.
- Foreign keys.
- Measures.
- Control tables.

The SQL implementation is located in:

```text
../sql/01_DDL_BancoAgricolaRD.sql
```

## 5. Why This Model Works

The model supports:

- Branch analysis.
- Regional analysis.
- Year and month analysis.
- Destination analysis.
- Portfolio, area, disbursement, collection, and beneficiary metrics.
- Audit and historical tracking.

