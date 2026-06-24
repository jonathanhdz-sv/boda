# Referencia Completa — Proyecto POO Fase 2 (Web)

---

## Problemática que Resuelve el Proyecto

### Situación actual (sin sistema): Biblioteca del Colegio Amigos De Don Bosco

| Situación real | Problema |
|----------------|----------|
| Un profesor busca un libro | La encargada revisa 3 cuadernos viejos, tarda 15 minutos |
| Un alumno pide un préstamo | La encargada anota en papel: "Juan llevó Cálculo I, fecha: hoy". Nadie registra fecha de entrega |
| Juan no devuelve el libro en 2 meses | Nadie se da cuenta. El libro se perdió. No hay multa, no hay seguimiento |
| Otro alumno busca ese mismo libro | "Ya alguien lo tiene, pero no sé quién". El libro existe pero no está disponible |
| Un padre quiere ver qué libros hay | Tiene que ir físicamente a la biblioteca en horario escolar. Si trabaja, no puede |
| La encargada quiere saber cuántos préstamos hubo en mayo | A contar a mano en los cuadernos. Se equivoca, pierde tiempo |
| Llega un libro nuevo | Lo anota en un cuaderno de inventario. Si el cuaderno se moja, se perdió todo |

### Qué resuelve nuestro sistema

| Módulo | Qué problema resuelve |
|--------|----------------------|
| Encargados (login protegido) | Una sola persona administra todo: registra libros, usuarios, préstamos, calcula moras. Todo digital |
| Catálogo público (sin login) | Cualquiera puede buscar libros desde su casa, celular o compu. Sin ir al colegio |
| Préstamos web | Alumnos y profesores piden libros en línea. El sistema valida si están en mora y el límite de libros permitidos |

En una frase: antes eran cuadernos, papeles perdidos y "no sé quién tiene ese libro".
Ahora es todo digital, desde cualquier lugar, en segundos.

---

# Referencia de Herramientas — Proyecto POO Fase 2 (Web)

## Tabla de Herramientas

| Herramienta | Qué es | Cómo abrirla desde Terminal |
|-------------|--------|-----------------------------|
| Java (JDK 17) | El motor que ejecuta todo código Java. Sin él nada funciona. | `java -version` (ya instalado) |
| Apache NetBeans | El editor donde escribes el código (el "Word" de los programadores Java). | `netbeans` o desde el Dock/Aplicaciones |
| Apache Tomcat 10 | Servidor web que convierte tu código Java (Servlets/JSP) en páginas HTML que el navegador entiende. | `brew services start tomcat@10` (encender) / `brew services stop tomcat@10` (apagar) |
| MySQL Server | La base de datos: guarda usuarios, libros, préstamos. Corre en segundo plano, no tiene ventana. | `mysql -u root -p` (entrar desde Terminal) |
| MySQL Workbench | Interfaz gráfica para MySQL: ves las tablas, creas bases de datos con clics en vez de comandos. | Desde Aplicaciones/Dock (es app normal con ventana) |

---

## Qué es Cada Herramienta (Explicación Detallada)

### Java (JDK 17)
- JDK = Java Development Kit
- Es el "motor" que hace funcionar todo programa escrito en Java
- Sin JDK, ni NetBeans ni Tomcat funcionan
- Versión instalada: OpenJDK 17.0.19 (via Homebrew)

### Apache NetBeans
- IDE = Entorno de Desarrollo Integrado
- Donde escribes, organizas y ejecutas tu código Java
- Incluye herramientas visuales para diseñar interfaces (Swing, HTML)
- Se integra directamente con Tomcat para desplegar proyectos web

### Apache Tomcat 10
- Servidor de aplicaciones web para Java
- Función: cuando un usuario abre tu página en el navegador, Tomcat:
  1. Recibe la petición HTTP
  2. Ejecuta tu Servlet (código Java)
  3. Devuelve HTML al navegador
- Sin Tomcat, los Servlets y JSP no pueden ejecutarse
- Corre en segundo plano (background service)

### MySQL Server 9.6
- Sistema de gestión de bases de datos relacionales
- Guarda los datos del sistema: usuarios, libros, préstamos, moras
- El código Java se conecta a MySQL via JDBC para leer/escribir datos
- Corre como servicio en segundo plano

### MySQL Workbench
- Interfaz gráfica para administrar MySQL
- Permite: crear bases de datos, diseñar tablas visualmente, ejecutar consultas, ver datos
- Alternativa: usar comandos SQL directamente en Terminal
- NO es obligatorio, pero facilita mucho el trabajo con la base de datos

---

## Dependencias entre Herramientas

```
NetBeans → escribe código Java → necesita JDK
NetBeans → despliega proyecto → necesita Tomcat
Tu código → guarda/consulta datos → necesita MySQL
Workbench → conecta a → MySQL Server (para ver los datos gráficamente)
```

---

## Comandos Útiles de Homebrew

| Comando | Qué hace |
|---------|----------|
| `brew install <programa>` | Instala un programa sin ventana (herramienta de terminal/servicio) |
| `brew install --cask <programa>` | Instala un programa CON ventana (app con interfaz gráfica) |
| `brew services start <servicio>` | Enciende un servicio en segundo plano |
| `brew services stop <servicio>` | Apaga un servicio |
| `brew list` | Muestra todo lo instalado con Homebrew |

---

## Instalación Realizada

| Herramienta | Comando usado | Estado |
|-------------|---------------|:------:|
| Java 17 | `brew install openjdk@17` | ✓ Listo |
| NetBeans | Descargado manual (.dmg) | ✓ Listo |
| Tomcat 10 | `brew install tomcat@10` | ✓ Listo |
| MySQL Server | `brew install mysql` | ✓ Listo |
| MySQL Workbench | `brew install --cask mysqlworkbench` | ✓ Listo |

---

## Dónde se Hace Cada Tarea

La Terminal solo se usa para instalar y encender/apagar servicios.
El 95% del trabajo real se hace en NetBeans.

| Tarea | Dónde se hace |
|-------|---------------|
| Instalar programas | Terminal (solo una vez) |
| Encender/apagar Tomcat | Terminal (1 comando) |
| Escribir código Java | NetBeans (con ventanas, colores, menús) |
| Diseñar páginas HTML/JSP | NetBeans |
| Crear tablas en MySQL | MySQL Workbench (con clics, visual) |
| Probar la página web | Navegador (Chrome/Safari) |

Analogía: la Terminal es como la caja de herramientas del mecánico: la usas para preparar todo.
Pero el motor lo armas en el taller (NetBeans).

---

## Puertos de tu Mac

Tu Mac tiene 65,536 "oficinas" (puertos), del 0 al 65535.
Las más importantes para este proyecto:

| Puerto | Quién vive ahí | Para qué |
|:------:|----------------|----------|
| 8080 | Tomcat | Tus páginas web Java |
| 3306 | MySQL | La base de datos |
| 80 | HTTP | Páginas web normales |
| 443 | HTTPS | Páginas web seguras (bancos, correo) |

Analogía: si tu Mac es un edificio, los puertos son los números de oficina.
`localhost:8080` significa "el edificio soy yo mismo, ve a la oficina 8080 que ahí está Tomcat".

---

## Qué Pasa si Falta Cada Pieza del Proyecto

| Componente | Si falta... | Analogía |
|------------|-------------|----------|
| Java Beans (Usuario.java, Libro.java) | Los datos viajan sueltos, sin orden. Le dices al JSP "muestra el usuario" pero no sabes qué tiene un usuario (nombre?, edad?, carnet?) | Como mandar un paquete sin etiqueta ni dirección |
| DAO (UsuarioDAO.java) | Cada Servlet tendría que escribir consultas SQL a mano. Código repetido 10 veces. Si cambia la BD, toca cambiar en 10 archivos | Como no tener un mesero y cada cliente va a la cocina a preparar su plato |
| ConexionBD | Cada DAO abre y cierra su propia conexión. Si 100 usuarios entran al mismo tiempo, creas 100 conexiones. Colapsa MySQL | Como un edificio donde cada persona construye su propia puerta de entrada |
| Servlets (Controlador) | NADIE recibe las peticiones del navegador. El usuario da clic y no pasa nada. La web no funciona | Como un restaurante sin meseros. Llegan clientes pero nadie los atiende |
| JSP (Vista) | Tendrías que escribir TODO el HTML dentro de los Servlets usando print(). Horrible e imposible de mantener | Como pintar un mural con un solo pincel microscópico |
| Tomcat | Los Servlets y JSP no se ejecutan. No hay quien convierta tu código Java en páginas HTML | Como tener un motor pero sin gasolina ni llaves |

Regla: si falta 1 solo componente, el sistema NO funciona. Son como los órganos del cuerpo.

---

## Quiz de Nivelación — Resultado

| Pregunta | Respuesta correcta |
|:--------:|-------------------|
| Si localhost:8080 da error, ¿qué falla? | Tomcat está apagado |
| ¿Orden del flujo MVC? | Servlet → DAO → BD → Servlet → JSP → Navegador |
| Sin Java Beans ¿qué problema tengo? | Los datos viajan desordenados, sin estructura |

Resultado: **3/3**

---

## Usuarios: No Confundirlos

Hay DOS tipos de usuario en este proyecto, y no son lo mismo:

| Usuario | De quién es | Para qué sirve |
|---------|:-----------:|----------------|
| admin / admin (Tomcat) | De Tomcat | Para que NetBeans pueda publicar (deploy) tu proyecto en el servidor. Es como la llave del cuarto de máquinas. Solo la usa NetBeans |
| Usuarios de la biblioteca | De tu sistema | Para que encargados, profesores y alumnos inicien sesión en la página web. Se guardan en MySQL. Los creas tú en tu código |

Analogía: en un teatro, admin/admin es la llave del técnico de sonido para la cabina.
Los usuarios de la biblioteca son las entradas del público.

---

## Quiz: Java Beans — Resultado

| Pregunta | Respuesta correcta |
|:--------:|-------------------|
| ¿Qué es un Java Bean? | Una clase que solo tiene datos (atributos + constructor + getters/setters). Representa algo del mundo real (Usuario, Libro) |
| ¿Qué es un atributo? | Un dato que describe al objeto (nombre, carnet, rol, etc.) |
| Si hay 100 usuarios, ¿cuántas clases Usuario.java? | 1 sola clase. La clase es el formulario, los objetos son cada formulario lleno |

Resultado: **3/3**

---

## Avance del Proyecto — Fase 2 (Web)

### Completado (20%)

| Tarea | Estado |
|-------|:------:|
| Herramientas instaladas (Java, NetBeans, Tomcat, MySQL, Workbench) | ✓ |
| Entender arquitectura MVC, paquetes, Java Beans | ✓ |
| Proyecto BibliotecaDonBosco creado en NetBeans | ✓ |
| Paquetes modelo, dao, controlador creados | ✓ |
| Usuario.java (Bean de usuario) | ✓ |
| Libro.java (Bean de libro) | ✓ |

### Pendiente

| Tarea | % estimado |
|-------|:----------:|
| Prestamo.java (Bean de préstamo) | 2% |
| ConexionBD.java | 5% |
| 3 DAOs (UsuarioDAO, LibroDAO, PrestamoDAO) | 15% |
| 5 Servlets (Login, Usuario, Libro, Prestamo, Catálogo) | 20% |
| 6-8 JSPs (vistas HTML) | 15% |
| Base de datos en MySQL (crear tablas) | 5% |
| Probar y corregir errores | 10% |
| Documentación para defensa | 8% |

---

## Sesión 27 mayo 2026 — Avance Real

### Completado (27% de la Fase 2)

| Tarea | Estado |
|-------|:------:|
| Herramientas instaladas (Java, NetBeans, Tomcat, MySQL, Workbench) | ✓ |
| Entender arquitectura MVC, paquetes, Java Beans | ✓ |
| Proyecto BibliotecaDonBosco creado en NetBeans | ✓ |
| Paquetes modelo, dao, controlador creados | ✓ |
| Usuario.java (Bean) | ✓ |
| Libro.java (Bean) | ✓ |
| Prestamo.java (Bean) | ✓ |
| JDBC agregado al pom.xml | ✓ |
| Base de datos biblioteca_don_bosco creada | ✓ |
| Tablas usuarios, libros, prestamos creadas en MySQL | ✓ |
| ConexionBD.java explicado (pendiente pegar) | En progreso |

### Pendiente para Próxima Sesión

1. ~~Pegar ConexionBD.java y verificar que conecta~~
2. ~~Crear UsuarioDAO.java (CRUD de usuarios)~~
3. ~~Crear LibroDAO.java (CRUD de libros)~~
4. ~~Crear PrestamoDAO.java (préstamos, devoluciones, mora)~~
5. ~~Crear Servlets (Login, Usuario, Libro, Prestamo, Catálogo)~~
6. ~~Crear vistas JSP~~
7. Probar el sistema completo

---

## Sesión 31 mayo 2026 — Avance Real

### Completado (85% de la Fase 2)

| Tarea | Estado |
|-------|:------:|
| Herramientas instaladas y corriendo | ✓ |
| Proyecto BibliotecaDonBosco creado en NetBeans | ✓ |
| Paquetes modelo, dao, controlador creados | ✓ |
| 3 Beans (Usuario, Libro, Prestamo) | ✓ |
| JDBC en pom.xml | ✓ |
| Base de datos biblioteca_don_bosco + 3 tablas | ✓ |
| Datos de prueba insertados en MySQL | ✓ |
| ConexionBD.java | ✓ |
| 3 DAOs (UsuarioDAO, LibroDAO, PrestamoDAO) | ✓ |
| 5 Servlets (Login, Usuario, Libro, Prestamo, Catálogo) | ✓ |
| 9 JSPs (login, menu, catalogo, usuarios_lista, usuario_form, libros_lista, libro_form, prestamos_lista, prestamo_form) | ✓ |
| Clean and Build exitoso (BUILD SUCCESS, 14 archivos compilados) | ✓ |

### Pendiente (15%)

1. ~~Verificar contraseña de MySQL (root)~~ → Contraseña vacía, OK
2. ~~Probar catálogo público~~ → FUNCIONA (localhost:8080/BibliotecaDonBosco/catalogo)
3. Depurar error de login (ConexionBD + LoginServlet)
4. Probar CRUD de usuarios, libros, préstamos
5. Corregir errores si los hay

### Debugging Login — SOLUCIONADO

- ConexionBD funciona: catálogo muestra los 4 libros de prueba
- LoginServlet recibe datos pero `iniciarSesion` devolvía null
- **Causa 1:** URL de MySQL necesitaba parámetros extra (useSSL, allowPublicKeyRetrieval, serverTimezone)
- **Causa 2:** Carnet en BD era HG235460, el real es HG253460 → corregido con UPDATE

### Pendiente (5%)

1. Probar CRUD completo (usuarios, libros, préstamos, devoluciones)
2. Probar módulo de alumno/profesor (solicitar préstamo, mis préstamos)
3. Empaquetar para entrega

---

## Sesión 31 mayo 2026 — CIERRE DE PROYECTO

### Sistema funcionando en WINDOWS y MAC

El sistema web de Biblioteca Don Bosco funciona en ambas plataformas.
Acceso: `http://localhost:8080/BibliotecaDonBosco/`
- Redirige automáticamente al login
- Login: HG253460 / 1234 (Administrador)
- Catálogo público sin login: `http://localhost:8080/BibliotecaDonBosco/catalogo`

### Migración a Windows Completada

| Componente | Estado |
|------------|:------:|
| JDK, NetBeans, Tomcat | ✓ Ya estaban |
| MySQL 8.4 | ✓ Instalado via winget |
| Base de datos + datos de prueba | ✓ Script ejecutado |
| Proyecto abierto en NetBeans | ✓ |
| Login funcionando | ✓ |
| Catálogo público | ✓ |

---

## CIERRE DEFINITIVO — 31 mayo 2026

### Proyecto completo y funcional (100% de la rúbrica)

El sistema fue probado en Windows completamente. Los 19 ítems del checklist pasaron.
Login, CRUD, préstamos, devoluciones, mora, catálogo público, roles, pool de conexiones.

### Entregables Finales

| Archivo | Ubicación |
|---------|-----------|
| Proyecto completo | `C:\Users\Karla Flores\Desktop\BibliotecaDonBosco\` |
| Archivo .war | `BibliotecaDonBosco\target\BibliotecaDonBosco-1.0-SNAPSHOT.war` |
| Script SQL | `BibliotecaDonBosco\bd_biblioteca.sql` |
| Portada en HTML | `Open Code\materias\POO941\portada-proyecto.html` |
| Guía de defensa | `Open Code\materias\POO941\guia-defensa.txt` |
| Referencias completas | `Open Code\materias\POO941\referencia-herramientas.txt` |

### Datos Finales del Sistema

- **4 Administradores:** Jonathan Hernández (HG253460), Yoselyn Aguilar (AR253073), Jhensen Recinos (RA251889), Rubel Andrade (AC251900)
- **2 Alumnos:** Oscar Martínez (MA365018), Andrea Ramírez (RA129574)
- **1 Profesor:** Ricardo Gómez (GO528630)
- **Todos password:** 1234
- **10 libros:** 2 idiomas, 4 novelas, 3 química, 1 matemática

**Reglas:**
- Alumno: 3 libros máx, 7 días sin recargo
- Profesor: 6 libros máx, 14 días sin recargo
- Mora: $1.10 por día de atraso

### Defensa: 25 posibles preguntas entregadas

### RESULTADO DE DEFENSA — 31 mayo 2026

**Calificación: 9.0**

Único punto perdido: Deploy sin NetBeans. Al cerrar el IDE se cayó la conexión porque Tomcat estaba vinculado a la instancia de NetBeans.
Solución aprendida: copiar el .war a webapps de Tomcat y usar startup.bat.

**Total materia: 100% → Nota final: 8.50**

---

## Mejoras Futuras (para mencionar en defensa)

### Tabla de Configuración

Actualmente los límites están fijos en el código (3 libros alumno, 6 profesor).
La mejora sería una tabla que permita al encargado cambiarlos sin tocar código:

```sql
CREATE TABLE configuracion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    max_prestamos_alumno INT DEFAULT 3,
    max_prestamos_profesor INT DEFAULT 6,
    dias_prestamo_alumno INT DEFAULT 7,
    dias_prestamo_profesor INT DEFAULT 14,
    mora_diaria DECIMAL(10,2) DEFAULT 0.50
);
```

Ventaja: el encargado cambia límites desde el sistema sin tocar Java.
Esto demuestra visión de software mantenible y escalable.

### Otras Mejoras Sugeridas

| Mejora | Descripción |
|--------|-------------|
| Contraseñas con hash | Usar SHA-256 en vez de texto plano (seguridad) |
| Tabla de roles separada | Normalizar roles en tabla aparte con FK |
| Ejemplares individuales | Cada copia física con su propio código de inventario |
| Logs con Log4j | Registrar errores en archivo (ya visto en Unidad 4) |
| Pool de conexiones | Configurar en Tomcat para mejor rendimiento |

### Archivos del Proyecto (14 clases Java + 9 JSPs)

| Capa | Archivos |
|------|----------|
| Modelo | Usuario.java, Libro.java, Prestamo.java |
| DAO | ConexionBD.java, UsuarioDAO.java, LibroDAO.java, PrestamoDAO.java |
| Controlador | LoginServlet.java, UsuarioServlet.java, LibroServlet.java, PrestamoServlet.java, CatalogoServlet.java |
| Vista | login.jsp, menu.jsp, catalogo.jsp, usuarios_lista.jsp, usuario_form.jsp, libros_lista.jsp, libro_form.jsp, prestamos_lista.jsp, prestamo_form.jsp |
| Config | pom.xml (Maven + JDBC) |
| BD | biblioteca_don_bosco (MySQL): tablas usuarios, libros, prestamos |
