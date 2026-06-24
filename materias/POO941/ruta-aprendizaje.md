# Programación Orientada a Objetos (POO941) — Ruta de Aprendizaje

## Competencia
Desarrolla aplicaciones basadas en tecnologías emergentes: Computación en la nube, Frameworks para desarrollo, adoptadas en el mercado nacional e Internacional.

## Indicadores de Logro
- Crea aplicaciones basadas en tecnologías emergentes (Computación en la nube, Frameworks para desarrollo), atendiendo los requerimientos de los usuarios y los estándares relacionados con el desarrollo de software.
- Documenta todas las etapas del desarrollo de aplicaciones que utilizan tecnología emergente: Levantamiento de requerimientos, análisis, diseño, construcción, prueba e implementación de una aplicación.

## Fechas Importantes y Calendario

| Mes | Actividades y fechas para entregar | Porcentaje de evaluación |
| --- | --- | --- |
| **Ene-Jun** | Video conferencia de bienvenida: 19 de enero | — |
| | Desarrollo Unidad I: 19 ene – 8 feb | — |
| | Desarrollo Unidad II: 9 feb – 5 mar | — |
| | **Entrega Foro 1:** 14 feb | 10% |
| | Desarrollo Unidad III: 6 mar – 7 abr | — |
| | **Entrega Foro 2:** 1 mar | 10% |
| | **Entrega Desafío 1:** 21 mar | 10% |
| | Desarrollo Unidad IV: 8 abr – 4 may | — |
| | **Entrega Desafío 2:** 19 abr | 10% |
| | Vacaciones: 30 mar – 5 abr | — |
| | Desarrollo Unidad V: 5 may – 6 jun | — |
| | **Entrega avance de proyecto (Fase 1):** 11 may | 30% |
| **Jun** | **Entrega Proyecto Final (Fase 2):** 31 may | 30% |

### Resumen de ponderaciones
| Actividad | Peso |
|-----------|:----:|
| Foro 1 | 10% |
| Foro 2 | 10% |
| Desafío 1 | 10% |
| Desafío 2 | 10% |
| Proyecto Fase 1 (Desktop) | 30% |
| Proyecto Fase 2 (Web) | 30% |
| **Total** | **100%** |

---

## Experiencia de Aprendizaje 1 — Foros (20%)

### Foro 1 — Colecciones y Mapas en Java (10%)
**Fechas:** 31 ene – 14 feb | **Agrupamiento:** Grupal (máx. 5)

**Contenido:** Investigar `Collection`, `List`, `Map` en Java:
1. ¿Cómo se declaran?
2. ¿Cómo se asignan valores?
3. ¿Cómo se eliminan valores?

**Ejercicio:** Programa que gestione alumnos de POO en UDB Virtual:
- Ingresar alumnos (carnet + nombre completo) → "Alumno ingresado exitosamente"
- Buscar alumnos por carnet → si no existe: "Alumno no encontrado, no se puede Mostrar"
- Eliminar alumnos por carnet → mensaje de éxito o "Alumno no encontrado, no se puede Eliminar"
- Mostrar todos los alumnos
- **Tecnologías:** Swing (`JOptionPane`) + POO

**Rúbrica:** 30% resolución completa | 70% ejecución libre de errores y uso correcto de colecciones | 10% manejo de errores

### Foro 2 — Herencia con Equipos de Cómputo (10%)
**Fechas:** 20 feb – 1 mar | **Agrupamiento:** Grupal (máx. 5)

**Ejercicio:** TODOPC — registro de equipos en venta usando herencia:

| Clase | Atributos |
|-------|-----------|
| **Clase base** | (comunes) |
| **Desktop** | Fabricante, Modelo, Microprocesador, Memoria, Tarjeta gráfica, Tamaño de torre, Capacidad de disco duro |
| **Laptop** | Fabricante, Modelo, Microprocesador, Memoria, Tamaño pantalla, Capacidad de disco duro |
| **Tablet** | Fabricante, Modelo, Microprocesador, Tamaño diagonal de pantalla, ¿Capacitiva/Resistiva?, Tamaño memoria NAND, Sistema Operativo |

**Requisitos técnicos:**
- Clase base + 3 subclases (herencia estricta)
- `ArrayList` para almacenar objetos
- Menú: 1. Registrar equipo | 2. Ver equipos | 3. Salir
- `JOptionPane` para entrada/salida
- Validación de campos vacíos
- Uso de paquetes (packages)

**Rúbrica:** 30% resolución | 70% ejecución sin errores | 20% diseño de interfaz | 10% manejo de errores

---

## Experiencia de Aprendizaje 2 — Desafíos (20%)

### Desafío 1 — Análisis UML + BD Mediateca (10%)
**Fechas:** 11 mar – 21 mar | **Agrupamiento:** Grupal (máx. 5)

**Enunciado:** Mediateca con libros, revistas, DVDs y CDs de audio para socios.

**Opciones del sistema:** a) Agregar | b) Modificar | c) Listar | d) Borrar | e) Buscar | f) Salir

**Datos por material:**
- **Libro:** código, título, autor, n° páginas, editorial, ISBN, año publicación, unidades
- **Revista:** código, título, editorial, periodicidad, fecha publicación, unidades
- **CD audio:** código, título, artista, género, duración, n° canciones, unidades
- **DVD:** código, título, director, duración, género, unidades

**Códigos únicos:** `LIB00000`, `REV00000`, `CDA00000`, `DVD00000`

**Jerarquía de clases:**
```
Material (base)
├── MaterialEscrito → Libro, Revista
└── MaterialAudiovisual → CD de audio, DVD
```

**Entregables:** Diagramas de casos de uso, secuencia y modelo relacional MySQL.

**Rúbrica:** 60% análisis y resolución | 25% diagramas casos de uso/secuencia | 15% diagrama ER + BD MySQL

### Desafío 2 — Sistema Funcional Mediateca (10%)
**Fechas:** 11 abr – 19 abr | **Agrupamiento:** Grupal (máx. 5)

**Contenido:** Implementar el Desafío 1 como sistema funcional:
- Interfaz gráfica: **Swing** (`JTable` para listar materiales)
- Persistencia: **MySQL** vía **JDBC**
- Logs de errores: **Log4J**

**Rúbrica:** 70% resolución | 20% interfaz gráfica atractiva | 10% manejo de excepciones con Log4J

---

## Experiencia de Aprendizaje 3 — Proyecto Final (60%)

**Contexto:** Colegio Amigos De Don Bosco — sistema de gestión de biblioteca.

### Fase 1 — Aplicación Desktop (30%)
**Entrega:** 11 mayo

**Roles:** Administrador, Profesor, Alumnos

**Módulo de Encargados:**
- Ingresar usuarios y asignar privilegios
- Restablecer contraseñas
- Ingresar nuevos ejemplares
- Consulta de ejemplares
- Préstamos a usuarios registrados (validar mora)
- Configurar límite de ejemplares a prestar
- Devoluciones
- Calcular mora (configurable por día/año)

**Rúbrica:** 25% capa de datos | 25% capa lógica | 10% IU Desktop | 30% programación y validaciones | 10% ejecutable fuera del IDE

### Fase 2 — Aplicación Web (30%)
**Entrega:** 31 mayo ← ¡PRÓXIMA ENTREGA!

**Contenido:**
- Migrar **Módulo de Encargados** a ambiente Web
- **Módulo de Consultas:** Catálogo en línea público (sin login), búsqueda por título, autor, texto completo, tipo de material, idioma
- **Módulo de Préstamo:** Usuarios registrados solicitan préstamos web (sin mora)

**Reglas de negocio:**
- Docente: hasta 6 libros, mayor tiempo de préstamo
- Alumno: hasta 3 libros (configurable por encargado)

**Tecnologías:** HTML, **Servlets**, **JSP**, **Java Beans**, **Apache Tomcat**, Pool de conexiones

**Rúbrica:** 10% capa de datos y validaciones web | 40% lógica de negocio migrada | 20% IU web atractiva | 15% Pool de conexiones en Tomcat | 15% deploy exitoso en Tomcat

---

## Tecnologías por Actividad

| Actividad | Tecnologías |
|-----------|-------------|
| Foro 1 | Java, Swing (`JOptionPane`), Colecciones/Mapas |
| Foro 2 | Java, Swing (`JOptionPane`), Herencia, `ArrayList`, Paquetes |
| Desafío 1 | UML (casos de uso, secuencia), MySQL, Diagrama ER |
| Desafío 2 | Java, Swing (`JTable`), MySQL, JDBC, Log4J |
| Proyecto Fase 1 | Java, Swing, MySQL, JDBC (Desktop) |
| Proyecto Fase 2 | HTML, Servlets, JSP, Java Beans, Apache Tomcat, Pool de conexiones |
