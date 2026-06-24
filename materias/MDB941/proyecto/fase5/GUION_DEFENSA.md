# Guion para Defensa — Fase 5 ExperienciaSV

## Cómo estudiar esto
Cada sección tiene 3 partes:
- **Explicación**: qué decir (en tus palabras)
- **Sintaxis**: qué escribir en SSMS
- **Contraseña mental**: una frase corta para recordar la sintaxis

Leelo 2-3 veces y después practicá escribiendo sin ver.

---

## 1. BACKUP COMPLETO (FULL)

### Qué decir
"Un backup completo es una copia de toda la base de datos en un solo archivo. Se usa COMPRESSION para que pese menos y CHECKSUM para verificar que no esté corrupto. Se ejecuta diario en la madrugada."

### Qué escribir
```sql
BACKUP DATABASE ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Full.bak'
WITH FORMAT,
     NAME = 'ExperienciaSV-Full Backup',
     COMPRESSION,
     CHECKSUM,
     STATS = 10;
```

### Contraseña mental
`DATABASE nombre TO DISK ruta WITH FORMAT COMPRESSION CHECKSUM`

---

## 2. BACKUP DIFERENCIAL

### Qué decir
"El backup diferencial guarda solo lo que cambió desde el último backup completo. Es más rápido y liviano que el FULL. Se ejecuta cada 6 horas. Para restaurar necesito el FULL más el último DIFERENCIAL."

### Qué escribir
```sql
BACKUP DATABASE ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Dif.bak'
WITH DIFFERENTIAL,
     NAME = 'ExperienciaSV-Diff Backup',
     COMPRESSION,
     CHECKSUM,
     STATS = 10;
```

### Contraseña mental
Lo mismo que FULL pero cambiá `FORMAT` por `DIFFERENTIAL`

---

## 3. BACKUP DE TRANSACTION LOG

### Qué decir
"El backup de log guarda el historial de cada operación: cada INSERT, UPDATE y DELETE. Permite restaurar los datos hasta un minuto específico. Se ejecuta cada hora."

### Qué escribir
```sql
BACKUP LOG ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Log.trn'
WITH NAME = 'ExperienciaSV-Log Backup',
     COMPRESSION,
     CHECKSUM;
```

### Contraseña mental
`BACKUP LOG` en vez de `BACKUP DATABASE`. Sin FORMAT ni DIFFERENTIAL.

---

## 4. REBUILD DE ÍNDICES

### Qué decir
"Con el tiempo los índices se fragmentan. Cuando la fragmentación supera el 30%, se hace un REBUILD: borra el índice y lo crea desde cero. Es como rehacer el índice de un libro."

### Qué escribir
```sql
ALTER INDEX ALL ON Experiencias REBUILD;
ALTER INDEX ALL ON Reservaciones REBUILD;
```

### Contraseña mental
`ALTER INDEX ALL ON tabla REBUILD`

---

## 5. REORGANIZE DE ÍNDICES

### Qué decir
"Cuando la fragmentación está entre 10% y 30%, solo se REORGANIZA: reordena las páginas sin reconstruir todo. Es menos pesado que el REBUILD."

### Qué escribir
```sql
ALTER INDEX ALL ON Experiencias REORGANIZE;
ALTER INDEX ALL ON Reservaciones REORGANIZE;
```

### Contraseña mental
`ALTER INDEX ALL ON tabla REORGANIZE`

---

## 6. ACTUALIZAR ESTADÍSTICAS

### Qué decir
"SQL Server usa estadísticas para decidir cómo buscar datos. Si están desactualizadas, las consultas se vuelven lentas. UPDATE STATISTICS las refresca."

### Qué escribir
```sql
UPDATE STATISTICS Experiencias;
UPDATE STATISTICS Reservaciones;
```

### Contraseña mental
`UPDATE STATISTICS tabla`

### Versión global (toda la BD)
```sql
EXEC sp_updatestats;
```

---

## 7. COMPACTAR LOGS (SHRINK)

### Qué decir
"El archivo de log (.ldf) guarda todas las operaciones y crece sin parar. DBCC SHRINKFILE reduce su tamaño físico liberando espacio en disco. Se hace semanalmente."

### Qué escribir
```sql
DBCC SHRINKFILE(ExperienciaSV_log, 10);
```

### Contraseña mental
`DBCC SHRINKFILE(nombre_log, porcentaje_libre)`

---

## 8. CREAR UN JOB

### Qué decir
"Un job es una tarea programada. Con sp_add_job defino el nombre, con sp_add_jobstep defino qué hace, y con sp_add_schedule defino cuándo se ejecuta."

### Qué escribir
```sql
-- Paso 1: Crear el job
EXEC msdb.dbo.sp_add_job
    @job_name = 'MiJob_Diario',
    @enabled = 1;

-- Paso 2: Agregar el paso (lo que hace)
EXEC msdb.dbo.sp_add_jobstep
    @job_name = 'MiJob_Diario',
    @step_name = 'Backup',
    @subsystem = 'TSQL',
    @command = 'BACKUP DATABASE ExperienciaSV TO DISK = ''C:\Backups\MiBackup.bak''',
    @database_name = 'ExperienciaSV';

-- Paso 3: Programar horario
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = 'Diario_2AM',
    @freq_type = 4,
    @active_start_time = 020000;

-- Paso 4: Unir schedule al job
EXEC msdb.dbo.sp_attach_schedule
    @job_name = 'MiJob_Diario',
    @schedule_name = 'Diario_2AM';

-- Paso 5: Asignar al servidor
EXEC msdb.dbo.sp_add_jobserver
    @job_name = 'MiJob_Diario';
```

### Contraseña mental
Los 5 pasos: `job → step → schedule → attach → server`

### Valores de @freq_type
| Valor | Significado |
|-------|------------|
| 4 | Diario |
| 8 | Semanal |
| 16 | Mensual |

### Formato de @active_start_time
`HHMMSS` → 020000 = 2:00 AM, 140000 = 2:00 PM

---

## 9. CONFIGURAR DATABASE MAIL

### Qué decir
"Database Mail permite que SQL Server envíe correos automáticos para notificar backups fallidos, errores o reportes diarios."

### Qué escribir (pasos esenciales)
```sql
-- Habilitar Database Mail
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;

-- Crear perfil
EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'Perfil_ExperienciaSV';

-- Enviar correo de prueba
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Perfil_ExperienciaSV',
    @recipients = 'admin@correo.com',
    @subject = 'Prueba',
    @body = 'Database Mail funciona';
```

### Contraseña mental
3 pasos: `habilitar → perfil → enviar`

---

## Resumen rápido para memorizar

| Si te pide... | Palabra clave |
|---------------|---------------|
| Backup FULL | `BACKUP DATABASE ... WITH FORMAT` |
| Backup DIFERENCIAL | `BACKUP DATABASE ... WITH DIFFERENTIAL` |
| Backup LOG | `BACKUP LOG` |
| Rebuild índice | `ALTER INDEX ALL ON tabla REBUILD` |
| Reorganize índice | `ALTER INDEX ALL ON tabla REORGANIZE` |
| Estadísticas | `UPDATE STATISTICS tabla` o `sp_updatestats` |
| Compactar | `DBCC SHRINKFILE(nombre, 10)` |
| Crear job | `sp_add_job → step → schedule → attach → server` |
| Correo | `sp_configure → sysmail_add_profile → sp_send_dbmail` |
