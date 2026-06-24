# Fase 1 — Modelado de Procesos de Negocio (ExperienciaSV)

**Nota original:** 68/100 → Corregida a 70  
**Estado:** Completada y corregida  
**Archivo Word:** `MDB941_ExperienciaSV_Fases_HG235460.docx`

---

## Correcciones aplicadas

| # | Error original | Corrección |
|---|---------------|------------|
| 1 | Un solo diagrama para todo el sistema | 7 diagramas independientes, uno por proceso |
| 2 | Regla inventada: "12 horas para pagar o se cancela" | Eliminada. No existe en el enunciado |
| 3 | Suspensión invertida: "si nota > 3.0 → suspender" | Corregida: suspensión si promedio < 3.0 |
| 4 | Temporada alta: solo 1.3x | Rango completo: 1.3x, 1.4x o 1.5x según feriado |
| 5 | Faltaban 4 procesos: guías, proveedores, cancelación, liquidaciones | Agregados como diagramas independientes |

---

## Diagrama 1: Búsqueda y Selección de Experiencias

**Descripción:** El turista ingresa destino, fecha, tipo e idioma. El sistema filtra experiencias con cupos disponibles. Si no hay, sugiere alternativas.

**Reglas de negocio:** Validar disponibilidad, capacidad no excedible.

| Símbolo | Texto |
|---------|-------|
| Óvalo | INICIO |
| Rectángulo | Usuario ingresa preferencias: Destino, Fecha, Tipo, Idioma, N° personas |
| Rectángulo | Sistema busca experiencias en la BD |
| Rombo | ¿Hay resultados con cupos disponibles? |
| Rectángulo | (No) Mostrar "No se encontraron resultados". Sugerir alternativas |
| Rectángulo | (Sí) Mostrar lista de experiencias con horarios y cupos |
| Rectángulo | Usuario selecciona experiencia, fecha y horario |
| Rombo | ¿Capacidad suficiente para el N° de personas? |
| Rectángulo | (No) Mostrar "Cupos insuficientes". Sugerir horarios alternos |
| Óvalo | FIN (conexión a Diagrama 2) |

---

## Diagrama 2: Reservación y Pago

**Descripción:** Calcula precio aplicando temporada (1.3x-1.5x), descuento por grupo (10% o 15%) y comisión (10% o 15%). Procesa el pago, confirma reservación y notifica.

**Reglas de negocio:** Multiplicador temporada 1.3-1.5x según feriado, descuento 10% (5-9 pers) y 15% (10+), comisión 10% estándar / 15% premium.

| Símbolo | Texto |
|---------|-------|
| Óvalo | INICIO |
| Rectángulo | Recopilar datos: turista, experiencia, fecha, horario, personas, idioma |
| Rectángulo | Calcular precio base de la experiencia |
| Rectángulo | Aplicar multiplicador por temporada: lookup(TipoFeriado) → 1.3, 1.4 o 1.5 |
| Rectángulo | Aplicar descuento por grupo: 5-9 pers → 10%, 10+ pers → 15% |
| Rectángulo | Calcular comisión plataforma: Premium → 15%, Estándar → 10% |
| Rectángulo | Calcular precio final y monto neto proveedor |
| Rombo | ¿Turista acepta y procede al pago? |
| Rectángulo | (No) Cancelar → FIN |
| Rectángulo | (Sí) Ingresar método de pago |
| Rectángulo | Procesar pago |
| Rombo | ¿Pago exitoso? |
| Rectángulo | (No) Mostrar "Error en pago, intente de nuevo" → regresar a método de pago |
| Rectángulo | (Sí) Registrar transacción. Estado reserva → "Confirmada" |
| Rectángulo | Actualizar inventario de cupos |
| Rectángulo | Enviar confirmación al turista y al proveedor |
| Óvalo | FIN |

---

## Diagrama 3: Gestión y Asignación de Guías

**Descripción:** Registro del guía. Se certifica si habla español + 1 idioma extranjero. El sistema asigna según disponibilidad, idioma, especialidad y mejor calificación.

**Reglas de negocio:** Español + 1 idioma extranjero para certificación, guía solo 1 experiencia a la vez.

| Símbolo | Texto |
|---------|-------|
| Óvalo | INICIO |
| Rectángulo | Registrar datos del guía: nombre, idiomas, especialidades, certificaciones |
| Rombo | ¿Guía certificado? (español + al menos 1 idioma extranjero) |
| Rectángulo | (No) Marcar como "No certificado" |
| Óvalo | FIN |
| Rectángulo | (Sí) Marcar como "Certificado" |
| Rectángulo | Registrar disponibilidad: fecha, horario, estado (disponible/ocupado) |
| Rectángulo | Sistema busca guías disponibles que coincidan: fecha, horario, idioma, especialidad |
| Rectángulo | Ordenar resultados por calificación promedio (mayor a menor) |
| Rombo | ¿Existe guía que cumpla los requisitos? |
| Rectángulo | (Sí) Asignar guía automáticamente. Marcar como "Ocupado". Registrar asignación |
| Rectángulo | (No) Notificar al proveedor para asignación manual |
| Óvalo | FIN |

---

## Diagrama 4: Gestión de Proveedores (Registro y Suspensión)

**Descripción:** Verifica certificaciones MITUR. Si son válidas, estado "Activo". Monitorea reseñas: si promedio de últimas 10 es < 3.0, suspensión automática.

**Reglas de negocio:** Suspensión si últimas 10 reseñas ≥ 10 Y promedio < 3.0.

| Símbolo | Texto |
|---------|-------|
| Óvalo | INICIO |
| Rectángulo | Registrar/actualizar datos del proveedor: contacto, licencias, certificaciones |
| Rectángulo | Verificar certificaciones (MITUR) |
| Rombo | ¿Certificaciones válidas? |
| Rectángulo | (No) Marcar estado → "Pendiente/Suspendido". Registrar auditoría |
| Óvalo | FIN |
| Rectángulo | (Sí) Marcar estado → "Activo" |
| Rectángulo | Monitoreo continuo: cada nueva reseña actualiza promedio y contador |
| Rombo | ¿Últimas 10 reseñas ≥ 10 Y promedio < 3.0? |
| Rectángulo | (No) Sin acción. Continúa monitoreando |
| Rectángulo | (Sí) Cambiar estado → "Suspendido" |
| Rectángulo | Registrar auditoría: quién, cuándo, motivo |
| Rectángulo | Notificar al proveedor y al administrador |
| Rectángulo | Revisión manual por el administrador (posible reactivación) |
| Óvalo | FIN |

---

## Diagrama 5: Reseñas y Control de Calidad

**Descripción:** Al completar la experiencia, se habilita la reseña. El turista califica experiencia, guía y calidad-precio. El sistema actualiza promedios y conecta con la evaluación de suspensión del proveedor.

**Reglas de negocio:** Solo turistas que completaron pueden reseñar, calificación 1-5 estrellas.

| Símbolo | Texto |
|---------|-------|
| Óvalo | INICIO |
| Rectángulo | Ejecutar servicio/tour en la fecha acordada |
| Rombo | ¿Se completó el servicio? |
| Rectángulo | (No) FIN (no se habilita reseña) |
| Rectángulo | (Sí) Marcar reservación como "Completada" |
| Rectángulo | Habilitar opción de reseña al turista |
| Rectángulo | Turista califica: experiencia, guía, relación calidad-precio + comentario |
| Rectángulo | Sistema actualiza promedios y contadores de la experiencia y del guía |
| Rectángulo | Evaluar suspensión → (conexión al Diagrama 4) |
| Rectángulo | Registrar auditoría: comentarios y evidencias |
| Óvalo | FIN |

---

## Diagrama 6: Cancelación y Reembolsos

**Descripción:** Según anticipación: >48h reembolso 100%, 24-48h 50%, <24h 0%. Libera cupos, cambia estado a "Cancelada", registra auditoría y notifica.

**Reglas de negocio:** >48h = 100%, 24-48h = 50%, <24h = 0% reembolso.

| Símbolo | Texto |
|---------|-------|
| Óvalo | INICIO |
| Rectángulo | Turista solicita cancelación de reservación confirmada |
| Rectángulo | Sistema calcula horas restantes hasta la fecha de la experiencia |
| Rombo | ¿Faltan más de 48 horas? |
| Rectángulo | (Sí) Reembolso del 100% |
| Rombo | (No) ¿Faltan entre 24 y 48 horas? |
| Rectángulo | (Sí) Reembolso del 50% |
| Rectángulo | (No) Sin reembolso (0%) |
| Rectángulo | Liberar cupos de inventario |
| Rectángulo | Cambiar estado de reservación → "Cancelada" |
| Rectángulo | Registrar auditoría: quién canceló, cuándo, monto, motivo |
| Rectángulo | Notificar al turista y al proveedor |
| Óvalo | FIN |

---

## Diagrama 7: Liquidaciones Mensuales a Proveedores

**Descripción:** Día 1 de cada mes, calcula el monto neto acumulado del mes anterior por proveedor, genera reporte y notifica.

**Reglas de negocio:** Cálculo automático el día 1, monto neto = precio final - comisión.

| Símbolo | Texto |
|---------|-------|
| Óvalo | INICIO |
| Rectángulo | Sistema ejecuta proceso automático el día 1 de cada mes |
| Rectángulo | Calcular monto neto acumulado del mes anterior (experiencias completadas) |
| Rectángulo | Generar reporte: detalle por experiencia, turistas, precio, comisión, neto |
| Rectángulo | Enviar reporte al proveedor por correo |
| Rectángulo | Registrar estado → "Pendiente de pago" |
| Rombo | ¿Se realiza el pago al proveedor? |
| Rectángulo | (Sí) Cambiar estado → "Pagada". Registrar fecha de pago |
| Rectángulo | (No) Mantener como "Pendiente" para seguimiento |
| Rectángulo | Registrar auditoría de la liquidación |
| Óvalo | FIN |
