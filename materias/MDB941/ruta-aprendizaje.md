# Modelamiento y Diseño de Base de Datos (MDB941) — Ruta de Aprendizaje

## Información del Curso

- **Código:** MDB941
- **Prerrequisito:** PRE941 - Programación Estructurada (Aprobada con 10.0)
- **UV:** 4
- **Ciclo:** 01-2026
- **Herramientas:** SQL Server + SSMS (T-SQL), Draw.io (diagramas ER)

## Competencia

Diseña, desarrolla y actualiza aplicaciones informáticas para diferentes plataformas web y escritorio, documentando todas las etapas.

## Indicadores de Logro

- Diseña aplicaciones informáticas para diferentes plataformas web y escritorio utilizando un enfoque de Modelado basado en la Base de Datos.
- Realiza mantenimiento y actualizaciones de las aplicaciones web y de escritorio, según las necesidades de las instituciones.
- Entiende los diferentes ejes temáticos utilizados en el Ciclo de Vida de los Sistemas de Información bajo una perspectiva de la administración de la Base de Datos.

## Estructura de Evaluación (100% Proyecto Práctico)

La materia se evalúa completamente mediante un proyecto práctico dividido en 5 experiencias de aprendizaje. Cada experiencia vale 20%. **Todas son grupales.**

| Experiencia | Tema | Clases | Peso | Entrega |
|-------------|------|--------|:----:|---------|
| 1 | Modelado de Procesos | 1, 2, 3, 4 | 20% | 15 feb |
| 2 | Modelado de Datos | 5, 6, 7, 8 | 20% | 15 mar |
| 3 | Administración de Datos | 9, 10, 11, 12 | 20% | 19 abr |
| 4 | Trazabilidad de los Datos | 13, 14, 15, 16 | 20% | 10 may |
| 5 | Mantenimiento de Datos | 17, 18, 19, 20 | 20% | 31 may |

---

## Experiencias de Aprendizaje

### Experiencia 1: Modelado de Procesos (20%) — Clases 1 a 4 — Entrega: 15 feb

Los estudiantes analizarán bajo el Modelamiento de Procesos las situaciones planteadas por las áreas requeridoras de sistemas de información para poder interpretar las diferentes situaciones a considerar para cada uno de los procesos a automatizar. Se presentarán y defenderán por medio de diagramas de flujo los procesos identificados.

- **Actividad:** Grupal
- **Entregable:** Diagramas de flujo de procesos
- **Hay defensa:** Sí

### Experiencia 2: Modelado de Datos (20%) — Clases 5 a 8 — Entrega: 15 mar

Los estudiantes, a partir de los procesos ya validados en la fase anterior, realizarán los Diagramas de Entidad Relación (E-R) que corresponden a cada uno de dichos procesos. Se presentarán y defenderán dichos E-R's.

- **Actividad:** Grupal
- **Entregable:** Diagramas Entidad-Relación (E-R)
- **Hay defensa:** Sí

### Experiencia 3: Administración de Datos (20%) — Clases 9 a 12 — Entrega: 19 abr

Los estudiantes deberán crear procedimientos almacenados y funciones para el mantenimiento de los datos en las Tablas. Los procedimientos insertarán, modificarán y eliminarán los datos, mientras que las funciones validarán la consistencia de los datos.

- **Actividad:** Grupal
- **Entregable:** Scripts SQL con procedimientos almacenados y funciones
- **Hay defensa:** No

### Experiencia 4: Trazabilidad de los Datos (20%) — Clases 13 a 16 — Entrega: 10 may

Los estudiantes deberán crear disparadores (Triggers) para la implementación de la trazabilidad de la información (Auditoría), la cual permitirá identificar tanto quién hace la acción como en qué momento se realiza (inserciones, modificaciones y eliminaciones).

- **Actividad:** Grupal
- **Entregable:** Scripts SQL con Triggers de auditoría
- **Hay defensa:** No

### Experiencia 5: Mantenimiento de Datos (20%) — Clases 17 a 20 — Entrega: 31 may

Esta última fase se enfocará en el mantenimiento post-implementación de los sistemas de información. Los estudiantes crearán diversos planes de mantenimiento de los datos y las configuraciones necesarias para la automatización de estos. Ejemplos: planes de Backup, compactado de Logs, corrida de estadísticas, reordenamiento de índices, configuración de correo, entre otras.

- **Actividad:** Grupal
- **Entregable:** Planes de mantenimiento y configuraciones de automatización
- **Hay defensa:** Sí

---

## Unidades y Clases

| Unidad | Contenido | Clases | Archivo |
|--------|-----------|--------|---------|
| 1 | Base de Datos | 1-4 | `unidad-1.md` |
| 2 | Base de Datos Relacionales | 5-8 | `unidad-2.md` |
| 3 | Integridad de Datos y SQL | 9-12 | `unidad-3.md` |
| 4 | Administración de Datos y Objetos de BD | 13-16 | `unidad-4.md` |
| 5 | Administración de Bases de Datos | 17-20 | `unidad-5.md` |

---

## Proyecto de Materia: ExperienciaSV

**Contexto:** Plataforma de turismo experiencial para El Salvador. Turistas descubren, reservan y viven experiencias. Proveedores digitalizan sus servicios.

**Alcance:** Solo análisis y diseño de la base de datos. NO se desarrolla frontend ni aplicaciones web.

**Tecnología:** SQL Server 2019+, SSMS, T-SQL.

### Fases del Proyecto (misma estructura de evaluación)

| Fase | Entregable | Entrega | Estado |
|------|-----------|---------|--------|
| 1 | Diagramas de flujo de procesos | 15 feb | Entregada |
| 2 | Diagrama Entidad-Relación (E-R) | 15 mar | Entregada |
| 3 | Procedimientos almacenados y funciones | 19 abr | Entregada |
| 4 | Triggers de auditoría y trazabilidad | 10 may | Entregada |
| 5 | Plan de mantenimiento (backups, índices, estadísticas, jobs) | 25 may | Entregada — pendiente defensa |
