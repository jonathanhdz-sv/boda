# Retroalimentación Fase 2 — Modelado de Datos

**Nota:** 68/100 | **Estado:** Corregida

---

## Errores señalados por el docente

| # | Error | Corrección aplicada |
|---|-------|---------------------|
| 1 | Faltaba tabla PROVEEDOR | Agregada con certificaciones, estado (activo/suspendido/verificado) |
| 2 | Faltaba tabla AUDITORIA | Agregada con tabla, acción, usuario, fecha |
| 3 | Faltaba tabla LIQUIDACION | Agregada con período y montos |
| 4 | Faltaba tabla CANCELACION | Agregada con % reembolso |
| 5 | GUIA_IDIOMA PK simple | PK compuesta (guia_id + idioma_id) |
| 6 | GUIA_ESPECIALIDAD PK simple | PK compuesta (guia_id + especialidad_id) |
| 7 | TEMPORADA desconectada | Conectada a RESERVACION |
| 8 | Multiplicador suelto en RESERVACION | Movido a tabla TEMPORADA |

---

## Resultado final: 22 tablas y 20 relaciones

| # | Tabla | Tipo |
|---|-------|------|
| 1 | CATEGORIA | Catálogo |
| 2 | DESTINO | Catálogo |
| 3 | ROL | Catálogo |
| 4 | ESTADO_RESERVACION | Catálogo |
| 5 | IDIOMA | Catálogo |
| 6 | ESPECIALIDAD | Catálogo |
| 7 | METODO_PAGO | Catálogo |
| 8 | TURISTA | Persona |
| 9 | PROVEEDOR | Persona |
| 10 | GUIA | Persona |
| 11 | EXPERIENCIA | Núcleo |
| 12 | RESERVACION | Núcleo |
| 13 | DISPONIBILIDAD | Núcleo |
| 14 | PAGO | Transacción |
| 15 | TEMPORADA | Transacción |
| 16 | DESCUENTO_GRUPO | Transacción |
| 17 | RESEÑA | Cierre |
| 18 | CANCELACION | Cierre |
| 19 | LIQUIDACION | Cierre |
| 20 | GUIA_IDIOMA | Puente N:M |
| 21 | GUIA_ESPECIALIDAD | Puente N:M |
| 22 | AUDITORIA | Transversal |
