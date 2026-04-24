# Guia De SQL Server Y Docker Para Portafolio Spanish

Esta guia explica como ejecutar el proyecto de base de datos Banco Agricola RD segun el sistema operativo.

Esta escrita para portafolio, companeros y revisores tecnicos. La idea es documentar claramente la configuracion real:

- En macOS normalmente se usa SQL Server con Docker.
- En Linux normalmente se usa SQL Server con Docker.
- En Windows normalmente se usa SQL Server nativo y no hace falta Docker.
- Un asistente de IA no debe asumir el nombre del contenedor, las herramientas locales ni la ubicacion del password.

---

## 1. Archivos Del Proyecto

Script principal de base de datos:

```text
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
```

Script de verificacion para demo:

```text
sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

Script DQL didactico:

```text
sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql
```

Nombre de la base de datos:

```text
BancoAgricolaRD
```

Variable de entorno recomendada:

```bash
PROJECT_DIR=/RUTA/A/proyectofinakl
```

---

## 2. Configuracion En macOS Con Docker

SQL Server no corre de forma nativa en macOS, por eso Docker es la opcion practica.

### 2.1. Verificar Docker

```bash
docker ps
```

Si Docker no esta corriendo, abrir Docker Desktop.

### 2.2. Encontrar El Contenedor SQL Server

```bash
docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

En este proyecto, el contenedor usado durante el desarrollo fue:

```text
sql1
```

### 2.3. Ejecutar El Proyecto Completo

```bash
cd "$PROJECT_DIR" && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

### 2.4. Ejecutar El Script DQL Didactico

```bash
cd "$PROJECT_DIR" && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/07_DQL_Ejemplos_Didacticos_BancoAgricolaRD.sql
```

---

## 3. Configuracion En Linux / Ubuntu Con Docker

Usuarios de Linux, incluyendo Ubuntu, tambien pueden correr SQL Server usando Docker.

### 3.1. Verificar Docker

En Ubuntu, verificar si Docker esta instalado:

```bash
docker --version
```

Si Docker no esta instalado:

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
```

Luego ejecutar:

```bash
docker ps
```

Si aparece error de permisos:

```bash
sudo docker ps
```

### 3.2. Ejecutar El Proyecto Completo

```bash
cd "$PROJECT_DIR" && docker start sql1 && SA_PASSWORD="$(docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

Con `sudo`:

```bash
cd "$PROJECT_DIR" && sudo docker start sql1 && SA_PASSWORD="$(sudo docker inspect sql1 --format '{{range .Config.Env}}{{println .}}{{end}}' | awk -F= '/^(MSSQL_SA_PASSWORD|SA_PASSWORD)=/{print $2; exit}')" && sleep 30 && sudo docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b < sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql && sudo docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -b -d BancoAgricolaRD < sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

---

## 4. Configuracion En Windows Sin Docker

En Windows normalmente no hace falta Docker porque SQL Server corre nativo.

### 4.1. Iniciar SQL Server

Instancia por defecto:

```powershell
net start MSSQLSERVER
```

SQL Server Express:

```powershell
net start MSSQL$SQLEXPRESS
```

### 4.2. Ejecutar Con Autenticacion De Windows

```powershell
cd C:\RUTA\A\proyectofinakl
sqlcmd -S localhost -E -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost -E -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

Para SQL Server Express:

```powershell
cd C:\RUTA\A\proyectofinakl
sqlcmd -S localhost\SQLEXPRESS -E -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost\SQLEXPRESS -E -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

### 4.3. Ejecutar Con Login SQL

```powershell
cd C:\RUTA\A\proyectofinakl
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

---

## 5. Notas Importantes De Solucion De Problemas

### 5.1. En macOS Puede No Existir `sqlcmd` Local

Si falla:

```bash
sqlcmd
```

Usar la herramienta dentro del contenedor:

```bash
docker exec -i sql1 /opt/mssql-tools18/bin/sqlcmd
```

### 5.2. Certificado Con ODBC Driver 18

Cuando se usa `/opt/mssql-tools18/bin/sqlcmd`, incluir:

```bash
-C
```

Esto acepta el certificado usado por el contenedor SQL Server.

### 5.3. Detenerse Ante Errores SQL

Usar:

```bash
-b
```

Esto hace que `sqlcmd` se detenga si ocurre un error.

### 5.4. Opciones SET De SQL Server

El proyecto requiere:

```sql
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
```

Estas opciones ya estan incluidas en el DDL y en el script maestro.

---

## 6. Resultado Esperado De Verificacion

El script de verificacion debe mostrar:

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

Si aparecen estos valores, la base esta cargada y lista para demo.

---

## 7. Guias Relacionadas

Guias tecnicas de apoyo:

```text
DOCKER_AI_TROUBLESHOOTING_GUIDE.md
DOCKER_SETUP_MAC.md
DOCKER_SETUP_LINUX.md
WINDOWS_SQL_SERVER_SETUP.md
```
