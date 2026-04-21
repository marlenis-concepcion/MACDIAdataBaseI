# Guia rapida para montar el dashboard en Power BI

## Opcion recomendada

Si tienes una computadora Windows o una maquina virtual con Windows, usa Power BI Desktop. Es la opcion mas comoda para este proyecto porque permite importar varias tablas, crear relaciones y definir medidas DAX con facilidad.

En macOS, la alternativa practica es abrir el dashboard HTML incluido en este proyecto o usar Power BI Service desde el navegador. Power BI Service sirve para publicar y explorar, pero para modelar varias tablas relacionadas suele ser menos comodo que Power BI Desktop.

## Archivos a importar

Importa estos CSV desde `datos/limpios`:

- `dim_periodo.csv`
- `dim_sucursal.csv`
- `dim_destino.csv`
- `fact_cartera_prestamo.csv`
- `fact_area_financiada.csv`
- `fact_desembolso_cobro.csv`
- `fact_monto_destino.csv`

## Relaciones del modelo

Crea estas relaciones en la vista Modelo:

- `dim_periodo[periodo_id]` 1:* `fact_cartera_prestamo[periodo_id]`
- `dim_periodo[periodo_id]` 1:* `fact_area_financiada[periodo_id]`
- `dim_periodo[periodo_id]` 1:* `fact_desembolso_cobro[periodo_id]`
- `dim_periodo[periodo_id]` 1:* `fact_monto_destino[periodo_id]`
- `dim_sucursal[sucursal_id]` 1:* `fact_cartera_prestamo[sucursal_id]`
- `dim_sucursal[sucursal_id]` 1:* `fact_area_financiada[sucursal_id]`
- `dim_sucursal[sucursal_id]` 1:* `fact_desembolso_cobro[sucursal_id]`
- `dim_destino[destino_id]` 1:* `fact_monto_destino[destino_id]`

Direccion de filtro: Single desde las dimensiones hacia las tablas de hechos.

## Tipos de datos

- Todos los campos terminados en `_id`: Whole number.
- `periodo_fecha`: Date.
- Campos `valor_rd`, `valores_rd`, `desembolsos_rd`, `cobros_rd`, `balance_neto_rd`: Decimal number o Currency.
- `tareas`, `cantidad_prestamos`, `beneficiados`: Whole number o Decimal segun Power BI detecte.

## Medidas DAX

```DAX
Total Cartera = SUM(fact_cartera_prestamo[valor_rd])

Total Prestamos = SUM(fact_cartera_prestamo[cantidad_prestamos])

Total Areas RD = SUM(fact_area_financiada[valor_rd])

Total Tareas = SUM(fact_area_financiada[tareas])

Total Desembolsos = SUM(fact_desembolso_cobro[desembolsos_rd])

Total Cobros = SUM(fact_desembolso_cobro[cobros_rd])

Balance Neto = [Total Desembolsos] - [Total Cobros]

Total Montos Destino = SUM(fact_monto_destino[valores_rd])

Total Beneficiados = SUM(fact_monto_destino[beneficiados])

Valor Promedio Prestamo = DIVIDE([Total Cartera], [Total Prestamos])
```

## Pagina sugerida del dashboard

1. Slicer: `dim_periodo[anio]`.
2. Tarjetas: Total Cartera, Total Prestamos, Total Desembolsos, Total Cobros, Total Tareas, Total Beneficiados.
3. Grafico de barras: eje `dim_sucursal[sucursal_nombre]`, valor `[Total Cartera]`, filtro Top N = 10.
4. Grafico de pastel: leyenda `dim_destino[tipo_operacion]`, valor `[Total Montos Destino]`.
5. Columnas agrupadas: eje `dim_periodo[periodo_fecha]`, valores `[Total Desembolsos]` y `[Total Cobros]`.
6. Tabla: `dim_destino[destino_nombre]`, `dim_destino[tipo_operacion]`, `[Total Montos Destino]`, `[Total Beneficiados]`.

## Entrega si usas Power BI

Exporta o guarda:

- Archivo `.pbix` si usas Power BI Desktop.
- Capturas o PDF del dashboard si solo usas Power BI Service.
- Conserva los CSV limpios y el documento PDF del proyecto en la misma carpeta.
