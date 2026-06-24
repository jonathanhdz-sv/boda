# Universidad Don Bosco — Vicerrectoría de Educación a Distancia — UDB Virtual

## Asignatura: Interconexión de Redes de Datos
## Manual de Contenido: Unidad 5
## Tema: Protocolo IPv6

---

## Introducción de la Unidad 5

El protocolo IPv6 (Internet Protocol Version 6) representa la evolución tecnológica diseñada para resolver la limitación fundamental de su predecesor, IPv4: el agotamiento de las direcciones de red disponibles a nivel global. Con un espacio de direccionamiento expandido a 128 bits, IPv6 no solo asegura la viabilidad a largo plazo del crecimiento de Internet y el despliegue masivo de tecnologías como el Internet de las Cosas (IoT), sino que también introduce mejoras estructurales significativas. Entre estas destacan la simplificación del encabezado del paquete para optimizar el enrutamiento, el soporte nativo para la autoconfiguración de dispositivos sin necesidad de servidores DHCP (Stateless Address Autoconfiguration - SLAAC) y la integración mandatoria de mecanismos de seguridad como IPsec. Comprender la arquitectura de IPv6, sus tipologías de direccionamiento (Unicast, Multicast y Anycast) y las estrategias de transición desde entornos IPv4 es fundamental para el diseño, implementación y administración de las infraestructuras de red contemporáneas y futuras.

---

## 1. Diferencias de las Cabeceras de IPv4 e IPv6

Una de las principales mejoras de IPv6 sobre IPv4 es la simplificación de su cabecera. Aunque las direcciones IPv6 son cuatro veces más grandes que las de IPv4, la cabecera base de IPv6 tiene un tamaño fijo de **40 bytes**, mientras que la de IPv4 es variable (mínimo 20 bytes). Se eliminaron varios campos de la cabecera IPv4 para acelerar el procesamiento de los paquetes en los routers.

### Campos eliminados o modificados en IPv6:

- **Longitud de cabecera de Internet (IHL):** Eliminado porque la cabecera IPv6 siempre tiene un tamaño fijo.
- **Identificación, Flags y Fragment Offset:** Eliminados de la cabecera base. En IPv6, los routers ya no fragmentan los paquetes; la fragmentación es responsabilidad exclusiva del host de origen y se maneja mediante cabeceras de extensión opcionales.
- **Checksum (Suma de comprobación):** Eliminado de la cabecera para mejorar la velocidad de procesamiento. Se delega la verificación de errores a las capas superiores (Capa de transporte como TCP/UDP) y a la Capa de enlace de datos.

### 1.1. Reglas de escritura de direcciones IPv6

Las direcciones IPv6 tienen un tamaño de 128 bits y se escriben en formato hexadecimal, divididas en ocho grupos de 16 bits cada uno (llamados hextetos), separados por dos puntos (`:`). Cada hexteto se representa con cuatro dígitos hexadecimales.

**Ejemplo de una dirección IPv6 completa:**

```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

Para simplificar la escritura de estas direcciones, existen dos reglas fundamentales de compresión:

**Regla 1: Omisión de ceros iniciales**

En cualquier grupo de cuatro dígitos hexadecimales (hexteto), los ceros que se encuentran a la izquierda se pueden omitir. Los ceros a la derecha o los que están en medio no se pueden eliminar.

- Dirección original: `2001:0db8:000a:0000:0100:0000:0000:0001`
- Dirección simplificada: `2001:db8:a:0:100:0:0:1`

**Regla 2: Reducción de dobles dos puntos (`::`)**

Una secuencia continua de uno o más hextetos compuestos exclusivamente por ceros (0000) puede ser reemplazada por un único doble dos puntos (`::`). Esta regla **solo se puede aplicar una sola vez** en una dirección IPv6 para evitar ambigüedades al reconstruir los 128 bits.

- Dirección original: `2001:0db8:0000:0000:0000:0000:1428:57ab`
- Paso 1 (Ceros iniciales): `2001:db8:0:0:0:0:1428:57ab`
- Paso 2 (Doble dos puntos): `2001:db8::1428:57ab`

### 1.2. Tipos de direcciones IPv6

A diferencia de IPv4, en IPv6 **no existe el concepto de direcciones de Broadcast** (difusión amplia). En su lugar, las funciones de broadcast son asumidas por direcciones Multicast específicas. Los tres tipos principales de direcciones IPv6 son:

**Unicast (Unidifusión):**

Identifica de forma única a una sola interfaz. Un paquete enviado a una dirección unicast se entrega exclusivamente a la interfaz que tiene asignada dicha dirección. Las direcciones unicast más comunes son:

- **Dirección de Enlace Local (Link-Local):** Válidas únicamente dentro de un mismo segmento de red física o dominio de broadcast. Los routers no reenvían paquetes que tengan estas direcciones como origen o destino. Siempre comienzan con el prefijo `fe80::/10`.
- **Dirección Unicast Global (GUA):** Equivalentes a las direcciones IPv4 públicas. Son globalmente únicas y enrutables en todo el Internet de IPv6. El rango asignado actualmente comienza con el prefijo `2000::/3`.
- **Dirección de Loopback:** Se utiliza para que un nodo se envíe paquetes a sí mismo para pruebas de la pila de protocolos. Se representa como `::1/128`.
- **Dirección Indefinida (Unspecified):** Se compone totalmente de ceros y se representa como `::/128`. Indica la ausencia de una dirección.

**Multicast (Multidifusión):**

Identifica a un grupo de interfaces que pertenecen a diferentes nodos. Un paquete enviado a una dirección multicast se entrega a todos los dispositivos que se han unido a ese grupo específico. Siempre comienzan con el prefijo `ff00::/8`.

Ejemplos comunes de multicast:

- `ff02::1`: Todos los nodos del enlace local.
- `ff02::2`: Todos los routers del enlace local.

**Anycast (Cualquier difusión):**

Es una dirección asignada a un conjunto de interfaces que generalmente pertenecen a nodos diferentes. Un paquete enviado a una dirección anycast se enruta al dispositivo **más cercano** que tenga asignada esa dirección, basándose en las métricas del protocolo de enrutamiento. No tienen un prefijo especial.

### 1.3. Campos de la Cabecera IPv6

La cabecera base de IPv6 consta de los siguientes campos fijos (40 bytes):

| Campo | Tamaño | Descripción |
|-------|:------:|-------------|
| **Version** | 4 bits | Identifica la versión del protocolo IP (valor 6). |
| **Clase de Tráfico** | 8 bits | Equivalente al campo Tipo de Servicio (ToS) de IPv4. Se utiliza para QoS y priorización de paquetes. |
| **Etiqueta de Flujo (Flow Label)** | 20 bits | Campo nuevo en IPv6. Informa a los routers que determinados paquetes pertenecen a un flujo de datos específico (como voz o video en tiempo real) para que se manejen por la misma ruta sin reordenamiento. |
| **Longitud de la carga útil (Payload Length)** | 16 bits | Indica el tamaño en bytes de los datos que siguen a la cabecera base de IPv6, incluyendo las cabeceras de extensión opcionales. |
| **Siguiente Cabecera (Next Header)** | 8 bits | Equivalente al campo Protocolo de IPv4. Indica el tipo de cabecera que sigue a la cabecera IPv6 (TCP, UDP o una cabecera de extensión IPv6). |
| **Límite de Saltos (Hop Limit)** | 8 bits | Equivalente al campo TTL de IPv4. Decrece en 1 por cada router. Si llega a cero, el paquete se descarta para evitar bucles infinitos. |
| **Dirección de Origen** | 128 bits | Identifica la dirección IPv6 del host emisor. |
| **Dirección de Destino** | 128 bits | Identifica la dirección IPv6 del host receptor final. |

---

## 2. Confirmación de Host (ICMPv6)

Al igual que en IPv4, el Protocolo de Mensajes de Control de Internet (ICMP) es fundamental para diagnosticar problemas de red, confirmar la disponibilidad de un host y reportar errores. En IPv6, este protocolo se actualiza a **ICMPv6** e integra funciones adicionales que antes dependían de protocolos externos.

Los mensajes de error más comunes reportados por ICMPv6 son:

### 2.1. Destino o Servicio Inaccesible

Informa al host de origen que el paquete no pudo entregarse debido a que la red, el host o el puerto de destino no están disponibles, o porque el tráfico está bloqueado por un firewall.

### 2.2. Tiempo Superado

Se envía cuando el campo Límite de Saltos (Hop Limit) de un paquete llega a cero en un router, lo que impide que el paquete continúe su viaje.

### 2.3. Redireccionamiento de Ruta

Un router lo utiliza para informar a un host local que existe un router alternativo en el mismo segmento que ofrece una ruta más corta o eficiente para llegar a un destino específico.

### 2.4. Nuevos Protocolos Manejados Mediante ICMPv6 (Protocolo ND)

ICMPv6 incluye el protocolo de **Descubrimiento de Vecinos (Neighbor Discovery - ND)**, que asume las funciones de resolución de direcciones (que en IPv4 hacía ARP) y autoconfiguración. Utiliza cinco tipos de mensajes:

| Mensaje | Siglas | Descripción |
|---------|--------|-------------|
| **Solicitud de Router** | RS | Enviado por los hosts para localizar routers IPv6 en el enlace local. |
| **Anuncio de Router** | RA | Enviado por los routers de manera periódica o en respuesta a un mensaje RS para proveer prefijos de red y opciones de configuración a los hosts. |
| **Solicitud de Vecino** | NS | Utilizado para determinar la dirección de capa de enlace (MAC) de un vecino o para verificar si un vecino aún es accesible. |
| **Anuncio de Vecino** | NA | Enviado en respuesta a un mensaje NS para notificar la dirección MAC correspondiente. |
| **Redirección** | Redirect | Utilizado por los routers para indicar un mejor siguiente salto. |

### 2.5. Comando de Pruebas

Las herramientas estándar para verificar la conectividad en IPv6 son:

- **Ping:** Envía mensajes de solicitud de eco (Echo Request) y espera mensajes de respuesta de eco (Echo Reply) de ICMPv6 para verificar que un nodo remoto esté activo.
- **Traceroute / Tracert:** Utiliza mensajes de tiempo superado para mapear de forma secuencial cada uno de los routers (saltos) en el camino hacia un destino.

---

## 3. Configuración Stateless y Stateful

Un dispositivo final puede obtener de manera dinámica su Dirección Unicast Global (GUA) mediante dos enfoques de configuración primarios:

### 3.1. SLAAC (Stateless Address Autoconfiguration - Sin Estado)

Es un método autónomo que permite a un dispositivo configurarse a sí mismo sin la necesidad de un servidor DHCPv6.

El proceso:

1. El dispositivo envía un mensaje RS.
2. El router local responde con un mensaje RA que incluye el prefijo de red local (64 bits).
3. El dispositivo toma el prefijo recibido y genera de forma autónoma sus propios 64 bits restantes (Identificador de Interfaz) para completar la dirección de 128 bits, ya sea mediante el método EUI-64 modificado (basado en la dirección MAC) o por generación aleatoria.

### 3.2. DHCPv6 Operación e Implementación

Cuando se requiere un control centralizado de los direccionamientos, se implementa DHCPv6. Este opera bajo dos modalidades basadas en los flags contenidos en los anuncios de router (RA):

**DHCPv6 sin estado (Stateless):**

El dispositivo usa SLAAC para obtener su dirección IP y la puerta de enlace predeterminada desde el mensaje RA del router, pero recurre a un servidor DHCPv6 exclusivamente para obtener parámetros de red complementarios, como la dirección del servidor DNS y el nombre de dominio de la organización.

**DHCPv6 con estado (Stateful):**

El router a través de los flags del mensaje RA le indica al dispositivo que **no** genere su IP autónomamente. El host realiza una solicitud directa al servidor DHCPv6 para que este le asigne tanto una dirección IPv6 disponible de su pool como todos los demás parámetros requeridos (DNS, puerta de enlace, etc.). El servidor mantiene un registro o estado de qué IP ha sido rentada a cada cliente.

---

## Glosario de Términos Citados en la Unidad 5

- **Anycast:** Dirección de red asignada a más de una interfaz (normalmente en nodos diferentes). Un paquete enviado a una dirección anycast se enruta al dispositivo más cercano que tenga asignada esa dirección.

- **EUI-64:** Formato estandarizado de 64 bits que permite a un host generar automáticamente su identificador de interfaz IPv6 expandiendo su dirección MAC física de 48 bits mediante la inserción del valor hexadecimal `FFFE` en medio de esta.

- **Firewall:** Dispositivo de seguridad de red (hardware o software) diseñado para bloquear el acceso no autorizado, permitiendo al mismo tiempo comunicaciones autorizadas.

- **IDS (Intrusion Detection System):** Programa de detección de accesos no autorizados a un computador o a una red informática.

- **IPS (Intrusion Prevention System):** Software que ejerce el control de acceso en una red informática para proteger a los sistemas computacionales de ataques y abusos en tiempo real de manera activa.

- **ICMPv6:** Versión actualizada del Protocolo de Mensajes de Control de Internet para IPv6 que se encarga de la gestión de errores, funciones de diagnóstico y el descubrimiento de vecinos en la red.

- **Multicast:** Tipo de direccionamiento donde los datos se envían desde un único origen hacia un grupo específico de dispositivos de destino de forma simultánea.

- **SLAAC:** Protocolo que permite a los dispositivos de una red IPv6 configurar su propia dirección IP de forma totalmente automática y sin estado, a partir de la información enviada por los routers locales.

- **Unicast:** Tipo de comunicación de red tradicional donde los paquetes se envían desde un único emisor hacia un único receptor perfectamente identificado.
