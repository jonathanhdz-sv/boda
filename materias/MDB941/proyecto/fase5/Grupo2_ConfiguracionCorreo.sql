-- ============================================================
-- PROYECTO EXPERIENCIASV — MDB941
-- Fase 5: Mantenimiento de Datos
-- Grupo 2 | Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
-- Archivo: Grupo2_ConfiguracionCorreo.sql
-- Contenido: Configuración de Database Mail para notificaciones
-- ============================================================

USE msdb;
GO

PRINT '============================================';
PRINT 'CONFIGURACIÓN DE DATABASE MAIL - ExperienciaSV';
PRINT '============================================';

-- ============================================================
-- 1. HABILITAR DATABASE MAIL
-- ============================================================

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;
PRINT '>> Database Mail habilitado correctamente';
GO

-- ============================================================
-- 2. CREAR PERFIL DE CORREO
-- ============================================================

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysmail_profile WHERE name = 'ExperienciaSV_Profile')
BEGIN
    EXEC msdb.dbo.sysmail_add_profile_sp
        @profile_name = 'ExperienciaSV_Profile',
        @description  = 'Perfil de correo para notificaciones de ExperienciaSV';
    PRINT '>> Perfil ExperienciaSV_Profile creado';
END;
GO

-- ============================================================
-- 3. CREAR CUENTA DE CORREO SMTP
-- NOTA: Ajustar servidor SMTP según el proveedor de correo
-- ============================================================

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysmail_account WHERE name = 'ExperienciaSV_Account')
BEGIN
    EXEC msdb.dbo.sysmail_add_account_sp
        @account_name    = 'ExperienciaSV_Account',
        @description     = 'Cuenta para notificaciones de mantenimiento ExperienciaSV',
        @email_address   = 'experienciasv@notificaciones.com',
        @display_name    = 'ExperienciaSV - Notificaciones',
        @mailserver_name = 'smtp.office365.com',
        @mailserver_type = 'SMTP',
        @port            = 587,
        @username        = 'experienciasv@notificaciones.com',
        @password        = 'TU_CONTRASENA_AQUI',
        @enable_ssl      = 1;
    PRINT '>> Cuenta ExperienciaSV_Account creada';
END;
GO

-- ============================================================
-- 4. ASOCIAR CUENTA AL PERFIL
-- ============================================================

IF NOT EXISTS (
    SELECT 1 FROM msdb.dbo.sysmail_profileaccount
    WHERE profile_id = (SELECT profile_id FROM msdb.dbo.sysmail_profile WHERE name = 'ExperienciaSV_Profile')
      AND account_id = (SELECT account_id FROM msdb.dbo.sysmail_account WHERE name = 'ExperienciaSV_Account')
)
BEGIN
    EXEC msdb.dbo.sysmail_add_profileaccount_sp
        @profile_name    = 'ExperienciaSV_Profile',
        @account_name    = 'ExperienciaSV_Account',
        @sequence_number = 1;
    PRINT '>> Cuenta asociada al perfil correctamente';
END;
GO

-- ============================================================
-- 5. OTORGAR PERMISOS AL PERFIL
-- ============================================================

EXEC msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name   = 'ExperienciaSV_Profile',
    @principal_name = 'public',
    @is_default     = 1;
PRINT '>> Permisos otorgados a public';
GO

-- ============================================================
-- 6. CONFIGURAR PARÁMETROS DEL SISTEMA DE CORREO
-- ============================================================

EXEC msdb.dbo.sysmail_configure_sp
    @parameter_name  = 'AccountRetryAttempts',
    @parameter_value = 3;

EXEC msdb.dbo.sysmail_configure_sp
    @parameter_name  = 'AccountRetryDelay',
    @parameter_value = 60;

EXEC msdb.dbo.sysmail_configure_sp
    @parameter_name  = 'LoggingLevel',
    @parameter_value = 2;

PRINT '>> Parámetros de Database Mail configurados';
GO

-- ============================================================
-- 7. PRUEBA DE ENVÍO DE CORREO
-- ============================================================

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'ExperienciaSV_Profile',
    @recipients   = 'admin@experienciasv.com',
    @subject      = 'Prueba de Configuración - ExperienciaSV Database Mail',
    @body         = 'Database Mail configurado correctamente para el proyecto ExperienciaSV.',
    @body_format  = 'HTML';
PRINT '>> Correo de prueba enviado. Verificar bandeja de entrada.';
GO

PRINT '';
PRINT '>> Configuración de Database Mail completada exitosamente';
GO
