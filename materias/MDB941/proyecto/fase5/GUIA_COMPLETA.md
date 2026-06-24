# Guía Completa: Mantenimiento de Bases de Datos en SQL Server
## Proyecto ExperienciaSV — Fase 5

---

# PARTE 1: BACKUPS

## 1.1 ¿Qué es un backup y por qué existe?

Una base de datos vive en archivos físicos en el disco duro. Esos archivos se pueden:
- Corromper (un apagón mientras escribe)
- Borrar por error (alguien ejecuta un DROP DATABASE)
- Fallar (el disco duro muere)

Un backup es una **fotocopia de seguridad** que se guarda en OTRO lugar. Si algo falla, restauramos la copia.

## 1.2 Los tres niveles de backup

Imaginate que estás escribiendo un libro de 500 páginas:

| Tipo | Analogía | ¿Qué guarda? | ¿Cuándo? |
|------|----------|-------------|----------|
| **FULL** | Fotocopiar TODO el libro | La base de datos entera | 1 vez al día |
| **DIFERENCIAL** | Fotocopiar solo las páginas escritas HOY | Cambios desde el último FULL | Cada 6 horas |
| **LOG** | Un cuaderno donde anotás cada letra que escribiste | Cada operación (INSERT, UPDATE, DELETE) | Cada 1 hora |

### Ejemplo de restauración

Ocurre un desastre un martes a las 3:30 PM. Para recuperar:

```
1. Restaurar FULL del lunes 2:00 AM         → BD como estaba el lunes
2. Restaurar DIFERENCIAL del martes 8:00 AM  → cambios del lunes 2AM a martes 8AM
3. Restaurar LOG de 9:00 AM                  → operaciones de 8-9 AM
4. Restaurar LOG de 10:00 AM                 → operaciones de 9-10 AM
5. ... así hasta el LOG de 3:00 PM           → recuperás hasta las 3 PM
```

**Perdiste solo 30 minutos de datos** (de 3:00 a 3:30 PM). Sin backups, perdías TODO.

## 1.3 Opciones importantes en BACKUP

```sql
BACKUP DATABASE ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV.bak'
WITH FORMAT,        -- Sobrescribe el archivo si ya existe
     COMPRESSION,   -- Comprime el backup (reduce tamaño hasta 70%)
     CHECKSUM,      -- Detecta si el archivo se corrompió
     STATS = 10;    -- Muestra "10% completado... 20%..." en pantalla
```

| Opción | ¿Para qué sirve? | ¿Qué pasa si no la pongo? |
|--------|-----------------|--------------------------|
| FORMAT | Sobrescribe el archivo existente | Error si el archivo ya existe |
| COMPRESSION | Reduce el tamaño del backup | Backup ocupa más espacio en disco |
| CHECKSUM | Verifica que los datos no estén corruptos | No sabés si el backup sirve hasta que intentás restaurar |
| STATS = 10 | Muestra progreso en pantalla | No ves avance, parece que se congeló |

## 1.4 Verificar que un backup sirve

De nada sirve hacer backups si no verificás que funcionan:

```sql
RESTORE VERIFYONLY
FROM DISK = 'C:\Backups\ExperienciaSV.bak'
WITH CHECKSUM;
```

Si dice "The backup set is valid", el backup está sano. Si no, tenés un problema.

## 1.5 ¿Cada cuánto hacer cada tipo?

| Tipo | Frecuencia | ¿Por qué? |
|------|-----------|-----------|
| FULL | Diario | Es pesado. Hacerlo cada hora sobrecarga el servidor |
| DIFERENCIAL | Cada 6 horas | Equilibrio: más frecuente que FULL, más ligero |
| LOG | Cada 1 hora | Permite recuperar hasta 1 hora antes del fallo |

---

# PARTE 2: ÍNDICES

## 2.1 ¿Qué es un índice?

Sin índice, SQL Server busca datos **fila por fila** (table scan). Con 10,000 turistas, buscar uno por email recorre las 10,000 filas.

Con índice, es como buscar en el índice de un libro: vas directo a la página correcta.

```sql
-- Sin índice: recorre 10,000 filas
-- Con índice: lee 2-3 páginas
SELECT * FROM TURISTA WHERE email = 'carlos@email.com';
```

## 2.2 ¿Qué es la fragmentación?

Cuando insertás, actualizás y borrás datos, las páginas del índice se **desordenan**. Es como un libro donde arrancaste páginas y las pegaste en cualquier lado.

**Fragmentación = desorden del índice.** Mientras más alto el porcentaje, más lento busca.

## 2.3 REORGANIZE vs REBUILD

```sql
-- Fragmentación 10% - 30%: REORGANIZE (ordena sin reconstruir)
ALTER INDEX ALL ON Experiencias REORGANIZE;

-- Fragmentación > 30%: REBUILD (borra y crea desde cero)
ALTER INDEX ALL ON Experiencias REBUILD;
```

| Característica | REORGANIZE | REBUILD |
|---------------|-----------|---------|
| ¿Qué hace? | Reordena páginas | Borra el índice y lo crea nuevo |
| ¿Bloquea la tabla? | No (se puede usar mientras) | Sí (con ONLINE=OFF) |
| ¿Cuándo usarlo? | 10%-30% fragmentación | >30% fragmentación |
| ¿Es pesado? | Liviano | Pesado |

## 2.4 ¿Cómo sé cuánta fragmentación tengo?

```sql
SELECT
    OBJECT_NAME(ips.object_id) AS Tabla,
    i.name AS Indice,
    ips.avg_fragmentation_in_percent AS FragmentacionPct
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
INNER JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE i.name IS NOT NULL
ORDER BY ips.avg_fragmentation_in_percent DESC;
```

---

# PARTE 3: ESTADÍSTICAS

## 3.1 ¿Qué son las estadísticas?

SQL Server tiene un **optimizador** que decide cómo ejecutar cada consulta. Para decidir bien, necesita saber:

- ¿Cuántas filas tiene la tabla TURISTA?
- ¿Cuántos valores distintos hay en la columna `nacionalidad`?
- ¿Cuál es el valor más frecuente en `estado`?

Esa información son las **estadísticas**. SQL Server las usa para armar el "plan de ejecución".

## 3.2 ¿Qué pasa si las estadísticas están viejas?

Imaginate que la tabla TURISTA tenía 100 filas cuando se crearon las estadísticas, pero ahora tiene 10,000. El optimizador sigue pensando que son 100 filas y **toma malas decisiones**: usa un plan para tabla chica en una tabla enorme. Resultado: consultas lentas.

## 3.3 Cómo actualizar estadísticas

```sql
-- Una tabla específica
UPDATE STATISTICS TURISTA;

-- Varias tablas
UPDATE STATISTICS TURISTA;
UPDATE STATISTICS RESERVACION;
UPDATE STATISTICS EXPERIENCIA;

-- TODA la base de datos de un solo golpe
EXEC sp_updatestats;
```

`sp_updatestats` recorre todas las tablas y actualiza solo las estadísticas que realmente necesitan refrescarse.

---

# PARTE 4: LOGS Y SHRINK

## 4.1 Los dos archivos de una base de datos

Toda base de datos SQL Server tiene mínimo 2 archivos:

| Archivo | Extensión | ¿Qué guarda? |
|---------|-----------|-------------|
| Datos | `.mdf` | Los datos reales: turistas, reservas, pagos |
| Log | `.ldf` | Bitácora de CADA operación: "INSERT en TURISTA a las 14:32", "UPDATE en PAGO a las 14:33" |

## 4.2 ¿Por qué crece el .ldf?

El archivo de log **nunca se limpia solo**. Cada INSERT, UPDATE, DELETE se anota. Si hacés 100,000 operaciones al día, el .ldf crece sin parar.

## 4.3 Cómo compactar (SHRINK)

```sql
-- Ver el tamaño actual
SELECT name, size * 8 / 1024 AS TamanoMB
FROM sys.database_files;

-- Compactar el log (dejar 10% libre)
DBCC SHRINKFILE(ExperienciaSV_log, 10);

-- Compactar los datos (dejar 15% libre)
DBCC SHRINKFILE(ExperienciaSV_data, 15);
```

**Importante:** El shrink se hace DESPUÉS del backup. El backup libera espacio en el log, el shrink lo compacta.

## 4.4 Configurar crecimiento automático

Para que los archivos crezcan de forma controlada:

```sql
ALTER DATABASE ExperienciaSV
MODIFY FILE (NAME = ExperienciaSV_data, FILEGROWTH = 50MB);

ALTER DATABASE ExperienciaSV
MODIFY FILE (NAME = ExperienciaSV_log, FILEGROWTH = 25MB);
```

**¿MB o porcentaje?** Siempre en MB. Si usás porcentaje, un archivo de 10 GB crece 1 GB por evento. En MB crece de forma predecible.

---

# PARTE 5: DATABASE MAIL

## 5.1 ¿Qué es?

Database Mail es el sistema de correo integrado en SQL Server. Permite que la base de datos envíe correos automáticos sin necesidad de un programa externo.

## 5.2 ¿Para qué sirve?

- **Alertas:** "El backup de las 2 AM falló"
- **Reportes:** "Reporte diario: 150 reservas nuevas, $3,500 en pagos"
- **Notificaciones:** "El job de mantenimiento de índices terminó con errores"

## 5.3 Configuración básica

```sql
-- 1. Habilitar la funcionalidad
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;

-- 2. Crear un perfil (contenedor de cuentas)
EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'Perfil_ExperienciaSV';

-- 3. Crear una cuenta SMTP
EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = 'Cuenta_ExperienciaSV',
    @email_address = 'tu_correo@outlook.com',
    @mailserver_name = 'smtp.office365.com',
    @port = 587,
    @username = 'tu_correo@outlook.com',
    @password = 'tu_contraseña',
    @enable_ssl = 1;

-- 4. Asociar cuenta al perfil
EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Perfil_ExperienciaSV',
    @account_name = 'Cuenta_ExperienciaSV',
    @sequence_number = 1;

-- 5. Probar envío
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Perfil_ExperienciaSV',
    @recipients = 'destinatario@correo.com',
    @subject = 'Prueba Database Mail',
    @body = 'Si ves esto, Database Mail funciona.';
```

---

# PARTE 6: JOBS (SQL SERVER AGENT)

## 6.1 ¿Qué es un Job?

Un **job** es una tarea programada que se ejecuta automáticamente. Como la alarma del celular: "todos los días a las 7 AM, sonar".

SQL Server Agent es el servicio que ejecuta los jobs. Sin él, los jobs existen pero nunca se ejecutan.

## 6.2 Anatomía de un Job

Un job tiene 3 partes:

| Parte | ¿Qué es? | Analogía |
|-------|---------|----------|
| **Job** | El contenedor, el nombre | "Mi alarma" |
| **Step** (paso) | Lo que hace | "Sonar canción X" |
| **Schedule** (horario) | Cuándo lo hace | "Lunes a viernes 7:00 AM" |

## 6.3 Crear un job desde cero

```sql
USE msdb;
GO

-- PASO 1: Crear el job
EXEC sp_add_job
    @job_name = 'MiJob_BackupDiario',
    @enabled = 1,
    @description = 'Backup completo diario de ExperienciaSV';

-- PASO 2: Crear el step (lo que ejecuta)
EXEC sp_add_jobstep
    @job_name = 'MiJob_BackupDiario',
    @step_name = 'EjecutarBackup',
    @subsystem = 'TSQL',
    @command = 'BACKUP DATABASE ExperienciaSV TO DISK = ''C:\Backups\bd.bak'' WITH FORMAT, COMPRESSION',
    @database_name = 'ExperienciaSV';

-- PASO 3: Crear el schedule (cuándo)
EXEC sp_add_schedule
    @schedule_name = 'Diario_2AM',
    @freq_type = 4,
    @freq_interval = 1,
    @active_start_time = 020000;

-- PASO 4: Pegar el schedule al job
EXEC sp_attach_schedule
    @job_name = 'MiJob_BackupDiario',
    @schedule_name = 'Diario_2AM';

-- PASO 5: Asignar el job al servidor
EXEC sp_add_jobserver
    @job_name = 'MiJob_BackupDiario';
```

## 6.4 Tipos de frecuencia (@freq_type)

| @freq_type | Significado | Ejemplo |
|-----------|------------|---------|
| 4 | Diario | Todos los días |
| 8 | Semanal | Cada domingo |
| 16 | Mensual | Día 1 de cada mes |

## 6.5 Formato de hora (@active_start_time)

Se escribe en formato militar sin dos puntos: `HHMMSS`

| Hora | Se escribe |
|------|-----------|
| 1:00 AM | `010000` |
| 2:00 AM | `020000` |
| 2:00 PM | `140000` |
| 11:30 PM | `233000` |

---

# PARTE 7: CONFIGURACIÓN DE RECURSOS

## 7.1 Memoria RAM

SQL Server es hambriento de RAM. Si no le ponés límite, se come todo y la computadora se arrastra.

```sql
-- Reservar 20% para el sistema operativo
-- Si tenés 8 GB totales → 6.4 GB para SQL Server
EXEC sp_configure 'max server memory (MB)', 6144;
RECONFIGURE;

-- Garantizar al menos 1 GB para SQL Server
EXEC sp_configure 'min server memory (MB)', 1024;
RECONFIGURE;
```

| RAM total | RAM para SQL Server (80%) |
|-----------|--------------------------|
| 4 GB | 3276 MB |
| 8 GB | 6553 MB |
| 16 GB | 13107 MB |

## 7.2 Procesadores (MAXDOP)

MAXDOP = máximo de procesadores que una consulta puede usar en paralelo. Si es muy alto, una consulta pesada acapara todos los cores.

```sql
-- Regla: número de cores físicos, máximo 8
EXEC sp_configure 'max degree of parallelism', 4;
RECONFIGURE;
```

## 7.3 Configuraciones de la base de datos

```sql
ALTER DATABASE ExperienciaSV SET AUTO_CLOSE OFF;
ALTER DATABASE ExperienciaSV SET AUTO_SHRINK OFF;
ALTER DATABASE ExperienciaSV SET RECOVERY FULL;
ALTER DATABASE ExperienciaSV SET PAGE_VERIFY CHECKSUM;
```

| Opción | Valor | ¿Por qué? |
|--------|-------|-----------|
| AUTO_CLOSE | OFF | Si está ON, la BD se cierra cuando nadie la usa. Con OFF, siempre está lista |
| AUTO_SHRINK | OFF | Si está ON, se compacta sola en cualquier momento (causa fragmentación) |
| RECOVERY | FULL | Permite recuperación al punto exacto usando backups de log |
| PAGE_VERIFY | CHECKSUM | Detecta páginas corruptas en disco |

---

# PARTE 8: PREGUNTAS FRECUENTES DE DEFENSA

### "¿Qué diferencia hay entre backup FULL y DIFERENCIAL?"
El FULL copia todo. El DIFERENCIAL copia solo lo que cambió desde el último FULL. El DIFERENCIAL depende del FULL: no puedo restaurar un DIFERENCIAL si no tengo el FULL.

### "¿Cuándo usás REBUILD y cuándo REORGANIZE?"
Fragmentación > 30% = REBUILD (reconstruye desde cero, más pesado). Fragmentación entre 10% y 30% = REORGANIZE (reordena, más liviano). Menos de 10% = no se toca.

### "¿Qué pasa si no actualizo estadísticas?"
El optimizador de SQL toma decisiones con información vieja. Las consultas usan planes ineficientes y todo se vuelve lento.

### "¿Por qué el AUTO_SHRINK debe estar en OFF?"
Porque se dispara en cualquier momento y causa fragmentación en los índices. Es mejor hacer SHRINK manualmente una vez por semana, después del REBUILD de índices.

### "¿Para qué sirve Database Mail si ya tengo correo?"
Para que SQL Server te avise automáticamente cuando algo falla. Un backup puede fallar a las 2 AM; sin Database Mail, te enterás al día siguiente cuando ya es tarde.

---

# PARTE 9: EJERCICIOS DE PRÁCTICA

Intentá escribir cada uno sin ver. Si te trabás, volvé a leer la sección correspondiente.

### Ejercicio 1
Creá un backup completo de la BD VentasSA con compresión.

### Ejercicio 2
Creá un backup de log de la BD ExperienciaSV.

### Ejercicio 3
Reconstruí todos los índices de la tabla PAGOS.

### Ejercicio 4
Actualizá las estadísticas de las tablas CLIENTES y FACTURAS.

### Ejercicio 5
Compactá el archivo de log dejando 10% libre.

### Ejercicio 6
Creá un job que haga backup diferencial todos los días a las 2 PM.

### Ejercicio 7
Explicá con tus palabras: ¿qué es fragmentación y cómo se arregla?
