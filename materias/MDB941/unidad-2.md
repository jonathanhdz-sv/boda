# Unidad 2 — Clases 5 a 8: Base de Datos Relacionales

## Clase 5: Elementos Básicos de Modelado

- **Atributos:** características propias de las entidades que se convierten en campos dentro de una tabla. Ej: entidad Carro → atributos: Color, Marca, Modelo, Placa, Chasis
- **Representación:** círculos alrededor de las entidades en el diagrama ER
- **Dominio de atributos:** conjunto de valores posibles que pueden contener (Capacho & Wilson, 2017)
  - Macro: Enteros, Cadenas de texto, Fecha
  - A nivel SGBD se derivan en tipos concretos: `int`, `bigint`, `smallint`, `tinyint`, `decimal`, `numeric`, `varchar`, `char`, `date`, etc.
- **Tipos de atributos:**
  - **Atómicos (simples):** no se subdividen (ej: Género → Masculino/Femenino)
  - **Compuestos:** pueden subdividirse (ej: Nombre → Primer Nombre, Segundo Nombre, Primer Apellido, Segundo Apellido)
  - **Mono valor:** contienen un solo valor (ej: Fecha de Contratación)
  - **Multi valor:** contienen varios valores, representados con doble rombo (ej: Correo Electrónico → personal e institucional)
  - **Derivados:** se calculan a partir de otro atributo, elipses discontinuas (ej: Edad desde Fecha de Nacimiento, Antigüedad desde Fecha de Ingreso)
  - **Clave:** valores únicos que no se repiten, se convierten en llave primaria, aparecen subrayados en el diagrama

## Clase 6: Modelo Relacional

- **Diagrama Entidad-Relación (ER):** creado por Peter Chen (1976), herramienta para diseño conceptual
- **Componentes del modelo ER:**
  - **Entidad:** objeto real o abstracto de interés. Símbolo: Rectángulo
  - **Atributo:** propiedad o característica de una entidad. Símbolo: Elipse/Círculo
  - **Relación/Interrelación:** asociación entre entidades. Símbolo: Rombo. Cada relación tiene su cardinalidad
- **Software para diseño ER:**
  - Dia (libre, GPLv2): exporta a `.cgm`, `.eps`, `.dia`, `.png`, `.svg`
  - Visio (propietario, licencia paga)
  - Power Designer (propietario, licencia paga)

### Componentes del modelo relacional (E.F. Codd, 1970)

- **Tabla (relación):** nombre único, compuesta por columnas (campos) y filas (registros)
- **Tuplas:** filas de la tabla, conjunto de campos que forman un registro
- **Campos:** dato mínimo indivisible en la intersección fila-columna
- **Tipos de datos:** dominio del campo (`int`, `varchar`, `char`, `date`, etc.)
- **Llave Primaria (PK):** clave candidata elegida por el diseñador para identificar cada registro de forma única
- **Llave Foránea (FK):** atributo que permite combinar datos de distintas relaciones. Es la PK repetida en otra tabla
- **Campos candidatos:** valores únicos (ej: DUI, carné con formato nemotécnico)

## Clase 7: Estructura de Datos Relacional

- Las entidades no están aisladas, interactúan según el proceso de negocio
- **Cardinalidad:** tipificación de la conexión entre entidades. Se analiza desde la perspectiva de cada entidad (ida y vuelta), generando una relación predominante
- **Tipos de relaciones:**
  - **Uno a Uno (1:1):** un registro de A se relaciona con solo un registro de B
  - **Uno a Muchos (1:N):** un registro de A se relaciona con varios de B
  - **Muchos a Muchos (N:M):** varios registros de A se relacionan con varios de B
- **Regla para llave foránea:**
  - Relación 1:N → la FK va en la tabla del lado "muchos" (N)
  - Relación 1:1 → la FK puede ir en cualquiera de las dos tablas
  - Relación N:M → requiere tabla intermedia (se resuelve en normalización)

## Clase 8: Normalización

- **Normalización:** técnica para organizar datos basados en un diseño correcto de tablas y relaciones (Piñeiro, 2014)
- **Objetivo:** eliminar redundancia (repetición de datos) e inconsistencia
- **Por qué normalizar:** evita inexactitud de datos, lentitud en consultas y pérdida de tiempo arreglando consistencia

### 1FN - Primera Forma Normal

- Eliminar grupos repetidos de las tablas individuales
- Identificar cada conjunto de datos relacionados con una clave principal (PK)
- Los atributos deben ser atómicos (no multi valor)

### 2FN - Segunda Forma Normal

- Crear tablas independientes para conjuntos de valores repetitivos
- Relacionar las tablas con una clave externa (FK)
- Aplica cuando hay dependencia parcial de la PK compuesta

### 3FN - Tercera Forma Normal

- Eliminar campos que no dependan de la clave (dependencia transitiva)
- Ej: empleado tiene departamento, pero departamento no depende del empleado → separar en tabla Departamentos y referenciar con FK

### 4FN - Cuarta Forma Normal (otras formas)

- Resolver relaciones N:M creando una tercera tabla intermedia
- La PK de la tabla intermedia = combinación de las PK de las entidades principales
- Cada campo por sí solo es FK hacia su entidad principal
