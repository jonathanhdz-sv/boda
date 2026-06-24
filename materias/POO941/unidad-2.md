# Unidad 2 — Modelado de Datos y Programación Orientada a Objetos

**Clases:** 5 y 6 | **Periodo:** 9 feb – 5 mar

Esta unidad introduce el paradigma POO desde dos frentes: el modelado visual con UML y la implementación en código Java con clases, objetos y los 4 pilares de POO.

---

## Clase 5: Fundamentos de UML

### 5. Lenguaje Unificado de Modelado (UML)

UML es un lenguaje visual, semántico y sintáctico para la **arquitectura, diseño e implementación** de sistemas de software complejos. Permite que analistas, desarrolladores y clientes compartan una misma comprensión del sistema.

> "Una imagen vale más que mil palabras" — mostrar al cliente un diagrama es más efectivo que explicarle solo con palabras.

### 5.1. Antecedentes
- Antes de UML cada ingeniero creaba sus propias anotaciones -> conflictos de interpretación
- 1994: James Rumbaugh se une a Grady Booch en Rational Software
- 1995: Ivar Jacobson se une -> forman **"los tres amigos"**
- Unificaron el **Método Booch** y **OMT** (Object Modelling Tool)
- 1997: OMG adopta UML 1.1 oficialmente
- 2005: UML 2.0 (primera gran evolución)
- 2015: UML 2.5 (versión actual)

### 5.2. Utilidad
- El cliente comprende qué hará el equipo de desarrollo
- Permite señalar cambios antes de programar
- Cada miembro del equipo sabe su lugar en la solución
- Organiza el diseño para manejar sistemas complejos

**Analogía:** un arquitecto no construye un edificio sin un anteproyecto detallado.

**Ventajas:**
- Conciso, notación simple
- Mejora tiempos de desarrollo
- Comprensible (describe todos los aspectos del sistema)
- Lenguaje formal (cada elemento tiene significado fuerte)
- Escalable (proyectos de cualquier tamaño)

### 5.3. Componentes
- **Notación:** parte gráfica, sintaxis del lenguaje de modelado
- **Metamodelo:** reglas, restricciones y esquemas que definen el significado

### 5.4. Tipos de Diagramas UML

**Diagramas de Estructura** (estática: cómo están conformados los objetos):
- Diagrama de clases
- Diagrama de objetos
- Diagrama de componentes
- Diagrama de despliegue
- Diagrama de paquetes
- Diagrama de estructuras compuestas

**Diagramas de Comportamiento** (dinámica: cómo interactúan los objetos):
- Diagrama de casos de uso
- Diagrama de actividad
- Diagrama de secuencia
- Diagrama de máquina de estados

### 5.5. Herramientas CASE para UML
- StarUML
- Umbrello
- Argo UML
- Visio
- UML Designer
- Netbeans (plugin)
- Eclipse (plugin)

---

## Tipos de Diagramas UML (Clase 5 — continuación)

### 6.1. Diagrama de Clases
El más importante del modelado estructural. Muestra clases, atributos, métodos y relaciones.

**Representación gráfica:** rectángulo con 3 compartimentos:
```
+------------------------------------+
|           NombreClase              |  ← Superior: nombre (centrado, negrita)
+------------------------------------+
| - atributo1: tipo                  |  ← Medio: atributos con visibilidad
| - atributo2: tipo                  |
+------------------------------------+
| + metodo1(): tipo_retorno          |  ← Inferior: métodos/operaciones
| + metodo2(param): void             |
+------------------------------------+
```

**Visibilidad (modificadores de acceso):**
| Símbolo | Nombre | Significado |
|:-------:|--------|-------------|
| `+` | Public | Accesible desde cualquier clase |
| `-` | Private | Solo accesible dentro de la propia clase |
| `#` | Protected | Accesible en la clase y sus subclases |
| `~` | Package | Accesible solo en el mismo paquete |

**Relaciones entre clases:**
| Relación | Símbolo | Significado | Ejemplo |
|----------|---------|-------------|---------|
| **Asociación** | Línea continua | Conexión básica entre clases | Cliente — Pedido |
| **Herencia** | Triángulo hueco | "es un" (subclase -> superclase) | Perro -> Animal |
| **Agregación** | Rombo hueco | "todo-parte" débil (partes independientes) | Equipo — Jugador |
| **Composición** | Rombo relleno | "todo-parte" fuerte (partes dependen del todo) | Casa — Habitación |
| **Dependencia** | Línea discontinua | Uso temporal de otra clase | parámetro en método |

**Multiplicidad:**
| Valor | Significado |
|-------|-------------|
| `1` | Uno y solo uno |
| `0..1` | Cero o uno |
| `0..*` o `*` | Cero o muchos |
| `1..*` | Uno o muchos |

### 6.2. Diagrama de Casos de Uso
Modela la funcionalidad desde el punto de vista del usuario.

**Elementos:**
- **Actor:** persona/sistema que interactúa (figura de palo)
- **Caso de Uso:** funcionalidad que entrega valor (elipse con nombre)
- **Límite del Sistema:** rectángulo que delimita el alcance

**Relaciones:**
- **Asociación:** actor — caso de uso (línea continua)
- **<<include>>:** inclusión obligatoria (flecha discontinua al incluido)
- **<<extend>>:** extensión opcional (flecha discontinua al base)

### 6.3. Diagrama de Secuencia
Muestra cómo los objetos interactúan en orden cronológico.

**Elementos:**
- **Línea de Vida:** existencia del objeto en el tiempo (rectángulo + línea vertical punteada)
- **Mensajes:** flechas horizontales entre líneas de vida
- **Foco de Control:** rectángulo fino sobre la línea de vida (tiempo activo)

**Tipos de mensajes:**
| Tipo | Flecha | Comportamiento |
|------|--------|----------------|
| Síncrono | Sólida, punta llena | Emisor espera respuesta |
| Asíncrono | Sólida, punta abierta | Emisor continúa sin esperar |
| Retorno | Discontinua, punta abierta | Devuelve valor o control |

---

## Clase 6: El Paradigma Orientado a Objetos en Java

### 7.1. Clases
Una **clase** es un molde, plantilla o plano a partir del cual se crean objetos. Define atributos (datos) y métodos (comportamiento) que compartirán todos los objetos de ese tipo.

```java
public class NombreClase {
    // Atributos (variables de instancia)
    // Constructores (inicialización)
    // Métodos (acciones)
}
```

### 7.2. Objetos
Un **objeto** es una instancia concreta de una clase. Si la clase es el plano de una casa, el objeto es la casa construida.

```java
NombreClase nombreObjeto = new NombreClase();
```

La palabra `new` reserva espacio en la memoria dinámica (Heap).

### 7.3. Atributos
Características o propiedades de la clase. Por buena práctica se declaran **private** (encapsulamiento).

```java
public class Vehiculo {
    private String marca;
    private String modelo;
    private int anio;
}
```

### 7.4. Métodos
Comportamiento dinámico de los objetos. Bloques que realizan tareas específicas.

```java
visibilidad tipo_retorno nombreMetodo(parametros) {
    // cuerpo del metodo
    return valor; // obligatorio si tipo_retorno != void
}
```

### 7.4.1. Métodos Constructores
Método especial que **inicializa** los atributos al crear el objeto.

**Características únicas:**
- Se llama exactamente igual que la clase
- **No** tiene tipo de retorno (ni siquiera `void`)
- Se invoca automáticamente con `new`
- Si no se define, Java crea uno por defecto (valores: 0, false, null)

```java
public class Persona {
    private String nombre;

    public Persona(String nombreInicial) {
        this.nombre = nombreInicial;
    }
}
```

### 7.5. Métodos de Acceso (Getters y Setters)
Mecanismos públicos para interactuar con atributos privados.

```java
// Getter: obtener/leer el valor
public String getNombre() {
    return this.nombre;
}

// Setter: modificar/asignar valor (permite validar)
public void setNombre(String nuevoNombre) {
    if (!nuevoNombre.isEmpty()) {
        this.nombre = nuevoNombre;
    }
}
```
**Convención:** `getAtributo()` y `setAtributo(valor)` con camelCase.

### 7.6. Paquetes (Packages)
Carpetas lógicas para organizar clases y evitar colisiones de nombres.

```java
package com.udbvirtual.modelo;   // primera línea del archivo
import com.udbvirtual.modelo.Persona;  // usar clases de otros paquetes
```

### 7.7. Visibilidad a Nivel Paquete
Java no tiene "clases amigas" como C++, pero sí un modificador por defecto: sin `public`, `private` ni `protected`, el miembro es accesible solo por clases del **mismo paquete**.

---

## 8. Propiedades (Pilares) de la POO

### 8.1. Abstracción
Proceso de extraer solo las características **relevantes** de un objeto del mundo real, ignorando detalles superfluos. Responde a "¿qué hace?" sin preocuparse por "¿cómo lo hace?".

```java
public abstract class Animal {
    private String especie;
    
    // Método abstracto: firma sin cuerpo
    public abstract void emitirSonido();
}
```
**Regla clave:** una clase abstracta **NO** se puede instanciar con `new`.

### 8.2. Encapsulamiento
Empaquetar datos (atributos) y código (métodos) en una clase, **ocultando** los detalles internos. Se logra con atributos `private` + getters/setters públicos. Protege el estado del objeto de manipulaciones externas.

### 8.3. Modularidad
Dividir una aplicación compleja en partes más pequeñas, independientes y con alta cohesión. En Java se implementa mediante **paquetes** que agrupan clases especializadas.

### 8.4. Herencia
Mecanismo que permite crear una clase nueva (subclase) a partir de una existente (superclase). La subclase **hereda** atributos y métodos del padre, promoviendo la reutilización de código.

- Java tiene **herencia simple** (una clase solo puede tener UN padre)
- Se implementa con la palabra clave `extends`

```java
// Clase Padre
public class Empleado {
    private double salario;
    public Empleado(double salario) { this.salario = salario; }
    public double getSalario() { return salario; }
}

// Clase Hija
public class Gerente extends Empleado {
    private String departamento;
    public Gerente(double salario, String departamento) {
        super(salario);  // invoca al constructor del padre
        this.departamento = departamento;
    }
}
```

### 8.5. Sobrecarga (Overloading)
Definir **varios métodos con el mismo nombre** pero con diferentes parámetros (cantidad, tipo u orden). El compilador decide cuál llamar según los argumentos.

```java
public class Calculadora {
    public int sumar(int a, int b) { return a + b; }
    public double sumar(double a, double b) { return a + b; }
}
```

### 8.6. Polimorfismo ("muchas formas")
Una variable de tipo padre puede almacenar objetos de cualquier subclase, y al invocar un método se ejecuta la versión **específica** del objeto real en memoria.

```java
Animal miMascota;          // referencia de tipo padre

miMascota = new Perro();
miMascota.emitirSonido();  // "Guau Guau"

miMascota = new Gato();
miMascota.emitirSonido();  // "Miau Miau"
```

**Ventajas del polimorfismo:**
- **Extensibilidad:** agregar nuevas subclases sin modificar código existente
- **Mantenimiento simplificado:** evita if-else/switch para distinguir tipos
- **Reutilización:** colecciones que almacenan distintos tipos bajo una misma referencia

---

## 9. Relaciones Avanzadas entre Clases

### 9.1. Asociación Unidireccional vs Bidireccional
- **Unidireccional:** A conoce a B, pero B no conoce a A
- **Bidireccional:** ambas clases mantienen referencias mutuas (requiere actualizar ambos lados explícitamente)

### 9.2. Operador instanceof
Verifica en tiempo de ejecución la clase real de un objeto.

```java
if (miMascota instanceof Perro) {
    Perro miPerro = (Perro) miMascota;  // casting
    miPerro.enterrarHueso();            // método exclusivo de Perro
}
```
**Precaución:** abusar de `instanceof` puede indicar un mal diseño polimórfico.

---

## Resumen de la Unidad 2

| Concepto | Idea clave |
|----------|------------|
| **UML** | Lenguaje visual para modelar sistemas antes de programar |
| **Diagrama de Clases** | Estructura estática: clases, atributos, métodos y relaciones |
| **Diagrama de Casos de Uso** | Qué hace el sistema desde la vista del usuario |
| **Diagrama de Secuencia** | Cómo interactúan los objetos en orden cronológico |
| **Clase** | Molde/plantilla que define atributos y métodos |
| **Objeto** | Instancia concreta de una clase (`new`) |
| **Constructores** | Inicializan atributos al crear el objeto |
| **Abstracción** | Extraer solo lo relevante, ignorar lo superfluo |
| **Encapsulamiento** | Ocultar datos internos (`private` + getters/setters) |
| **Herencia** | Subclase hereda de superclase (`extends`) |
| **Sobrecarga** | Mismo nombre de método, distintos parámetros |
| **Polimorfismo** | Misma referencia, comportamientos diferentes según el objeto real |
