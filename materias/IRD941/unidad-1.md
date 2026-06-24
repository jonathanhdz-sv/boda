# Universidad Don Bosco — Vicerrectoría de Educación a Distancia — UDB Virtual

## Asignatura: Interconexión de Redes de Datos
## Manual de Contenido: Unidad 1

---

## Introducción de la Unidad

El protocolo IPv6 (Internet Protocol Version 6) representa la evolución tecnológica diseñada para resolver la limitación fundamental de su predecesor, IPv4: el agotamiento de las direcciones de red disponibles a nivel global. Con un espacio de direccionamiento expandido a 128 bits, IPv6 no solo asegura la viabilidad a largo plazo del crecimiento de Internet y el despliegue masivo de tecnologías como el Internet de las Cosas (IoT), sino que también introduce mejoras estructurales significativas. Entre estas destacan la simplificación del encabezado del paquete para optimizar el enrutamiento, el soporte nativo para la autoconfiguración de dispositivos sin necesidad de servidores DHCP (Stateless Address Autoconfiguration - SLAAC) y la integración mandatoria de mecanismos de seguridad como IPsec. Comprender la arquitectura de IPv6, sus tipologías de direccionamiento (Unicast, Multicast y Anycast) y las estrategias de transición desde entornos IPv4 es fundamental para el diseño, implementación y administración de las infraestructuras de red contemporáneas y futuras.

---

## 1. Direccionamiento IPv6

Las direcciones IPv6 tienen un tamaño de 128 bits y se escriben en formato hexadecimal, divididas en ocho grupos de 16 bits cada uno (llamados hextetos), separados por dos puntos (`:`). Cada hexteto se representa con cuatro dígitos hexadecimales.

**Ejemplo de una dirección IPv6 completa:**

```
2001:0db8:85a3:0000:0000:8a2e:0370:7334
```

Para simplificar la escritura de estas direcciones, existen dos reglas fundamentales de compresión:

### Regla 1: Omisión de ceros iniciales

En cualquier grupo de cuatro dígitos hexadecimales (hexteto), los ceros que se encuentran a la izquierda se pueden omitir. Los ceros a la derecha o los que están en medio no se pueden eliminar.

**Ejemplo aplicando la regla 1:**

- Dirección original: `2001:0db8:000a:0000:0100:0000:0000:0001`
- Dirección simplificada: `2001:db8:a:0:100:0:0:1`

### Regla 2: Reducción de dobles dos puntos (`::`)

Una secuencia continua de uno o más hextetos compuestos exclusivamente por ceros (0000) puede ser reemplazada por un único doble dos puntos (`::`). Esta regla **solo se puede aplicar una sola vez** en una dirección IPv6 para evitar ambigüedades al reconstruir los 128 bits.

**Ejemplo aplicando ambas reglas:**

- Dirección original: `2001:0db8:0000:0000:0000:0000:1428:57ab`
- Paso 1 (Ceros iniciales): `2001:db8:0:0:0:0:1428:57ab`
- Paso 2 (Doble dos puntos): `2001:db8::1428:57ab`

---

## 2. Estructura de la Dirección IPv6

Una dirección IPv6 se divide típicamente en dos partes principales de 64 bits cada una:

### Prefijo de red (64 bits)

Equivale a la porción de red en IPv4. Generalmente se subdivide en:

- **Prefijo de enrutamiento global** (normalmente los primeros 48 bits): Asignado por el proveedor de servicios de Internet (ISP) a una organización.
- **ID de subred** (los siguientes 16 bits): Utilizado por la organización interna para crear sus propios segmentos de red.

### Identificador de interfaz (64 bits)

Equivale a la porción de host en IPv4. Identifica de manera única a una interfaz específica en un enlace. Puede ser configurado estáticamente, generado de forma aleatoria por el sistema operativo, o derivado automáticamente del hardware usando el método EUI-64.

---

## 3. Tipos de Direcciones IPv6

A diferencia de IPv4, en IPv6 **no existe el concepto de direcciones de Broadcast** (difusión amplia). En su lugar, las funciones de broadcast son asumidas por direcciones Multicast específicas. Los tres tipos principales de direcciones IPv6 son:

### 3.1. Unicast (Unidifusión)

Identifica de forma única a una sola interfaz. Un paquete enviado a una dirección unicast se entrega exclusivamente a la interfaz que tiene asignada dicha dirección. Las direcciones unicast más comunes son:

- **Dirección de Enlace Local (Link-Local):**
  Son válidas únicamente dentro de un mismo segmento de red física o dominio de broadcast. Los routers no reenvían paquetes que tengan estas direcciones como origen o destino. Siempre comienzan con el prefijo `fe80::/10`. Se utilizan para protocolos de enrutamiento y autoconfiguración de red.

- **Dirección Unicast Global (GUA - Global Unicast Address):**
  Son el equivalente a las direcciones IPv4 públicas. Son globalmente únicas y enrutables en todo el Internet de IPv6. Actualmente, el rango asignado por la IANA para estas direcciones comienza con el prefijo `2000::/3`.

- **Dirección de Loopback (Bucle local):**
  Se utiliza para que un nodo se envíe paquetes a sí mismo para pruebas de la pila de protocolos. Se representa como `::1/128`.

- **Dirección Indefinida (Unspecified):**
  Se compone totalmente de ceros y se representa como `::/128`. Indica la ausencia de una dirección y se usa habitualmente como dirección de origen cuando un dispositivo aún no ha obtenido una dirección IP válida.

### 3.2. Multicast (Multidifusión)

Identifica a un grupo de interfaces que pertenecen a diferentes nodos. Un paquete enviado a una dirección multicast se entrega a todos los dispositivos que se han unido a ese grupo específico. Siempre comienzan con el prefijo `ff00::/8`.

**Ejemplos comunes de multicast:**

- `ff02::1`: Todos los nodos del enlace local.
- `ff02::2`: Todos los routers del enlace local.

### 3.3. Anycast (Cualquier difusión)

Es una dirección asignada a un conjunto de interfaces que generalmente pertenecen a nodos diferentes. Un paquete enviado a una dirección anycast se enruta al dispositivo **más cercano** que tenga asignada esa dirección, basándose en las métricas del protocolo de enrutamiento. No tienen un prefijo especial; se configuran usando el mismo rango que las direcciones unicast globales.

---

## 4. Asignación Dinámica de Direcciones IPv6 GUA

Un dispositivo final puede obtener de manera dinámica su Dirección Unicast Global (GUA) mediante dos métodos principales que interactúan con los routers de la red:

### 4.1. SLAAC (Stateless Address Autoconfiguration)

Es un método autónomo que permite a un dispositivo configurarse a sí mismo sin la necesidad de un servidor DHCPv6.

El proceso funciona de la siguiente manera:

1. El dispositivo envía un mensaje de **Solicitud de Router** (RS - Router Solicitation) usando multicast para buscar routers en el segmento.
2. Los routers responden con un mensaje de **Anuncio de Router** (RA - Router Advertisement), el cual incluye el prefijo de red local (64 bits), la longitud del prefijo y la dirección de la puerta de enlace predeterminada.
3. El dispositivo toma el prefijo recibido del router y genera de forma autónoma sus propios 64 bits restantes (Identificador de Interfaz) para completar la dirección de 128 bits.

Para generar el identificador de interfaz en SLAAC, el dispositivo puede usar dos técnicas:

- **EUI-64 modificado:** Utiliza la dirección MAC física del dispositivo (48 bits), inserta el valor hexadecimal `FFFE` en medio y complementa el séptimo bit (bit U/L) para transformarla en un identificador único de 64 bits.
- **Generación aleatoria:** El sistema operativo genera un valor de 64 bits al azar para mejorar la privacidad y evitar el rastreo del hardware en Internet.

### 4.2. DHCPv6 (Dynamic Host Configuration Protocol para IPv6)

Se utiliza cuando se requiere un control centralizado de la asignación de direcciones o parámetros adicionales (como servidores DNS específicos). Puede operar de dos maneras:

- **DHCPv6 sin estado (Stateless):**
  El dispositivo usa SLAAC para obtener su dirección IP y puerta de enlace desde el Anuncio de Router (RA), pero recurre a un servidor DHCPv6 para obtener información complementaria como el nombre de dominio y los servidores DNS.

- **DHCPv6 con estado (Stateful):**
  El mensaje RA del router le indica al dispositivo que **no** genere su IP de forma autónoma. El dispositivo solicita tanto su dirección IPv6 como todos los parámetros de red directamente al servidor DHCPv6, el cual mantiene un registro exacto de qué dirección ha sido asignada a cada cliente.

---

## 5. Mecanismos de Transición de IPv4 a IPv6

Dado que IPv4 e IPv6 no son compatibles de forma nativa, se han diseñado diferentes estrategias de transición para permitir la coexistencia y migración gradual de las redes a nivel mundial:

### 5.1. Doble Pila (Dual Stack)

Permite que los dispositivos de red y los nodos finales ejecuten simultáneamente ambas pilas de protocolos (IPv4 e IPv6). Un dispositivo con doble pila tiene configuradas direcciones IPv4 e IPv6 en la misma interfaz y decide cuál protocolo utilizar en función de las capacidades del destino y las consultas DNS. Es la estrategia de transición más recomendada y limpia cuando la infraestructura de red soporta ambos estándares de manera nativa.

### 5.2. Tunelización (Tunneling)

Es un método utilizado para transportar paquetes de una red IPv6 a través de una infraestructura de red que actualmente solo soporta IPv4 (o viceversa). El paquete IPv6 original se encapsula dentro de un encabezado de paquete IPv4 en el extremo de origen del túnel. El paquete viaja por la red IPv4 como si fuera tráfico IPv4 estándar y, al llegar al extremo de destino, el encabezado IPv4 es retirado para liberar y procesar el paquete IPv6 original.

### 5.3. Traducción (NAT64)

Permite que los dispositivos que solo disponen de IPv6 se comuniquen de forma directa con dispositivos que solo disponen de IPv4. Funciona de manera similar a NAT en IPv4, utilizando un router o gateway traductor que convierte el encabezado del paquete IPv6 en un encabezado IPv4 (y viceversa), modificando las direcciones IP y adaptando los protocolos de transporte para posibilitar el intercambio de información entre entornos incompatibles.
