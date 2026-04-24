/*
    ===============================================================
    BACKUP Y RESTORE - BancoAgricolaRD

    Nota:
    Ajustar la ruta BACKUP_PATH segun el sistema operativo, permisos
    y ubicacion disponible dentro del servidor SQL Server.
    ===============================================================
*/

USE master;
GO

/*
    EJEMPLO 1: BACKUP EN SQL SERVER LOCAL WINDOWS

    BACKUP DATABASE BancoAgricolaRD
    TO DISK = N'C:\Backups\BancoAgricolaRD.bak'
    WITH INIT, FORMAT, NAME = N'BancoAgricolaRD Full Backup';
    GO
*/

/*
    EJEMPLO 2: BACKUP EN SQL SERVER DENTRO DE DOCKER

    Dentro del contenedor SQL Server se usa una ruta existente:
    /var/opt/mssql/data/BancoAgricolaRD.bak
*/

-- BACKUP recomendado para Docker:
BACKUP DATABASE BancoAgricolaRD
TO DISK = N'/var/opt/mssql/data/BancoAgricolaRD.bak'
WITH INIT, FORMAT, NAME = N'BancoAgricolaRD Full Backup';
GO

/*
    Para copiar el backup desde Docker hacia la computadora:

    docker cp sql1:/var/opt/mssql/data/BancoAgricolaRD.bak ./BancoAgricolaRD.bak
*/

/*
    EJEMPLO DE RESTORE

    Usar solo si se desea restaurar desde backup. Este bloque queda
    comentado para evitar sobrescribir la base por accidente.

    ALTER DATABASE BancoAgricolaRD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    RESTORE DATABASE BancoAgricolaRD
    FROM DISK = N'/var/opt/mssql/data/BancoAgricolaRD.bak'
    WITH REPLACE;

    ALTER DATABASE BancoAgricolaRD SET MULTI_USER;
    GO
*/
