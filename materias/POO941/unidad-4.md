# Unidad 4 — Introducción a la Programación de Escritorio y Manejo de Logs de Errores

**Clases:** 13 a 16 | **Periodo:** 8 abr – 4 may

Esta unidad da el salto de la consola a las aplicaciones gráficas de escritorio usando Swing, las conecta con bases de datos mediante JDBC e introduce el manejo de logs de errores.

---

## Clase 13: Swing — Interfaces Gráficas en Java

### Qué es Swing
Conjunto de componentes de **interfaz gráfica de usuario (GUI)** para Java. Forma parte de JFC (Java Foundation Classes).

**Diferencias clave vs AWT:**
- Escrito completamente en **Java** (no depende de componentes nativos del SO)
- Apariencia adaptable al sistema operativo (Windows, Linux, macOS)
- Más flexible y profesional

### Conceptos fundamentales

| Elemento | Función |
|----------|---------|
| **Contenedores** | Albergan otros componentes |
| **Componentes** (Widgets) | Elementos individuales: botones, etiquetas, campos de texto |
| **Gestores de Diseño** (Layout Managers) | Definen cómo se organizan los componentes dentro del contenedor |

---

## Contenedores de Alto Nivel
Ventanas principales, no pueden estar dentro de otros componentes.

| Contenedor | Uso |
|------------|-----|
| **JFrame** | Ventana principal con bordes, barra de título, botones cerrar/minimizar |
| **JDialog** | Ventana secundaria para alertas o cuadros de diálogo |
| **JApplet** | Ejecutado en navegador (en desuso) |

## Contenedores Intermedios
Organizan componentes **dentro** de un contenedor de alto nivel.

| Contenedor | Uso |
|------------|-----|
| **JPanel** | Área genérica para agrupar componentes (el más común) |
| **JScrollPane** | Vista desplazable con barras de scroll |
| **JTabbedPane** | Organiza componentes en pestañas |

---

## Componentes Básicos (Widgets)

| Componente | Descripción |
|------------|-------------|
| `JButton` | Botón cliqueable |
| `JLabel` | Texto corto o imagen (solo lectura) |
| `JTextField` | Campo de texto de una sola línea |
| `JPasswordField` | Campo de texto que oculta caracteres (passwords) |
| `JCheckBox` | Casilla de verificación (selección múltiple) |
| `JRadioButton` | Botón de opción (selección única) |
| `JTextArea` | Área de texto multi-línea |
| `JComboBox` | Lista desplegable |
| `JTable` | Tabla de datos |
| `JOptionPane` | Cuadros de diálogo rápidos (mensaje, entrada, confirmación) |

---

## Manejo de Eventos en Swing

En una GUI el programa no sigue un flujo secuencial, sino que **"espera"** a que el usuario actúe. Estos eventos se capturan con **Listeners** (escuchadores), usando el patrón **Observer**.

```
Componente fuente (botón)  →  genera evento  →  Listener (lo captura y ejecuta código)
```

### Ejemplo básico con ActionListener
```java
boton.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent e) {
        System.out.println("Botón presionado!");
    }
});
```

### Tipos de Listeners más comunes

| Listener | Detecta |
|----------|---------|
| **ActionListener** | Clics en botones, presionar "Enter" en campos de texto |
| **MouseListener** | Eventos del ratón: clic, entrar/salir del área |
| **KeyListener** | Presionar o soltar teclas |
| **ItemListener** | Cambios en JCheckBox, JRadioButton, JComboBox |

**Principio de diseño limpio:** separar la lógica de la interfaz (vista) de la lógica de procesamiento (controlador).

---

## Creación de Aplicaciones de Escritorio

### Estructura de un proyecto Swing
1. **Crear proyecto en NetBeans** como "Java Application"
2. Agregar **JFrame Form** (formulario visual con drag-and-drop)
3. **Paleta de componentes:** arrastrar botones, etiquetas, campos al formulario
4. **Inspector de propiedades:** modificar textos, tamaños, colores
5. **Eventos:** click derecho -> Events -> Action -> actionPerformed (genera el método)

### Ventana de desarrollo en NetBeans
- **Área de Proyectos:** estructura de archivos
- **Editor de código:** lógica del programa
- **Paleta:** componentes arrastrables
- **Inspector:** propiedades del componente seleccionado
- **Consola de salida:** resultados de ejecución

---

## Swing con JDBC (Integración GUI + Base de Datos)

Objetivo: conectar las interfaces gráficas de Swing con MySQL.

### Arquitectura recomendada (3 capas)

| Capa | Responsabilidad |
|------|-----------------|
| **Capa de Interfaz** (JFrame) | Formularios, botones, campos. Captura eventos del usuario |
| **Capa de Lógica** (DAO) | Métodos que ejecutan consultas SQL. Data Access Object |
| **Capa de Conexión** | Clase encargada de abrir/cerrar conexión con la BD |

```
JFrame (botón Guardar) → EstudianteDAO.insertar() → ConexionMySQL → BD
```

### Ejemplo: guardar datos desde un formulario
```java
private void btnGuardarActionPerformed(java.awt.event.ActionEvent evt) {
    String nombre = txtNombre.getText();
    String carnet = txtCarnet.getText();
    
    if (nombre.isEmpty() || carnet.isEmpty()) {
        JOptionPane.showMessageDialog(this, "Todos los campos son obligatorios");
        return;
    }
    
    EstudianteDAO dao = new EstudianteDAO();
    dao.insertar(carnet, nombre);
    JOptionPane.showMessageDialog(this, "Datos guardados con éxito");
}
```

### Buenas prácticas al integrar GUI y BD
1. **Validar datos en la interfaz** antes de enviarlos a la BD
2. **Nunca** ejecutar consultas pesadas en el hilo principal (congela la ventana)
3. **Cerrar siempre** las conexiones en `finally` (evitar fugas de memoria)
4. **Separar** la lógica de negocio de la interfaz gráfica
5. Usar `JOptionPane` para mostrar mensajes de éxito/error al usuario

---

## Manejo de Logs de Errores

En aplicaciones de escritorio no basta con `System.out.println()`. Se necesita un **registro** (log) para depurar fallos, especialmente en producción.

### java.util.logging (Librería estándar de Java)

**Niveles de severidad** (de mayor a menor):
| Nivel | Uso |
|-------|-----|
| `SEVERE` | Fallo grave (ej. no se pudo conectar a BD) |
| `WARNING` | Advertencia (ej. dato incompleto) |
| `INFO` | Información general (ej. "usuario guardado exitosamente") |
| `CONFIG` | Mensajes de configuración |
| `FINE` | Detalle fino para depuración |

### Ejemplo básico de Logger
```java
private static final Logger LOGGER = Logger.getLogger(MiClase.class.getName());

try {
    // intentar conectar a BD
    Connection con = DriverManager.getConnection(url, user, pass);
    LOGGER.info("Conexión exitosa a la BD");
} catch (SQLException e) {
    LOGGER.log(Level.SEVERE, "Error al conectar a la BD", e);
}
```

---

## Resumen de la Unidad 4

| Tema | Idea clave |
|------|------------|
| **Swing** | Biblioteca GUI de Java para crear aplicaciones de escritorio |
| **Contenedores** | JFrame (ventana), JPanel (agrupador), JScrollPane (desplazable) |
| **Componentes** | JButton, JLabel, JTextField, JTable, JOptionPane |
| **Eventos** | ActionListener, MouseListener, KeyListener |
| **Arquitectura 3 capas** | Interfaz (Swing) → Lógica (DAO) → Conexión (JDBC) |
| **Logs** | `java.util.logging.Logger` con niveles SEVERE, WARNING, INFO, FINE |
| **Buenas prácticas** | Validar en GUI, no bloquear hilo principal, cerrar conexiones, separar capas |
