# Retroalimentación Fase 4 — Trazabilidad de Datos (Triggers de Auditoría)

**Nota:** 58/100 | **Estado:** Retroalimentación recibida

**Entregado:** 6 triggers y 3 tablas de auditoría

---

## Errores señalados por el docente

| # | Error | Descripción |
|---|-------|-------------|
| 1 | Sin comentarios en el código | Los triggers no incluyen documentación interna que explique qué auditan y por qué |
| 2 | Solo 1 campo capturado | Las tablas de auditoría solo registran 1 campo. Deben capturar todos los campos relevantes de la operación (antes y después en UPDATE) |
| 3 | Script de pruebas insuficiente | No se incluyeron suficientes casos de prueba para demostrar que los triggers funcionan correctamente en INSERT, UPDATE y DELETE |
| 4 | Documentación mínima | La documentación entregada es muy breve. Debe explicar: propósito de cada trigger, tablas afectadas, campos auditados, y ejemplos de uso |

---

## Recomendaciones para mejorar

- Documentar cada trigger con comentarios explicando: qué tabla audita, qué operaciones captura, qué campos registra
- Usar las tablas lógicas `inserted` y `deleted` para capturar valores antes y después
- Crear scripts de prueba con INSERT, UPDATE y DELETE para cada tabla auditada
- Ampliar la documentación explicando el diseño de la auditoría y su propósito en el sistema
