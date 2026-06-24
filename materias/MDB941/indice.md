# Índice — Modelamiento y Diseño de Base de Datos

## Unidad 1 — Base de Datos (Clases 1 a 4)

### Tema 1: Fundamentos de BD
- Clase 1: Generalidades
  - Concepto de base de datos (BD)
  - Sistema Gestor de Base de Datos (SGBD/DBMS)
  - Aplicación de BD
  - Jerarquía de datos (bits → bytes → campos → registros → archivos)
  - Metadatos
  - Usuarios de BD (final, diseñador, programador, DBA)
  - Arquitectura ANSI-SPARC de 3 niveles (interno, conceptual, externo)
  - Independencia de datos (lógica y física)

### Tema 2: SQL Server y SGBDR
- Clase 2: SGBDR y SQL Server
  - Objetivos de los SGBD
  - Componentes del motor SQL Server (Protocolos, Motor Relacional, Motor de Almacenamiento)
  - Bases de datos del sistema (master, model, tempdb, msdb)
  - Tablas del sistema
  - Bases de datos de usuario (archivos .mdf, .ndf, .ldf)
  - Procedimientos almacenados del sistema

### Tema 3: Lenguaje SQL
- Clase 3: Definiciones SQL
  - DDL — Data Definition Language (CREATE, ALTER, DROP)
  - DML — Data Manipulation Language (SELECT, INSERT, UPDATE, DELETE)
  - Creación gráfica en SSMS

### Tema 4: Diseño de BD
- Clase 4: Fases del Diseño
  - Levantamiento y análisis de requisitos
  - Diseño conceptual (modelo ER, UML)
  - Diseño lógico (transformación, normalización)
  - Diseño físico (sizing, volúmenes, elección de SGBD)

---

## Unidad 2 — Base de Datos Relacionales (Clases 5 a 8)

### Tema 1: Elementos de Modelado
- Clase 5: Atributos
  - Atributos y su representación
  - Dominio de atributos (macro y a nivel SGBD)
  - Tipos de atributos: atómicos, compuestos, mono valor, multi valor, derivados, clave

### Tema 2: Modelo ER y Relacional
- Clase 6: Modelo Relacional
  - Diagrama Entidad-Relación (ER) — Peter Chen, 1976
  - Componentes del modelo ER (entidades, atributos, relaciones)
  - Software para diseño ER (Dia, Visio, Power Designer)
  - Componentes del modelo relacional (E.F. Codd, 1970): tabla, tuplas, campos, PK, FK, candidatos

### Tema 3: Estructura Relacional
- Clase 7: Cardinalidad y Relaciones
  - Cardinalidad (ida y vuelta)
  - Tipos de relaciones: 1:1, 1:N, N:M
  - Regla para llave foránea (FK va en el lado N; N:M requiere tabla intermedia)

### Tema 4: Normalización
- Clase 8: Formas Normales
  - 1FN — Primera Forma Normal (atributos atómicos, PK)
  - 2FN — Segunda Forma Normal (dependencia parcial)
  - 3FN — Tercera Forma Normal (dependencia transitiva)
  - 4FN — Cuarta Forma Normal (resolver N:M con tabla intermedia)

---

## Unidad 3 — Integridad de Datos y SQL (Clases 9 a 12)

### Tema 1: Reglas de Integridad
- Clase 9: Constraints
  - 9.1 Reglas de Dominio (tipo de dato)
  - 9.2 Reglas de Llave — PRIMARY KEY
  - 9.3 Reglas de Entidad — NOT NULL
  - 9.4 Reglas de Referencias — FOREIGN KEY
  - 9.5 Transformación modelo conceptual a lógico

### Tema 2: Objetos de BD con DDL
- Clase 10: Creación de Objetos en Script
  - CREATE DATABASE (script con parámetros)
  - Security (logins, users, roles, GRANT)
  - Objetos de BD: Tables, Views, Synonyms, Stored Procedures, Functions, Triggers, Sequences, Indexes

### Tema 3: Consultas SQL
- Clase 11: Manejo de Consultas — SELECT
  - Filtrado (WHERE), Ordenación (ORDER BY)
  - No repetición (Identity), Filas duplicadas (DISTINCT)
  - Operadores aritméticos y prioridad
  - Alias de columna, Concatenación, Cadenas literales
  - Limitación de filas (TOP n)
  - Operadores Lógicos (AND, OR, NOT)

### Tema 4: Administración de Datos con DML
- Clase 12: DML en Script
  - INSERT (dos sintaxis, inserción masiva)
  - UPDATE
  - DELETE
  - TRUNCATE vs DELETE
  - MERGE

---

## Unidad 4 — Administración de Datos y Objetos de BD (Clases 13 a 16)

### Tema 1: Cadenas de Caracteres y Fechas
- Clase 13: Funciones de Texto y Fecha
  - Funciones de cadenas (UPPER, LOWER, SUBSTRING, CHARINDEX, LEN)
  - Tipos de dato fecha (TIME, DATE, DATETIME)
  - Funciones de fecha (GETDATE, DAY, MONTH, YEAR)

### Tema 2: Procedimientos Almacenados
- Clase 14: Stored Procedures
  - CREATE PROCEDURE (estructura y sintaxis)
  - Parámetros de entrada y salida (OUTPUT)
  - Restricciones y buenas prácticas
  - Transact-SQL (BEGIN...END, TRANSACTION, TRY...CATCH, RETURN)

### Tema 3: Funciones
- Clase 15: Funciones Definidas por el Usuario
  - Tres tipos: escalares, con valor de tabla, integradas del sistema
  - Ciclo de vida (CREATE, ALTER, DROP)
  - Funciones de agregado (COUNT, SUM, MAX, MIN, AVG)

### Tema 4: Disparadores
- Clase 16: Triggers
  - Tipos por ámbito: DML, DDL, LOGON
  - Momentos de activación: AFTER, INSTEAD OF
  - Tablas lógicas: INSERTED y DELETED
  - CREATE TRIGGER, ALTER TRIGGER, DROP TRIGGER

---

## Unidad 5 — Administración de Bases de Datos (Clases 17 a 20)

### Tema 1: Vistas, Roles y Permisos
- Clase 17: Administración de Otros Objetos
  - Administración de Vistas (VIEWS): ocultar datos, combinar tablas
  - Administración de Roles (servidor, BD, aplicación)
  - Administración de Permisos (GRANT, REVOKE, niveles)

### Tema 2: Backups y Restauración
- Clase 18: Mantenimiento de Backups
  - Creación de Backup (Maintenance Plan, tipo Completa, .bak)
  - Restauración de Backup (Device → archivo .bak)

### Tema 3: Tareas de Mantenimiento
- Clase 19: Tareas Programadas
  - Configuración de tareas automáticas
  - Compactado de BD — Shrink (.mdf y .ldf)
  - Reorganización de Índices (Rebuild Index Task)
  - Ejecución de Estadísticas (Update Statistics Task)

### Tema 4: Rendimiento y Monitoreo
- Clase 20: Rendimiento de la BD
  - Monitor de Actividades (Activity Monitor)
  - Funciones DBCC (mantenimiento, informativas, validación)
  - Manejo de Sesiones de Usuarios
  - Manejo de Procesos de BD
  - Administración de Recursos (CPU y RAM)
