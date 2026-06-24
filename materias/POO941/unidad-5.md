# Unidad 5 — Introducción a la Programación Web

**Clases:** 15 a 17 | **Periodo:** 5 may – 6 jun

Esta unidad cierra el curso con el salto al desarrollo web: HTML para la vista, Servlets para la lógica del servidor, JSP para interfaces dinámicas, integrando todo lo aprendido (POO + BD + Excepciones) en aplicaciones web.

---

## Clase 15: HTML (HyperText Markup Language)

### Qué es HTML
**No** es un lenguaje de programación, es un **lenguaje de marcado**. Estructura el contenido de las páginas web mediante **etiquetas** (tags).

### Estructura básica de una página HTML
```html
<!DOCTYPE html>
<html>
<head>
    <title>Título de la página</title>
</head>
<body>
    <h1>Mi primera página</h1>
    <p>Este es un párrafo de ejemplo.</p>
</body>
</html>
```

### Principales etiquetas (tags) HTML

| Etiqueta | Función | Ejemplo |
|----------|---------|---------|
| `<html>` | Envuelve todo el documento | `<html>...</html>` |
| `<head>` | Metadatos, título, estilos | `<head><title>...</title></head>` |
| `<body>` | Contenido visible | `<body>...</body>` |
| `<h1>` a `<h6>` | Encabezados (niveles) | `<h1>Título principal</h1>` |
| `<p>` | Párrafo de texto | `<p>Texto aquí</p>` |
| `<a>` | Enlace (hipervínculo) | `<a href="url">Click</a>` |
| `<img>` | Imagen | `<img src="foto.jpg">` |
| `<ul>` / `<ol>` / `<li>` | Listas | `<li>Elemento</li>` |
| `<table>` / `<tr>` / `<td>` | Tablas | `<td>Celda</td>` |
| `<div>` | División/contenedor genérico | `<div>...</div>` |
| `<br>` | Salto de línea | `<br>` |

---

## Formularios en HTML

Los formularios son el medio por el cual el usuario **envía datos** hacia el servidor (Servlets). Se definen con `<form>`:

```html
<form action="MiServlet" method="POST">
    <label>Nombre:</label>
    <input type="text" name="nombre">
    
    <label>Edad:</label>
    <input type="number" name="edad">
    
    <input type="submit" value="Enviar">
</form>
```

### Atributos clave de `<form>`
| Atributo | Función | Valores comunes |
|----------|---------|-----------------|
| `action` | URL destino donde se envían los datos | `"MiServlet"`, `"/guardar"` |
| `method` | Método HTTP de envío | `GET` (datos en URL) o `POST` (datos en cuerpo) |

### Tipos de `<input>`
| Tipo | Uso |
|------|-----|
| `text` | Texto en una línea |
| `password` | Contraseña (oculta caracteres) |
| `number` | Solo números |
| `email` | Dirección de correo |
| `submit` | Botón de envío |
| `reset` | Botón para limpiar el formulario |

**Regla:** GET para solicitar datos (ej. búsquedas), POST para enviar datos sensibles o grandes (ej. registro, login).

---

## Clase 16: Servlets

### Qué es un Servlet
Clase Java que se ejecuta dentro de un **servidor web** (contenedor de servlets). Recibe una **petición (request)** del navegador, la procesa y devuelve una **respuesta (response)**, generalmente en HTML.

### Arquitectura de Contenedor Web (Apache Tomcat)
```
Navegador  →  HTTP Request  →  Tomcat (contenedor)  →  Servlet  →  BD
           ←  HTTP Response ←                          ←          ←
```

**Funciones del contenedor:**
1. Recibir la petición HTTP del cliente
2. Instanciar el Servlet si es necesario
3. Invocar los métodos del ciclo de vida (`init`, `service`, `destroy`)
4. Gestionar la concurrencia (múltiples usuarios simultáneos)

### Ciclo de Vida de un Servlet

| Método | Cuándo se ejecuta | Propósito |
|--------|-------------------|-----------|
| `init()` | **Una sola vez** al instanciarse | Configuraciones iniciales (ej. conexión a BD) |
| `service()` | **Por cada petición** recibida | Redirige a `doGet()` o `doPost()` según el método HTTP |
| `destroy()` | Antes de ser eliminado de memoria | Liberar recursos (cerrar conexiones) |

### Métodos doGet y doPost

**doGet** — peticiones GET:
```java
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Recuperar datos sin modificar el servidor
    // Ej: cargar lista de estudiantes
}
```

**doPost** — peticiones POST:
```java
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Enviar datos de formulario (registro, login)
    // Los datos viajan en el cuerpo de la petición, no en la URL
}
```

### Objetos Request y Response

| Objeto | Propósito | Método clave |
|--------|-----------|--------------|
| **request** (HttpServletRequest) | Obtener datos enviados por el cliente | `request.getParameter("nombre_input")` |
| **response** (HttpServletResponse) | Definir qué se envía de vuelta al navegador | `response.getWriter().println("<html>...")` |

### Ejemplo básico de Servlet
```java
@WebServlet("/saludo")
public class SaludoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String nombre = request.getParameter("nombre");
        out.println("<html><body>");
        out.println("<h1>Hola, " + nombre + "</h1>");
        out.println("</body></html>");
    }
}
```

---

## Clase 17: JSP (JavaServer Pages)

### Qué es JSP
Escribir HTML dentro de un Servlet (`out.println(...)`) es **tedioso y propenso a errores**. JSP invierte el enfoque: escribes HTML y **embebes** pequeñas piezas de código Java dentro.

Un archivo `.jsp` es compilado automáticamente por el servidor en un Servlet la primera vez que se accede a él.

### Elementos básicos de JSP

| Elemento | Sintaxis | Uso |
|----------|----------|-----|
| **Scriptlet** | `<% ... %>` | Insertar bloques de código Java (lógica, ciclos, condiciones) |
| **Expresión** | `<%= ... %>` | Imprimir valores directamente en el HTML |
| **Directiva** | `<%@ ... %>` | Importar librerías, configurar la página |

### Ejemplo de archivo JSP
```jsp
<%@ page import="java.util.*" %>
<html>
<body>
    <h1>Bienvenido, <%= request.getParameter("usuario") %></h1>
    <%
        int hora = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
        String saludo = (hora < 12) ? "Buenos días" : "Buenas tardes";
    %>
    <p><%= saludo %></p>
</body>
</html>
```

---

## Arquitectura MVC (Modelo-Vista-Controlador)

Organiza aplicaciones web profesionales **separando responsabilidades**:

```
         PETICIÓN               LLAMA
NAVEGADOR -----→ CONTROLADOR ---------→ MODELO (DAOs, Entidades)
                  (Servlet)               ↓
                     |                RESULTADOS
                     ↓                    ↓
                  VISTA (JSP) ←-----------┘
                     |
                     → RESPUESTA HTML → NAVEGADOR
```

| Capa | Componente | Responsabilidad |
|------|------------|-----------------|
| **Modelo** | Clases DAO + Entidades | Lógica de negocio y acceso a datos (BD) |
| **Vista** | Archivos JSP | Mostrar datos al usuario (HTML) |
| **Controlador** | Servlets | Recibir petición, llamar al modelo, decidir qué JSP mostrar |

---

## Integración Completa: Swing + Servlets + BD

La gran ventaja de la POO es la **reutilización de código**. Las clases DAO creadas en la Unidad 4 para escritorio se usan **exactamente igual** en los Servlets:

```
Escritorio:  JFrame  →  DAO.insertar()  →  BD
Web:         Servlet →  DAO.insertar()  →  BD
                            ↑
                    LA MISMA CLASE DAO
```

La lógica de acceso a datos es **independiente** de la interfaz de usuario gracias al paradigma orientado a objetos.

---

## Resumen de la Unidad 5

| Tema | Idea clave |
|------|------------|
| **HTML** | Lenguaje de marcado para estructurar contenido web |
| **Formularios** | `<form action="..." method="POST">` envía datos al servidor |
| **Servlet** | Clase Java que procesa peticiones HTTP y genera respuestas dinámicas |
| **Ciclo de vida** | `init()` → `service()` (doGet/doPost) → `destroy()` |
| **Tomcat** | Contenedor de servlets que gestiona peticiones, instancias y concurrencia |
| **JSP** | HTML + código Java embebido. Más fácil que escribir HTML en Servlets |
| **MVC** | Modelo (DAO) + Vista (JSP) + Controlador (Servlet) |
| **Reutilización** | Los mismos DAOs funcionan en escritorio (Swing) y web (Servlets) |
