# Unidad 3 — Excepciones y Fundamentos de Bases de Datos

**Clases:** 9 a 12 | **Periodo:** 6 mar – 7 abr

Esta unidad conecta dos áreas críticas: el manejo de errores en tiempo de ejecución (excepciones) y la conexión de aplicaciones Java con bases de datos mediante JDBC.

---

## Clase 9: Manejo de Excepciones

### 9.1. Qué es una Excepción
Evento producido en la ejecución que **interrumpe el flujo normal** de instrucciones. Se genera al producirse errores en tiempo de ejecución.

Java encapsula los detalles del error en un **objeto**. Al generarse, hay tres escenarios posibles:
1. La excepción es **capturada** por el método (try-catch)
2. La excepción es **levantada** (throws) al método anterior en la pila de llamadas
3. El programa **termina** al no encontrar manejador

### 9.2. Efectos de una Excepción
- El método lanzado acaba **prematuramente**
- **No se devuelve** ningún valor de retorno
- El control **no regresa** al punto de llamada del cliente

**Estructura básica:**
```java
try {
    // Código propenso a errores
} catch(Exception error) {
    // Código para manejar el error
} finally {
    // Se ejecuta SIEMPRE (haya o no error)
}
```

### 9.3. Categorías de Excepción

**Unchecked Exceptions** (no comprobadas en compilación):
- Lanzadas por la JVM, representan condiciones fatales
- No obligan a ser declaradas o capturadas

| Excepción | Causa |
|-----------|-------|
| `NullPointerException` | Usar un objeto que es `null` |
| `ArrayIndexOutOfBoundsException` | Acceder a un índice fuera del arreglo |
| `ArithmeticException` | División por cero |
| `ClassCastException` | Conversión inválida de tipos |
| `NumberFormatException` | Convertir String no numérico a número |

**Checked Exceptions** (comprobadas en compilación):
- El compilador obliga a manejarlas o declararlas con `throws`
- Los IDE modernos las detectan antes de compilar

| Excepción | Causa |
|-----------|-------|
| `IOException` | Operaciones de Entrada/Salida |
| `ClassNotFoundException` | No encuentra la definición de una clase |
| `NoSuchMethodException` | Método no encontrado |
| `InterruptedException` | Thread interrumpido mientras dormía |

**Jerarquía resumida:**
```
Throwable
├── Error (graves: OutOfMemoryError, NoClassDefFoundError)
└── Exception
    ├── IOException (Checked)
    └── RuntimeException (Unchecked)
```

### 9.4. Ejemplo práctico de try-catch
```java
Scanner reader = new Scanner(System.in);
try {
    System.out.print("Ingrese un dato: ");
    String valor = reader.nextLine();
    Integer numero = Integer.parseInt(valor);
    System.out.println("El numero ingresado es: " + numero);
} catch (NumberFormatException e) {
    System.out.println("No se puede convertir el dato: " + e);
}
```

**Resultado sin error:** Ingresa "10" -> muestra "El numero ingresado es: 10"
**Resultado con error:** Ingresa "d" -> muestra "No se puede convertir el dato..."

### 9.5. Cláusula finally
Se ejecuta **siempre** al final, incluso si hay `return` dentro de try o catch. Uso típico: cerrar archivos, conexiones a BD, liberar recursos.
```java
try {
    // abrir conexion
} catch (Exception e) {
    // manejar error
} finally {
    // cerrar conexion (pase lo que pase)
}
```

---

## Clase 10: Introducción a las Bases de Datos

### 10.1. Definición de Base de Datos (BD)
Colección de **datos relacionados** entre sí con un **significado implícito**.

Ejemplo: una agenda física con nombres y teléfonos = BD en formato físico.

Para que sea una BD se requiere:
1. **Relaciones entre datos:** vinculación de datos (ej. estudiante con su historial académico)
2. **Significado implícito:** el contexto da sentido al dato (ej. "fecha" en ventas ≠ "fecha" en registro académico)

### 10.2. Evolución de las BD

| Etapa | Característica |
|-------|---------------|
| **Archivos tradicionales** | Datos en archivos individuales por aplicación. Redundantes, actualización lenta |
| **Bases de Datos** | Almacenamiento centralizado, definido formalmente. Sirve a múltiples aplicaciones |

### 10.3. Conceptos Básicos
| Término | Definición | Ejemplo |
|---------|------------|---------|
| **Campo** (Columna) | Unidad mínima de información | `nombre`, `edad` |
| **Registro** (Fila) | Conjunto de campos de una entidad | Toda la info de un alumno |
| **Tabla** (Entidad) | Estructura donde se almacenan registros | `Estudiantes` |
| **Base de Datos** | Conjunto de tablas relacionadas | `UniversidadDB` |

### 10.4. SGBD (Sistema Gestor de Bases de Datos)
Software que permite **crear y mantener** una BD. Funciones: definir, construir y manipular datos.

**Para este curso:** **MySQL** (gratuito, ampliamente usado).

### 10.5. Bases de Datos Relacionales
Basado en el concepto matemático de relaciones (tablas).

| Concepto | Definición |
|----------|------------|
| **Clave Primaria (PK)** | Campo que identifica de forma ÚNICA cada registro. No se repite |
| **Clave Foránea (FK)** | Campo que relaciona dos tablas, apuntando a la PK de otra tabla |

**Modelo Entidad-Relación (E-R):** representación gráfica antes de implementar.
- **Entidad** = rectángulo
- **Atributo** = óvalo
- **Relación** = rombo

---

## Clase 11: Sentencias SQL

SQL (Structured Query Language) es el lenguaje estándar para SGBD relacionales. Se divide en DDL y DML.

### 11.1. DDL (Data Definition Language) — Crear estructura

**Crear Base de Datos:**
```sql
CREATE DATABASE nombre_bd;
```

**Crear Tabla:**
```sql
CREATE TABLE Estudiantes (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT
);
```

### 11.2. DML (Data Manipulation Language) — Manipular datos

**SELECT — Consultar:**
```sql
SELECT * FROM Estudiantes;                          -- todos los registros
SELECT nombre FROM Estudiantes WHERE edad > 20;     -- filtrado
```

**INSERT — Insertar:**
```sql
INSERT INTO Estudiantes (id, nombre, edad) VALUES (1, 'Juan', 22);
```

**UPDATE — Actualizar:**
```sql
UPDATE Estudiantes SET edad = 23 WHERE id = 1;
```

**DELETE — Eliminar:**
```sql
DELETE FROM Estudiantes WHERE id = 1;
```

---

## Clase 12: JDBC (Java Database Connectivity)

### 12.1. Qué es JDBC
API estándar de Java que permite conectar aplicaciones con bases de datos relacionales, enviando sentencias SQL desde código Java.

### 12.2. Tipos de Manejadores (Drivers)

| Tipo | Descripción | Rendimiento |
|------|-------------|:-----------:|
| Puente JDBC-ODBC | Usa ODBC como intermediario | Bajo (obsoleto) |
| API Nativo | Convierte llamadas a C/C++ nativo | Medio |
| JDBC-Net | Servidor intermedio, todo Java | Medio |
| **Protocolo Nativo** (Recomendado) | Driver puro Java, directo al motor. Ej: Connector/J de MySQL | **Alto** |

### 12.3. Pasos básicos para usar JDBC

```java
// 1. Cargar el Driver
Class.forName("com.mysql.jdbc.Driver");

// 2. Establecer conexion
String url = "jdbc:mysql://localhost:3306/nombre_bd";
Connection con = DriverManager.getConnection(url, "usuario", "password");

// 3. Crear Statement
Statement st = con.createStatement();

// 4. Ejecutar consulta
ResultSet rs = st.executeQuery("SELECT * FROM tabla");     // SELECT
int rows = st.executeUpdate("UPDATE...");                   // INSERT/UPDATE/DELETE

// 5. Procesar resultados
while (rs.next()) {
    System.out.println(rs.getString("nombre"));
}

// 6. Cerrar recursos (orden inverso: rs -> st -> con)
rs.close();
st.close();
con.close();
```

### 12.4. PreparedStatement (Seguridad)

Para evitar **SQL Injection**, usar `PreparedStatement` en lugar de `Statement`. Los datos se tratan como valores, no como comandos.

```java
String sql = "INSERT INTO Estudiantes (id, nombre, edad) VALUES (?, ?, ?)";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, 1);
ps.setString(2, "Juan");
ps.setInt(3, 22);
ps.executeUpdate();
```

---

## Resumen de la Unidad 3

| Tema | Idea clave |
|------|------------|
| **Excepciones** | Eventos que interrumpen el flujo normal. Se manejan con try-catch-finally |
| **Checked vs Unchecked** | Checked = compilador obliga. Unchecked = solo en ejecución (JVM) |
| **Bases de Datos** | Colección de datos relacionados con significado implícito |
| **SQL (DDL/DML)** | CREATE/ALTER/DROP definen estructura. SELECT/INSERT/UPDATE/DELETE manipulan datos |
| **JDBC** | API Java para conectar con BD. Driver nativo recomendado |
| **PreparedStatement** | Evita SQL Injection usando parámetros precompilados |
