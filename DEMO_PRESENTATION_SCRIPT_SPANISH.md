# Guion De Demo - Proyecto Banco Agricola RD

Este guion ayuda a presentar el proyecto final en vivo.

## 1. Apertura

Buenos dias/tardes. Este proyecto presenta una solucion completa de base de datos usando datos abiertos del Banco Agricola de la Republica Dominicana.

El objetivo fue transformar archivos CSV separados en una base de datos relacional normalizada en SQL Server, con consultas analiticas, stored procedures, triggers, dashboard, Power BI y documentacion.

## 2. Mostrar La Estructura Del Proyecto

Abrir la carpeta del proyecto y mostrar:

```text
datos/originales/
datos/limpios/
sql/
diagramas/
documento/
dashboard/
powerbi/
```

Frase sugerida:

> Aqui se conserva la trazabilidad: los datos originales no se modifican, los datos limpios se guardan aparte y SQL Server recibe datos ya normalizados.

## 3. Mostrar Los Datos Originales

Archivos clave:

```text
cartera-de-prestamos-bagricola-2017-2026.csv
areas-financiadas-bagricola-2017-2026.csv
desembolsos-y-cobros-bagricola-2025-2026.csv
montos-otorgados-por-destino-bagricola-2017-2026.csv
```

Frase sugerida:

> Se integraron cuatro datasets relacionados con cartera, areas financiadas, desembolsos, cobros y montos por destino.

## 4. Mostrar El Modelo

Abrir:

```text
diagramas/01_modelo_conceptual.svg
diagramas/02_modelo_logico.svg
diagramas/03_modelo_fisico.svg
```

Explicar:

- Dimensiones: `Periodo`, `Sucursal`, `Destino`, `FuenteDato`.
- Hechos: `FactCarteraPrestamo`, `FactAreaFinanciada`, `FactDesembolsoCobro`, `FactMontoDestino`.
- Control: `AuditoriaOperacion`, `CarteraPrestamoHistorico`.

## 5. Ejecutar La Base

En macOS con Docker:

```bash
cd "$PROJECT_DIR" && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

Frase sugerida:

> Este script maestro crea la base, tablas, restricciones, indices, vistas, inserta los datos, crea procedimientos, triggers y deja consultas analiticas listas.

## 6. Verificar Que Las Tablas Tienen Datos

Ejecutar:

```bash
docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

Resultados esperados:

```text
Periodo: 108
Sucursal: 33
Destino: 105
FactCarteraPrestamo: 3455
FactAreaFinanciada: 3456
FactDesembolsoCobro: 480
FactMontoDestino: 4913
```

Frase sugerida:

> Esta verificacion confirma que las tablas no estan vacias y que la carga se realizo correctamente.

## 7. Mostrar Consultas DQL

Abrir:

```text
sql/03_DQL_25_Consultas_BancoAgricolaRD.sql
sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql
```

Explicar que hay ejemplos de:

- `SELECT`
- `WHERE`
- `ORDER BY`
- `DISTINCT`
- `GROUP BY`
- `HAVING`
- `JOIN`
- Subconsultas
- `EXISTS`
- `CASE`
- Funciones agregadas
- Funciones de ventana
- Vistas
- Stored procedures
- Triggers

## 8. Mostrar Stored Procedures Y Triggers

Archivo:

```text
sql/04_Programacion_SP_Triggers_BancoAgricolaRD.sql
```

Frase sugerida:

> Los stored procedures encapsulan consultas reutilizables, mientras que los triggers agregan auditoria, historico y validaciones.

## 9. Mostrar Dashboard

Abrir:

```text
dashboard/dashboard_banco_agricola.html
```

Mostrar:

- KPIs.
- Top sucursales.
- Distribucion por destino.
- Desembolsos vs cobros.
- Filtros por anio.

## 10. Mostrar Power BI

Archivos:

```text
powerbi/BancoAgricolaRD_PowerBI_Unificado.csv
powerbi/Guia_PowerBI.md
```

Frase sugerida:

> Tambien se preparo un archivo consolidado para Power BI Online o Desktop, junto con una guia para construir los visuales.

## 11. Cierre

Hallazgos principales:

- Cartera total integrada: RD$ 4,328,206,887,618.
- Prestamos registrados: 4,505,198.
- Areas financiadas: 11,864,365 tareas.
- Desembolsos registrados: RD$ 31,595,581,251.
- Cobros registrados: RD$ 30,614,020,812.
- Montos por destino: RD$ 241,148,789,863.

Frase final:

> En conclusion, el proyecto convierte datos abiertos en una solucion de base de datos completa, normalizada, consultable, auditable y lista para analisis visual.

