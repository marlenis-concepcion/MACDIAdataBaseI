# Windows SQL Server Setup Guide

This guide is for Windows users. Unlike macOS and many Linux setups, Windows users usually do not need Docker because SQL Server can run natively on Windows.

Use this guide if you have:

- SQL Server Developer, Express, or Enterprise installed locally.
- SQL Server Management Studio, Azure Data Studio, Visual Studio Code, or `sqlcmd`.
- The Banco Agricola RD project folder downloaded locally.

---

## 1. Project Scripts

The main scripts are:

```text
sql/05_Script_Maestro_Completo_BancoAgricolaRD.sql
sql/06_Verificacion_Demo_BancoAgricolaRD.sql
```

The database created is:

```text
BancoAgricolaRD
```

---

## 2. Start SQL Server On Windows

Open PowerShell as Administrator.

For the default SQL Server instance:

```powershell
net start MSSQLSERVER
```

For SQL Server Express:

```powershell
net start MSSQL$SQLEXPRESS
```

If the service is already running, Windows will tell you.

---

## 3. Run The Project With Windows Authentication

If your SQL Server accepts Windows Authentication, run this from the project folder:

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

---

## 4. Run The Project With SQL Login

If you use the `sa` user or another SQL login:

```powershell
cd C:\PATH\TO\proyectofinakl
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost -U sa -P "YOUR_PASSWORD" -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

For SQL Server Express:

```powershell
cd C:\PATH\TO\proyectofinakl
sqlcmd -S localhost\SQLEXPRESS -U sa -P "YOUR_PASSWORD" -i .\sql\05_Script_Maestro_Completo_BancoAgricolaRD.sql
sqlcmd -S localhost\SQLEXPRESS -U sa -P "YOUR_PASSWORD" -d BancoAgricolaRD -i .\sql\06_Verificacion_Demo_BancoAgricolaRD.sql
```

---

## 5. If `sqlcmd` Is Not Recognized

If PowerShell says:

```text
sqlcmd: The term 'sqlcmd' is not recognized
```

Install Microsoft SQL Server command line tools, or run the scripts from:

- SQL Server Management Studio.
- Azure Data Studio.
- Visual Studio Code with the SQL Server extension.

---

## 6. Expected Verification Results

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

If these counts appear, the database is loaded successfully.

---

## 7. When Windows Users Should Use Docker

Windows users only need Docker if:

- They do not want to install SQL Server locally.
- Their local SQL Server installation is broken.
- They want to match a Mac/Linux development environment.
- The professor specifically asks for Docker.

Otherwise, native SQL Server is simpler on Windows.
