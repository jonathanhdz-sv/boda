# Referencia Completa — Proyecto POO Fase 2 (Web)

**Autores:** Yoselyn Aguilar, Jhensen Recinos, Jonathan Hernández, Rubel Andrade

---

## Problemática que Resuelve el Proyecto

### Situación actual (sin sistema): Biblioteca del Colegio Amigos De Don Bosco

- Un profesor busca un libro: la encargada revisa cuadernos viejos, tarda minutos.
- Un alumno pide un préstamo: la encargada anota en papel la fecha. Nadie registra fecha de entrega.
- Un alumno no devuelve el libro en meses: nadie se da cuenta. El libro se perdió. No hay multa ni seguimiento.
- Otro alumno busca ese mismo libro: ya alguien lo tiene pero no se sabe quién. El libro existe pero no está disponible.
- Un padre quiere ver qué libros hay: tiene que ir físicamente a la biblioteca en horario escolar.
- La encargada quiere saber cuántos préstamos hubo en mayo: a contar a mano en los cuadernos. Se equivoca, pierde tiempo.
- Llega un libro nuevo: lo anota en un cuaderno de inventario. Si el cuaderno se moja, se perdió todo.

### Qué resuelve nuestro sistema

- **Encargados con login protegido:** una sola persona administra todo. Registra libros, usuarios, préstamos, calcula moras. Todo digital.
- **Catálogo público sin login:** cualquiera puede buscar libros desde su casa, celular o compu. Sin ir al colegio.
- **Préstamos web:** alumnos y profesores piden libros en línea. El sistema valida si están en mora y el límite de libros permitidos.

En una frase: antes eran cuadernos, papeles perdidos y "no sé quién tiene ese libro". Ahora es todo digital, desde cualquier lugar, en segundos.

---

## Herramientas del Proyecto

- **Java JDK** es el motor que ejecuta todo código Java. Sin él nada funciona.
- **Apache NetBeans IDE** es el editor donde escribes el código. El Word de los programadores Java.
- **Apache Tomcat** es el servidor web que convierte tu código Java Servlets y JSP en páginas HTML que el navegador entiende. Cuando un usuario abre tu página, Tomcat recibe la petición HTTP, ejecuta tu Servlet y devuelve HTML al navegador.
- **MySQL Server** es la base de datos. Guarda usuarios, libros, préstamos. Corre en segundo plano, sin ventana.
- **MySQL Workbench** es la interfaz gráfica para MySQL. Ves las tablas, creas bases de datos con clics.

**Dependencias entre herramientas:** NetBeans escribe código Java y necesita JDK. NetBeans despliega el proyecto y necesita Tomcat. Tu código guarda y consulta datos y necesita MySQL. Workbench conecta a MySQL Server para ver los datos gráficamente.

---

## Dónde se Hace Cada Tarea

La Terminal solo se usa para instalar y encender o apagar servicios. La mayor parte del trabajo se hace en NetBeans.

- Instalar programas se hace en Terminal una sola vez.
- Encender o apagar Tomcat se hace en Terminal con un comando.
- Escribir código Java se hace en NetBeans con ventanas, colores y menús.
- Diseñar páginas HTML o JSP se hace en NetBeans.
- Crear tablas en MySQL se hace en MySQL Workbench con clics, visual.
- Probar la página web se hace en el navegador Chrome o Safari.

Analogía: la Terminal es como la caja de herramientas del mecánico. El motor lo armas en el taller que es NetBeans.

---

## Puertos de la Computadora

La computadora tiene 65,536 "oficinas" llamadas puertos, del 0 al 65535.

| Puerto | Quién vive ahí | Para qué |
|:------:|----------------|----------|
| 8080 | Tomcat | Tus páginas web Java |
| 3306 | MySQL | La base de datos |
| 80 | HTTP | Páginas web normales |
| 443 | HTTPS | Páginas seguras como bancos y correo |

Analogía: `localhost:8080` significa "el edificio soy yo mismo, ve a la oficina 8080 que ahí está Tomcat".

---

## Qué Pasa si Falta Cada Pieza del Proyecto

| Componente | Si falta... | Analogía |
|------------|-------------|----------|
| **Java Bean** | Los datos viajan sueltos, sin orden | Como mandar un paquete sin etiqueta ni dirección |
| **DAO** | Cada Servlet escribe consultas SQL a mano. Código repetido | Como no tener mesero, cada cliente va a la cocina |
| **ConexionBD** | Cada DAO abre y cierra su propia conexión. Con muchos usuarios colapsa | Como que cada persona construye su propia puerta |
| **Servlet Controlador** | Nadie recibe peticiones del navegador. La web no funciona | Como un restaurante sin meseros |
| **JSP Vista** | HTML escrito dentro de Servlets con print. Horrible de mantener | Como pintar un mural con un pincel microscópico |
| **Tomcat** | Los Servlets y JSP no se ejecutan | Como tener un motor sin gasolina ni llaves |

**Regla:** si falta un solo componente, el sistema NO funciona. Son como los órganos del cuerpo.

---

## Flujo MVC (Modelo-Vista-Controlador)

**Orden correcto:** Servlet → DAO → Base de Datos → Servlet → JSP → Navegador

1. El usuario hace clic en "Ver Libros" en el navegador.
2. `LibroServlet` recibe la petición.
3. `LibroServlet` llama a `LibroDAO` para obtener todos.
4. `LibroDAO` ejecuta `SELECT` en MySQL.
5. Devuelve la lista de libros al Servlet.
6. Servlet envía la lista al JSP.
7. El JSP genera una tabla HTML con los datos.
8. El navegador muestra la tabla al usuario.

---

## Java Beans

Un Java Bean es una clase que representa **UNA SOLA COSA** del mundo real. Tiene tres elementos: atributos, constructores y getters con setters.

- **Atributo:** un dato que describe al objeto, como nombre, carnet o rol.
- **Constructor:** método que fabrica objetos nuevos.
- **Getters y Setters:** métodos para leer y modificar cada atributo.

Ejemplo: con una sola clase `Usuario.java` puedo crear cien objetos Usuario como Juan, María o Carlos. La clase es el formulario vacío. Los objetos son cada formulario lleno con datos reales.

---

## DAO (Data Access Object)

El DAO es el empleado que solo habla con MySQL. Separa el código SQL del resto.

- **Sin DAO:** el Servlet escribe SQL directo. Si cambia la BD tocas muchos archivos.
- **Con DAO:** el Servlet solo llama a `usuarioDAO.insertar()`. Si cambia la BD tocas un archivo.

Analogía: el DAO es el mesero que va a la cocina MySQL por ti. Tú como Servlet le dices "tráeme todos los usuarios", él va, ejecuta SQL y te trae la lista.

---

## Excepciones (try-catch)

Exception significa "algo salió mal". Siempre que hables con base de datos, archivos o internet, usa try y catch.

- **try:** voy a intentar hacer esto.
- **catch:** si falla, no truena el programa. Solo digo "no se pudo" y sigo.

Analogía: es como un paracaídas. Si el vuelo va bien no se usa. Si algo falla se abre y salva al programa de estrellarse.

---

## PreparedStatement

PreparedStatement es una consulta SQL segura que usa huecos con signo de interrogación en vez de concatenar texto.

- **Sin PreparedStatement:** hay SQL injection: un hacker escribe `' OR 1=1'` y entra sin password.
- **Con PreparedStatement:** los huecos se rellenan con datos. Cualquier código malicioso se trata como texto.

Analogía: es como un sobre oficial con casilleros. Lo que metas se trata como texto, no como código.

---

## Servlet

El Servlet es el mesero o policía de tránsito. Hace solo tres cosas:

1. **RECIBIR** datos del navegador con `request.getParameter()`.
2. **LLAMAR** al empleado que sabe, que es el DAO.
3. **DECIDIR** qué página mostrar, haciendo forward a un JSP o redirect.

El Servlet **NUNCA** escribe SQL ni HTML complejo. Solo recibe, delega y redirige.

---

## Usuarios: No Confundirlos

Hay **DOS** tipos de usuario en este proyecto:

| Usuario | De quién es | Para qué sirve |
|---------|:-----------:|----------------|
| **admin / admin** (Tomcat) | De Tomcat | Para que NetBeans publique el proyecto en el servidor. Es la llave del cuarto de máquinas. Solo la usa NetBeans |
| **Usuarios de la biblioteca** | De tu sistema | Para que encargados, profesores y alumnos inicien sesión en la página web. Se guardan en MySQL. Los programas tú |

Analogía: en un teatro, admin/admin es la llave del técnico de sonido. Los usuarios de la biblioteca son las entradas del público.

---

## Maven

Maven es un asistente que organiza tu proyecto, baja librerías automático y empaqueta. **NO** es un lenguaje de programación.

- **Sin Maven:** buscas cada librería a mano, copias archivos `.jar` uno por uno, hay desorden.
- **Con Maven:** escribes una línea y él baja, organiza y actualiza todo.

Analogía: Java es el idioma en que escribes el libro. Maven es el editor que imprime, organiza capítulos y compra referencias.

---

## Estructura del Proyecto

**BibliotecaDonBosco** contiene las siguientes carpetas y archivos:

- La carpeta **modelo** contiene los Java Beans: `Usuario.java`, `Libro.java`, `Prestamo.java`.
- La carpeta **dao** contiene el acceso a datos: `ConexionBD.java`, `UsuarioDAO.java`, `LibroDAO.java`, `PrestamoDAO.java`.
- La carpeta **controlador** contiene los Servlets: `LoginServlet`, `UsuarioServlet`, `LibroServlet`, `PrestamoServlet`, `CatalogoServlet`.
- La carpeta **webapp** contiene los JSP: `login.jsp`, `menu.jsp`, `catalogo.jsp`, `usuarios_lista.jsp`, `usuario_form.jsp`, `libros_lista.jsp`, `libro_form.jsp`, `prestamos_lista.jsp`, `prestamo_form.jsp`, `prestamo_solicitar.jsp`, `mis_prestamos.jsp`.
- El archivo **pom.xml** contiene la configuración Maven y las dependencias JDBC, Jakarta EE y Tomcat JDBC Pool.
- El archivo **bd_biblioteca.sql** contiene el script de creación de la base de datos.

---

## Rúbrica de la Fase 2 (30% de la materia)

| Criterio | Peso | Estado |
|----------|:----:|:------:|
| Capa de datos y validaciones web | 10% | ✓ Cumplido con Beans, DAOs, validaciones de sesión, formularios requeridos |
| Lógica de negocio migrada | 40% | ✓ Cumplido con CRUD de usuarios, libros, préstamos, devoluciones y mora |
| IU web atractiva | 20% | ✓ Cumplido con CSS en todos los JSP, logo institucional, diseño responsive |
| Pool de conexiones en Tomcat | 15% | ✓ Cumplido con context.xml, Resource DataSource, máximo 20 conexiones, mínimo 5 |
| Deploy exitoso en Tomcat | 15% | ✓ Cumplido, funciona en Windows y Mac, archivo .war generado |

---

## Mejoras Futuras (para mencionar en defensa)

- Tabla de configuración que permite cambiar límites de préstamos sin tocar código, como máximo de préstamos por alumno, días de préstamo y mora diaria.
- Contraseñas con hash SHA-256 en vez de texto plano.
- Tabla de roles separada para normalizar con llave foránea.
- Ejemplares individuales donde cada copia física tiene su propio código de inventario.
- Logs con Log4j para registrar errores en archivo (visto en Unidad 4).

---

## Datos de Acceso

- **Administrador:** HG253460 / 1234
- **Alumno:** HG00002 / 1234
- **URL:** `http://localhost:8080/BibliotecaDonBosco/`
- **Catálogo público sin login:** `http://localhost:8080/BibliotecaDonBosco/catalogo`
