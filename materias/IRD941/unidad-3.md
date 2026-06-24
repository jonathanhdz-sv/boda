# Universidad Don Bosco — Vicerrectoría de Educación a Distancia — UDB Virtual

## Asignatura: Interconexión de Redes de Datos
## Manual de Contenido: Unidad 3
## Tema: Tecnologías de Comunicación WAN

---

## Introducción de la Unidad 3

En la presente unidad se abordarán las temáticas necesarias para comprender el funcionamiento y los conceptos de los diferentes protocolos utilizados a nivel de redes de área amplia (WAN), desde los accesos telefónicos tradicionales hasta los mecanismos avanzados de conmutación de etiquetas.

---

## Clase 9: Protocolo Punto a Punto (PPP - Point-to-Point Protocol)

El protocolo Punto a Punto (PPP) es un protocolo de la capa de enlace de datos (Capa 2) ampliamente utilizado para establecer una conexión directa entre dos nodos de red a través de un enlace físico dedicado.

### Componentes principales de PPP

- **Encapsulación de datagramas:** PPP puede encapsular diferentes protocolos de la capa de red (como IPv4 e IPv6) simultáneamente sobre el mismo enlace físico.

- **LCP (Link Control Protocol - Protocolo de Control de Enlace):** Se encarga de establecer, configurar, probar, mantener y finalizar la conexión del enlace físico. LCP también maneja funciones opcionales como la autenticación de la identidad del extremo remoto, la compresión de datos y la detección de errores en el enlace.

- **NCP (Network Control Protocol - Protocolos de Control de Red):** Es una familia de protocolos encargados de configurar y adaptar los diferentes protocolos de la capa de red que van a viajar sobre el enlace PPP (por ejemplo, IPCP para IPv4 e IPv6CP para IPv6).

### Mecanismos de Autenticación en PPP

| Mecanismo | Descripción | Seguridad |
|-----------|-------------|:---------:|
| **PAP (Password Authentication Protocol)** | Método de autenticación simple de dos vías. El cliente envía su usuario y contraseña en texto plano (sin cifrar) a través del enlace. | Baja |
| **CHAP (Challenge Handshake Authentication Protocol)** | Método seguro de tres vías. No envía contraseñas en texto plano. El servidor envía un mensaje de desafío, el cliente responde utilizando una función de hash (MD5) basada en su contraseña, y el servidor valida el resultado. | Alta |

---

## Clase 10: Protocolo ATM y Frame Relay

Tanto ATM como Frame Relay son tecnologías de conmutación de paquetes y circuitos virtuales utilizadas históricamente por los proveedores de servicios para transportar datos a través de la nube WAN.

### ATM (Asynchronous Transfer Mode - Modo de Transferencia Asíncrona)

Es una tecnología de red de alto rendimiento orientada a conexión.

Su característica principal es que no utiliza paquetes de longitud variable, sino que divide toda la información en contenedores de tamaño fijo llamados **"Celdas"**.

Cada celda ATM tiene un tamaño estricto de **53 bytes** (48 bytes para los datos de usuario y 5 bytes para el encabezado de control). Al tener un tamaño fijo, los switches de hardware pueden procesar las celdas de forma extremadamente rápida y con un retardo predecible, lo que facilita el transporte de voz y video en tiempo real.

### Frame Relay

Es un protocolo WAN de Capa 2 eficiente y orientado a conexión, diseñado para el transporte de datos de longitud variable de una manera más económica que las líneas dedicadas.

- Utiliza **Circuitos Virtuales Permanentes (PVC)** para conectar nodos remotos a través de la infraestructura del proveedor de servicios.
- Identifica cada circuito virtual mediante un número local llamado **DLCI** (Data Link Connection Identifier - Identificador de Conexión de Enlace de Datos).
- A diferencia de tecnologías previas, Frame Relay elimina la mayor parte de la verificación de errores y el control de flujo en los nodos intermedios de la red del proveedor, delegando esa tarea a los dispositivos finales (capas superiores como TCP), lo que reduce drásticamente el retardo en el procesamiento.

---

## Clase 11 y 12: Multiprotocol Label Switching (MPLS) e Implementación

MPLS (Conmutación de Etiquetas Multiprotocolo) es una tecnología avanzada de transporte de datos que unifica y optimiza el envío de tráfico sobre las redes de los proveedores de servicios de Internet (ISP).

### Concepto y Funcionamiento

En una red enrutable tradicional, cada router debe analizar el encabezado IP de Capa 3 de un paquete completo, compararlo con su tabla de enrutamiento y decidir el siguiente salto. Esto se repite en cada router del camino.

MPLS reemplaza este proceso agregando una **"Etiqueta"** de 32 bits de tamaño pequeño entre el encabezado de Capa 2 (Ethernet) y el encabezado de Capa 3 (IP). A esto se le conoce como un protocolo de **Capa 2.5**.

Los routers internos de la red del proveedor (llamados switches de etiquetas o LSR) solo leen la etiqueta adjunta del paquete para reenviarlo por el hardware a velocidad de cable, sin necesidad de inspeccionar el paquete IP interno, lo que acelera enormemente el rendimiento y procesamiento de la red.

### Componentes de una red MPLS

| Componente | Siglas | Descripción |
|------------|--------|-------------|
| **Customer Edge** | CE | Router del cliente final que se conecta a la red del proveedor. No habla MPLS; envía y recibe tráfico IP estándar. |
| **Provider Edge** | PE | Router de entrada a la red MPLS. Recibe el tráfico IP del cliente, le asigna una etiqueta MPLS correspondiente a su destino y lo introduce al núcleo de la red. También retira la etiqueta al entregar tráfico al cliente. |
| **Provider (LSR)** | P | Routers que forman el núcleo (Core) de la red MPLS. Su única función es recibir paquetes etiquetados, conmutar las etiquetas basándose en una tabla y reenviar el paquete rápidamente al siguiente nodo. |

### Beneficios principales de MPLS

- **Soporte Multiprotocolo:** Puede transportar cualquier tipo de tráfico (IPv4, IPv6, Ethernet, ATM) encapsulado bajo las mismas etiquetas.
- **Ingeniería de Tráfico (Traffic Engineering):** Permite a los administradores del ISP dirigir el tráfico por rutas específicas para evitar la saturación de los enlaces primarios.
- **Redes Privadas Virtuales (VPNs de Capa 2 y Capa 3):** Permite aislar y conectar de forma segura múltiples sucursales de un mismo cliente compartiendo la misma infraestructura física del proveedor.

---

## Glosario de Términos Citados en la Unidad 3

- **DCE (Data Circuit-terminating Equipment):** Incluye los dispositivos que se utilizan para ganar acceso a un sistema a través de las líneas de telecomunicaciones. Su función es convertir los datos de usuario del DTE a un formato aceptable para el enlace de transmisión del proveedor de servicios WAN (por ejemplo, modems, multiplexores, CSU/DSU).

- **DTE (Data Terminal Equipment):** El equipo terminal de datos del usuario final o de la red local que se conecta al enlace WAN (por ejemplo, un router corporativo).

- **Frame Relay:** Protocolo que define cómo se direccionan las tramas en una red de paquetes rápidos en función del campo de dirección de la trama, reduciendo al máximo la comprobación de errores en los nodos de la red.

- **MPLS (Multiprotocol Label Switching):** Técnica que unifica la transferencia de diferentes tipos de datos a través de una misma red para superar las limitaciones de velocidad y mejorar el flujo de trabajo de Internet mediante el uso de etiquetas.

- **PPP (Point-to-Point Protocol):** Protocolo de la capa de enlace de datos TCP/IP que se emplea para conectar directamente un sistema informático a otro a través de medios físicos o líneas telefónicas.
