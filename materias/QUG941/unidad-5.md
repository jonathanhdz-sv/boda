# Unidad 5 — Cálculos en Reacciones Químicas

**Química General — Universidad Don Bosco**

---

## Sumario

17. Estequiometría (balanceo, cálculos estequiométricos, reactivo limitante, rendimiento de reacción)
18. Electroquímica y procesos redox (semi-reacciones, tablas de potencial de reducción estándar)
19. Celdas galvánicas y electrolíticas (potencial de celda, electrólisis de NaCl fundido y en solución acuosa)
20. Leyes de Faraday (Q = I·t, equivalente químico, masa de producto)

---

## Clase 17 | Estequiometría

### 17.1 Ecuación Química y Balanceo

- **Reacción química:** describe qué sustancias se consumen y cuáles se forman.
- **Ecuación química:** reacción **BALANCEADA** que además indica la **PROPORCIÓN** en moles en que se consumen reactivos y se forman productos.

Se añaden **COEFICIENTES ESTEQUIOMÉTRICOS** (números enteros a la izquierda de cada sustancia) para igualar el número de átomos en reactivos y productos.

**Ejemplo:** 2H₂(g) + O₂(g) → 2H₂O(l)

| | Átomos H | Átomos O |
|--|:-------:|:-------:|
| Reactivos | 4 | 2 |
| Productos | 4 | 2 |

→ **BALANCEADA** ✓

### 17.2 Cálculos Estequiométricos

Los coeficientes estequiométricos indican proporción en **MOLES** (no en masa).

**Ejemplo:** C₃H₈ + 5O₂ → 3CO₂ + 4H₂O

Por cada 1 mol de C₃H₈ reaccionan 5 moles de O₂ y se forman 3 moles de CO₂ y 4 moles de H₂O.

**Diagrama de cálculo (Figura 36):**

> Gramos A → Moles A (n = m/M) → Moles B (usando coeficientes) → Gramos B (m = n·M)

**Ej:** ¿Gramos de O₂ que reaccionan con 88g de C₃H₈?

- M(C₃H₈) = 44 g/mol, n = 88/44 = 2 mol C₃H₈
- 2 mol C₃H₈ × (5 mol O₂ / 1 mol C₃H₈) = 10 mol O₂
- M(O₂) = 32 g/mol, m = 10 × 32 = **320g O₂**

#### 17.2.1 Reactivo Limitante

- Reactivo que se **CONSUME POR COMPLETO** y detiene la reacción.
- **Reactivo en exceso:** sobra al terminarse el limitante.
- **Cómo identificarlo:** calcular cuánto se necesita de un reactivo a partir del otro. Si no alcanza → es el limitante.
- **SIEMPRE** se calculan los productos a partir del **REACTIVO LIMITANTE**.

**Ejemplo:** 88g C₃H₈ + 300g O₂ (necesita 320g O₂, solo hay 300g)

→ **O₂ es limitante.** A partir de O₂:

- 300g O₂ = 9.375 mol O₂
- 9.375 × (3 mol CO₂ / 5 mol O₂) = 5.625 mol CO₂ × 44 = **247.5g CO₂**

#### 17.2.2 Rendimiento de Reacción

- **Rendimiento teórico (RT):** masa máxima si se consume todo el limitante
- **Rendimiento real (RR):** masa obtenida en la práctica
- **Rendimiento porcentual:**

> **%R = (RR / RT) × 100** *[Ec. 37]*

**Ej:** Si se obtienen 200g CO₂ de 247.5g teóricos:

%R = (200 / 247.5) × 100 = **80.8%**

---

## Clase 18 | Electroquímica y Procesos Redox

**Electroquímica:** rama que estudia la conversión entre energía química y energía eléctrica. Solo aplica a reacciones **REDOX**.

### Pasos para Plantear Semi-Reacciones

1. Escribir el elemento que cambia de N.O. en reactivos y productos
2. Escribir en forma molecular (subíndice 2) H₂, N₂, O₂, halógenos cuando tengan N.O. = 0
3. Balancear número de átomos
4. Balancear carga eléctrica añadiendo electrones (e⁻)
    - **Oxidación:** electrones como PRODUCTOS (se pierden)
    - **Reducción:** electrones como REACTIVOS (se ganan)
5. Verificar que los electrones coincidan en ambas semi-reacciones
    - Si no coinciden, multiplicar por números que igualen

**Ejemplo:** Zn + 2HCl → ZnCl₂ + H₂

- **Oxidación:** Zn⁰ → Zn⁺² + 2e⁻
- **Reducción:** 2H⁺¹ + 2e⁻ → H₂⁰

| Rol | Definición | Ejemplo |
|-----|-----------|---------|
| Agente oxidante | Reactivo que contiene al elemento que SE REDUCE | HCl (contiene H que se reduce) |
| Agente reductor | Reactivo que contiene al elemento que SE OXIDA | Zn (se oxida) |

### 18.1 Tablas de Potencial de Reducción Estándar

**Condiciones estándar:** 1M (soluciones), 1atm (gases), 25°C.

**Potencial de reducción estándar (E°red):** mide la tendencia de un elemento a reducirse. Se compara contra el hidrógeno:

> 2H⁺ + 2e⁻ → H₂, E°red = **0.00V**

- **Mayor E°red** → mayor tendencia a reducirse (mejor agente oxidante)
- **Menor E°red** → mayor tendencia a oxidarse (mejor agente reductor)

**Potencial de celda estándar:**

> **E°celda = E°red + E°ox** *[Ec. 38]*

Donde E°ox = −(E°red de la tabla) porque la oxidación es lo opuesto.

**Ejemplo:** Celda de Zn y H₂

- Zn⁺² + 2e⁻ → Zn⁰, E°red = −0.76V
- 2H⁺ + 2e⁻ → H₂, E°red = 0.00V (cátodo)

Entonces el Zn se oxida (ánodo): Zn⁰ → Zn⁺² + 2e⁻, E°ox = +0.76V

E°celda = 0.00 + 0.76 = **+0.76V** (POSITIVO → reacción espontánea)

---

## Clase 19 | Celdas Galvánicas y Electrolíticas

### 19.1 Celdas Galvánicas (Espontáneas)

- **E°celda > 0** → reacción espontánea → genera electricidad
- **ÁNODO:** electrodo donde ocurre la **OXIDACIÓN** (Zn → Zn⁺² + 2e⁻). La barra se **GASTA**, se forman iones en la solución.
- **CÁTODO:** electrodo donde ocurre la **REDUCCIÓN** (Cu⁺² + 2e⁻ → Cu⁰). La barra se **ENGROSA**, se consumen iones de la solución.
- Electrones fluyen del **ÁNODO** al **CÁTODO** por el cable externo
- **Puente salino:** permite contacto iónico entre semi-celdas

**Ejemplo Zn-Cu:**

| Electrodo | Semi-reacción | Potencial |
|-----------|--------------|:---------:|
| Cátodo | Cu⁺² + 2e⁻ → Cu⁰ | E°red = +0.34V |
| Ánodo | Zn⁰ → Zn⁺² + 2e⁻ | E°ox = +0.76V |

- Celda total: Cu⁺² + Zn⁰ → Cu⁰ + Zn⁺²
- **E°celda = +1.10V**

### 19.2 Celdas Electrolíticas (No Espontáneas)

- **E°celda < 0** → se necesita aplicar voltaje externo
- Polo **NEGATIVO** de la fuente → **CÁTODO** (donde ocurre reducción)
- Polo **POSITIVO** de la fuente → **ÁNODO** (donde ocurre oxidación)

#### 19.2.1 Electrólisis de NaCl Fundido

- Na⁺ ya está oxidado (no puede oxidarse más) → solo puede reducirse
- Cl⁻ ya está reducido (no puede reducirse más) → solo puede oxidarse

| Electrodo | Semi-reacción | Potencial |
|-----------|--------------|:---------:|
| Cátodo | Na⁺ + e⁻ → Na⁰ | E°red = −2.71V |
| Ánodo | 2Cl⁻ → Cl₂ + 2e⁻ | E°ox = −1.36V |

- Total: 2NaCl → 2Na + Cl₂
- **E°celda = −4.07V** (se necesitan 4.07V mínimo)

#### 19.2.2 Electrólisis de NaCl en Solución Acuosa

Compiten por reducirse: Na⁺ (E°red = −2.71V) y H₂O (E°red = −0.83V)
Compiten por oxidarse: Cl⁻ (E°ox = −1.36V) y H₂O (E°ox = −1.23V)

**Resultado:** gana el **AGUA** en ambos casos (mayor potencial).

| Proceso | Semi-reacción | Potencial |
|---------|--------------|:---------:|
| Oxidación | 2H₂O → O₂ + 4H⁺ + 4e⁻ | E°ox = −1.23V |
| Reducción | 4H₂O + 4e⁻ → 2H₂ + 4OH⁻ | E°red = −0.83V |

- Total: 2H₂O → 2H₂ + O₂
- **E°celda = −2.06V**

**NOTA:** Si se aplica **SOBREVOLTAJE** suficiente, pueden darse las reacciones del NaCl también.

---

## Clase 20 | Leyes de Faraday

> **Q = I · t** *[Ec. 39]*

Donde:
- Q = carga eléctrica (Culombios C)
- I = corriente (Amperios A)
- t = tiempo (segundos s)

> **1 mol de electrones = 96480 C = 1 Faradio (F)**

**Equivalente químico (Eq):**

Masa en gramos de producto obtenido por cada mol de electrones trasladado.

> **Eq = Masa atómica del producto / |carga del ion en la semi-reacción|** *[Ec. 40]*

**Ejemplo semi-reacción** 2Na⁺ + 2e⁻ → 2Na⁰:

Eq = 23g / 1 = **23g** (por cada mol de e⁻ se obtienen 23g de Na)

**Segunda ley de Faraday (Ecuación 41):**

> **m = (I · t · Eq) / F**

Donde m = masa de producto en gramos.

**Problema resuelto 19:** ¿Corriente para obtener 30g Fe en 3h 50min?

- Semi-reacción: Fe⁺³ + 3e⁻ → Fe⁰ (REDUCCIÓN → cátodo)
- Eq = 55.85g / 3 = 18.62g
- t = 3h × 3600 + 50min × 60 = 13800s
- I = (m · F) / (t · Eq) = (30 × 96480) / (13800 × 18.62) = **11.26 A**

---

## Ecuaciones Clave Unidad 5

| Ecuación | Fórmula | Núm. |
|----------|---------|:----:|
| Rendimiento porcentual | %R = (RR / RT) × 100 | Ec. 37 |
| Potencial de celda | E°celda = E°red + E°ox | Ec. 38 |
| Carga eléctrica | Q = I · t | Ec. 39 |
| Equivalente químico | Eq = Matómica / |carga ion| | Ec. 40 |
| Ley de Faraday (masa) | m = (I · t · Eq) / F | Ec. 41 |
| Constante de Faraday | F = 96480 C/mol e⁻ | — |

---

## Glosario Unidad 5

| Término | Definición |
|--------|-----------|
| Agente oxidante | Reactivo que contiene al elemento que se reduce |
| Agente reductor | Reactivo que contiene al elemento que se oxida |
| Ánodo | Electrodo donde ocurre la OXIDACIÓN |
| Balanceo | Añadir coeficientes para igualar átomos en reactivos y productos |
| Cátodo | Electrodo donde ocurre la REDUCCIÓN |
| Celda electrolítica | Reacción redox NO espontánea (requiere voltaje externo) |
| Celda galvánica | Reacción redox ESPONTÁNEA (genera electricidad) |
| Coeficiente estequiométrico | Número que indica proporción molar en la reacción |
| Ecuación química | Reacción química balanceada |
| Electroquímica | Rama que estudia conversión energía química ↔ eléctrica |
| Equivalente químico (Eq) | Gramos de producto por mol de electrones |
| Estequiometría | Proporción en que se consumen reactivos y se forman productos |
| Faradio (F) | Carga de 1 mol de electrones = 96480 C |
| Potencial de celda (E°celda) | E°red + E°ox. Positivo = espontáneo |
| Reactivo limitante | Se consume primero, detiene la reacción |
| Reactivo en exceso | Sobra al consumirse el limitante |
| Rendimiento porcentual | (RR/RT) × 100 |
| Rendimiento real (RR) | Masa obtenida en la práctica |
| Rendimiento teórico (RT) | Masa máxima esperada del producto |
