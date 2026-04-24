from __future__ import annotations

import importlib.util
import os
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent
DEFAULT_PROJECT_DIR = SCRIPT_DIR.parent


def load_env_file(path: Path) -> None:
    if not path.exists():
        return
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        os.environ.setdefault(key.strip(), value.strip())


load_env_file(DEFAULT_PROJECT_DIR / ".env.local")

PROJECT_DIR = Path(os.environ.get("PROJECT_DIR", DEFAULT_PROJECT_DIR)).expanduser()
UASD_WORKSPACE_DIR = Path(
    os.environ.get("UASD_WORKSPACE_DIR", PROJECT_DIR.parent)
).expanduser()
PPTX_TEMPLATE_PATH = Path(os.environ["PPTX_TEMPLATE_PATH"]).expanduser()
PYTHON_PRESENTATION_BUILDER = Path(
    os.environ.get(
        "PYTHON_PRESENTATION_BUILDER",
        UASD_WORKSPACE_DIR / "build_presentacion_tarea51_inf8236.py",
    )
).expanduser()
PRESENTATION_OUTPUT_PATH = Path(
    os.environ.get(
        "PRESENTATION_OUTPUT_PATH",
        PROJECT_DIR / "Presentacion_Final_Banco_Agricola_RD.pptx",
    )
).expanduser()

spec = importlib.util.spec_from_file_location(
    "presentation_builder", PYTHON_PRESENTATION_BUILDER
)
if spec is None or spec.loader is None:
    raise RuntimeError(f"No se pudo cargar el builder: {PYTHON_PRESENTATION_BUILDER}")

builder = importlib.util.module_from_spec(spec)
spec.loader.exec_module(builder)

builder.BASE_PPTX = PPTX_TEMPLATE_PATH
builder.OUTPUT_PPTX = PRESENTATION_OUTPUT_PATH

builder.SLIDE_PLAN = {
    1: {
        "source": 1,
        "texts": {
            1: ["UNIVERSIDAD AUTONOMA DE SANTO DOMINGO"],
            2: ["Primada de America  Fundada el 28 de octubre de 1538"],
            3: [
                "PROYECTO FINAL DE BASE DE DATOS I",
                "Banco Agricola RD: modelado, SQL y analisis",
            ],
            4: [
                "Maestria en Ciencias de Datos e Inteligencia Artificial",
                "Marlenis Judith Concepcion Cuevas",
            ],
            5: ["INF-8236"],
        },
        "remove_images": ["image7.jpg"],
    },
    2: {
        "source": 2,
        "texts": {
            1: ["Agenda"],
            2: [
                "Contexto del problema",
                "Datasets utilizados",
                "Limpieza y preparacion",
                "Modelo conceptual, logico y fisico",
                "Implementacion SQL Server",
                "Consultas, procedimientos y triggers",
                "Dashboard, Power BI y hallazgos",
                "Conclusiones",
            ],
        },
        "remove_all_images": True,
    },
    3: {
        "source": 3,
        "texts": {
            1: ["Seccion", "I"],
            2: [
                "Contexto del proyecto",
                "Datos abiertos",
                "Financiamiento agricola",
                "Integracion",
                "Analisis",
            ],
            3: ["Banco Agricola", "RD"],
        },
    },
    4: {
        "source": 40,
        "texts": {
            1: [
                "Problema de datos",
                "Los datos del Banco Agricola estan distribuidos en varios CSV con estructuras diferentes.",
                "El proyecto integra cartera, areas financiadas, desembolsos, cobros y montos por destino.",
                "Se normalizan sucursales, periodos y destinos para evitar duplicidad y mejorar la consulta.",
                "La solucion convierte archivos planos en una base relacional para analisis academico y gerencial.",
                "Periodo integrado: 2017 a 2026.",
            ]
        },
        "remove_all_images": True,
    },
    5: {
        "source": 41,
        "texts": {
            1: [
                "Datasets utilizados",
                "Cartera de prestamos agricolas: cantidad de prestamos y valor RD$ por sucursal y periodo.",
                "Areas financiadas: tareas, prestamos y valor RD$ por sucursal y periodo.",
                "Desembolsos y cobros: desembolsos RD$, cobros RD$ y balance neto por sucursal.",
                "Montos otorgados por destino agricola: valores, tareas, beneficiados y tipo de operacion.",
                "El dataset de desembolsos y cobros solo cubre 2025-2026.",
            ]
        },
        "remove_all_images": True,
    },
    6: {
        "source": 15,
        "texts": {
            1: ["Seccion", "II"],
            2: [
                "Preparacion de datos",
                "Limpieza, estandarizacion y normalizacion previa a la carga.",
                "Base para el modelo relacional.",
            ],
            3: ["Datos", "limpios"],
        },
    },
    7: {
        "source": 43,
        "texts": {
            1: [
                "Limpieza y transformacion",
                "Se leyeron los CSV originales y se generaron archivos limpios en UTF-8.",
                "Se eliminaron espacios sobrantes en encabezados, meses y nombres.",
                "Se convirtieron montos y cantidades a valores numericos.",
                "Se normalizaron variantes como Higuey/Higüey, Bani/Bani y San Fco. Macoris.",
                "Se agregaron valores duplicados por diferencias ortograficas.",
                "Se crearon llaves sustitutas para periodo, sucursal, destino y fuente de datos.",
            ]
        },
        "remove_all_images": True,
    },
    8: {
        "source": 41,
        "texts": {
            1: [
                "Metricas del proyecto",
                "Filas originales: 12,436.",
                "Registros factuales normalizados: 12,304.",
                "Periodos: 108.",
                "Sucursales normalizadas: 33.",
                "Destinos normalizados: 105.",
                "Consultas DQL: 25.",
                "Stored procedures: 6.",
                "Triggers: 3.",
            ]
        },
        "remove_all_images": True,
    },
    9: {
        "source": 34,
        "texts": {
            1: ["Seccion", "III"],
            2: [
                "Modelo de base de datos",
                "Separacion entre dimensiones descriptivas y hechos medibles.",
                "Modelo conceptual, logico y fisico.",
            ],
        },
    },
    10: {
        "source": 43,
        "texts": {
            1: [
                "Diseno relacional",
                "Dimensiones: Periodo, Sucursal, Destino y FuenteDato.",
                "Hechos: FactCarteraPrestamo, FactAreaFinanciada, FactDesembolsoCobro y FactMontoDestino.",
                "Tablas de control: AuditoriaOperacion y CarteraPrestamoHistorico.",
                "El modelo aplica 1FN, 2FN y 3FN para reducir redundancia.",
                "Las relaciones permiten analisis por año, mes, sucursal, region, destino y tipo de operacion.",
            ]
        },
        "remove_all_images": True,
    },
    11: {
        "source": 40,
        "texts": {
            1: [
                "Implementacion fisica en SQL Server",
                "Base de datos: BancoAgricolaRD.",
                "El DDL crea tablas, PK, FK, UNIQUE, DEFAULT, CHECK, indices y vistas.",
                "Las restricciones validan meses, años, estatus, regiones y valores no negativos.",
                "Las vistas resumen cartera por sucursal/año, desembolsos vs cobros, destinos top y areas financiadas.",
                "El script maestro consolida DDL, DML, programacion y consultas.",
            ]
        },
        "remove_all_images": True,
    },
    12: {
        "source": 37,
        "texts": {
            1: ["Seccion", "IV"],
            2: [
                "Consultas y programacion",
                "DQL, stored procedures, triggers, auditoria e historicos.",
                "Evidencia tecnica de la implementacion.",
                "SQL Server",
                "Power BI",
            ],
        },
    },
    13: {
        "source": 43,
        "texts": {
            1: [
                "DQL y objetos programables",
                "El archivo DQL incluye 25 consultas con filtros, joins, agrupaciones, HAVING y subconsultas.",
                "Tambien usa funciones agregadas y funciones de ventana para rankings y comparaciones.",
                "Procedimientos: resumen anual, top sucursales, desembolsos por sucursal, top destinos, actualizacion de cartera e indicadores por periodo.",
                "Triggers: auditoria de desembolsos, historico de cartera y validacion de montos por destino.",
                "La solucion demuestra consulta, control e integridad de datos.",
            ]
        },
        "remove_all_images": True,
    },
    14: {
        "source": 41,
        "texts": {
            1: [
                "Dashboard y Power BI",
                "El dashboard HTML permite filtrar por año y visualizar KPIs principales.",
                "Incluye cartera total, prestamos, desembolsos, cobros, tareas y beneficiados.",
                "Muestra top de sucursales, distribucion por tipo de operacion y destinos financiados.",
                "El archivo Power BI unificado permite crear visuales en Power BI Online.",
                "La guia Power BI explica relaciones, medidas DAX y visuales recomendados.",
            ]
        },
        "remove_all_images": True,
    },
    15: {
        "source": 43,
        "texts": {
            1: [
                "Hallazgos principales",
                "Cartera total integrada: RD$ 4,328,206,887,618.",
                "Prestamos registrados: 4,505,198.",
                "Areas financiadas: 11,864,365 tareas.",
                "Desembolsos registrados: RD$ 31,595,581,251.",
                "Cobros registrados: RD$ 30,614,020,812.",
                "Montos por destino: RD$ 241,148,789,863.",
                "Beneficiados asociados: 216,930.",
            ]
        },
        "remove_all_images": True,
    },
    16: {
        "source": 42,
        "texts": {
            1: ["Cierre", "Final"],
            2: [
                "Conclusiones y entregables",
                "El proyecto integra datos abiertos en una base relacional normalizada y auditable.",
                "Permite analizar financiamiento agricola por sucursal, region, periodo y destino.",
                "Entregables: informe PDF, scripts SQL, script maestro, diagramas, dashboard HTML y CSV para Power BI.",
                "La solucion conserva trazabilidad mediante FuenteDato y controla integridad con restricciones.",
                "Gracias.",
            ],
            3: ["Marlenis", "INF-8236"],
        },
    },
}


if __name__ == "__main__":
    builder.main()
