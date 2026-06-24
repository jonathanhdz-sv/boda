# Proyecto Final Fase 2 — Aplicación Web

**Materia:** Programación Orientada a Objetos (POO941)  
**Carrera:** Ingeniería en Ciencias de la Computación  
**Universidad:** Universidad Don Bosco (UDB Virtual)  
**Plan:** 2024  
**Ciclo:** 01-2026  

---

## Integrantes

| Nombre | Carnet |
|--------|--------|
| Yoselyn Aguilar | AR253073 |
| Jhensen Recinos | RA251889 |
| Jonathan Hernández | HG253460 |
| Rubel Andrade | AC251900 |

---

## Proyecto

**Sistema de Gestión de Biblioteca — Colegio Amigos De Don Bosco**  
**Fase 2:** Aplicación Web con Servlets, JSP y Apache Tomcat

**Descripción:** Sistema web para la administración de una biblioteca escolar que permite gestionar usuarios, libros y préstamos. Incluye catálogo público sin necesidad de iniciar sesión, módulo de administración para encargados, y módulo de préstamos para alumnos y profesores con cálculo automático de mora.

---

## Tecnologías Utilizadas

| Tecnología | Detalle |
|------------|---------|
| Lenguaje | Java 17 |
| IDE | Apache NetBeans 29 |
| Servidor Web | Apache Tomcat 10 |
| Base de Datos | MySQL 8.4 |
| Conector | JDBC con Pool de Conexiones |
| Gestión de Dependencias | Maven |
| Frontend | HTML5, CSS3, JSP (JavaServer Pages) |
| Backend | Servlets, DAOs, Java Beans |
| Arquitectura | MVC (Modelo-Vista-Controlador) |

---

## Módulos del Sistema

### Módulo de Encargados (login protegido)
- Gestión de usuarios (CRUD)
- Gestión de libros del catálogo (CRUD)
- Registro y devolución de préstamos
- Cálculo automático de mora

### Módulo de Consultas (público, sin login)
- Búsqueda de libros por título, autor, tipo e idioma

### Módulo de Préstamos Web
- Alumnos y profesores solicitan libros en línea
- Límite de 3 libros para alumnos, 6 para profesores
- 7 días de préstamo sin recargo para alumnos
- 14 días de préstamo sin recargo para profesores
- Mora de $1.10 por día de atraso

---

## Estructura del Proyecto

| Capa | Archivos |
|------|----------|
| **Modelo** (Java Beans) | Usuario.java, Libro.java, Prestamo.java |
| **DAO** (Acceso a Datos) | ConexionBD.java, UsuarioDAO.java, LibroDAO.java, PrestamoDAO.java |
| **Controlador** (Servlets) | LoginServlet, UsuarioServlet, LibroServlet, PrestamoServlet, CatalogoServlet |
| **Vista** (JSP) | 11 archivos JSP con interfaz gráfica atractiva |

**Base de Datos:** `biblioteca_don_bosco`  
**Tablas:** usuarios, libros, prestamos, configuracion  
**Pool de Conexiones:** Configurado en context.xml (mínimo 5, máximo 20 conexiones)

---

## Rúbrica

| Criterio | Peso |
|----------|:----:|
| Capa de datos y validaciones web | 10% |
| Lógica de negocio migrada a entorno web | 40% |
| Interfaz de usuario web atractiva | 20% |
| Pool de conexiones en Apache Tomcat | 15% |
| Deploy exitoso del proyecto en Tomcat | 15% |

---

## Acceso al Sistema

### Administradores
| Nombre | Usuario | Contraseña |
|--------|---------|:----------:|
| Jonathan Hernández | HG253460 | 1234 |
| Yoselyn Aguilar | AR253073 | 1234 |
| Jhensen Recinos | RA251889 | 1234 |
| Rubel Andrade | AC251900 | 1234 |

### Alumnos
| Nombre | Usuario | Contraseña |
|--------|---------|:----------:|
| Oscar Martínez | MA365018 | 1234 |
| Andrea Ramírez | RA129574 | 1234 |

### Profesor
| Nombre | Usuario | Contraseña |
|--------|---------|:----------:|
| Ricardo Gómez | GO528630 | 1234 |

**URL:** `http://localhost:8080/BibliotecaDonBosco/`  
**Catálogo público:** `http://localhost:8080/BibliotecaDonBosco/catalogo`

---

## Fecha de Entrega

**31 de mayo de 2026**
