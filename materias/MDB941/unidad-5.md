# Unidad 5 — Clases 17 a 20: Administración de Bases de Datos

## Clase 17: Administración de Otros Objetos

La administración de objetos requiere dos tipos de permisos: mantenimiento del objeto (`CREATE`, `ALTER`, `DROP`) y acciones sobre el objeto.

Ej: para administrar una FUNCIÓN se necesita `CREATE`/`ALTER`/`DROP` + `EXECUTE` para usarla. Un TRIGGER necesita `CREATE`/`ALTER`/`DROP` pero su ejecución es automática; los permisos de acción van sobre la TABLA asociada (`INSERT`, `UPDATE`, `DELETE`).

### 16.1 Administración de Vistas (VIEWS)

- Objetos que contienen un `SELECT`, no almacenan datos, son apuntadores a tablas
- Objetivo 1: ocultar información sensible (ej: vista de empleados sin el campo salario)
- Objetivo 2: combinar varias tablas con JOIN y presentarlas como un solo objeto simple
- `CREATE VIEW`, `ALTER VIEW` (DDL)

### 16.2 Administración de Roles

- Centralizador de permisos. Un usuario puede tener muchos roles
- **Roles de Servidor** (nivel instancia): `sysadmin`, `serveradmin`, `securityadmin`, `processadmin`, `setupadmin`, `bulkadmin`, `diskadmin`, `dbcreator`, `public`
- **Roles de BD y Aplicación:** Roles de Aplicación (contraseña guardada en cliente, permisos duran la conexión) y Roles de BD (se crean según perfiles de usuario: configuración, transaccional, auditor)
- `CREATE ROLE` para crear roles personalizados

### 16.3 Administración de Permisos

- Niveles: Servidor/Instancia (afecta todas las BD), Base de Datos (afecta solo esa BD), Aplicaciones (sobre tablas específicas)
- `GRANT <permiso> ON <objeto> TO <usuario/rol>` — otorgar permisos
- `REVOKE <permiso> ON <objeto> FROM <usuario/rol>` — quitar permisos
- Nivel grupal: otorgar/quitar ROLES completos en lugar de permisos individuales

## Clase 18: Mantenimiento de la Base de Datos

### 17. Administración de Backups

Tarea primordial para continuidad del negocio. Periodicidad normal: diaria.

#### 17.1 Creación de Backup

- Configurar correo electrónico del servidor para notificaciones
- Crear Maintenance Plan: clic derecho en Maintenance Plans → New Maintenance Plan
- Asignar nombre, programar frecuencia/hora, seleccionar tarea "Back Up Database Task"
- Configurar: tipo Completa, bases de datos (Todas o específicas), ruta física, extensión `.bak`

#### 17.2 Restauración de Backup

- Clic derecho en Databases → Restore Database
- Seleccionar "Device" → Add → buscar archivo `.bak` → OK

## Clase 19: Tareas de la Base de Datos

### 18. Tareas Programadas

Tareas automáticas en planes de mantenimiento. Existen plantillas preexistentes (paleta de herramientas).

#### 18.1 Configuración de Tareas

Definir calendario (frecuencia, hora), arrastrar tareas desde plantillas al plan, guardar.

### 19. Compactado de la Base de Datos (Shrink)

- Archivo de datos (`.mdf`): guarda los valores. Compactar = redistribuir datos
- Archivo de log (`.ldf`): guarda TODAS las sentencias SQL ejecutadas. Compactar = eliminar sentencias antiguas del log
- El compactado debe ir de la mano con el backup: si backup es diario, compactado también
- Existe tarea preestablecida "Shrink Database" en planes de mantenimiento

### 20. Reorganización de Índices

Mantiene tablas óptimas y consultas eficientes. Aplica a todos los índices de la BD seleccionada. Tarea: "Rebuild Index Task"

### 21. Ejecución de Estadísticas

Ayuda al motor a tener los mejores planes de ejecución. Recolecta: tamaño de tablas, índices asociados, etc. Tarea: "Update Statistics Task"

## Clase 20: Rendimiento de Base de Datos

### 22. Monitor de Actividades (Activity Monitor)

Utilidad en SSMS para visualizar procesos, recursos con tiempos de espera, sesiones leyendo/escribiendo en disco, consultas pesadas activas.

### 23. Funciones DBCC (Database Console Commands)

Comandos de consola para mantenimiento y diagnóstico. Se dividen en categorías:

- **Mantenimiento:** tareas de mantenimiento de BD
- **Varios:** funciones diversas
- **Informativa:** información de objetos
- **Validación:** validar consistencia de objetos y BD completa. Ej: `DBCC CHECKDB`

### 24. Manejo de Sesiones de Usuarios

Las sesiones consumen CPU y memoria. Monitorear con consultas a vistas del sistema como `sys.dm_exec_sessions`.

### 25. Manejo de Procesos de BD

Cada conexión genera un proceso a nivel SO. Visibles desde Activity Monitor.

### 26. Administración de Recursos

- CPU (procesadores) y RAM (memoria)
- Reservar al menos 20% de recursos para el sistema operativo
- Configurar en SSMS: clic derecho instancia → Propiedades → Procesadores (elegir cuáles usar) y Memoria (límite máximo en MB que la BD puede tomar)
