-- ============================================================
-- PROYECTO EXPERIENCIASV — MDB941
-- Fase 5: Mantenimiento de Datos
-- Grupo 2 | Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
-- Archivo: Grupo2_MantenimientoLogs.sql
-- Contenido: Compactar logs (SHRINKFILE), configuración de crecimiento
-- ============================================================

USE ExperienciaSV;
GO

PRINT '============================================';
PRINT 'MANTENIMIENTO DE LOGS - ExperienciaSV';
PRINT '============================================';

-- ============================================================
-- 1. CONSULTAR TAMAÑO ACTUAL DE ARCHIVOS
-- ============================================================

SELECT
    name                  AS NombreLogico,
    physical_name         AS RutaFisica,
    type_desc             AS Tipo,
    size * 8 / 1024       AS TamanoMB,
    FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024 AS EspacioUsadoMB,
    (size - FILEPROPERTY(name, 'SpaceUsed')) * 8 / 1024 AS EspacioLibreMB
FROM sys.database_files;
GO

-- ============================================================
-- 2. COMPACTAR ARCHIVO DE LOG (SHRINKFILE)
-- Reduce el archivo .ldf liberando espacio no utilizado
-- ============================================================

-- Obtener el nombre lógico del archivo de log
DECLARE @log_name NVARCHAR(128);
SELECT @log_name = name FROM sys.database_files WHERE type = 1;

-- Compactar el archivo de log dejando 10% libre
DBCC SHRINKFILE (@log_name, 10);
PRINT '>> Archivo de log compactado: ' + @log_name;

-- ============================================================
-- 3. COMPACTAR ARCHIVO DE DATOS (SHRINKFILE)
-- ============================================================

DECLARE @data_name NVARCHAR(128);
SELECT @data_name = name FROM sys.database_files WHERE type = 0;

DBCC SHRINKFILE (@data_name, 15);
PRINT '>> Archivo de datos compactado: ' + @data_name;
GO

-- ============================================================
-- 4. CONFIGURAR CRECIMIENTO AUTOMÁTICO DE ARCHIVOS
-- ============================================================

-- Configurar crecimiento del archivo de datos en MB (no en %)
ALTER DATABASE ExperienciaSV
MODIFY FILE (
    NAME = ExperienciaSV_data,
    FILEGROWTH = 50MB
);
PRINT '>> Crecimiento de .mdf configurado: 50 MB';

-- Configurar crecimiento del archivo de log en MB
ALTER DATABASE ExperienciaSV
MODIFY FILE (
    NAME = ExperienciaSV_log,
    FILEGROWTH = 25MB
);
PRINT '>> Crecimiento de .ldf configurado: 25 MB';
GO

-- ============================================================
-- 5. VERIFICAR ESPACIO RESULTANTE
-- ============================================================

SELECT
    name                  AS NombreLogico,
    physical_name         AS RutaFisica,
    type_desc             AS Tipo,
    size * 8 / 1024       AS TamanoMB,
    FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024 AS EspacioUsadoMB,
    growth * 8 / 1024     AS CrecimientoConfiguradoMB
FROM sys.database_files;

PRINT '';
PRINT '>> Mantenimiento de logs completado exitosamente';
GO
