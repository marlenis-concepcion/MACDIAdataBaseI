# Quick Start - BancoAgricolaRD

This file gives the shortest path to run the Banco Agricola RD database project.

## 1. Main Scripts

Run everything:

```text
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

Verify demo data:

```text
sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

Teaching DQL examples:

```text
sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql
```

Integrity tests:

```text
sql/08_Pruebas_Integridad_BancoAgricolaRD.sql
```

## 2. macOS With Docker

Set:

```bash
export PROJECT_DIR=/PATH/TO/proyectofinakl
```

Run:

```bash
cd "$PROJECT_DIR" && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

## 3. Linux With Docker

Set:

```bash
export PROJECT_DIR=/PATH/TO/proyectofinakl
```

Run:

```bash
cd "$PROJECT_DIR" && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

## 4. Windows With Native SQL Server

Windows Authentication:

```powershell
cd C:\PATH\TO\proyectofinakl
sqlcmd -S localhost -E -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost -E -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

SQL Login:

```powershell
cd C:\PATH\TO\proyectofinakl
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

## 5. Expected Verification Counts

```text
Periodo: 108
Sucursal: 33
Destino: 105
FuenteDato: 4
FactCarteraPrestamo: 3455
FactAreaFinanciada: 3456
FactDesembolsoCobro: 480
FactMontoDestino: 4913
```

