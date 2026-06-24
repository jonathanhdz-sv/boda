# Unidad 1 — Clases 1 a 4: Base de Datos

## Clase 1: Base de Datos

- Concepto de base de datos (BD): colección de datos relacionados, depósito centralizado (Merchan, 2016)
- Sistema Gestor de Base de Datos (SGBD/DBMS): software que gestiona y controla el acceso a los datos
- Aplicación de BD: interfaz entre usuario y SGBD. El usuario no interactúa directo con la BD
- Jerarquía de datos: bits → bytes/caracteres → campos → registros → archivos
- Metadatos: diccionario de datos que describe la estructura de la BD
- Usuarios de BD: usuario final, diseñador, programador de aplicaciones, DBA (administrador)
- Arquitectura ANSI-SPARC de 3 niveles:
  - Nivel Interno/Físico: cómo se almacenan físicamente los datos
  - Nivel Conceptual/Lógico: qué datos se almacenan y sus relaciones
  - Nivel Externo/Vistas: parte de la BD visible para cada tipo de usuario
- Independencia de datos: lógica (modificar esquema conceptual sin afectar apps) y física (modificar almacenamiento sin afectar esquema conceptual)

## Clase 2: SGBDR y SQL Server

- Objetivos de los SGBD: reducir redundancia e inconsistencia, facilitar acceso, aislamiento de datos, acceso concurrente sin anomalías, seguridad, integridad de datos
- Componentes del motor SQL Server: Protocolos de Red, Motor Relacional (Query Processor), Motor de Almacenamiento (Storage Engine)
- Bases de datos del sistema en SQL Server:
  - **master:** configuración del servidor, logins, existencia de todas las BD. Si se daña, SQL Server no inicia
  - **model:** plantilla para nuevas BD. Todo `CREATE DATABASE` copia model
  - **tempdb:** recurso global, buffer que se vacía al reiniciar la instancia
  - **msdb:** usada por el Agente SQL Server para alertas, trabajos y planes de mantenimiento
- Tablas del sistema: `Sys.Tables`, `Sys.Objects`, `Sys.dm_exec_sessions`
- Bases de datos de usuario: archivo de datos (`.mdf` principal, `.ndf` secundarios) + archivo de registro/log (`.ldf`)
- Procedimientos almacenados del sistema: `sp_catalogs`, `sp_databases`, `sp_tables`, `sp_columns`, `sp_fkeys`, `sp_pkeys`, `sp_indexes`, etc.

## Clase 3: Lenguaje SQL - Definiciones

- Sub-lenguajes SQL: DDL (definición), DML (manipulación), DCL (control)

### DDL - Data Definition Language

- `CREATE`: crear objetos (Database, User, Table). Argumentos varían según el objeto
- `ALTER`: modificar objetos (Database, User, Table)
- `DROP`: eliminar objetos (Database, User, Table)
- Creación gráfica de BD en SSMS: New Database → configurar nombre, tamaño inicial, auto-crecimiento, ruta física
- Creación gráfica de Tablas: definir Column Name, Data Type, Allow Nulls

### DML - Data Manipulation Language

- `SELECT`: `SELECT * FROM <Tabla>` (el `*` es comodín para todos los campos)
- `INSERT`: `INSERT INTO <Tabla> (<Campos>) VALUES (<Valores>)` (campos opcionales; si se omiten, `VALUES` debe cubrir todos los campos en orden)
- `UPDATE`: `UPDATE <Tabla> SET <Campo> = <Valor>` (varios campos separados por coma)
- `DELETE`: `DELETE <Tabla> WHERE <Campo> <Condicion>` (sin `WHERE` se eliminan todos los registros)

## Clase 4: Diseño de Base de Datos

- El diseño de BD consiste en definir la estructura lógica y física para responder a las necesidades de los usuarios (Casa & Conesa, 2014)
- Fases del diseño de BD:
  1. **Levantamiento y análisis de requisitos:** técnicas como entrevistas, observación, encuestas, historias de usuario. Identificar actores que interactuarán con la BD
  2. **Diseño conceptual:** esquema de alto nivel independiente de tecnología. Modelos: Entidad-Relación (E-R) y UML
  3. **Diseño lógico:** transformar modelo conceptual en modelo lógico dependiente del tipo de BD. Subfases: reconsideraciones, transformación, normalización
  4. **Diseño físico:** creación física en un SGBD concreto. Criterios: tamaño (sizing, 3-5 años), manejo de volúmenes de información, precio del SGBD
