# Unidad 1 — Programación Estructurada (Repaso en Java)

**Clases:** 1 a 4 | **Periodo:** 19 ene – 8 feb

Esta unidad sirve como puente entre Programación Estructurada (PRE941) y POO, repasando los fundamentos del lenguaje Java.

---

## Clase 1: Generalidades del Lenguaje de Programación Java

### 1. Introducción a Java
- Java es un lenguaje potente, seguro y completamente Orientado a Objetos
- Permite expresar cálculos y procesos que serán ejecutados por un ordenador
- Seleccionado para este curso por ser ideal para aprender el paradigma POO

### 1.1. Historia de Java
- Creado por Sun Microsystems (James Gosling, 1990)
- Originalmente llamado **Oak** (roble), luego renombrado a **Java** (café en argot inglés)
- Sun comprada por Oracle Corporation (17 abril 2009)
- Primera versión pública: principios de 1995
- Frase célebre: **"Write Once, Run Anywhere"** (escríbelo una vez, ejecútalo en cualquier lugar)

### 1.2. Plataforma de Java
- Se apoya en un gran número de **clases preexistentes** (API - Application Programming Interface)
- Los programas se compilan a **Bytecode** (código neutro) interpretado por la JVM
- Cada SO instala su JVM correspondiente

**Elementos de la plataforma:**
1. Código fuente Java (.java)
2. Compilador Java (javac) -> Bytecode (.class)
3. JRE (Java Runtime Environment) con JVM
4. Sistema Operativo (Windows, Mac, Linux, Solaris...)
5. Hardware (Intel, AMD, etc.)

### 1.2.1. Características destacadas
- Basado en C++, sintaxis similar, orientado a objetos
- Multiplataforma
- Soporte para datos locales y en red
- JDK gratuito
- Tipos de programas: gráficos, applets, servicios web
- Manejo automático de memoria (Garbage Collector)

### 1.2.2. Ediciones de Java
| Edición | Uso |
|---------|-----|
| **Java SE** (Standard) | Computadoras personales, escritorio. Base para las demás |
| **Java ME** (Micro) | Dispositivos móviles, celulares no smartphone |
| **Java EE** (Enterprise) | Aplicaciones empresariales. Incluye JDBC, JSP, Servlets |

### 1.3. Versiones de Java
JDK 1.0 (1996) -> 1.1 (1997) -> J2SE 1.2 (1998) -> 1.3 (2000) -> 1.4 (2002) -> 5.0 (2004) -> SE 6 (2006) -> SE 7 (2011) -> SE 8 (2014) -> SE 9 (2017)

---

## Clase 2: Entorno de Desarrollo de Java

### 2.1. Java Development Kit (JDK)
- Conjunto de programas y librerías para **desarrollar, compilar y ejecutar** programas Java
- Incluye Debugger para detección y corrección de errores
- **JRE** (Java Runtime Environment): versión reducida, solo ejecuta (no compila)

**Estructura de directorios del JDK:**
- `bin/` — Ejecutables: javac.exe, java.exe, jdb.exe, appletviewer.exe, javadoc.exe
- `lib/` — Librerías base (clases)
- `jre/` — Ambiente de ejecución

### 2.2. Compilador de Java (javac)
- Analiza sintaxis del código fuente (.java)
- Si no hay errores, genera bytecode (.class)
- Si hay errores, muestra la línea donde ocurren

**Proceso de compilación y ejecución:**
1. Editar código en bloc de notas o IDE -> archivo .java
2. Compilar con `javac MiClase.java` -> archivo .class (bytecode)
3. Ejecutar con `java MiClase` -> resultado en consola

### 2.3. Java Virtual Machine (JVM)
- Máquina hipotética/virtual que interpreta el bytecode
- Convierte el código neutro a código particular de la CPU
- Cada plataforma tiene su propia JVM
- **JIT** (Just-In-Time Compiler): mejora velocidad 10-20x

### 2.4. Garbage Collection
- Recolector de basura **automático**
- El programador NO gestiona la memoria (diferencia clave vs C++)
- Elimina objetos no utilizados para liberar memoria

### 2.5. Entorno de Desarrollo Integrado (IDE)
- Ofrece ambiente gráfico amigable con herramientas integradas
- **IDEs comunes:** Netbeans, Eclipse, IntelliJ Idea, JDeveloper
- **Para este curso:** Netbeans 8.2
- Secciones: Área de Proyectos, Edición de código, Consola de salida

---

## Clase 3: Fundamentos de la Programación en Java

### 3.1. Variables
Espacio de memoria reservado que puede cambiar durante la ejecución.

**Sintaxis:**
```java
tipo_dato nombre_variable;
tipo_dato nombre_variable = valor;
```

**Reglas para identificadores:**
- Comienzan con letra, `$` o `_`
- No pueden comenzar con número
- Sin espacios en blanco
- **Case sensitive** (distingue mayúsculas/minúsculas)
- No usar palabras reservadas
- **Convención:** camelCase (ej. `sueldoNeto`, `fechaNacimiento`)

### 3.2. Constantes
Valor que NO cambia durante la ejecución. Usa palabra reservada `final`.

```java
final double PI = 3.14159265;
final int MAX_USUARIOS = 100;
```
**Convención:** MAYÚSCULAS con guión bajo (ej. `MAX_USUARIOS`)

### 3.3. Comentarios
Ignorados por el compilador, no afectan el rendimiento.

| Tipo | Sintaxis | Uso |
|------|----------|-----|
| Una línea | `// comentario` | Explicaciones breves |
| Múltiples líneas | `/* ... */` | Bloques de explicación |
| Documentación | `/** ... */` | JavaDoc, genera HTML automático |

### 3.4. Tipos de Datos
Java es de **tipado fuerte**: no permite operaciones entre tipos incompatibles sin conversión (cast).

**3.4.1. Tipos Primitivos (8 tipos):**

| Tipo | Tamaño | Rango | Ejemplo |
|------|--------|-------|---------|
| `byte` | 8 bits | -128 a 127 | `byte edad = 25;` |
| `short` | 16 bits | -32,768 a 32,767 | `short año = 2024;` |
| `int` | 32 bits | ±2.1 mil millones | `int poblacion = 6500000;` |
| `long` | 64 bits | ±9.2 trillones | `long deuda = 5000000000L;` |
| `float` | 32 bits | 1.4e-45 a 3.4e+38 | `float pi = 3.14f;` |
| `double` | 64 bits | 4.9e-324 a 1.7e+308 | `double salario = 1500.50;` |
| `char` | 16 bits | '\u0000' a '\uffff' | `char letra = 'A';` |
| `boolean` | — | true / false | `boolean activo = true;` |

**3.4.2. Tipos Referenciados (Objetos):**
- Almacenan dirección de memoria (referencia al objeto)
- Clases, Interfaces, Arreglos (Arrays)
- Valor por defecto si no se inicializan: **null**

### 3.5. Cadenas (String)
No es tipo primitivo, es una **clase**. Secuencia inmutable de caracteres.

```java
String mensaje = "Bienvenidos a la UDB Virtual";
```

**Métodos útiles:**
- `length()` — longitud de la cadena
- `toUpperCase()` / `toLowerCase()` — conversión mayúsculas/minúsculas
- `equals()` — comparar cadenas
- Concatenación: operador `+`

### 3.6. Operadores

**Aritméticos:** `+` `-` `*` `/` `%` `++` `--`

**Lógicos:**
| Operador | Significado | Descripción |
|----------|-------------|-------------|
| `&&` | AND (Y) | true solo si AMBAS son true |
| `||` | OR (O) | true si AL MENOS UNA es true |
| `!` | NOT (Negación) | Invierte el valor (true↔false) |

**Relacionales (Comparación):**
| Operador | Significado |
|----------|-------------|
| `==` | Igual a |
| `!=` | Diferente de |
| `>` | Mayor que |
| `<` | Menor que |
| `>=` | Mayor o igual |
| `<=` | Menor o igual |

**Atención:** `=` asigna, `==` compara. Confundirlos es error común.

### 3.7. Palabras Reservadas
Identificadores con significado especial para el compilador. **NO pueden usarse** como nombres de variables, clases o métodos.

Principales: `abstract, boolean, break, byte, case, catch, char, class, continue, default, do, double, else, extends, final, finally, float, for, if, implements, import, int, interface, long, new, package, private, protected, public, return, short, static, switch, this, throw, throws, try, void, while`

---

## Clase 4: Estructuras de Control de Flujo

### 4.1. Estructuras de Selección (Condicionales)

**4.1.1. if**
```java
if (condicion) {
    // se ejecuta si condicion es true
}
```

**4.1.2. if-else**
```java
if (condicion) {
    // si es true
} else {
    // si es false
}
```

**4.1.3. if-else if (múltiple)**
```java
if (condicion1) {
    // ...
} else if (condicion2) {
    // ...
} else {
    // caso por defecto (opcional)
}
```

**4.1.4. switch case**
Alternativa limpia a múltiples if-else if. Evalúa enteros, char o String.

```java
switch (expresion) {
    case valor1:
        // instrucciones
        break;
    case valor2:
        // instrucciones
        break;
    default:
        // si ningun caso coincide
        break;
}
```
**IMPORTANTE:** no olvidar `break`, sin él se ejecutan todos los casos siguientes.

**4.1.5. Operador Ternario (if-else compacto)**
```java
variable = (condicion) ? valor_si_true : valor_si_false;
```

### 4.2. Estructuras Iterativas (Bucles)

**4.2.1. for**
Se usa cuando se conoce el número exacto de repeticiones.

```java
for (inicializacion; condicion; incremento) {
    // bloque a repetir
}
```
Ejemplo: `for (int i = 1; i <= 5; i++) { ... }`

**4.2.2. while**
La condición se evalúa ANTES de ejecutar el bloque. Puede no ejecutarse nunca.

```java
while (condicion) {
    // instrucciones
    // IMPORTANTE: modificar la variable de control aqui
}
```

**4.2.3. do-while**
La condición se evalúa DESPUÉS de ejecutar. Se ejecuta AL MENOS UNA VEZ.

```java
do {
    // instrucciones (se ejecutan minimo 1 vez)
} while (condicion);
```
**Uso común:** menús interactivos de consola.

---

## Resumen de la Unidad 1

Esta unidad repasa los fundamentos de **Programación Estructurada** aplicados a Java:
- Historia y plataforma Java (compilación, bytecode, JVM)
- Entorno de desarrollo (JDK, JRE, Netbeans)
- Variables, constantes, tipos de datos primitivos y referenciados
- Operadores aritméticos, lógicos y relacionales
- Estructuras de selección (if, if-else, switch, ternario)
- Estructuras iterativas (for, while, do-while)

Estos fundamentos son la base lógica necesaria para abordar la Programación Orientada a Objetos en las siguientes unidades.
