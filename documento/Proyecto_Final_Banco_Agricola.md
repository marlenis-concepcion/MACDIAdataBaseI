# Proyecto Final: Banco Agricola RD

Universidad Autonoma de Santo Domingo (UASD)
Maestria en Ciencias de Datos e Inteligencia Artificial
Asignatura: Base de Datos I - INF-8236
Estudiante: Marlenis Judith Concepcion Cuevas
Tema: Modelado, implementacion y analisis de datos abiertos del Banco Agricola
Fecha de entrega indicada: 2 de mayo de 2026
Fecha de presentacion indicada: 3 de mayo de 2026

---

**Autora:** Marlenis Judith Concepcion Cuevas
**LinkedIn:** [linkedin.com/in/marlenis-judith-c-561117a3](https://www.linkedin.com/in/marlenis-judith-c-561117a3/)
**Instagram:** [@marlenisj.concepcionc](https://www.instagram.com/marlenisj.concepcionc/)

---

## 1. Analisis del Dataset

El proyecto utiliza cuatro conjuntos de datos abiertos relacionados con el Banco Agricola de la Republica Dominicana: cartera de prestamos agricolas, areas financiadas, desembolsos y cobros, y montos otorgados por destino. El problema de datos consiste en integrar archivos separados, con nombres de sucursales no siempre uniformes, para construir una base de datos relacional que permita responder preguntas sobre financiamiento agricola, concentracion por sucursal, destinos productivos, desembolsos, cobros y areas financiadas.

El periodo cubierto por la base integrada va de 2017 a 2026. Los archivos originales contienen 12,436 filas; despues de normalizar sucursales, periodos y destinos, se cargan 12,304 registros factuales en el modelo.

### Variables Principales

| Area | Variables |
| --- | --- |
| Periodo | año, mes, fecha del periodo |
| Sucursal | nombre, region, estatus |
| Destino agricola | destino, rubro, tipo de operacion |
| Cartera | cantidad de prestamos, valor RD$ |
| Areas financiadas | tareas, cantidad de prestamos, valor RD$ |
| Desembolsos y cobros | desembolsos RD$, cobros RD$, balance neto |
| Montos por destino | cantidad, valores RD$, tareas, beneficiados |

### Limpieza y Preparacion

- Se leyeron los CSV originales en codificacion ISO-8859 y se generaron copias limpias en UTF-8.
- Se eliminaron espacios sobrantes en encabezados, meses y nombres.
- Se convirtieron montos y cantidades con separadores de miles a valores numericos.
- Se normalizaron variantes de sucursales, por ejemplo Higuey/Higüey, Bani/Baní, Cotui/Cotuí, San Fco. Macoris/San Francisco de Macorís.
- Se crearon llaves sustitutas para Periodo, Sucursal, Destino y FuenteDato.
- Cuando una misma sucursal o destino quedo duplicado por diferencias ortograficas, se agregaron sus valores por periodo.

## 2. Modelado de Datos

El modelo conceptual separa dimensiones descriptivas de hechos medibles. Periodo, Sucursal, Destino y FuenteDato actuan como dimensiones. Las tablas FactCarteraPrestamo, FactAreaFinanciada, FactDesembolsoCobro y FactMontoDestino almacenan las metricas del negocio.

El modelo logico define claves primarias, claves foraneas, reglas de unicidad por periodo y entidad, y restricciones CHECK para valores no negativos. El modelo fisico esta implementado para Microsoft SQL Server e incluye indices, vistas, triggers, historicos y auditoria.

Diagramas incluidos:
- diagramas/01_modelo_conceptual.svg
- diagramas/02_modelo_logico.svg
- diagramas/03_modelo_fisico.svg
- Versiones Mermaid .mmd para edicion posterior.

## 3. Base de Datos Fisica

La base se llama BancoAgricolaRD. El script DDL crea las tablas Periodo, Sucursal, Destino, FuenteDato, las cuatro tablas de hechos, la tabla de auditoria y el historico de cartera. Tambien crea indices y vistas analiticas.

Restricciones incluidas:
- PK en todas las tablas principales.
- FK desde hechos hacia dimensiones.
- UNIQUE para evitar duplicidad de periodos, sucursales, destinos y hechos por entidad-periodo.
- DEFAULT para estatus, regiones, fecha de carga y usuarios de auditoria.
- CHECK para meses validos, años esperados, regiones validas y valores no negativos.
- Indices por periodo, sucursal, destino y rubro.
- Vistas: VW_CarteraPorSucursalAnio, VW_DesembolsosVsCobrosMensual, VW_DestinosTopFinanciamiento y VW_AreasFinanciadasSucursal.

## 4. DML y Carga

El archivo 02_DML_BancoAgricolaRD.sql inserta las dimensiones y hechos normalizados. Incluye tambien las 6 sentencias UPDATE solicitadas para enriquecer las sucursales con regiones: Metropolitana, Este, Sur, Cibao Norte, Cibao Nordeste y Cibao Noroeste.

Registros cargados:
- Cartera de prestamos: 3,455
- Areas financiadas: 3,456
- Desembolsos y cobros: 480
- Montos por destino: 4,913
- Periodos: 108
- Sucursales normalizadas: 33
- Destinos normalizados: 105

## 5. Consultas DQL

El archivo 03_DQL_25_Consultas_BancoAgricolaRD.sql contiene 25 consultas con SELECT, WHERE, ORDER BY, GROUP BY, HAVING, JOINs, subconsultas, EXISTS, funciones agregadas y funciones de ventana. Las consultas cubren cartera anual, top de sucursales, desembolsos versus cobros, destinos mas financiados, participacion por region y comparaciones entre hechos.

## 6. Programacion en Base de Datos

El archivo 04_Programacion_SP_Triggers_BancoAgricolaRD.sql incluye seis stored procedures:

- SP_Resumen_Cartera_Por_Anio
- SP_TopSucursales_Cartera
- SP_DesembolsosCobros_PorSucursal
- SP_TopDestinos_Financiados
- SP_Actualizar_CarteraValor
- SP_Indicadores_Periodo

Triggers incluidos:
- TR_FactDesembolsoCobro_Auditoria: registra INSERT, UPDATE y DELETE.
- TR_FactCarteraPrestamo_Historico: guarda valores anteriores ante actualizaciones de cartera.
- TR_FactMontoDestino_Validacion: valida consistencia entre cantidad de operaciones y beneficiados.

## 7. Normalizacion

Primera Forma Normal: cada campo almacena un dato atomico. Los montos, tareas, cantidades, meses y años fueron separados en columnas independientes y convertidos a tipos numericos o fecha.

Segunda Forma Normal: las tablas de hechos dependen de la clave de su hecho y de sus dimensiones. Los atributos descriptivos de sucursal, destino y periodo se movieron a dimensiones propias, evitando que se repitan en cada registro transaccional.

Tercera Forma Normal: los atributos no clave no dependen de otros atributos no clave. La region depende de Sucursal y no de una tabla de hechos; el rubro y tipo de operacion dependen de Destino; la descripcion del archivo depende de FuenteDato.

## 8. Dashboard

El dashboard funcional esta en dashboard/dashboard_banco_agricola.html. Es un archivo HTML autosuficiente que puede abrirse en el navegador y permite filtrar por año. Tambien se incluye powerbi/Guia_PowerBI.md con las relaciones, medidas DAX y visuales recomendados para reconstruirlo en Power BI.

Incluye:

- Indicadores de cartera total, prestamos, desembolsos, cobros, tareas y beneficiados.
- Grafico de barras con el top de sucursales por cartera.
- Grafico de pastel por tipo de destino.
- Grafico comparativo de desembolsos y cobros.
- Tabla de destinos con mayor monto otorgado.

## 9. Hallazgos Principales

Cartera total integrada: RD$ 4,328,206,887,618 en 4,505,198 prestamos.
Areas financiadas: 11,864,365 tareas.
Desembolsos registrados: RD$ 31,595,581,251.
Cobros registrados: RD$ 30,614,020,812.
Montos por destino: RD$ 241,148,789,863 para 216,930 beneficiados.

Top sucursales por cartera:
- Monte Plata: RD$ 315,620,424,841
- San José de Ocoa: RD$ 304,046,494,152
- Santo Domingo: RD$ 274,819,668,838
- San Juan de la Maguana: RD$ 244,881,270,479
- Valverde Mao: RD$ 215,901,846,665

Top destinos por monto otorgado:
- Arroz (Producción): RD$ 31,157,715,701
- Agro. Manufactura, Comercio V. y Otros: RD$ 28,257,806,361
- Otros: RD$ 27,225,670,224
- Arroz (Comercialización): RD$ 19,233,906,194
- Microempresas y Otros: RD$ 11,496,901,555

Distribucion por tipo de operacion:
- General: RD$ 135,895,401,173
- Producción: RD$ 58,448,923,706
- Comercialización: RD$ 30,691,672,156
- Comerc.: RD$ 9,255,641,357
- Pignoración: RD$ 4,816,311,117
- Com.: RD$ 995,978,705

Cartera anual:
- 2017: RD$ 207,923,317,671
- 2018: RD$ 308,189,296,191
- 2019: RD$ 338,081,051,222
- 2020: RD$ 359,005,842,737
- 2021: RD$ 444,315,305,610
- 2022: RD$ 534,009,307,615
- 2023: RD$ 633,398,785,923
- 2024: RD$ 668,323,563,038
- 2025: RD$ 668,106,428,978
- 2026: RD$ 166,853,988,633

## 10. Instrucciones de Ejecucion

Ejecutar en SQL Server en este orden:

```sql
01_DDL_BancoAgricolaRD.sql
02_DML_BancoAgricolaRD.sql
04_Programacion_SP_Triggers_BancoAgricolaRD.sql
03_DQL_25_Consultas_BancoAgricolaRD.sql
```

Tambien se incluye 00_Ejecutar_en_orden_SQLCMD.sql para SQLCMD Mode en SQL Server Management Studio.

## 11. Conclusion

La solucion integra datos abiertos del Banco Agricola en un modelo relacional normalizado, consultable y auditable. El diseño permite pasar de archivos planos separados a una base de datos preparada para analisis, visualizacion y crecimiento futuro. La estructura conserva trazabilidad mediante FuenteDato, controla integridad con restricciones, y agrega capacidades de consulta mediante vistas, stored procedures y triggers.

---

## 12. Uso de Inteligencia Artificial y Agentes de IA

Este proyecto fue desarrollado aplicando herramientas de Inteligencia Artificial Generativa y agentes de IA como apoyo de productividad profesional en todas las fases del ciclo de vida del dato.

### Herramientas de IA Utilizadas

| Herramienta | Uso en el Proyecto |
| --- | --- |
| **Claude (Anthropic)** | Generacion y revision de scripts SQL (DDL, DML, DQL), stored procedures y triggers; construccion del dashboard HTML; generacion de diagramas Mermaid; redaccion del informe y documentacion tecnica. |
| **Claude Code (Anthropic)** | Agente de IA en terminal para automatizar la construccion de archivos del proyecto, generacion de PDFs, scripts Python y Swift, y verificacion de consistencia del repositorio. |
| **ChatGPT (OpenAI)** | Apoyo en la validacion de convenciones de nombres SQL, verificacion de logica de normalizacion y consulta de buenas practicas de modelado dimensional. |

### Flujo de Trabajo con IA

El uso de agentes de IA no sustituye el criterio academico sino que acelera la implementacion tecnica, permitiendo mayor foco en el analisis, la interpretacion de resultados y las decisiones de modelado. La autora reviso, ajusto y valido cada componente generado para garantizar coherencia tecnica y academica.

- Criterio humano: decisiones de diseno, claves, restricciones, normalizacion, estructura del dashboard.
- Agentes de IA: generacion de codigo repetitivo, documentacion, transformacion de formatos.
- Revision manual: validacion de integridad, consistencia y alineacion con requisitos academicos.

---

## 13. Referencias APA

Las siguientes referencias sustentan las mejores practicas aplicadas en el desarrollo de este proyecto.

### Normalizacion y Modelado Relacional

Codd, E. F. (1970). A relational model of data for large shared data banks. *Communications of the ACM, 13*(6), 377–387. https://doi.org/10.1145/362384.362685

Date, C. J. (2019). *Database design and relational theory: Normal forms and all that jazz* (2nd ed.). Apress. https://doi.org/10.1007/978-1-4842-5540-7

Kimball, R., & Ross, M. (2013). *The data warehouse toolkit: The definitive guide to dimensional modeling* (3rd ed.). John Wiley & Sons.

### Limpieza y Calidad de Datos

Rahm, E., & Do, H. H. (2000). Data cleaning: Problems and current approaches. *IEEE Data Engineering Bulletin, 23*(4), 3–13. http://sites.computer.org/debull/A00dec/rahm.pdf

### SQL Server y Programacion de Bases de Datos

Microsoft. (2024a). *SQL Server technical documentation*. Microsoft Learn. https://learn.microsoft.com/en-us/sql/sql-server/

Microsoft. (2024b). *Stored procedures (Database Engine)*. Microsoft Learn. https://learn.microsoft.com/en-us/sql/relational-databases/stored-procedures/stored-procedures-database-engine

Microsoft. (2024c). *DML triggers*. Microsoft Learn. https://learn.microsoft.com/en-us/sql/relational-databases/triggers/dml-triggers

Microsoft. (2024d). *Indexes (SQL Server)*. Microsoft Learn. https://learn.microsoft.com/en-us/sql/relational-databases/indexes/indexes

Mullins, C. S. (2012). *Database administration: The complete guide to DBA practices and procedures* (2nd ed.). Addison-Wesley.

### Visualizacion de Datos y Dashboards

Few, S. (2006). *Information dashboard design: The effective visual communication of data*. O'Reilly Media.

Tufte, E. R. (2001). *The visual display of quantitative information* (2nd ed.). Graphics Press.

Microsoft. (2024e). *Power BI documentation*. Microsoft Learn. https://learn.microsoft.com/en-us/power-bi/

### Gobierno del Dato y Documentacion

DAMA International. (2017). *DAMA-DMBOK: Data management body of knowledge* (2nd ed.). Technics Publications.

Seiner, R. S. (2014). *Non-invasive data governance: The path of least resistance and greatest success*. Technics Publications.

### Datos Abiertos

Gobierno de la Republica Dominicana. (2024). *Portal de datos abiertos de la Republica Dominicana*. datos.gob.do. https://datos.gob.do/

Banco Agricola de la Republica Dominicana. (2024). *Datasets de financiamiento agricola 2017–2026* [Conjuntos de datos]. Portal de Datos Abiertos RD. https://datos.gob.do/

### Contenedores y Reproducibilidad

Merkel, D. (2014). Docker: Lightweight Linux containers for consistent development and deployment. *Linux Journal, 2014*(239), 2.

### Control de Versiones

Chacon, S., & Straub, B. (2014). *Pro Git* (2nd ed.). Apress. https://git-scm.com/book/en/v2

### Inteligencia Artificial Generativa y Agentes de IA

Anthropic. (2024). *Claude: AI assistant*. https://www.anthropic.com/claude

Anthropic. (2024). *Claude Code: AI-powered terminal agent*. https://www.anthropic.com/claude-code

OpenAI. (2024). *ChatGPT: Large language model*. https://chatgpt.com/

Bubeck, S., Chandrasekaran, V., Eldan, R., Gehrke, J., Horvitz, E., Kamar, E., Lee, P., Lee, Y. T., Li, Y., Lundberg, S., Nori, H., Palangi, H., Ribeiro, M. T., & Zhang, Y. (2023). Sparks of artificial general intelligence: Early experiments with GPT-4. *arXiv preprint arXiv:2303.12528*. https://arxiv.org/abs/2303.12528
