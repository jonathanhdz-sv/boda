-- ============================================================
-- PROYECTO EXPERIENCIASV — MDB941
-- Fase 5: Mantenimiento de Datos
-- Grupo 2 | Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
-- Archivo: Grupo2_Mantenimiento_Indices.sql
-- Contenido: Detectar fragmentación, REORGANIZE (10-30%), REBUILD (>30%)
-- ============================================================

USE ExperienciaSV;
GO

PRINT '============================================';
PRINT 'REORDENAMIENTO DE ÍNDICES - ExperienciaSV';
PRINT '============================================';

-- ============================================================
-- 1. DETECTAR FRAGMENTACIÓN DE TODOS LOS ÍNDICES
-- ============================================================

SELECT
    OBJECT_SCHEMA_NAME(ips.object_id) + '.' + OBJECT_NAME(ips.object_id) AS Tabla,
    i.name                                          AS Indice,
    i.type_desc                                     AS Tipo,
    ips.avg_fragmentation_in_percent                 AS FragmentacionPct,
    ips.page_count                                  AS Paginas,
    CASE
        WHEN ips.avg_fragmentation_in_percent > 30 THEN 'REBUILD'
        WHEN ips.avg_fragmentation_in_percent > 10 THEN 'REORGANIZE'
        ELSE 'OK'
    END                                             AS AccionRecomendada
FROM sys.dm_db_index_physical_stats(DB_ID('ExperienciaSV'), NULL, NULL, NULL, 'LIMITED') ips
INNER JOIN sys.indexes i
    ON ips.object_id = i.object_id
   AND ips.index_id = i.index_id
WHERE i.name IS NOT NULL
ORDER BY ips.avg_fragmentation_in_percent DESC;
GO

-- ============================================================
-- 2. REORGANIZAR O RECONSTRUIR ÍNDICES SEGÚN FRAGMENTACIÓN
-- ============================================================

DECLARE @tabla        NVARCHAR(256);
DECLARE @indice       NVARCHAR(256);
DECLARE @fragmentacion DECIMAL(5,2);
DECLARE @sql          NVARCHAR(MAX);

DECLARE cur_indices CURSOR FOR
SELECT
    OBJECT_SCHEMA_NAME(ips.object_id) + '.' + OBJECT_NAME(ips.object_id),
    i.name,
    ips.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID('ExperienciaSV'), NULL, NULL, NULL, 'LIMITED') ips
INNER JOIN sys.indexes i
    ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE i.name IS NOT NULL
  AND ips.avg_fragmentation_in_percent > 10
ORDER BY ips.avg_fragmentation_in_percent DESC;

OPEN cur_indices;
FETCH NEXT FROM cur_indices INTO @tabla, @indice, @fragmentacion;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @fragmentacion > 30
    BEGIN
        SET @sql = 'ALTER INDEX [' + @indice + '] ON ' + @tabla +
                   ' REBUILD WITH (FILLFACTOR = 90, ONLINE = OFF, SORT_IN_TEMPDB = ON);';
        EXEC sp_executesql @sql;
        PRINT '>> REBUILD: ' + @tabla + '.' + @indice +
              ' (fragmentación: ' + CAST(@fragmentacion AS NVARCHAR(10)) + '%)';
    END
    ELSE
    BEGIN
        SET @sql = 'ALTER INDEX [' + @indice + '] ON ' + @tabla + ' REORGANIZE;';
        EXEC sp_executesql @sql;
        PRINT '>> REORGANIZE: ' + @tabla + '.' + @indice +
              ' (fragmentación: ' + CAST(@fragmentacion AS NVARCHAR(10)) + '%)';
    END

    FETCH NEXT FROM cur_indices INTO @tabla, @indice, @fragmentacion;
END

CLOSE cur_indices;
DEALLOCATE cur_indices;

PRINT '';
PRINT '>> Índices optimizados correctamente';
GO
