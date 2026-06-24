# Unidad 3 — Clases 9 a 12: Integridad de Datos y SQL

## Clase 9: Reglas de Integridad (Constraints)

Las reglas de integridad son restricciones que garantizan que los datos respeten ciertos criterios.

### 9.1 Reglas de Dominio

Definen el tipo de dato del campo al crear la tabla (`int`, `char`, `date`, etc.). Si se ingresa un dato de tipo incorrecto, el SGBD rechaza la operación. Se implementa al `CREATE TABLE` o con `ALTER TABLE`.

### 9.2 Reglas de Llave (PK)

Establece valores únicos. Solo una PK por tabla. Los campos que cumplen la unicidad son "campos candidatos", pero solo uno es elegido como PK. Al ingresar un dato duplicado, la BD lo rechaza.

Sintaxis:

```sql
CONSTRAINT pk_nombre PRIMARY KEY (campo)
```

### 9.3 Reglas de Entidad (NOT NULL)

El campo no puede quedar vacío. Se adiciona automáticamente cuando un campo es declarado PK. Sintaxis: agregar `NOT NULL` en la definición del campo.

### 9.4 Reglas de Referencias (FK)

Integridad referencial. Elimina inconsistencia entre tablas relacionadas. La FK se crea en una de las dos tablas para establecer la relación física.

Sintaxis:

```sql
CONSTRAINT fk_nombre FOREIGN KEY (campo) REFERENCES OtraTabla(campo_PK)
```

### 9.5 Transformación modelo conceptual a lógico

El modelo conceptual es independiente del motor; el modelo lógico aplica la lógica de procesos, establece relaciones entre entidades, enriquece atributos y aplica normalización.

## Clase 10: Creación de Objetos de BD — DDL en Script

Comandos: `CREATE`, `ALTER`, `DROP`.

### CREATE DATABASE (script)

```sql
CREATE DATABASE Prueba
ON (NAME='Prueba', FILENAME='C:\PruebaData.mdf', SIZE=10MB, MAXSIZE=50MB, FILEGROWTH=5MB)
LOG ON (NAME='Pruebalog', FILENAME='D:\PruebaLog.ldf', SIZE=5MB, MAXSIZE=25MB, FILEGROWTH=5MB)
```

### Security

Logins (`CREATE LOGIN`), Users (`CREATE USER FOR LOGIN`), Roles (`CREATE ROLE`), `GRANT` (otorgar permisos), `EXEC sp_addrolemember` para asignar rol a usuario.

### Objetos de BD

- **Tables:** `CREATE TABLE tabla (campo_llave char(4), campo1 char(60), CONSTRAINT pk PRIMARY KEY (campo_llave))`
- **Views (Vistas):** no guardan datos, son consultas. Objetivos: ocultar columnas confidenciales y combinar tablas simulando ser una.

  ```sql
  CREATE VIEW vista AS SELECT t1.campo1, t2.campo2 FROM t1, t2 WHERE t1.id = t2.id
  ```

- **Synonyms:** alias que disfrazan la pertenencia de un objeto.

  ```sql
  CREATE SYNONYM Proveedores FOR Inventario.Proveedores
  ```

- **Stored Procedures:** código con lógica de programación. No necesariamente retornan valor.

  ```sql
  CREATE PROCEDURE nombre AS BEGIN ... END
  ```

- **Functions:** siempre deben retornar un valor.

  ```sql
  CREATE FUNCTION nombre (@param int) RETURNS int AS BEGIN ... RETURN @variable; END
  ```

- **Triggers:** se ejecutan automáticamente ante acciones DML (INSERT, UPDATE, DELETE). Tabla lógica `inserted` contiene los datos insertados.

  ```sql
  CREATE TRIGGER nombre ON tabla AFTER INSERT AS BEGIN ... END
  ```

- **Sequences:** valor incremental independiente, utilizable por varias tablas.

  ```sql
  CREATE SEQUENCE nombre START WITH 1 INCREMENT BY 1
  ```

  Uso: `NEXT VALUE FOR nombre`

- **Indexes:** mejoran velocidad de consultas. Clustered (ordenan físicamente, solo uno por tabla) y Non-Clustered.

  ```sql
  CREATE INDEX nombre ON tabla (campo)
  ```

## Clase 11: Manejo de Consultas — SELECT

- **11.1 Filtrado:** `WHERE` para segmentar datos según un criterio
- **11.2 Ordenación:** `ORDER BY campo ASC` (default) o `DESC`
- **11.3 No repetición:** campo Identity (auto-incremental) en SQL Server. En propiedades: Identity Specification → (Is Identity) = YES
- **11.4 Operadores aritméticos:** `+`, `-`, `*`, `/`, `%`
- **11.5 Prioridad:** paréntesis `()` > multiplicación/división > suma/resta (igual que matemáticas)
- **11.6 Alias de columna:** `SELECT campo AS alias FROM tabla`
- **11.7 Concatenación:** operador `+` entre campos del mismo tipo. Campos numéricos concatenados se SUMAN, no se unen
- **11.8 Cadenas literales:** usar `UPPER()` y `LOWER()` para normalizar textos
- **11.9 Filas duplicadas:** `DISTINCT` para obtener valores únicos. `SELECT DISTINCT campo FROM tabla`
- **11.10 Limitación de filas:** `TOP n` para limitar cantidad de registros. `SELECT TOP 10 * FROM tabla`

### Operadores Lógicos

- `AND`: ambos filtros deben cumplirse
- `OR`: cualquiera de los filtros puede cumplirse
- `NOT`: niega el filtro

## Clase 12: Administración de Datos — DML en Script

### INSERT (dos sintaxis)

- Sintaxis 1 (con campos): `INSERT INTO tabla (campo1, campo2) VALUES (valor1, valor2)` — inserta solo los campos especificados, útil cuando hay campos opcionales
- Sintaxis 2 (sin campos): `INSERT INTO tabla VALUES (valor1, valor2, ...)` — obliga a poner valores para TODOS los campos en orden
- Inserción masiva:

  ```sql
  INSERT INTO tabla1 SELECT * FROM tabla2 WHERE condicion
  ```

### UPDATE

```sql
UPDATE tabla SET campo1 = valor1, campo2 = valor2 WHERE condicion
```

Sin `WHERE` se afectan TODOS los registros.

### DELETE

```sql
DELETE FROM tabla WHERE condicion
```

Sin `WHERE` se eliminan TODOS los registros.

### TRUNCATE vs DELETE

| DELETE | TRUNCATE |
|--------|----------|
| Elimina fila por fila | Elimina todas las filas de golpe |
| Registra en el log | No registra individualmente en el log |
| Se puede filtrar con WHERE | No permite WHERE |
| Permite ROLLBACK | Reinicia contadores identity |

Ambos permiten ROLLBACK si están dentro de una transacción (`BEGIN TRAN...ROLLBACK`).

### MERGE

Combina INSERT, UPDATE y DELETE en una sola instrucción. Útil para mantenimiento completo: si falta → inserta, si sobra → elimina, si coincide → actualiza.
