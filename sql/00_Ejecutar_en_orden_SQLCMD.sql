/*
    Archivo guia para ejecutar el proyecto en SQL Server Management Studio.
    Active SQLCMD Mode si desea usar los comandos :r, o ejecute los
    archivos 01, 02, 04 y 03 manualmente en ese orden.
*/

:r .\01_DDL_BancoAgricolaRD.sql
:r .\02_DML_BancoAgricolaRD.sql
:r .\04_Programacion_SP_Triggers_BancoAgricolaRD.sql
:r .\03_DQL_25_Consultas_BancoAgricolaRD.sql
