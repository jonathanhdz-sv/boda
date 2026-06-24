-- ============================================================
-- PROYECTO EXPERIENCIASV — MDB941
-- Fase 5: Mantenimiento de Datos
-- Grupo 2 | Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
-- Archivo: Grupo2_Estadisticas.sql
-- Contenido: Actualización de estadísticas (UPDATE STATISTICS, sp_updatestats)
-- ============================================================

USE ExperienciaSV;
GO

PRINT '============================================';
PRINT 'ACTUALIZACIÓN DE ESTADÍSTICAS - ExperienciaSV';
PRINT '============================================';

-- ============================================================
-- 1. CONSULTAR ESTADÍSTICAS ACTUALES
-- ============================================================

SELECT
    OBJECT_SCHEMA_NAME(s.object_id) + '.' + OBJECT_NAME(s.object_id) AS Tabla,
    s.name      AS Estadistica,
    STATS_DATE(s.object_id, s.stats_id) AS UltimaActualizacion,
    DATEDIFF(DAY, STATS_DATE(s.object_id, s.stats_id), GETDATE()) AS DiasSinActualizar
FROM sys.stats s
INNER JOIN sys.tables t ON s.object_id = t.object_id
WHERE s.auto_created = 0
ORDER BY DiasSinActualizar DESC;
GO

-- ============================================================
-- 2. ACTUALIZAR ESTADÍSTICAS POR TABLA
-- ============================================================

-- Tablas de alto volumen transaccional
UPDATE STATISTICS TURISTA;
PRINT 'Estadísticas actualizadas: TURISTA';

UPDATE STATISTICS RESERVACION;
PRINT 'Estadísticas actualizadas: RESERVACION';

UPDATE STATISTICS EXPERIENCIA;
PRINT 'Estadísticas actualizadas: EXPERIENCIA';

UPDATE STATISTICS PAGO;
PRINT 'Estadísticas actualizadas: PAGO';

UPDATE STATISTICS DISPONIBILIDAD;
PRINT 'Estadísticas actualizadas: DISPONIBILIDAD';

UPDATE STATISTICS GUIA;
PRINT 'Estadísticas actualizadas: GUIA';

UPDATE STATISTICS PROVEEDOR;
PRINT 'Estadísticas actualizadas: PROVEEDOR';

UPDATE STATISTICS AUDITORIA;
PRINT 'Estadísticas actualizadas: AUDITORIA';

-- ============================================================
-- 3. ACTUALIZAR TODAS LAS ESTADÍSTICAS DE LA BASE DE DATOS
-- ============================================================

EXEC sp_updatestats;
PRINT '';
PRINT '>> Todas las estadísticas actualizadas correctamente con sp_updatestats';
GO
