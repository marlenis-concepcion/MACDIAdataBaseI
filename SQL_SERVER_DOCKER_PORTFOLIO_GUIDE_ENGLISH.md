# SQL Server And Docker Portfolio Guide English

This guide explains how to run the Banco Agricola RD database project depending on the operating system.

It is written for portfolio readers, classmates, and future project reviewers. The goal is to document the real setup clearly:

- macOS users normally run SQL Server through Docker.
- Linux users normally run SQL Server through Docker.
- Windows users usually run SQL Server natively and do not need Docker.
- AI assistants should not assume the container name, local tools, or password location.

---

## 1. Project Files

Main database script:

```text
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

Demo verification script:

```text
sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

Teaching DQL script:

```text
sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql
```

Database name:

```text
BancoAgricolaRD
```

Recommended environment variable:

```bash
PROJECT_DIR=/PATH/TO/proyectofinakl
```

---

## 2. macOS Setup With Docker

SQL Server does not run natively on macOS, so Docker is the practical option.

### 2.1. Check Docker

```bash
docker ps
```

If Docker is not running, open Docker Desktop.

### 2.2. Find The SQL Server Container

```bash
docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

In this project, the container used during development was:

```text
sql1
```

### 2.3. Run The Full Project

```bash
cd "$PROJECT_DIR" && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

### 2.4. Run The Teaching DQL Script

```bash
cd "$PROJECT_DIR" && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql
```

---

## 3. Linux Setup With Docker

Linux users can also run SQL Server through Docker.

### 3.1. Check Docker

```bash
docker ps
```

If permission is denied, use:

```bash
sudo docker ps
```

### 3.2. Run The Full Project

```bash
cd "$PROJECT_DIR" && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

With `sudo`:

```bash
cd "$PROJECT_DIR" && sudo docker start sql1 && SA_PASSWORD="$(sudo docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && sudo docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && sudo docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

---

## 4. Windows Setup Without Docker

Windows users usually do not need Docker because SQL Server runs natively on Windows.

### 4.1. Start SQL Server

Default SQL Server instance:

```powershell
net start MSSQLSERVER
```

SQL Server Express:

```powershell
net start MSSQL$SQLEXPRESS
```

### 4.2. Run With Windows Authentication

```powershell
cd C:\PATH\TO\proyectofinakl
sqlcmd -S localhost -E -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost -E -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

For SQL Server Express:

```powershell
cd C:\PATH\TO\proyectofinakl
sqlcmd -S localhost\SQLEXPRESS -E -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost\SQLEXPRESS -E -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

### 4.3. Run With SQL Login

```powershell
cd C:\PATH\TO\proyectofinakl
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

---

## 5. Important Troubleshooting Notes

### 5.1. Local `sqlcmd` May Not Exist On macOS

If this fails:

```bash
sqlcmd
```

Use the tool inside Docker:

```bash
docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd
```

### 5.2. ODBC Driver 18 Certificate Option

When using `/opt/mssql-tools18/bin/sqlcmd`, include:

```bash
-C
```

This trusts the SQL Server certificate used by the container.

### 5.3. Stop On SQL Errors

Use:

```bash
-b
```

This makes `sqlcmd` stop when an error occurs.

### 5.4. SQL Server SET Options

The project requires:

```sql
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
```

These settings are already included in the DDL and master script.

---

## 6. Expected Verification Output

The verification script should show:

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

If these values appear, the database is loaded and ready for demo.

---

## 7. Related Guides

Detailed supporting guides:

```text
DOCKER_AI_TROUBLESHOOTING_GUIDE.md
DOCKER_SETUP_MAC.md
DOCKER_SETUP_LINUX.md
WINDOWS_SQL_SERVER_SETUP.md
```

