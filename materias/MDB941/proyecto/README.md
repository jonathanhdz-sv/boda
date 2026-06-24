# Proyecto ExperienciaSV — MDB941

**Integrantes:** Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
**Grupo:** 2
**Docente:** Katherine Francisca Vigil Espinal

---

## Resumen por Fase

| Fase | Nombre | Nota | Estado |
|------|--------|:----:|--------|
| 1 | Modelado de Procesos | 68/100 | Corregida |
| 2 | Modelado de Datos | 68/100 | Corregida |
| 3 | Administración de Datos | 75/100 | Retroalimentación recibida |
| 4 | Trazabilidad de Datos | 58/100 | Retroalimentación recibida |
| 5 | Mantenimiento de Datos | — | **Entregada 25 may — pendiente defensa** |

---

## Fase 1 — Modelado de Procesos
- 7 diagramas de flujo independientes (corregido de 1 solo)
- Correcciones: temporada 1.3x-1.5x, suspensión < 3.0, regla inventada eliminada, 4 procesos agregados
- Detalle: `fase-1.md`

## Fase 2 — Modelado de Datos
- Diagrama E-R con 22 tablas y 20 relaciones
- Correcciones: PROVEEDOR, AUDITORIA, LIQUIDACION, CANCELACION agregadas; PK compuesta en tablas puente; TEMPORADA conectada
- Detalle: `fase-2.md`

## Fase 3 — Administración de Datos (75/100)
- 6 SPs y 4 funciones entregados
- Problemas: DELETEs sin validación, UPDATEs sin verificar existencia, solo 2 tablas cubiertas
- Retroalimentación: `retro-fase3.txt`

## Fase 4 — Trazabilidad de Datos (58/100)
- 6 triggers y 3 tablas de auditoría
- Problemas: sin comentarios, solo 1 campo capturado, script de pruebas insuficiente, documentación mínima
- Retroalimentación: `retro-fase4.txt`

## Fase 5 — Mantenimiento de Datos

### Scripts entregados

| # | Archivo | Contenido |
|---|---------|-----------|
| 1 | `fase5/00_crear_bd_tablas.sql` | BD + 22 tablas + 17 índices |
| 2 | `fase5/01_datos_prueba.sql` | 15 turistas, 10 guías, 6 proveedores, 13 experiencias |
| 3 | `fase5/02_backups.sql` | 8 SPs: FULL, diferencial, log, restauración, limpieza |
| 4 | `fase5/03_mantenimiento.sql` | 7 SPs: shrink, rebuild indexes, update stats, DBCC |
| 5 | `fase5/04_jobs.sql` | 6 jobs SQL Agent: backups, mantenimiento, limpieza |
| 6 | `fase5/05_correo.sql` | Database Mail, alertas, operadores, reporte diario |
| 7 | `fase5/06_recursos.sql` | Config CPU/RAM, monitoreo de sesiones |
| 8 | `fase5/07_documentacion_fase5.md` | Documentación completa en formato tabla |

### Jobs automatizados

| Job | Horario |
|-----|---------|
| Backup FULL | Diario 02:00 AM |
| Backup Diferencial | Cada 6 horas |
| Backup Log | Cada 1 hora |
| Mantenimiento Semanal | Domingo 03:00 AM |
| Limpieza Backups | Domingo 04:00 AM |
| Update Statistics | Diario 01:00 AM |
