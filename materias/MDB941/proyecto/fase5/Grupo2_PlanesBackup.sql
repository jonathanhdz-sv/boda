-- ============================================================
-- PROYECTO EXPERIENCIASV — MDB941
-- Fase 5: Mantenimiento de Datos
-- Grupo 2 | Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
-- Archivo: Grupo2_PlanesBackup.sql
-- Contenido: Backup COMPLETO, DIFERENCIAL y TRANSACTION LOG
-- ============================================================

USE ExperienciaSV;
GO

-- ============================================================
-- 1. PLAN DE BACKUP COMPLETO (FULL)
-- Descripción: Backup completo de la base de datos
-- Frecuencia: Diario a las 2:00 AM
-- ============================================================

BACKUP DATABASE ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Full.bak'
WITH FORMAT,
     NAME = 'ExperienciaSV-Full Database Backup',
     DESCRIPTION = 'Backup completo diario',
     COMPRESSION,
     CHECKSUM,
     STATS = 10;
PRINT 'Backup completo realizado exitosamente';

-- ============================================================
-- 2. PLAN DE BACKUP DIFERENCIAL
-- Descripción: Backup de cambios desde el último FULL
-- Frecuencia: Cada 6 horas (8:00 AM, 2:00 PM, 8:00 PM)
-- ============================================================

BACKUP DATABASE ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Diferencial.bak'
WITH DIFFERENTIAL,
     NAME = 'ExperienciaSV-Differential Database Backup',
     DESCRIPTION = 'Backup diferencial cada 6 horas',
     COMPRESSION,
     CHECKSUM,
     STATS = 10;
PRINT 'Backup diferencial realizado exitosamente';

-- ============================================================
-- 3. PLAN DE BACKUP DE TRANSACTION LOG
-- Descripción: Backup del log de transacciones
-- Frecuencia: Cada 1 hora
-- Permite recuperación al punto en el tiempo
-- ============================================================

BACKUP LOG ExperienciaSV
TO DISK = 'C:\Backups\ExperienciaSV_Log.trn'
WITH NAME = 'ExperienciaSV-Transaction Log Backup',
     DESCRIPTION = 'Backup de log de transacciones cada hora',
     COMPRESSION,
     CHECKSUM,
     STATS = 10;
PRINT 'Backup de transaction log realizado exitosamente';

-- ============================================================
-- 4. VERIFICAR INTEGRIDAD DEL BACKUP
-- Descripción: Restore VerifyOnly para confirmar que el backup no está corrupto
-- ============================================================
RESTORE VERIFYONLY
FROM DISK = 'C:\Backups\ExperienciaSV_Full.bak'
WITH CHECKSUM;
PRINT 'Verificación de backup completada sin errores';

PRINT '============================================';
PRINT 'PLANES DE BACKUP CONFIGURADOS';
PRINT '  FULL        -> Diario 2:00 AM (C:\Backups\ExperienciaSV_Full.bak)';
PRINT '  DIFFERENTIAL -> Cada 6 horas (C:\Backups\ExperienciaSV_Diferencial.bak)';
PRINT '  LOG          -> Cada 1 hora (C:\Backups\ExperienciaSV_Log.trn)';
PRINT '============================================';
GO
