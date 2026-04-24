# Docker Setup Guide For Linux

This guide explains how to run the Banco Agricola RD database project on Linux using Docker and SQL Server.

It works for Ubuntu, Debian, Fedora, CentOS, RHEL, Rocky Linux, AlmaLinux, Arch Linux, and most distributions that can run Docker.

---

## 1. Requirements

You need:

- Linux, including Ubuntu, Debian, Fedora, CentOS/RHEL, Rocky/AlmaLinux, and Arch.
- Docker installed.
- Permission to run Docker commands.
- The project folder downloaded locally.

Database name:

```text
BancoAgricolaRD
```

---

## 2. Install Or Check Docker

First check if Docker exists:

```bash
docker --version
```

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
```

### Fedora

```bash
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
```

### CentOS / RHEL / Rocky Linux / AlmaLinux

```bash
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
```

If `docker` is not available in the default repositories, install Docker Engine from the official Docker repository for that distribution.

### Arch Linux

```bash
sudo pacman -Syu docker
sudo systemctl enable docker
sudo systemctl start docker
```

Then verify:

```bash
docker ps
```

If you get a permission error, try:

```bash
sudo docker ps
```

Or add your user to the Docker group:

```bash
sudo usermod -aG docker "$USER"
```

Then log out and log back in.

For a quick temporary workaround, keep using `sudo docker` in the commands.

---

## 3. Find The SQL Server Container

```bash
docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

Look for:

```text
mcr.microsoft.com/mssql/server
```

Expected container name:

```text
sql1
```

---

## 4. Start SQL Server

```bash
docker start sql1
```

Wait:

```bash
sleep 30
```

---

## 5. Run The Whole Project In One Command

From the project folder, adjust the path if needed:

```bash
cd /PATH/TO/proyectofinakl && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

If your system requires `sudo` for Docker:

```bash
cd /PATH/TO/proyectofinakl && sudo docker start sql1 && SA_PASSWORD="$(sudo docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && sudo docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && sudo docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

---

## 6. If The Container Does Not Exist

Create it:

```bash
docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=YOUR_STRONG_PASSWORD!' -p 1433:1433 --name sql1 -d mcr.microsoft.com/mssql/server:2022-latest
```

With sudo:

```bash
sudo docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=YOUR_STRONG_PASSWORD!' -p 1433:1433 --name sql1 -d mcr.microsoft.com/mssql/server:2022-latest
```

---

## 7. Test The Connection Only

```bash
SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT DB_NAME(), @@VERSION;"
```

---

## 8. Expected Success

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

If these counts appear, the database is loaded and ready.
