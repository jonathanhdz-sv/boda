# Fase 5 — Mantenimiento de Datos

**Proyecto Integrador:** ExperienciaSV  
**Materia:** Modelamiento y Diseño de Base de Datos (MDB941)  
**Docente:** Katherine Francisca Vigil Espinal  
**Fecha de entrega:** 25 de mayo de 2026  

---

## Integrantes

| Nombre | Carnet |
|--------|--------|
| Jonathan Ernesto Hernández Guardado | HG235460 |
| Jhensen Alberto Recinos Álvarez | RA251889 |

---

## 1. Planes de Mantenimiento Implementados

| Plan | Descripción | Frecuencia | Archivo |
|------|-------------|------------|---------|
| Backup Completo (FULL) | Copia completa de la base de datos con COMPRESSION y CHECKSUM | Diario 2:00 AM | Grupo2_PlanesBackup.sql |
| Backup Diferencial | Cambios desde el último FULL | Cada 6 horas | Grupo2_PlanesBackup.sql |
| Backup Transaction Log | Historial de transacciones para recuperación al punto | Cada 1 hora | Grupo2_PlanesBackup.sql |
| Mantenimiento de Índices | REORGANIZE (>10% fragmentación) y REBUILD (>30%) | Semanal (domingo) | Grupo2_Mantenimiento_Indices.sql |
| Actualización de Estadísticas | UPDATE STATISTICS + sp_updatestats para optimizar consultas | Semanal (domingo) | Grupo2_Estadisticas.sql |
| Compactado de Logs | DBCC SHRINKFILE para liberar espacio en .mdf y .ldf | Semanal (domingo) | Grupo2_MantenimientoLogs.sql |
| Database Mail | Configuración de correo SMTP para notificaciones automáticas | Una vez (configuración) | Grupo2_ConfiguracionCorreo.sql |

---

## 2. SQL Agent Jobs Creados

| Nombre del Job | Frecuencia | Descripción |
|----------------|------------|-------------|
| ExperienciaSV_Backup_Diario | Diario 2:00 AM | Ejecuta BACKUP DATABASE completo con compresión y checksum |
| ExperienciaSV_Mantenimiento_Indices | Domingo 3:00 AM | Recorre todos los índices: REBUILD si fragmentación >30%, REORGANIZE si >10% |
| ExperienciaSV_Actualizar_Estadisticas | Domingo 1:00 AM | Ejecuta UPDATE STATISTICS en tablas principales y sp_updatestats global |
| ExperienciaSV_Compactar_Logs | Domingo 4:00 AM | Ejecuta DBCC SHRINKFILE en archivos .mdf (15% libre) y .ldf (10% libre) |

---

## 3. Estrategia de Backups

| Tipo de Backup | ¿Cuándo se ejecuta? | ¿Qué contiene? | Retención |
|----------------|---------------------|----------------|-----------|
| **FULL** | Diario 2:00 AM | Copia completa de toda la base de datos | — |
| **DIFERENCIAL** | Cada 6 horas (8 AM, 2 PM, 8 PM) | Solo los cambios desde el último FULL | — |
| **TRANSACTION LOG** | Cada 1 hora | Registro de cada operación (INSERT, UPDATE, DELETE) | — |

**Estrategia de restauración:** FULL más reciente + último DIFERENCIAL + todos los LOG posteriores.

**Opciones aplicadas:**
- `COMPRESSION`: reduce tamaño del backup hasta un 70%
- `CHECKSUM`: detecta corrupción en el archivo de backup
- `STATS = 10`: muestra progreso cada 10%

---

## 4. Calendario de Mantenimiento

### Semanal (todos los domingos)

| Hora | Tarea | Job |
|------|-------|-----|
| 01:00 AM | Actualizar estadísticas | ExperienciaSV_Actualizar_Estadisticas |
| 02:00 AM | Backup completo | ExperienciaSV_Backup_Diario |
| 03:00 AM | Mantenimiento de índices | ExperienciaSV_Mantenimiento_Indices |
| 04:00 AM | Compactar logs | ExperienciaSV_Compactar_Logs |

### Diario (lunes a domingo)

| Hora | Tarea |
|------|-------|
| 02:00 AM | Backup completo |
| Cada 1 hora | Backup de transaction log |
| Cada 6 horas (8 AM, 2 PM, 8 PM) | Backup diferencial |

---

## 5. Decisiones de Diseño y Justificación

**1. Backup FULL diario + DIF cada 6h + LOG cada 1h**  
Esta combinación permite recuperar los datos con máximo 1 hora de pérdida ante cualquier fallo. Es la estrategia estándar para bases de datos transaccionales donde se registran reservas, pagos y cancelaciones constantemente.

**2. Mantenimiento en horario de madrugada (1-4 AM)**  
Las tareas pesadas (DBCC CHECKDB, rebuild de índices, shrink) se programan en domingo de madrugada, cuando el sistema tiene menor o nula actividad de usuarios. Esto evita afectar el rendimiento durante horas pico.

**3. Umbrales de fragmentación: >30% REBUILD, >10% REORGANIZE**  
REBUILD es más costoso (bloquea la tabla) pero necesario cuando la fragmentación supera el 30%. Entre 10% y 30%, REORGANIZE es suficiente y menos intrusivo. Por debajo de 10% no se interviene.

**4. Compactado manual, no automático**  
Se desactiva AUTO_SHRINK porque causa fragmentación al ejecutarse descontroladamente. En su lugar, se programa un shrink semanal después del rebuild de índices para mantener la base de datos compacta sin degradar el rendimiento.

**5. Crecimiento de archivos en MB, no en porcentaje**  
Configurar FILEGROWTH en MB (50 MB para .mdf, 25 MB para .ldf) es más predecible y evita crecimientos excesivos que ocurren al usar porcentajes sobre archivos ya grandes.

**6. Database Mail con perfil dedicado**  
Se crea un perfil exclusivo para ExperienciaSV que permite notificaciones independientes sin interferir con otras bases de datos en la misma instancia de SQL Server.

---

## 6. Scripts Entregados

| # | Archivo | Contenido |
|---|---------|-----------|
| 1 | Grupo2_PlanesBackup.sql | Backup FULL, DIFERENCIAL y TRANSACTION LOG |
| 2 | Grupo2_Mantenimiento_Indices.sql | Detección de fragmentación, REORGANIZE, REBUILD |
| 3 | Grupo2_Estadisticas.sql | UPDATE STATISTICS, sp_updatestats |
| 4 | Grupo2_MantenimientoLogs.sql | DBCC SHRINKFILE, configuración de crecimiento |
| 5 | Grupo2_ConfiguracionCorreo.sql | Database Mail, perfil, cuenta SMTP |
| 6 | Grupo2_JobsAutomatizacion.sql | 4 jobs programados en SQL Server Agent |
| 7 | Grupo2_Documentacion.pdf | Este documento |
| 8 | Grupo2_CreacionBD.sql | Script completo de creación de la base de datos |
