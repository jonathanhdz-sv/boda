-- ============================================================
-- PROYECTO EXPERIENCIASV — MDB941
-- Fase 5: Mantenimiento de Datos
-- Grupo 2 | Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
-- Archivo: Grupo2_JobsAutomatizacion.sql
-- Contenido: Jobs programados con SQL Server Agent (mínimo 3)
-- ============================================================

USE msdb;
GO

PRINT '============================================';
PRINT 'JOBS DE AUTOMATIZACIÓN - ExperienciaSV';
PRINT '============================================';

-- ============================================================
-- JOB 1: BACKUP COMPLETO DIARIO
-- Descripción: Backup completo de ExperienciaSV
-- Frecuencia: Diario a las 2:00 AM
-- ============================================================

IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'ExperienciaSV_Backup_Diario')
    EXEC msdb.dbo.sp_delete_job @job_name = 'ExperienciaSV_Backup_Diario';
GO

EXEC msdb.dbo.sp_add_job
    @job_name    = 'ExperienciaSV_Backup_Diario',
    @enabled     = 1,
    @description = 'Backup completo diario de la base de datos ExperienciaSV',
    @owner_login_name = 'sa';

EXEC msdb.dbo.sp_add_jobstep
    @job_name         = 'ExperienciaSV_Backup_Diario',
    @step_name        = 'Ejecutar Backup Diario',
    @subsystem        = 'TSQL',
    @command          = 'BACKUP DATABASE ExperienciaSV TO DISK = ''C:\Backups\ExperienciaSV_Full.bak'' WITH FORMAT, NAME = ''ExperienciaSV-Full'', COMPRESSION, CHECKSUM, STATS = 10; PRINT ''Backup completo realizado'';',
    @database_name    = 'ExperienciaSV',
    @on_success_action = 1,
    @on_fail_action   = 2;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name     = 'Diario_2AM',
    @freq_type         = 4,
    @freq_interval     = 1,
    @active_start_time = 020000;

EXEC msdb.dbo.sp_attach_schedule
    @job_name      = 'ExperienciaSV_Backup_Diario',
    @schedule_name = 'Diario_2AM';

EXEC msdb.dbo.sp_add_jobserver
    @job_name    = 'ExperienciaSV_Backup_Diario',
    @server_name = @@SERVERNAME;

PRINT '>> Job 1 creado: ExperienciaSV_Backup_Diario (2:00 AM diario)';
GO

-- ============================================================
-- JOB 2: MANTENIMIENTO DE ÍNDICES SEMANAL
-- Descripción: Reorganiza o reconstruye índices fragmentados
-- Frecuencia: Domingo a las 3:00 AM
-- ============================================================

IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'ExperienciaSV_Mantenimiento_Indices')
    EXEC msdb.dbo.sp_delete_job @job_name = 'ExperienciaSV_Mantenimiento_Indices';
GO

EXEC msdb.dbo.sp_add_job
    @job_name    = 'ExperienciaSV_Mantenimiento_Indices',
    @enabled     = 1,
    @description = 'Reorganización y reconstrucción de índices según fragmentación',
    @owner_login_name = 'sa';

EXEC msdb.dbo.sp_add_jobstep
    @job_name         = 'ExperienciaSV_Mantenimiento_Indices',
    @step_name        = 'Ejecutar Mantenimiento Índices',
    @subsystem        = 'TSQL',
    @command          = '
DECLARE @tabla NVARCHAR(256), @indice NVARCHAR(256), @frag DECIMAL(5,2), @sql NVARCHAR(MAX);
DECLARE cur CURSOR FOR
SELECT OBJECT_SCHEMA_NAME(ips.object_id)+''.''+OBJECT_NAME(ips.object_id), i.name, ips.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(''ExperienciaSV''),NULL,NULL,NULL,''LIMITED'') ips
INNER JOIN sys.indexes i ON ips.object_id=i.object_id AND ips.index_id=i.index_id
WHERE i.name IS NOT NULL AND ips.avg_fragmentation_in_percent>10;
OPEN cur; FETCH NEXT FROM cur INTO @tabla,@indice,@frag;
WHILE @@FETCH_STATUS=0 BEGIN
  IF @frag>30 SET @sql=''ALTER INDEX [''+@indice+''] ON ''+@tabla+'' REBUILD;'';
  ELSE SET @sql=''ALTER INDEX [''+@indice+''] ON ''+@tabla+'' REORGANIZE;'';
  EXEC sp_executesql @sql;
  FETCH NEXT FROM cur INTO @tabla,@indice,@frag;
END
CLOSE cur; DEALLOCATE cur;
PRINT ''Mantenimiento de índices completado'';',
    @database_name    = 'ExperienciaSV',
    @on_success_action = 1,
    @on_fail_action   = 2;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name     = 'Domingo_3AM',
    @freq_type         = 8,
    @freq_interval     = 1,
    @freq_recurrence_factor = 1,
    @active_start_time = 030000;

EXEC msdb.dbo.sp_attach_schedule
    @job_name      = 'ExperienciaSV_Mantenimiento_Indices',
    @schedule_name = 'Domingo_3AM';

EXEC msdb.dbo.sp_add_jobserver
    @job_name    = 'ExperienciaSV_Mantenimiento_Indices',
    @server_name = @@SERVERNAME;

PRINT '>> Job 2 creado: ExperienciaSV_Mantenimiento_Indices (Domingo 3:00 AM)';
GO

-- ============================================================
-- JOB 3: ACTUALIZACIÓN DE ESTADÍSTICAS SEMANAL
-- Descripción: Actualiza estadísticas para optimizar consultas
-- Frecuencia: Domingo a las 1:00 AM
-- ============================================================

IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'ExperienciaSV_Actualizar_Estadisticas')
    EXEC msdb.dbo.sp_delete_job @job_name = 'ExperienciaSV_Actualizar_Estadisticas';
GO

EXEC msdb.dbo.sp_add_job
    @job_name    = 'ExperienciaSV_Actualizar_Estadisticas',
    @enabled     = 1,
    @description = 'Actualización semanal de estadísticas de la base de datos',
    @owner_login_name = 'sa';

EXEC msdb.dbo.sp_add_jobstep
    @job_name         = 'ExperienciaSV_Actualizar_Estadisticas',
    @step_name        = 'Actualizar Estadísticas',
    @subsystem        = 'TSQL',
    @command          = '
UPDATE STATISTICS TURISTA;
UPDATE STATISTICS RESERVACION;
UPDATE STATISTICS EXPERIENCIA;
UPDATE STATISTICS PAGO;
UPDATE STATISTICS GUIA;
UPDATE STATISTICS PROVEEDOR;
EXEC sp_updatestats;
PRINT ''Estadísticas actualizadas exitosamente'';',
    @database_name    = 'ExperienciaSV',
    @on_success_action = 1,
    @on_fail_action   = 2;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name     = 'Domingo_1AM',
    @freq_type         = 8,
    @freq_interval     = 1,
    @freq_recurrence_factor = 1,
    @active_start_time = 010000;

EXEC msdb.dbo.sp_attach_schedule
    @job_name      = 'ExperienciaSV_Actualizar_Estadisticas',
    @schedule_name = 'Domingo_1AM';

EXEC msdb.dbo.sp_add_jobserver
    @job_name    = 'ExperienciaSV_Actualizar_Estadisticas',
    @server_name = @@SERVERNAME;

PRINT '>> Job 3 creado: ExperienciaSV_Actualizar_Estadisticas (Domingo 1:00 AM)';
GO

-- ============================================================
-- JOB 4: COMPACTADO DE LOGS SEMANAL
-- Descripción: Compacta archivos .mdf y .ldf
-- Frecuencia: Domingo a las 4:00 AM
-- ============================================================

IF EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'ExperienciaSV_Compactar_Logs')
    EXEC msdb.dbo.sp_delete_job @job_name = 'ExperienciaSV_Compactar_Logs';
GO

EXEC msdb.dbo.sp_add_job
    @job_name    = 'ExperienciaSV_Compactar_Logs',
    @enabled     = 1,
    @description = 'Compactado semanal de archivos de datos y log',
    @owner_login_name = 'sa';

EXEC msdb.dbo.sp_add_jobstep
    @job_name         = 'ExperienciaSV_Compactar_Logs',
    @step_name        = 'Compactar Logs',
    @subsystem        = 'TSQL',
    @command          = '
DECLARE @log NVARCHAR(128), @data NVARCHAR(128);
SELECT @log=name FROM sys.database_files WHERE type=1;
SELECT @data=name FROM sys.database_files WHERE type=0;
DBCC SHRINKFILE(@log,10);
DBCC SHRINKFILE(@data,15);
PRINT ''Compactado de logs completado'';',
    @database_name    = 'ExperienciaSV',
    @on_success_action = 1,
    @on_fail_action   = 2;

EXEC msdb.dbo.sp_add_schedule
    @schedule_name     = 'Domingo_4AM',
    @freq_type         = 8,
    @freq_interval     = 1,
    @freq_recurrence_factor = 1,
    @active_start_time = 040000;

EXEC msdb.dbo.sp_attach_schedule
    @job_name      = 'ExperienciaSV_Compactar_Logs',
    @schedule_name = 'Domingo_4AM';

EXEC msdb.dbo.sp_add_jobserver
    @job_name    = 'ExperienciaSV_Compactar_Logs',
    @server_name = @@SERVERNAME;

PRINT '>> Job 4 creado: ExperienciaSV_Compactar_Logs (Domingo 4:00 AM)';
GO

-- ============================================================
-- RESUMEN DE JOBS CREADOS
-- ============================================================

PRINT '';
PRINT '============================================';
PRINT 'RESUMEN DE JOBS CREADOS';
PRINT '============================================';
PRINT '1. ExperienciaSV_Backup_Diario            -> Diario 2:00 AM';
PRINT '2. ExperienciaSV_Mantenimiento_Indices     -> Domingo 3:00 AM';
PRINT '3. ExperienciaSV_Actualizar_Estadisticas  -> Domingo 1:00 AM';
PRINT '4. ExperienciaSV_Compactar_Logs            -> Domingo 4:00 AM';
PRINT '';
PRINT 'Para iniciar un job manualmente:';
PRINT '  EXEC msdb.dbo.sp_start_job @job_name = ''NombreJob'';';
PRINT '============================================';
GO
