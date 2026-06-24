# Unidad 4 — Clases 13 a 16: Administración de Datos y Objetos de BD

## Clase 13: Cadenas de Caracteres y Fechas

Las cadenas se almacenan exactamente como se ingresan (mayúsculas/minúsculas), lo que dificulta las consultas.

### Funciones de cadenas (nivel registro individual)

- `UPPER(columna)`: convierte a mayúsculas
- `LOWER(columna)`: convierte a minúsculas
- `SUBSTRING(columna, inicio, longitud)`: extrae parte de una cadena
- `CHARINDEX('texto', columna)`: devuelve la posición de un carácter/subcadena
- `LEN(columna)`: devuelve la longitud de la cadena

### Tipos de dato fecha

- `TIME`: solo hora (Hora/Minutos/Segundos)
- `DATE`: solo fecha (Día/Mes/Año)
- `DATETIME`: ambos componentes

### Funciones de fecha

- `SYSDATETIME()`, `GETDATE()`: fecha y hora actual del sistema
- `DAY(fecha)`, `MONTH(fecha)`, `YEAR(fecha)`: extraen componentes específicos

## Clase 14: Administración de Procedimientos Almacenados

Combinan SQL + estructuras de programación (`IF`, `CASE`, `WHILE`), variables, constantes, cursores, manejo de errores.

**Ventajas del código en BD:** modularización, reutilización, centralización, velocidad (corre en servidor), portabilidad entre versiones.

**Buenas prácticas:** comentarios, estándar de nombres (`v_` para variables, `p_` para parámetros), palabras reservadas en MAYÚSCULAS, indentación.

**Parámetros:** datos que cambian según necesidad pero no cambian la fuente ni el objetivo del SP.

### CREATE PROCEDURE

```sql
CREATE PROCEDURE nombre AS BEGIN ... END
```

### Restricciones

- No se puede usar `CREATE VIEW`, `CREATE TRIGGER`, `CREATE PROCEDURE` dentro de un SP
- Un SP puede invocar otro SP; el segundo accede a objetos del primero
- Máximo 1024 parámetros
- Variables declaradas con `DECLARE` después de `AS`, limitadas a memoria del servidor

- `ALTER PROCEDURE`: modifica el SP existente.
- `DROP PROCEDURE`: elimina el SP.

**Parámetros de salida:** `OUTPUT` en la definición y en la ejecución.

### Transact-SQL (manejo de transacciones)

- `BEGIN...END`: delimita bloques de código
- `BEGIN TRANSACTION` + `COMMIT` (confirma) o `ROLLBACK` (revierte)
- `BEGIN TRY...END TRY` + `BEGIN CATCH...END CATCH`: manejo de errores
- `RETURN`: devuelve un valor numérico entero. Quien invoca debe declarar variable para capturarlo

## Clase 15: Administración de Funciones

Similar a procedimientos pero con diferencias clave:

- **Parámetros:** solo de entrada (a diferencia de SP que pueden tener `OUTPUT`)
- **Obligatorio:** `RETURNS <tipo_dato>` en la definición, y `RETURN <valor>` en el cuerpo

### Tres tipos de funciones

1. **Escalares:** devuelven un único valor con tipo definido.

   ```sql
   CREATE FUNCTION nombre (@param int) RETURNS int AS BEGIN ... RETURN @variable; END
   ```

2. **Con Valor de Tabla (Conjunto de Filas):** retornan múltiples registros, tipo `TABLE`.

   ```sql
   CREATE FUNCTION nombre () RETURNS TABLE AS RETURN (SELECT ...)
   ```

3. **Integradas del sistema:** vienen con SQL Server, no se modifican ni eliminan.
   Ej: `COUNT()`, `SUM()`, `MAX()`, `MIN()`, `AVG()`, `CONCAT()`, `LOWER()`, `UPPER()`

**Ciclo de vida:** `CREATE FUNCTION` → `ALTER FUNCTION` → `DROP FUNCTION`

### Funciones integradas adicionales

- `COUNT(*)`: total de registros
- `SUM(columna)`: suma de valores
- `MAX(columna)`: valor máximo
- `MIN(columna)`: valor mínimo

## Clase 16: Administración de Disparadores (Triggers)

Acciones automáticas, NO se invocan directamente, NO reciben parámetros, NO devuelven valores.

### Tipos por ámbito de activación

- **DML:** se activan con INSERT, UPDATE, DELETE sobre datos
- **DDL:** se activan con CREATE, ALTER, DROP sobre objetos
- **LOGON:** se activan al ingresar a la base de datos

### Momentos de activación

- **AFTER:** se ejecuta después de que la acción se concretó
- **INSTEAD OF:** se ejecuta en lugar de la acción (solo para triggers DML, no aplica a DDL ni LOGON)

### Tablas lógicas en triggers DML

- `INSERTED`: contiene los nuevos datos (en INSERT y UPDATE)
- `DELETED`: contiene los datos eliminados o anteriores (en DELETE y UPDATE)
- En UPDATE: `INSERTED` tiene los nuevos valores, `DELETED` los anteriores

### CREATE TRIGGER

```sql
-- DML
CREATE TRIGGER nombre ON tabla AFTER INSERT AS BEGIN ... END

-- DDL
CREATE TRIGGER nombre ON DATABASE AFTER CREATE_TABLE AS BEGIN ... END

-- LOGON
CREATE TRIGGER nombre ON ALL SERVER AFTER LOGON AS BEGIN ... END
```

- `ALTER TRIGGER`: modifica el trigger existente.
- `DROP TRIGGER`: elimina el trigger.
