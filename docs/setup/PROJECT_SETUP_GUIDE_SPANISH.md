# Project Setup Guide Spanish

### 1. Proposito

Esta guia describe un flujo reutilizable para construir un proyecto de datos completo, academico o apto para portafolio, a partir de cualquier dataset. El objetivo es transformar datos originales en una solucion estructurada con base de datos, documentacion, scripts SQL, diagramas, dashboard y archivos listos para Power BI.

La guia se puede adaptar a diferentes temas como finanzas, educacion, ventas, salud, datos abiertos gubernamentales, operaciones, logistica o cualquier otro dominio con datos estructurados.

### 2. Entregables Finales Esperados

Un paquete completo de Proyecto X debe incluir:

- Archivos de datos originales.
- Archivos de datos limpios.
- Resumen de analisis del dataset.
- Modelo conceptual de datos.
- Modelo logico de datos.
- Modelo fisico de datos.
- Script DDL para SQL Server.
- Script DML para SQL Server.
- Consultas analiticas DQL.
- Stored procedures, triggers, vistas e indices.
- Explicacion de normalizacion: 1FN, 2FN y 3FN.
- Informe final en Markdown y PDF.
- Dashboard HTML interactivo.
- CSV o archivos preparados para Power BI.
- Guia de configuracion de Power BI.
- Presentacion final.
- README con inventario completo de archivos.

### 3. Estructura Recomendada de Carpetas

```text
proyecto_x/
├── README.md
├── README.txt
├── PROJECT_X_SETUP_GUIDE_EN_ES.md
├── presentacion_final_proyecto_x.pptx
├── consigna/
│   └── instrucciones_proyecto.pdf
├── datos/
│   ├── originales/
│   │   └── dataset_original.csv
│   └── limpios/
│       ├── dim_entidad.csv
│       └── fact_medida.csv
├── diagramas/
│   ├── 01_modelo_conceptual.mmd
│   ├── 01_modelo_conceptual.svg
│   ├── 02_modelo_logico.mmd
│   ├── 02_modelo_logico.svg
│   ├── 03_modelo_fisico.mmd
│   └── 03_modelo_fisico.svg
├── documento/
│   ├── informe_final_proyecto_x.md
│   └── informe_final_proyecto_x.pdf
├── dashboard/
│   └── dashboard_proyecto_x.html
├── powerbi/
│   ├── proyecto_x_powerbi_unificado.csv
│   └── guia_powerbi.md
├── sql/
│   ├── 00_ejecutar_en_orden_sqlcmd.sql
│   ├── 01_ddl_proyecto_x.sql
│   ├── 02_dml_proyecto_x.sql
│   ├── 03_dql_proyecto_x.sql
│   ├── 04_programacion_sp_triggers_proyecto_x.sql
│   └── 05_script_maestro_completo_proyecto_x.sql
└── herramientas/
    └── scripts_de_generacion_o_limpieza
```

### 4. Precondiciones

Antes de iniciar, el responsable del proyecto debe tener:

- Un dataset en CSV, XLSX, JSON, TXT, SQL u otro formato estructurado.
- La consigna de la tarea, si el proyecto es academico.
- Visual Studio Code u otro editor de codigo.
- Acceso a SQL Server.
- Extension de SQL Server para Visual Studio Code, como `SQL Server (mssql)`.
- Permiso para crear bases de datos, tablas, vistas, stored procedures y triggers.
- Power BI Desktop, Power BI Service o acceso a Power BI desde navegador.
- Navegador web para abrir el dashboard HTML.

Para usuarios de macOS, SQL Server puede usarse mediante:

- Una instancia remota de SQL Server.
- Una maquina virtual.
- Docker.
- Un servidor de base de datos de la universidad o empresa.
- Visual Studio Code con la extension `SQL Server (mssql)`.

### 5. Informacion Requerida del Usuario

Para construir el proyecto, se debe recopilar:

- Nombre del estudiante o responsable.
- Institucion u organizacion.
- Asignatura o contexto del proyecto.
- Profesor o evaluador, si aplica.
- Fecha de entrega.
- Archivos del dataset.
- Consigna del proyecto.
- Motor de base de datos preferido.
- Cantidad requerida de consultas.
- Diagramas requeridos.
- Dashboard o herramienta BI requerida.
- Reglas especificas de formato.

### 6. Revision del Dataset

Se inicia inspeccionando el dataset:

- Identificar todas las columnas.
- Detectar entidades principales.
- Revisar tipos de datos.
- Verificar valores nulos.
- Verificar duplicados.
- Detectar campos de fecha o periodo.
- Detectar medidas numericas.
- Detectar campos categoricos.
- Revisar codificacion y separadores.
- Identificar problemas de calidad de datos.

Preguntas utiles:

- Que representa cada fila?
- Que pregunta academica o de negocio puede responder el dataset?
- Que columnas son atributos descriptivos?
- Que columnas son medidas?
- Que campos pueden convertirse en dimensiones?
- Que campos deben convertirse en tablas de hechos?

### 7. Limpieza de Datos

Tareas comunes de limpieza:

- Convertir archivos a UTF-8.
- Estandarizar nombres de columnas.
- Eliminar espacios sobrantes.
- Convertir texto numerico en valores numericos.
- Convertir fechas a formatos validos.
- Estandarizar nombres de categorias.
- Unificar entidades duplicadas.
- Eliminar registros invalidos o documentarlos.
- Crear archivos limpios de dimensiones.
- Crear archivos limpios de hechos.

Los archivos limpios deben guardarse separados de los originales para conservar trazabilidad.

### 8. Modelado de Datos

El proyecto debe incluir tres niveles de modelo.

Modelo conceptual:

- Muestra las entidades principales.
- Muestra relaciones generales.
- Evita detalles tecnicos de base de datos.

Modelo logico:

- Define tablas.
- Define claves primarias.
- Define claves foraneas.
- Define atributos.
- Muestra relaciones uno a muchos.

Modelo fisico:

- Define nombres de tablas para SQL Server.
- Define tipos de datos.
- Define restricciones.
- Define indices.
- Define vistas.
- Se alinea directamente con la implementacion SQL.

### 9. Implementacion en SQL Server

Crear los scripts SQL en este orden.

Script DDL:

- Crea la base de datos.
- Crea las tablas.
- Crea claves primarias.
- Crea claves foraneas.
- Crea restricciones `UNIQUE`, `DEFAULT` y `CHECK`.
- Crea indices.
- Crea vistas.

Script DML:

- Inserta datos de dimensiones.
- Inserta datos de hechos.
- Incluye actualizaciones requeridas.
- Conserva integridad referencial.

Script DQL:

- Incluye consultas analiticas.
- Usa `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, joins, subconsultas y funciones agregadas.
- Puede incluir funciones de ventana cuando sea util.

Script de programacion:

- Crea stored procedures.
- Crea triggers.
- Crea logica de auditoria o historico.
- Crea reglas de validacion.

Script maestro:

- Combina todo el flujo SQL en un solo archivo ejecutable.

### 10. Configuracion de Power BI

Preparar una de estas opciones:

- Un CSV unificado para Power BI Online.
- O varios CSV limpios con relaciones para Power BI Desktop.

Visuales recomendados:

- Tarjetas KPI.
- Grafico de barras.
- Grafico de lineas.
- Grafico de pastel o dona.
- Tabla o matriz.
- Filtros por ano, categoria, region o entidad.

Contenido recomendado para la guia:

- Archivo que se debe subir.
- Tipos de datos que se deben configurar.
- Relaciones que se deben crear.
- Medidas DAX que se deben agregar.
- Visuales que se deben construir.
- Filtros que se deben incluir.
- Pasos para exportar o presentar.

### 11. Configuracion del Dashboard

El dashboard HTML debe ser autocontenido siempre que sea posible.

Debe incluir:

- KPIs principales.
- Filtros.
- Al menos un grafico de ranking.
- Al menos un grafico de distribucion.
- Al menos un grafico temporal si existen fechas.
- Tabla resumen.
- Mensajes cuando no haya datos para los filtros seleccionados.

### 12. Informe Final

El informe final debe incluir:

- Portada.
- Introduccion.
- Descripcion del dataset.
- Planteamiento del problema de datos.
- Proceso de limpieza.
- Modelos de datos.
- Implementacion SQL.
- Resumen de consultas DQL.
- Stored procedures y triggers.
- Explicacion de normalizacion.
- Explicacion del dashboard.
- Hallazgos principales.
- Conclusiones.
- Inventario de archivos.

### 13. Presentacion Final

La presentacion debe resumir:

- Titulo del proyecto.
- Contexto.
- Dataset.
- Proceso de limpieza.
- Modelo de datos.
- Implementacion SQL.
- Consultas analiticas.
- Stored procedures y triggers.
- Dashboard y Power BI.
- Hallazgos principales.
- Conclusiones.

### 14. Checklist de Calidad

Antes de entregar, verificar:

- Los datos originales estan conservados.
- Los datos limpios estan disponibles.
- Los scripts SQL se ejecutan en orden.
- Las tablas cargan sin errores.
- Las claves foraneas son validas.
- Las consultas devuelven resultados utiles.
- Los stored procedures ejecutan correctamente.
- Los triggers funcionan como se espera.
- Los diagramas coinciden con la base de datos.
- El dashboard abre correctamente.
- El archivo o guia de Power BI es usable.
- El informe final esta completo.
- La presentacion esta lista.
- El README explica el proyecto completo.

### 15. Flujo Ultra Detallado Para Replicar el Proyecto

Esta seccion replica, en formato generico, el mismo proceso recomendado y aplicado en el proyecto del Banco Agricola RD. Sirve como guia operacional para crear un Proyecto X completo desde cero con cualquier dataset.

#### 15.1. Recibir y organizar los insumos

Antes de escribir codigo o SQL, crear una carpeta base para el proyecto y guardar todo de forma ordenada.

Entradas minimas:

- Dataset original.
- Consigna del proyecto.
- Nombre del estudiante o responsable.
- Nombre de la institucion.
- Asignatura o contexto.
- Fecha de entrega.
- Requisitos de SQL, dashboard, Power BI o presentacion.

Ubicacion recomendada:

```text
datos/originales/
consigna/
```

Regla importante:

```text
Nunca modificar directamente el dataset original.
```

El dataset original debe conservarse como evidencia y trazabilidad. Toda limpieza debe generar archivos nuevos dentro de `datos/limpios/`.

#### 15.2. Preparar variables locales de entorno

Para evitar rutas personales dentro del codigo, crear dos archivos:

```text
.env.example
.env.local
```

El archivo `.env.example` se comparte en el proyecto y sirve como plantilla.

El archivo `.env.local` contiene rutas reales de la computadora de la persona y debe ignorarse en Git.

Variables recomendadas:

```text
PROJECT_DIR=/PATH/TO/project_x
DATA_RAW_DIR=/PATH/TO/project_x/datos/originales
DATA_CLEAN_DIR=/PATH/TO/project_x/datos/limpios
SQL_DIR=/PATH/TO/project_x/sql
DASHBOARD_DIR=/PATH/TO/project_x/dashboard
POWERBI_DIR=/PATH/TO/project_x/powerbi
REPORT_INPUT_PATH=/PATH/TO/project_x/documento/informe.md
REPORT_OUTPUT_PATH=/PATH/TO/project_x/documento/informe.pdf
PRESENTATION_OUTPUT_PATH=/PATH/TO/project_x/presentacion_final.pptx
```

Agregar al `.gitignore`:

```text
.env.local
.env.*.local
```

Esto permite que cada persona configure su propia PC sin exponer rutas privadas.

#### 15.3. Revisar la consigna antes del dataset

Leer la consigna y anotar requisitos concretos.

Checklist de consigna:

- Motor requerido: SQL Server, MySQL, PostgreSQL u otro.
- Cantidad minima de tablas.
- Cantidad minima de consultas.
- Si exige DDL.
- Si exige DML.
- Si exige DQL.
- Si exige stored procedures.
- Si exige triggers.
- Si exige vistas.
- Si exige indices.
- Si exige normalizacion.
- Si exige dashboard.
- Si exige Power BI.
- Si exige PDF.
- Si exige presentacion.

Crear una tabla de control en el README o informe:

```text
Requisito | Archivo donde se cumple | Estado
```

#### 15.4. Perfilar el dataset

Revisar cada archivo original y documentar:

- Numero de filas.
- Numero de columnas.
- Codificacion.
- Separador.
- Columnas con fechas.
- Columnas numericas.
- Columnas categoricas.
- Valores nulos.
- Duplicados.
- Entidades repetidas.
- Posibles errores ortograficos.
- Posibles campos que deben convertirse a numeros.

Preguntas clave:

- Que representa una fila?
- Cual es la entidad principal?
- Hay fechas o periodos?
- Hay montos, cantidades, conteos o medidas?
- Hay categorias repetidas que conviene separar?
- Hay nombres de sucursales, clientes, productos o regiones repetidos?

#### 15.5. Definir el tema y el problema de datos

El proyecto debe explicar que problema resuelve.

Estructura recomendada:

```text
Este proyecto integra datos de [tema] para analizar [medidas principales] por [dimensiones principales], permitiendo responder preguntas sobre [objetivo academico o de negocio].
```

Ejemplo generico:

```text
Este proyecto integra datos de ventas para analizar ingresos, unidades vendidas y clientes por periodo, producto y region, permitiendo identificar tendencias, categorias principales y oportunidades de mejora.
```

#### 15.6. Disenar la limpieza

Crear un plan de limpieza antes de generar datos limpios.

Acciones comunes:

- Renombrar columnas con nombres consistentes.
- Convertir textos a UTF-8.
- Quitar espacios sobrantes.
- Normalizar acentos y variantes.
- Convertir fechas.
- Convertir numeros con comas o simbolos monetarios.
- Agrupar duplicados reales.
- Crear IDs sustitutos.
- Separar dimensiones.
- Separar hechos.

Salida esperada:

```text
datos/limpios/dim_periodo.csv
datos/limpios/dim_entidad.csv
datos/limpios/dim_categoria.csv
datos/limpios/fact_transaccion.csv
```

Los nombres cambian segun el tema, pero la logica se mantiene.

#### 15.7. Crear dimensiones y hechos

Separar datos descriptivos y datos medibles.

Dimensiones comunes:

- Periodo.
- Cliente.
- Producto.
- Categoria.
- Sucursal.
- Region.
- Departamento.
- Proveedor.
- Destino.

Hechos comunes:

- Venta.
- Prestamo.
- Pago.
- Movimiento.
- Registro academico.
- Servicio.
- Inventario.
- Transaccion.

Regla practica:

```text
Las dimensiones describen. Los hechos miden.
```

Ejemplo:

```text
Dimension Producto: producto_id, producto_nombre, categoria.
Hecho Venta: venta_id, producto_id, periodo_id, cantidad, monto.
```

#### 15.8. Crear diagramas

Crear tres diagramas.

Modelo conceptual:

- Entidades principales.
- Relaciones generales.
- Sin tipos de datos.

Modelo logico:

- Tablas.
- PK.
- FK.
- Atributos.
- Relaciones uno a muchos.

Modelo fisico:

- Nombres definitivos.
- Tipos SQL.
- Restricciones.
- Indices.
- Vistas.

Archivos esperados:

```text
diagramas/01_modelo_conceptual.mmd
diagramas/01_modelo_conceptual.svg
diagramas/02_modelo_logico.mmd
diagramas/02_modelo_logico.svg
diagramas/03_modelo_fisico.mmd
diagramas/03_modelo_fisico.svg
```

#### 15.9. Crear DDL

El DDL debe construir toda la estructura.

Debe incluir:

- `CREATE DATABASE`.
- `CREATE TABLE`.
- `PRIMARY KEY`.
- `FOREIGN KEY`.
- `UNIQUE`.
- `DEFAULT`.
- `CHECK`.
- `CREATE INDEX`.
- `CREATE VIEW`.

Recomendacion:

```text
El DDL debe poder ejecutarse desde cero y recrear la base completa.
```

Si el proyecto es para demo, puede incluir:

```sql
IF DB_ID(N'NombreBase') IS NOT NULL
BEGIN
    ALTER DATABASE NombreBase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE NombreBase;
END;
GO
```

Esto facilita reiniciar la base durante pruebas.

#### 15.10. Crear DML con datos reales

El DML es indispensable para que las tablas no queden vacias durante el demo.

Debe incluir `INSERT INTO` para:

- Dimensiones.
- Tablas de hechos.
- Fuentes de datos.
- Tablas de catalogo.

Tambien puede incluir `UPDATE` si la consigna lo pide.

Reglas:

- Insertar primero dimensiones.
- Insertar luego hechos.
- Respetar claves foraneas.
- Usar IDs consistentes.
- Cargar suficientes registros para demostrar analisis.

Orden recomendado:

```text
Periodo
Entidades descriptivas
Fuentes de datos
Hechos/transacciones
Actualizaciones
```

#### 15.11. Crear DQL analitico

El DQL demuestra que la base sirve para responder preguntas.

Debe incluir consultas como:

- Total por ano.
- Top 10 por monto.
- Ranking por categoria.
- Comparacion entre periodos.
- Agrupacion por region.
- Promedios.
- Maximos y minimos.
- Subconsultas.
- `HAVING`.
- `EXISTS`.
- Funciones de ventana.

Meta recomendada:

```text
Crear 25 consultas si la consigna no especifica otra cantidad.
```

#### 15.12. Crear stored procedures y triggers

Stored procedures recomendados:

- Resumen por ano.
- Top N entidades.
- Consulta por categoria.
- Indicadores por periodo.
- Actualizacion controlada.

Triggers recomendados:

- Auditoria de cambios.
- Historico antes de actualizar.
- Validacion de reglas de negocio.

Tablas de control recomendadas:

```text
AuditoriaOperacion
HistoricoEntidad
```

#### 15.13. Crear script maestro

El script maestro debe permitir ejecutar todo desde un solo archivo.

Debe incluir:

```text
DDL
DML
Stored procedures
Triggers
Consultas de prueba
```

Archivo recomendado:

```text
sql/05_Script_Maestro_Completo_ProyectoX.sql
```

#### 15.14. Crear script de verificacion para demo

Este paso es clave para evitar sorpresas.

Crear:

```text
sql/06_Verificacion_Demo_ProyectoX.sql
```

Debe mostrar:

- Conteo de registros por tabla.
- Totales generales.
- Top 10 de alguna entidad.
- Resumen anual o mensual.
- Prueba de una vista.
- Prueba de un stored procedure.

Consultas recomendadas:

```sql
SELECT 'TablaPrincipal' AS Tabla, COUNT(*) AS Registros
FROM dbo.TablaPrincipal;
```

Y una consulta de control:

```sql
SELECT
    (SELECT COUNT(*) FROM dbo.Dimension1) AS TotalDimension1,
    (SELECT COUNT(*) FROM dbo.Hecho1) AS TotalHecho1;
```

Si alguna tabla principal devuelve cero, el demo no esta listo.

#### 15.15. Probar en SQL Server

Orden de ejecucion:

```text
01_DDL
02_DML
04_Programacion_SP_Triggers
03_DQL
06_Verificacion_Demo
```

O:

```text
05_Script_Maestro_Completo
06_Verificacion_Demo
```

Verificar:

- No hay errores de sintaxis.
- No hay errores de claves foraneas.
- Los conteos son mayores que cero.
- Las consultas devuelven resultados.
- Los procedimientos ejecutan.
- Los triggers funcionan.

#### 15.16. Crear dashboard HTML

El dashboard debe abrir sin depender de configuraciones complejas.

Debe incluir:

- KPIs.
- Filtros.
- Grafico de barras.
- Grafico de distribucion.
- Grafico temporal si hay fechas.
- Tabla de resultados.
- Mensajes cuando no hay datos.

Ejemplo de KPIs:

- Total registros.
- Total monto.
- Total cantidad.
- Promedio.
- Top categoria.

#### 15.17. Preparar Power BI

Crear un archivo:

```text
powerbi/ProyectoX_PowerBI_Unificado.csv
```

O varios archivos:

```text
dim_periodo.csv
dim_entidad.csv
fact_transaccion.csv
```

Crear tambien:

```text
powerbi/Guia_PowerBI.md
```

La guia debe indicar:

- Archivo a subir.
- Tipos de datos.
- Relaciones.
- Medidas DAX.
- Visuales.
- Filtros.
- Como exportar evidencia.

#### 15.18. Crear informe final

El informe debe contar la historia completa del proyecto.

Secciones recomendadas:

- Portada.
- Introduccion.
- Descripcion del dataset.
- Problema de datos.
- Variables principales.
- Limpieza.
- Modelo conceptual.
- Modelo logico.
- Modelo fisico.
- Implementacion SQL.
- DML y carga.
- DQL.
- Stored procedures y triggers.
- Normalizacion.
- Dashboard.
- Power BI.
- Hallazgos.
- Conclusion.
- Inventario de archivos.

#### 15.19. Crear presentacion final

La presentacion debe ser clara para exposicion.

Estructura recomendada:

```text
1. Portada
2. Agenda
3. Contexto
4. Dataset
5. Limpieza
6. Modelo de datos
7. SQL Server
8. Consultas DQL
9. Stored procedures y triggers
10. Dashboard
11. Power BI
12. Hallazgos
13. Conclusiones
```

#### 15.20. Preparar el demo

Antes del demo:

- Abrir SQL Server.
- Verificar conexion.
- Ejecutar script maestro.
- Ejecutar script de verificacion.
- Abrir dashboard HTML.
- Abrir informe PDF.
- Abrir presentacion.
- Tener Power BI listo o capturas si no hay Power BI Desktop.

Guion de demo sugerido:

```text
1. Mostrar dataset original.
2. Mostrar datos limpios.
3. Mostrar modelo fisico.
4. Ejecutar conteo de registros.
5. Ejecutar top 10.
6. Ejecutar stored procedure.
7. Mostrar dashboard.
8. Mostrar Power BI o guia.
9. Cerrar con hallazgos.
```

#### 15.21. Reglas de seguridad para portafolio

Antes de publicar:

- No incluir `.env.local`.
- No incluir contrasenas.
- No incluir rutas personales.
- No incluir credenciales SQL.
- No incluir archivos privados del profesor si no se permite.
- Usar `.env.example`.
- Usar variables en mayusculas para rutas.

Ejemplo correcto:

```text
PROJECT_DIR=/PATH/TO/project
```

Ejemplo que no debe publicarse:

```text
LOCAL_USER_HOME/Documentos/proyecto
```

#### 15.22. Checklist final antes de entregar o publicar

- [ ] Dataset original guardado.
- [ ] Datos limpios generados.
- [ ] DDL completo.
- [ ] DML con inserts reales.
- [ ] Tablas no vacias.
- [ ] DQL probado.
- [ ] Stored procedures probados.
- [ ] Triggers probados.
- [ ] Script maestro listo.
- [ ] Script de verificacion listo.
- [ ] Dashboard abre correctamente.
- [ ] Power BI preparado.
- [ ] Informe final completo.
- [ ] Presentacion lista.
- [ ] `.env.example` incluido.
- [ ] `.env.local` ignorado.
- [ ] README actualizado.
