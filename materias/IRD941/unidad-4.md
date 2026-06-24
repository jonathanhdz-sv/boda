# Universidad Don Bosco — Vicerrectoría de Educación a Distancia — UDB Virtual

## Asignatura: Interconexión de Redes de Datos
## Manual de Contenido: Unidad 4
## Tema: Servicios de Red

---

## Introducción de la Unidad 4

En la unidad anterior se realizó la implementación de diferentes propuestas a nivel de capa 3, brindando una mejor conectividad a redes de área amplia, mejor funcionamiento y mayor seguridad mediante soluciones como ATM, Frame Relay y MPLS. A lo largo de la presente unidad se estará profundizando sobre los servicios de red empresarial, los cuales se abordarán más adelante en posteriores asignaturas bajo sistemas operativos propietarios y libres.

Dichos servicios son los que les permiten a las empresas realizar sus tareas laborales en el día a día, siendo el usuario final el que se beneficia consciente o inconscientemente al hacer uso de ellos. Por ejemplo, algunos de los más comunes en su uso diario son: el servicio web, el servicio de correos electrónicos o la mensajería instantánea. Por detrás de estos, deben estar implementados y desplegados otros servicios que no son tan evidentes para un usuario tradicional, como los servicios DNS, DHCP, FTP u otros que se abordarán a lo largo de esta unidad.

---

## Clase 13: Servicios de Red

### 13.1. ¿Qué son los servicios de red?

No se pueden comprender los detalles técnicos de Internet sin conocer los servicios que se ofrecen. Gran parte de la discusión sobre los servicios se centra en los llamados protocolos de red, que especifican la forma en cómo enviar y recibir mensajes, detallan su formato y describen cómo manejar las condiciones de error. Más importante aún, nos permiten definir estándares de comunicación.

La mayoría de los servicios proporcionados por las redes de comunicación informática se basan en el modelo **cliente/servidor**. Esto radica en que los servicios se pueden prestar si existe al menos una computadora en la red que actúe como servidor y se encargue de atender las solicitudes entrantes; otras computadoras en la red, a su vez, actúan como clientes y envían solicitudes al servidor para su procesamiento.

En una red de comunicación, el servicio más importante es el intercambio de información entre los diferentes dispositivos interconectados. Sin embargo, para que esto sea posible, se pueden requerir otros servicios complementarios que proporcionen la funcionalidad o el soporte necesario para permitirle a la red trabajar de manera correcta.

### 13.2. Servicios de alto nivel

Los servicios de alto nivel incluyen aquellos solicitados directamente por los usuarios o clientes. Mientras que en una red telefónica el servicio básico es enviar voz o un mensaje de texto, en las redes informáticas los usuarios desean intercambiar mensajes, archivos, videos, etc. Algunos de los servicios de alto nivel más importantes que una red ofrece actualmente son:

- Transferencia de Ficheros (FTP)
- Correo electrónico y mensajería instantánea
- Conexiones remotas a equipos
- Servicio web de páginas de hipertexto (HTTP/HTTPS)

### 13.2.1. Servicio de transferencia de ficheros (FTP)

El intercambio de archivos dentro de una red es una de las operaciones más frecuentes que los usuarios realizan de forma rutinaria. Las operaciones básicas que se pueden realizar con un archivo son transferir, leer, escribir y borrar de una máquina a otra. Un usuario de la red debe estar completamente identificado con sus parámetros de autenticación (nombre y contraseña) y tener los privilegios necesarios.

Trabajar con archivos en una red implica tres elementos básicos:

- **Editor de archivos:** Permite a los usuarios implementar las operaciones con los archivos. Requiere tener configurados previamente los servicios de la capa de transporte.
- **Sistema de archivos local:** Se ejecuta en la computadora donde el usuario está trabajando y debe poder interpretar el contenido de los archivos manipulados.
- **Sistema de archivos remotos:** Es el lugar donde residen todos los archivos a los que desea acceder (servidor). Este dispositivo es el responsable de las comprobaciones de autenticación y autorización de los clientes.

El protocolo FTP fue introducido originalmente en la arquitectura de redes TCP/IP y utilizado inicialmente en la red ARPANET antes de que TCP/IP fuera operacional, evolucionando hasta el estándar que conocemos hoy en día.

### 13.2.2. Correo electrónico y mensajería instantánea

El servicio de correo electrónico o email consiste en enviar y recibir mensajes de texto junto con archivos adjuntos desde un usuario de origen a otro de destino. Se puede conceptualizar como un sistema de transferencia de archivos, pero se distingue por características únicas:

- Se pueden enviar mensajes a un grupo de usuarios al mismo tiempo.
- La información de la cabecera está bien estructurada e incluye: nombres y direcciones del remitente y destinatario, fecha y hora de transmisión. El formato de dirección suele ser `nombredeusuario@nombredeequipo.dominio`.
- Facilidad de uso, ya que todo el programa de correo está integrado en una sola aplicación.

Por otra parte, los servicios de mensajería instantánea difieren del correo electrónico en que los usuarios deben estar "en línea" para recibir los mensajes. Hoy en día existen muchos sistemas operando a través de Internet, tales como WhatsApp, Telegram o Google Chat.

### 13.2.3. Conexiones remotas

Las herramientas de administración remota permiten operar y administrar un sistema a distancia en un equipo que puede estar ubicado geográficamente en cualquier parte del mundo, lo cual es imprescindible para los administradores que brindan soporte. Estas operaciones se realizan a través de la red de Internet, por lo que se deben evaluar aspectos de seguridad para generar un enlace de confianza entre el servidor y la computadora del administrador.

Para brindar este servicio se utilizan diferentes tipos de protocolos:

| Protocolo | Descripción |
|-----------|-------------|
| **RDP** (Remote Desktop Protocol) | Permite la conexión entre un cliente y un servidor Windows. Es propiedad de Microsoft. |
| **SSH** (Secure Shell) | Permite el acceso remoto por medio de un canal seguro y cifrado, permitiendo también la transferencia segura de documentos. |
| **ICA** (Citrix Independent Computing Architecture) | Diseñado por Citrix, permite la conexión y transferencia de archivos entre cliente y servidor. |

### 13.2.4. Servicio web

Cuando un cliente escribe la dirección de una página web en un navegador o hace clic en un hipervínculo, el servidor recibe una solicitud a través del protocolo TCP sobre el puerto 80 solicitando una página específica. El protocolo para generar (lado del cliente) o recibir (lado del servidor) respuestas se llama Protocolo de Transferencia de Hipertexto (HTTP).

Actualmente se utiliza principalmente su versión segura conocida como **HTTPS** (Hypertext Transfer Protocol Secure) para transmitir datos entre navegadores y sitios web. HTTPS está encriptado para aumentar la seguridad, lo cual es especialmente importante cuando se envía información confidencial como inicios de sesión bancarios, correos o datos médicos. Los navegadores modernos marcan los sitios web sin HTTPS como inseguros y muestran un candado en la barra de URL cuando la conexión sí es segura.

### 13.3. Servicios de bajo nivel

Para que una red pueda ofrecer servicios de alto nivel a los usuarios, necesita de una compleja infraestructura que en la mayoría de los casos queda oculta. Esta infraestructura incluye una serie de programas y servicios que realizan tareas más simples (comprobación de que el equipo destino está listo, selección de la mejor ruta, división de la información en fragmentos, comprobación de errores, etc.).

Las redes informáticas utilizan principalmente dos servicios de bajo nivel esenciales que admiten a los de nivel superior:

- **DHCP (Protocolo de configuración dinámica de host):** Se utiliza para facilitar la configuración automática de la computadora para que los usuarios no tengan que configurar manualmente parámetros de red como la dirección IP.
- **DNS (Sistema de nombres de dominio):** Se usa para ocultar los esquemas de direccionamiento IP de Internet, facilitando a los usuarios el acceso mediante nombres de computadoras en lugar de números.

---

## Clase 14: Implementación de Servicio DHCP

### 14.1. Subneteo de Red

Para realizar una simulación práctica en Packet Tracer, se divide una red clase C en 3 subredes diferentes utilizando VLSM: una red para Servidores (5 hosts requeridos), una Red A (29 hosts requeridos) y una Red B (63 hosts requeridos).

### 14.2. Interconexión de red e implementación

La topología se interconecta en el simulador utilizando las siguientes interfaces del router:

- **Interfaz fa0/0:** Conectada a la Red A (subred `192.168.10.128/27`)
- **Interfaz fa0/1:** Conectada a la Red B (subred `192.168.10.0/25`)
- **Interfaz fa1/0:** Conectada a la red de Servidores (subred `192.168.10.160/29`)

### 14.3. Configuración de la simulación

Se configuran los Gateways en el router ingresando los siguientes comandos en la CLI:

```
enable
configure terminal
interface fa0/0
ip address 192.168.10.129 255.255.255.224
no shut
exit
interface fa0/1
ip address 192.168.10.1 255.255.255.128
no shut
exit
interface fa1/0
ip address 192.168.10.161 255.255.255.248
no shut
exit
```

Luego, en el servidor DHCP (ubicado en la red de servidores), se configura manualmente una IP estática (por ejemplo, `192.168.10.162`) desde la opción "IP Configuration" en la pestaña Desktop.

Posteriormente, en la pestaña "Services", dentro de la opción DHCP, se crean los grupos de asignación (pools) para cada red:

- **Pool para Red A:** Se configuran los parámetros correspondientes y se añade.
- **Pool para Red B:** Se configuran los parámetros correspondientes y se añade.

**Redirección de solicitudes (IP Helper):**

Dado que las solicitudes DHCP de los clientes son mensajes de difusión (broadcast) y los routers no los reenvían por defecto, se debe configurar el comando `ip helper-address` en las interfaces del router que reciben las solicitudes, apuntando hacia la IP del servidor DHCP:

```
interface fa0/0
ip helper-address 192.168.10.162
exit
interface fa0/1
ip helper-address 192.168.10.162
exit
```

Finalmente, al ingresar a las PCs clientes en "IP Configuration" y seleccionar la opción "DHCP", estas obtienen automáticamente todos sus parámetros de red de manera exitosa.

---

## Clase 15: Implementación de Servicio DNS

### 15.1. Configuración de simulación

Se añade un segundo servidor a la red de servidores destinado a la resolución de nombres (Servidor DNS), asignándole la configuración IP estática correspondiente (por ejemplo, la IP `192.168.10.163`).

Para configurar el servicio, se ingresa a la pestaña "Services" del servidor, opción "DNS" y se siguen estos pasos:

1. Asegurar que el servicio esté encendido ("DNS Service: On").
2. Crear un primer registro o puntero de tipo A (A Record) para identificar al servidor DHCP: **Name:** `dhcp_server`, **Address:** `192.168.10.162`. Se da clic en "Add".
3. Crear un segundo puntero de tipo A para registrar al propio servidor DNS: **Name:** `dns_server`, **Address:** `192.168.10.163`.

### 15.2. Comprobación del funcionamiento

Desde el Command Prompt de cualquier PC cliente, se puede verificar la conectividad mediante un comando `ping` hacia el servidor DNS. Una vez confirmada, se utiliza el comando `nslookup`. Al escribir los nombres registrados (`dhcp_server` o `dns_server`), el servidor DNS resolverá la solicitud entregando la dirección IP exacta de cada dispositivo, confirmando que funciona de manera correcta.

---

## Clase 16: Implementación de Servidor Web

### 16.1. Configuración de simulación

Se integra un tercer servidor a la red de servidores con la dirección IP estática `192.168.10.164`, el cual desempeñará el rol de Servidor Web.

Para que los usuarios puedan buscarlo mediante un nombre de dominio amigable en lugar de su dirección IP, se añade un nuevo puntero de Tipo A dentro del Servidor DNS con los siguientes datos:

- **Name:** `www.prueba.com`
- **Address:** `192.168.10.164`

De esta forma, el DNS contará con tres registros mapeados.

**Configuración del contenido web:**

En el Servidor Web, se ingresa a la pestaña "Services" y se selecciona la opción "HTTP". Se eliminan todos los archivos HTML cargados por defecto, conservando únicamente el archivo llamado `index.html`. Se da clic en "Edit" sobre `index.html` para modificar el código HTML por defecto, reemplazándolo por el diseño de página propio de la práctica.

### 16.2. Prueba final de visualización

Desde una PC cliente, se abre la aplicación "Web Browser" en la pestaña Desktop. En la barra de direcciones se escribe el nombre de dominio `www.prueba.com` y se presiona Enter. El navegador enviará la consulta, el DNS resolverá el nombre a la IP `192.168.10.164`, y la pantalla mostrará correctamente la página web que fue editada en el servidor.

---

## Glosario de Términos Citados en la Unidad 4

- **Conexiones Remotas:** Conexión a distancia entre dos o más equipos, donde uno de ellos permite acceder al otro como si se estuviese trabajando directamente en frente de este, mediante el empleo de un software de acceso remoto a través de una red o Internet.

- **Protocolo HTTP:** Protocolo de comunicación (Hypertext Transfer Protocol) que permite las transferencias de información a través de archivos (XHTML, HTML...) en la World Wide Web.

- **Protocolo HTTPS:** Protocolo seguro de transferencia de hipertexto destinado a la transferencia segura de datos de hipertexto mediante encriptación; es decir, es la versión segura de HTTP.

- **Servidor DNS:** Sistema de nomenclatura jerárquico descentralizado para dispositivos conectados a redes IP (como Internet o redes privadas) que asocia información variada con nombres de dominio asignados a los participantes.

- **Servidor DHCP:** Protocolo de red de tipo cliente/servidor mediante el cual un servidor asigna dinámicamente una dirección IP y otros parámetros de configuración a cada dispositivo de una red para que puedan comunicarse. Posee una lista de direcciones dinámicas y las asigna conforme quedan libres, sabiendo a quién le correspondió, por cuánto tiempo y a quién se le asignó después.

- **Servidor FTP:** Protocolo de transferencia de archivos basado en la arquitectura cliente-servidor que opera en una red TCP, permitiendo que un equipo cliente se conecte a un servidor para descargar o enviar archivos de forma independiente al sistema operativo.
