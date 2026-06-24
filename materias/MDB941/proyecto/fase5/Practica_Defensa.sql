-- ============================================================
-- PRACTICA PARA DEFENSA - Fase 5: Mantenimiento de Datos
-- Proyecto ExperienciaSV | Jonathan Hernandez HG235460
-- Todos los comandos de la Fase 5 en un solo script
-- ============================================================
USE ExperienciaSV;
GO

-- ============================================================
-- CONSULTAS: ver lo que hay en la BD
-- ============================================================

-- Tablas existentes
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_NAME;
GO

-- Datos de prueba
SELECT * FROM TURISTA;
SELECT * FROM PROVEEDOR;
SELECT * FROM GUIA;
SELECT * FROM EXPERIENCIA;
SELECT * FROM RESERVACION;
GO

-- Fragmentacion actual de indices
SELECT
    OBJECT_NAME(ips.object_id) AS Tabla,
    i.name AS Indice,
    ips.avg_fragmentation_in_percent AS FragmentacionPct,
    CASE
        WHEN ips.avg_fragmentation_in_percent > 30 THEN 'REBUILD'
        WHEN ips.avg_fragmentation_in_percent > 10 THEN 'REORGANIZE'
        ELSE 'OK'
    END AS Accion
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
INNER JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE i.name IS NOT NULL
ORDER BY ips.avg_fragmentation_in_percent DESC;
GO

-- Tamano actual de archivos
SELECT name, size * 8 / 1024 AS TamanoMB, type_desc
FROM sys.database_files;
GO

-- Jobs creados
SELECT name, enabled, description FROM msdb.dbo.sysjobs WHERE name LIKE 'ExperienciaSV%';
GO

-- ============================================================
-- MANTENIMIENTO: comandos que ejecuta la Fase 5
-- ============================================================

-- 1. BACKUP COMPLETO (FULL) - diario 2:00 AM
BACKUP DATABASE ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Full.bak'
WITH FORMAT, COMPRESSION, CHECKSUM, STATS = 10;
PRINT '>> BACKUP COMPLETO ejecutado';

-- 2. BACKUP DIFERENCIAL - cada 6 horas
BACKUP DATABASE ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Dif.bak'
WITH DIFFERENTIAL, COMPRESSION, CHECKSUM, STATS = 10;
PRINT '>> BACKUP DIFERENCIAL ejecutado';

-- 3. BACKUP DE TRANSACTION LOG - cada 1 hora
BACKUP LOG ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Log.trn'
WITH COMPRESSION, CHECKSUM;
PRINT '>> BACKUP LOG ejecutado';

-- 4. Verificar que el backup no esta corrupto
RESTORE VERIFYONLY FROM DISK = 'C:\Backups\ExperienciaSV_Full.bak' WITH CHECKSUM;
PRINT '>> Backup verificado - sin errores';

-- 5. REBUILD de indice (fragmentacion > 30%)
ALTER INDEX ALL ON Reservacion REBUILD;
PRINT '>> REBUILD ejecutado en Reservacion';

-- 6. REORGANIZE de indice (fragmentacion 10-30%)
ALTER INDEX ALL ON Experiencia REORGANIZE;
PRINT '>> REORGANIZE ejecutado en Experiencia';

-- 7. Actualizar estadisticas por tabla
UPDATE STATISTICS TURISTA;
UPDATE STATISTICS RESERVACION;
UPDATE STATISTICS EXPERIENCIA;
UPDATE STATISTICS PAGO;
PRINT '>> Estadisticas actualizadas por tabla';

-- 8. Actualizar TODAS las estadisticas
EXEC sp_updatestats;
PRINT '>> sp_updatestats ejecutado - toda la BD';

-- 9. Compactar archivo de log (dejar 10% libre)
DECLARE @log_name NVARCHAR(128);
SELECT @log_name = name FROM sys.database_files WHERE type = 1;
DBCC SHRINKFILE(@log_name, 10);
PRINT '>> Log compactado';

-- 10. Compactar archivo de datos (dejar 15% libre)
DECLARE @data_name NVARCHAR(128);
SELECT @data_name = name FROM sys.database_files WHERE type = 0;
DBCC SHRINKFILE(@data_name, 15);
PRINT '>> Datos compactados';

-- 11. Configurar crecimiento en MB
ALTER DATABASE ExperienciaSV MODIFY FILE (NAME = ExperienciaSV_data, FILEGROWTH = 50MB);
ALTER DATABASE ExperienciaSV MODIFY FILE (NAME = ExperienciaSV_log, FILEGROWTH = 25MB);
PRINT '>> Crecimiento configurado (50MB .mdf, 25MB .ldf)';

PRINT '============================================';
PRINT 'FASE 5 COMPLETA - PRACTICA FINALIZADA';
PRINT '============================================';
GO
