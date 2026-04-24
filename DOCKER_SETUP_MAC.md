# Docker Setup Guide For macOS

This guide explains how to run the Banco Agricola RD database project on macOS using Docker.

---

## 1. Requirements

You need:

- macOS.
- Docker Desktop installed and running.
- The project folder downloaded locally.
- A SQL Server container.

Project folder:

```bash
/PATH/TO/proyectofinakl
```

Database name:

```text
BancoAgricolaRD
```

---

## 2. Check Docker Is Running

Run:

```bash
docker ps
```

If Docker is not running, open Docker Desktop and wait until it finishes starting.

---

## 3. Find The SQL Server Container

Run:

```bash
docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

Look for a container using:

```text
mcr.microsoft.com/mssql/server
```

In this project, the container name is:

```text
sql1
```

---

## 4. Start SQL Server

Run:

```bash
docker start sql1
```

Wait a few seconds:

```bash
sleep 30
```

---

## 5. Important macOS Detail

On macOS, this may not work:

```bash
sqlcmd
```

If you see:

```text
zsh: command not found: sqlcmd
```

that is okay. Use `sqlcmd` inside Docker instead:

```bash
docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd
```

---

## 6. Run The Whole Project In One Command

Paste this command:

```bash
cd /PATH/TO/proyectofinakl && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

This command:

1. Opens the project folder.
2. Starts the container `sql1`.
3. Reads the `sa` password from Docker.
4. Waits for SQL Server.
5. Runs the master script.
6. Runs the demo verification script.

---

## 7. If The Container Does Not Exist

Create it:

```bash
docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=YOUR_STRONG_PASSWORD!' -p 1433:1433 --name sql1 -d mcr.microsoft.com/mssql/server:2022-latest
```

Then run:

```bash
docker start sql1
```

---

## 8. Test The Connection Only

```bash
SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT DB_NAME(), @@VERSION;"
```

---

## 9. Expected Success

The verification should show:

```text
Periodo: 108
Sucursal: 33
Destino: 105
FactCarteraPrestamo: 3455
FactAreaFinanciada: 3456
FactDesembolsoCobro: 480
FactMontoDestino: 4913
```

If you see those counts, the database is ready.

