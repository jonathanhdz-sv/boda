# Retroalimentación Fase 3 — Administración de Datos (SPs y Funciones)

**Nota:** 75/100 | **Estado:** Retroalimentación recibida

**Entregado:** 6 procedimientos almacenados y 4 funciones

---

## Errores señalados por el docente

| # | Error | Descripción |
|---|-------|-------------|
| 1 | DELETEs sin validación | Los procedimientos de eliminación no verifican si el registro existe antes de borrar |
| 2 | UPDATEs sin verificar existencia | Los procedimientos de modificación no comprueban si el registro a actualizar existe |
| 3 | Solo 2 tablas cubiertas | De las 22 tablas del modelo, solo se crearon SPs para 2 tablas. Debían cubrirse más tablas del núcleo del negocio |

---

## Recomendaciones para mejorar

- Agregar validación de existencia antes de DELETE:

  ```sql
  IF EXISTS (SELECT 1 FROM tabla WHERE id = @id)
  ```

- Agregar validación antes de UPDATE: verificar que el registro existe y que no se violen constraints
- Ampliar cobertura: crear SPs para las tablas principales (EXPERIENCIA, RESERVACION, PAGO, GUIA, PROVEEDOR, TURISTA)
- Incluir manejo de errores con `TRY...CATCH` en cada SP
