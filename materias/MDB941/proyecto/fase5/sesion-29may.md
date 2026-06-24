# Sesión 29 mayo 2026 — Repaso Fase 5 MDB941

## Acciones realizadas

1. **Corrección de rutas en `Grupo2_CreacionBD.sql`**
   - Línea 19: `.mdf` cambiado de `C:\SQLData\` a ruta por defecto SQL Server
   - Línea 24: `.ldf` cambiado de `C:\SQLData\` a ruta por defecto SQL Server
   - Ruta real: `C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\`

2. **Ejecución de los 7 scripts en SSMS (todos exitosos)**
   - `CreacionBD.sql`: BD ExperienciaSV con 22 tablas, 17 índices, datos de prueba
   - `PlanesBackup.sql`: FULL, DIFERENCIAL, LOG + VERIFYONLY
   - `Mantenimiento_Indices.sql`: detección fragmentación + REBUILD/REORGANIZE
   - `Estadisticas.sql`: UPDATE STATISTICS + `sp_updatestats`
   - `MantenimientoLogs.sql`: SHRINKFILE + configuración crecimiento
   - `ConfiguracionCorreo.sql`: Database Mail habilitado
   - `JobsAutomatizacion.sql`: 4 jobs creados (Agent iniciado después)

3. **Corrección DUI/Pasaporte (`Correccion_DUI.sql`)**
   - Columna pasaporte agregada a TURISTA
   - Extranjeros usan pasaporte, salvadoreños usan DUI
   - `CK_TURISTA_IDENTIFICACION`: al menos uno lleno
   - `CK_TURISTA_DUI`: formato salvadoreño si se usa

4. **Material de defensa creado**
   - `Practica_Defensa.sql`: todos los comandos en un solo script
   - `25_Preguntas_Defensa.md`: preguntas y respuestas para defensa
   - `GUION_DEFENSA.md` y `GUIA_COMPLETA.md`: guías de estudio

5. **Archivos copiados a:** `Desktop\Fase5_ExperienciaSV\`

6. **SQL Server Agent** iniciado y en verde

## Pendiente

- Defensa Fase 5: 31 de mayo de 2026
- Practicar comandos del `Practica_Defensa.sql`
- Repasar 25 preguntas
