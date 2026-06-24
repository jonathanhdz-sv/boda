-- ============================================================
-- CORRECCION: Agregar columna PASAPORTE para extranjeros (por ID)
-- ============================================================
USE ExperienciaSV;
GO

-- 0. Limpiar restos de ejecuciones anteriores
ALTER TABLE TURISTA DROP CONSTRAINT IF EXISTS CK_TURISTA_IDENTIFICACION;
ALTER TABLE TURISTA DROP CONSTRAINT IF EXISTS CK_TURISTA_DUI;
ALTER TABLE TURISTA DROP CONSTRAINT IF EXISTS UQ_TURISTA_DUI;
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('TURISTA') AND name = 'pasaporte')
    ALTER TABLE TURISTA DROP COLUMN pasaporte;
GO

-- 1. DUI acepta NULL
ALTER TABLE TURISTA ALTER COLUMN dui VARCHAR(10) NULL;
GO

-- 2. Agregar PASAPORTE
ALTER TABLE TURISTA ADD pasaporte VARCHAR(20) NULL;
GO

-- 3. Restaurar DUIs de salvadorenos (se perdieron en corridas anteriores)
UPDATE TURISTA SET dui = '01234567-8' WHERE turista_id = 1;
UPDATE TURISTA SET dui = '02345678-9' WHERE turista_id = 2;
UPDATE TURISTA SET dui = '04567890-1' WHERE turista_id = 4;
UPDATE TURISTA SET dui = '06789012-3' WHERE turista_id = 6;
UPDATE TURISTA SET dui = '07890123-4' WHERE turista_id = 7;
UPDATE TURISTA SET dui = '09012345-6' WHERE turista_id = 9;
GO

-- 4. Extranjeros: NULL en DUI, valor en PASAPORTE
UPDATE TURISTA SET dui = NULL, pasaporte = 'USA123456'  WHERE turista_id = 3;  -- John
UPDATE TURISTA SET dui = NULL, pasaporte = 'FRA789012'  WHERE turista_id = 5;  -- Pierre
UPDATE TURISTA SET dui = NULL, pasaporte = 'CAN345678'  WHERE turista_id = 8;  -- Sofia
UPDATE TURISTA SET dui = NULL, pasaporte = 'GBR901234'  WHERE turista_id = 10; -- Emma
GO

-- 5. CHECK: al menos uno lleno
ALTER TABLE TURISTA ADD CONSTRAINT CK_TURISTA_IDENTIFICACION
CHECK (dui IS NOT NULL OR pasaporte IS NOT NULL);
GO

-- 6. CHECK: formato DUI salvadoreno
ALTER TABLE TURISTA ADD CONSTRAINT CK_TURISTA_DUI
CHECK (dui IS NULL OR dui LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]');
GO

-- 7. Verificar
SELECT turista_id, nombre, apellido, nacionalidad, dui, pasaporte
FROM TURISTA ORDER BY turista_id;
GO

PRINT '>> Listo';
