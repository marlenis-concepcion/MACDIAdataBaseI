# Docker AI Troubleshooting Guide

This guide is written for an AI assistant or technical helper that needs to support a student running the Banco Agricola RD SQL Server project with Docker.

The goal is to avoid the confusion that happened during setup and quickly identify the real problem.

---

## 1. Context

The project runs on:

- macOS.
- Docker.
- Microsoft SQL Server container.
- SQL scripts stored in the local project folder.
- `sqlcmd` executed from inside the SQL Server Docker container.

The project folder is:

```bash
/PATH/TO/proyectofinakl
```

The SQL Server database is:

```text
BancoAgricolaRD
```

The main scripts are:

```text
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

---

## 2. What Went Wrong Initially

The first mistakes were:

1. Assuming the container name was `sqlserver`.
2. Assuming `sqlcmd` was installed on macOS.
3. Asking the user for the `sa` password when it was already stored in the Docker container environment.
4. Not detecting that the user had previously created a container named `sql1`.
5. Not accounting for SQL Server requiring `SET QUOTED_IDENTIFIER ON` for computed columns, indexed views, filtered indexes, or related SQL Server features.

The correct container was:

```text
sql1
```

The correct `sqlcmd` path inside the container was:

```text
/opt/mssql-tools18/bin/sqlcmd
```

---

## 3. Correct Diagnosis Steps

When helping someone with this project, do this first.

### Step 1. Check Docker containers

```bash
docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

Look for a SQL Server container using an image like:

```text
mcr.microsoft.com/mssql/server:2022-latest
```

In this project, the container name was:

```text
sql1
```

### Step 2. Start the container

```bash
docker start sql1
```

### Step 3. Do not assume local `sqlcmd`

On macOS, this may fail:

```bash
sqlcmd
```

If it says:

```text
zsh: command not found: sqlcmd
```

use the `sqlcmd` inside the Docker container.

### Step 4. Detect the `sa` password from Docker

Do not ask the user to remember the password first. Try to read it from the container:

```bash
docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}'
```

Then extract it:

```bash
SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')"
```

### Step 5. Test connection

```bash
docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT @@VERSION;"
```

If this works, SQL Server is reachable.

---

## 4. Final Working Command

This is the final working command used for the Banco Agricola RD project:

```bash
cd /PATH/TO/proyectofinakl && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

What it does:

1. Enters the project folder.
2. Starts Docker container `sql1`.
3. Reads the `sa` password from the container environment.
4. Waits for SQL Server to finish starting.
5. Runs the master database script.
6. Runs the demo verification script.

---

## 5. SQL Error That Was Resolved

The SQL script initially failed with:

```text
CREATE TABLE failed because the following SET options have incorrect settings: 'QUOTED_IDENTIFIER'.
```

The fix was to add these lines after `USE BancoAgricolaRD;` in:

```text
sql/01_DDL_BancoAgricolaRD.sql
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

Required SQL settings:

```sql
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
```

After this fix, the database loaded correctly.

---

## 6. Expected Verification Results

The verification script should show counts like:

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

If these counts appear, the database is loaded and ready for demo.

---

## 7. Assistant Rules For This Project

When helping with this project:

- Do not assume the Docker container name.
- Do not assume `sqlcmd` is installed locally.
- Prefer `docker exec` with `/opt/mssql-tools18/bin/sqlcmd`.
- Try to read the password from Docker before asking the user.
- Use `-C` with ODBC Driver 18 to trust the SQL Server certificate.
- Use `-b` so script execution stops on SQL errors.
- Run the verification script after the master script.
- If a SQL Server SET option error appears, check `ANSI_NULLS` and `QUOTED_IDENTIFIER`.

