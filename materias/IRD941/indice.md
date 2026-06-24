# Índice — Interconexión de Redes de Datos

## Unidad 1 — Direccionamiento IPv6

### Tema 1: Fundamentos de Escritura y Estructura de IPv6
- 1.1 Omisión de ceros iniciales
- 1.2 Reducción de dobles dos puntos (`::`)
- 2.1 Prefijo de red (64 bits)
- 2.2 Identificador de interfaz (64 bits)

### Tema 2: Tipos de Direcciones IPv6
- 3.1 Unicast (Unidifusión) — Link-Local, GUA, Loopback, Indefinida
- 3.2 Multicast (Multidifusión)
- 3.3 Anycast (Cualquier difusión)

### Tema 3: Asignación Dinámica de Direcciones
- 4.1 SLAAC (Stateless Address Autoconfiguration)
- 4.2 DHCPv6 (Stateless y Stateful)

### Tema 4: Transición de IPv4 a IPv6
- 5.1 Doble Pila (Dual Stack)
- 5.2 Tunelización (Tunneling)
- 5.3 Traducción (NAT64)

## Unidad 2 — VTP, Enrutamiento Inter-VLAN y Enrutamiento Estático

### Tema 1: Administración Centralizada de VLANs con VTP
- 1.1 Componentes de VTP (Dominio, Publicaciones, Número de Revisión)
- 1.2 Modos de Operación de VTP (Servidor, Cliente, Transparente)
- 1.3 Poda VTP (VTP Pruning)

### Tema 2: Enrutamiento entre VLANs (Inter-VLAN Routing)
- 2.1 Enrutamiento Inter-VLAN Tradicional
- 2.2 Enrutamiento Router-on-a-Stick
- 2.3 Enrutamiento en Switch de Capa 3 (Multicapa)

### Tema 3: Fundamentos de Enrutamiento Estático
- 3.1 Características del Enrutamiento Estático (ventajas y desventajas)
- 3.2 Tipos de Rutas Estáticas (Estándar, por Defecto, Resumida, Flotante)
- 3.3 Configuración y Parámetros de Próximo Salto

## Unidad 3 — Tecnologías de Comunicación WAN

### Tema 1: Protocolo Punto a Punto (PPP)
- 1.1 Componentes principales de PPP (Encapsulación, LCP, NCP)
- 1.2 Mecanismos de Autenticación en PPP (PAP y CHAP)

### Tema 2: Tecnologías WAN Clásicas de Conmutación
- 2.1 ATM (Asynchronous Transfer Mode) — Celdas de 53 bytes
- 2.2 Frame Relay — Circuitos Virtuales (PVC y DLCI)

### Tema 3: MPLS — Conmutación de Etiquetas
- 3.1 Concepto y Funcionamiento (Capa 2.5)
- 3.2 Componentes de una red MPLS (CE, PE, P/LSR)
- 3.3 Beneficios principales de MPLS (Multiprotocolo, Ingeniería de Tráfico, VPNs)

## Unidad 4 — Servicios de Red

### Tema 1: Conceptos Fundamentales de Servicios de Red
- 1.1 ¿Qué son los servicios de red? (Modelo cliente/servidor)
- 1.3 Servicios de bajo nivel (DHCP y DNS)

### Tema 2: Servicios de Alto Nivel — Capa de Aplicación
- 1.2.1 Servicio de transferencia de ficheros (FTP)
- 1.2.2 Correo electrónico y mensajería instantánea
- 1.2.3 Conexiones remotas (RDP, SSH, ICA)
- 1.2.4 Servicio web (HTTP/HTTPS)

### Tema 3: Implementación del Servicio DHCP
- 2.1 Subneteo de Red (VLSM)
- 2.2 Interconexión de red e implementación
- 2.3 Configuración de la simulación (Pools, IP Helper)

### Tema 4: Implementación de DNS y Servidor Web
- 3.1 Configuración de simulación DNS (Registros Tipo A)
- 3.2 Comprobación del funcionamiento (nslookup)
- 4.1 Configuración de Servidor Web (index.html)
- 4.2 Prueba final de visualización (navegador)

## Unidad 5 — Protocolo IPv6

### Tema 1: Evolución de la Cabecera (IPv4 → IPv6)
- 1.1 Reglas de escritura de direcciones IPv6 (Omisión de ceros, `::`)
- 1.3 Campos de la Cabecera IPv6 (40 bytes, 8 campos fijos)

### Tema 2: Tipos de Direcciones IPv6
- 1.2 Tipos de direcciones IPv6 (Unicast, Multicast, Anycast)

### Tema 3: ICMPv6 — Diagnóstico y Descubrimiento de Vecinos
- 2.1 Destino o Servicio Inaccesible
- 2.2 Tiempo Superado
- 2.3 Redireccionamiento de Ruta
- 2.4 Protocolo ND — Mensajes RS, RA, NS, NA, Redirect
- 2.5 Comando de Pruebas (Ping y Traceroute para IPv6)

### Tema 4: Autoconfiguración IPv6
- 3.1 SLAAC (Stateless Address Autoconfiguration)
- 3.2 DHCPv6 — Operación Stateless y Stateful
