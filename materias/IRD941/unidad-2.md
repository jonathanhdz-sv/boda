# Universidad Don Bosco — Vicerrectoría de Educación a Distancia — UDB Virtual

## Asignatura: Interconexión de Redes de Datos
## Manual de Contenido: Unidad 2

---

## Introducción de la Unidad

En el diseño e implementación de redes de datos empresariales, la segmentación y la eficiencia en la administración de la infraestructura son pilares fundamentales para garantizar la seguridad, el rendimiento y la escalabilidad. Esta unidad se enfoca en tres tecnologías clave de la capa de enlace de datos y de red: el protocolo **VTP (VLAN Trunking Protocol)**, el enrutamiento entre VLANs (**Inter-VLAN Routing**) y los conceptos avanzados de **enrutamiento estático**. VTP permite centralizar la administración de las redes virtuales (VLANs) a lo largo de un dominio de switches, reduciendo drásticamente los errores de configuración manual. Por su parte, el enrutamiento Inter-VLAN rompe el aislamiento natural de las VLANs, permitiendo la comunicación controlada entre diferentes segmentos mediante el uso de routers (bajo esquemas tradicionales o "Router-on-a-Stick") o switches de Capa 3 (Multicapa). Finalmente, el estudio del enrutamiento estático proporciona los fundamentos para establecer rutas precisas y predecibles en la red, abarcando desde rutas estáticas estándar y por defecto, hasta configuraciones avanzadas de rutas flotantes para tolerancia a fallos.

---

## 1. VLAN Trunking Protocol (VTP)

VTP es un protocolo propietario de Cisco de Capa 2 que se utiliza para administrar la creación, eliminación y modificación de VLANs en un grupo de switches interconectados, manteniendo la consistencia de la base de datos de VLANs en toda la red de forma automática.

### 1.1. Componentes de VTP

- **Dominio VTP:** Consiste en uno o más switches interconectados que comparten el mismo nombre de dominio y la misma configuración de VLANs. Un switch solo puede pertenecer a un dominio VTP a la vez.
- **Publicaciones VTP (Advertisements):** Mensajes enviados por los switches a través de enlaces troncales para distribuir y sincronizar las actualizaciones de la base de datos de VLANs.
- **Número de revisión de configuración:** Un número de 32 bits que indica el nivel de actualización de una publicación VTP. Cada vez que se realiza un cambio de VLAN en un switch servidor, este número incrementa en 1. Los switches solo aceptan actualizaciones si el número de revisión recibido es **mayor** que el que tienen localmente.

### 1.2. Modos de Operación de VTP

Un switch puede configurarse en uno de los siguientes tres modos VTP:

| Modo | Descripción |
|------|-------------|
| **Servidor (Server)** | Es el modo por defecto. Permite crear, modificar y eliminar VLANs. El switch servidor almacena la información en la memoria NVRAM y publica los cambios a los demás switches del dominio. |
| **Cliente (Client)** | No permite crear, modificar ni eliminar VLANs. Recibe y procesa las actualizaciones provenientes de un servidor VTP y reenvía las publicaciones a otros switches. La configuración no se guarda en la NVRAM, por lo que se pierde si el switch se reinicia. |
| **Transparente (Transparent)** | No participa activamente en el dominio VTP. Permite crear, modificar y eliminar VLANs locales, pero estos cambios no se publican a otros switches ni afectan a la red. Sin embargo, un switch en modo transparente reenvía las publicaciones VTP que recibe a través de sus enlaces troncales. |

### 1.3. Poda VTP (VTP Pruning)

Es una función que optimiza el uso del ancho de banda en los enlaces troncales. Evita que el tráfico de inundación (como broadcast o multicast desconocido) se envíe a través de enlaces troncales hacia switches que no tienen puertos asignados a esa VLAN específica.

---

## 2. Enrutamiento Inter-VLAN (Inter-VLAN Routing)

Por diseño, los dispositivos que pertenecen a diferentes VLANs **no pueden** comunicarse entre sí directamente en la Capa 2, incluso si están conectados al mismo switch. Para permitir la comunicación entre VLANs, se requiere un dispositivo que opere en la Capa 3 (un router o un switch multicapa) para realizar el proceso de enrutamiento.

Existen tres métodos principales para implementar el enrutamiento Inter-VLAN:

### 2.1. Enrutamiento Inter-VLAN Tradicional

En este modelo antiguo, se utiliza una interfaz física independiente del router para cada VLAN configurada en la red. Cada interfaz del router se conecta a un puerto del switch configurado en modo acceso para su respectiva VLAN. Este método **no es escalable**, ya que consume rápidamente los puertos físicos tanto del router como del switch a medida que el número de VLANs crece.

### 2.2. Enrutamiento Router-on-a-Stick

Es una solución mucho más eficiente y escalable que el método tradicional. Utiliza **una única interfaz física** del router conectada a un puerto del switch configurado en modo troncal (Trunk).

El funcionamiento se basa en la creación de **subinterfaces virtuales** dentro de la interfaz física del router.

Cada subinterfaz se configura de manera independiente con su propia dirección IP (que actuará como la puerta de enlace predeterminada o Gateway de la VLAN) y se le asigna el ID de VLAN correspondiente utilizando la encapsulación estándar IEEE 802.1Q.

### 2.3. Enrutamiento en Switch de Capa 3 (Multicapa)

Es el método más moderno y de mayor rendimiento para redes empresariales. Los switches de Capa 3 tienen la capacidad de procesar paquetes IP además de tramas de Capa 2.

Se configuran **Interfaces Virtuales de Switch (SVI - Switch Virtual Interfaces)**. Una SVI es una interfaz lógica de Capa 3 asociada a una VLAN específica. Al asignar una dirección IP a la SVI de una VLAN, esta funciona como la puerta de enlace predeterminada para los dispositivos de dicha VLAN.

El enrutamiento se realiza directamente en el hardware del switch (a velocidad de cable), lo que elimina el cuello de botella que puede representar un router externo.

---

## 3. Enrutamiento Estático

El enrutamiento es el proceso mediante el cual un dispositivo de Capa 3 determina la mejor ruta para reenviar un paquete hacia su red de destino. El enrutamiento estático consiste en la configuración manual de las rutas en la tabla de enrutamiento del dispositivo por parte de un administrador de red.

### 3.1. Características del Enrutamiento Estático

**Ventajas:**

- No consume ancho de banda de la red para enviar actualizaciones de enrutamiento.
- Consume menos recursos de CPU y memoria en el router.
- Ofrece una mayor seguridad ya que el administrador controla exactamente qué rutas se conocen.

**Desventajas:**

- No es escalable para redes grandes.
- Requiere una gestión manual compleja.
- No tiene la capacidad de adaptarse automáticamente ante fallos o cambios en la topología de la red.

### 3.2. Tipos de Rutas Estáticas

| Tipo | Descripción |
|------|-------------|
| **Ruta Estática Estándar** | Se utiliza para conectarse a una red remota específica indicando explícitamente la dirección de red destino, la máscara de subred y la dirección del siguiente salto o la interfaz de salida. |
| **Ruta Estática por Defecto (Default Static Route)** | Es una ruta que coincide con todos los paquetes independientemente de su red de destino. Se utiliza cuando no existe una ruta específica en la tabla de enrutamiento para un destino en particular. En IPv4 se representa como `0.0.0.0 0.0.0.0` y en IPv6 como `::/0`. |
| **Ruta Estática Resumida (Summary Static Route)** | Permite combinar múltiples redes de destino contiguas que comparten la misma interfaz de salida o dirección de siguiente salto en una sola ruta estática, reduciendo el tamaño de la tabla de enrutamiento. |
| **Ruta Estática Flotante (Floating Static Route)** | Son rutas estáticas que se configuran como respaldo de otra ruta estática o dinámica. Se les asigna una Distancia Administrativa (AD) **mayor** que la de la ruta principal. La ruta flotante permanece oculta (no aparece en la tabla de enrutamiento) y solo se activa de forma automática si la ruta principal falla. |

### 3.3. Configuración y Parámetros de Próximo Salto

Al configurar una ruta estática, el administrador puede especificar el siguiente destino de tres maneras:

- **Ruta de Siguiente Salto:** Solo se especifica la dirección IP del router vecino. El router local debe realizar una búsqueda recursiva en su tabla de enrutamiento para determinar por qué interfaz debe enviar el paquete.
- **Ruta Directamente Conectada:** Solo se especifica la interfaz de salida local del router. El router asume que el destino está directamente conectado a ese enlace.
- **Ruta Completamente Especificada:** Se configuran tanto la interfaz de salida local como la dirección IP del siguiente salto del router vecino, evitando búsquedas recursivas y optimizando el procesamiento.
