# Fase 2 — Modelado de Datos (ExperienciaSV)

**Nota original:** 68/100 — Corregida
**Estado:** Completada y corregida

## Entregable: Diagrama Entidad-Relación (E-R)

## 22 Tablas del modelo

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
| 20 | GUIA_IDIOMA | Puente N:M (PK compuesta) |
| 21 | GUIA_ESPECIALIDAD | Puente N:M (PK compuesta) |
| 22 | AUDITORIA | Transversal |

## 20 Relaciones con cardinalidad

- Mayoría 1:N
- RESERVACION → RESEÑA: 1:1
- RESERVACION → CANCELACION: 1:1
- GUIA ↔ IDIOMA: N:M (vía GUIA_IDIOMA)
- GUIA ↔ ESPECIALIDAD: N:M (vía GUIA_ESPECIALIDAD)
- AUDITORIA: sin conexión directa

## Correcciones aplicadas respecto a primera entrega

| Error | Corrección |
|-------|------------|
| Faltaba PROVEEDOR | Agregada con certificaciones, estado |
| Faltaba AUDITORIA | Agregada (tabla, acción, usuario, fecha) |
| Faltaba LIQUIDACION | Agregada con período y montos |
| Faltaba CANCELACION | Agregada con % reembolso |
| GUIA_IDIOMA PK simple | PK compuesta (guia_id + idioma_id) |
| GUIA_ESPECIALIDAD PK simple | PK compuesta (guia_id + especialidad_id) |
| TEMPORADA desconectada | Conectada a RESERVACION |
| Multiplicador suelto en RESERVACION | Ahora en tabla TEMPORADA |
