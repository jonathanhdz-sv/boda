-- ============================================================
-- PROYECTO EXPERIENCIASV — MDB941
-- Fase 5: Mantenimiento de Datos
-- Grupo 2 | Jonathan Hernández (HG235460), Jhensen Recinos (RA251889)
-- Archivo: Grupo2_CreacionBD.sql
-- Descripción: Script completo para crear la BD desde cero
-- ============================================================

USE master;
GO

IF DB_ID('ExperienciaSV') IS NOT NULL
    DROP DATABASE ExperienciaSV;
GO

CREATE DATABASE ExperienciaSV
ON PRIMARY (
    NAME = 'ExperienciaSV_data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\ExperienciaSV.mdf',
    SIZE = 100MB, MAXSIZE = 500MB, FILEGROWTH = 50MB
)
LOG ON (
    NAME = 'ExperienciaSV_log',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\ExperienciaSV_log.ldf',
    SIZE = 50MB, MAXSIZE = 200MB, FILEGROWTH = 25MB
);
GO

USE ExperienciaSV;
GO

PRINT '>> Base de datos ExperienciaSV creada exitosamente.';

-- ============================================================
-- CATÁLOGOS (7 tablas)
-- ============================================================

CREATE TABLE CATEGORIA (
    categoria_id INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(100) NOT NULL,
    descripcion  VARCHAR(500) NULL,
    estado       BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY CLUSTERED (categoria_id),
    CONSTRAINT UQ_CATEGORIA_NOMBRE UNIQUE (nombre)
);

CREATE TABLE DESTINO (
    destino_id   INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(100) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    descripcion  VARCHAR(500) NULL,
    estado       BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_DESTINO PRIMARY KEY CLUSTERED (destino_id),
    CONSTRAINT UQ_DESTINO_NOMBRE UNIQUE (nombre)
);

CREATE TABLE ROL (
    rol_id       INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    descripcion  VARCHAR(200) NULL,
    CONSTRAINT PK_ROL PRIMARY KEY CLUSTERED (rol_id),
    CONSTRAINT UQ_ROL_NOMBRE UNIQUE (nombre)
);

CREATE TABLE ESTADO_RESERVACION (
    estado_id    INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    descripcion  VARCHAR(200) NULL,
    CONSTRAINT PK_ESTADO_RESERVACION PRIMARY KEY CLUSTERED (estado_id),
    CONSTRAINT UQ_ESTADO_RESERVACION_NOMBRE UNIQUE (nombre)
);

CREATE TABLE IDIOMA (
    idioma_id    INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    codigo_iso   CHAR(2) NULL,
    CONSTRAINT PK_IDIOMA PRIMARY KEY CLUSTERED (idioma_id),
    CONSTRAINT UQ_IDIOMA_NOMBRE UNIQUE (nombre)
);

CREATE TABLE ESPECIALIDAD (
    especialidad_id INT IDENTITY(1,1) NOT NULL,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     VARCHAR(300) NULL,
    CONSTRAINT PK_ESPECIALIDAD PRIMARY KEY CLUSTERED (especialidad_id),
    CONSTRAINT UQ_ESPECIALIDAD_NOMBRE UNIQUE (nombre)
);

CREATE TABLE METODO_PAGO (
    metodo_id    INT IDENTITY(1,1) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    descripcion  VARCHAR(200) NULL,
    CONSTRAINT PK_METODO_PAGO PRIMARY KEY CLUSTERED (metodo_id),
    CONSTRAINT UQ_METODO_PAGO_NOMBRE UNIQUE (nombre)
);

-- ============================================================
-- PERSONAS (3 tablas)
-- ============================================================

CREATE TABLE TURISTA (
    turista_id     INT IDENTITY(1,1) NOT NULL,
    nombre         VARCHAR(100) NOT NULL,
    apellido       VARCHAR(100) NOT NULL,
    email          VARCHAR(150) NOT NULL,
    telefono       VARCHAR(20) NOT NULL,
    dui            VARCHAR(10) NOT NULL,
    nacionalidad   VARCHAR(50) NOT NULL DEFAULT 'Salvadoreño',
    fecha_registro DATETIME NOT NULL DEFAULT GETDATE(),
    estado         BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_TURISTA PRIMARY KEY CLUSTERED (turista_id),
    CONSTRAINT UQ_TURISTA_EMAIL UNIQUE (email),
    CONSTRAINT UQ_TURISTA_DUI UNIQUE (dui),
    CONSTRAINT CK_TURISTA_EMAIL CHECK (email LIKE '%_@_%._%' AND email NOT LIKE '% %'),
    CONSTRAINT CK_TURISTA_TELEFONO CHECK (telefono LIKE '[2,6,7][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_TURISTA_DUI CHECK (dui LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]')
);

CREATE TABLE PROVEEDOR (
    proveedor_id         INT IDENTITY(1,1) NOT NULL,
    nombre_empresa       VARCHAR(150) NOT NULL,
    nombre_contacto      VARCHAR(100) NOT NULL,
    email                VARCHAR(150) NOT NULL,
    telefono             VARCHAR(20) NOT NULL,
    certificacion_mitur  VARCHAR(50) NULL,
    tipo_comision        VARCHAR(20) NOT NULL DEFAULT 'ESTANDAR',
    calificacion_promedio DECIMAL(3,2) NOT NULL DEFAULT 0.00,
    estado               VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',
    fecha_registro       DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_PROVEEDOR PRIMARY KEY CLUSTERED (proveedor_id),
    CONSTRAINT UQ_PROVEEDOR_EMAIL UNIQUE (email),
    CONSTRAINT CK_PROVEEDOR_ESTADO CHECK (estado IN ('ACTIVO','SUSPENDIDO','VERIFICADO')),
    CONSTRAINT CK_PROVEEDOR_TIPO_COMISION CHECK (tipo_comision IN ('ESTANDAR','PREMIUM')),
    CONSTRAINT CK_PROVEEDOR_CALIFICACION CHECK (calificacion_promedio BETWEEN 0.00 AND 5.00)
);

CREATE TABLE GUIA (
    guia_id              INT IDENTITY(1,1) NOT NULL,
    nombre               VARCHAR(100) NOT NULL,
    apellido             VARCHAR(100) NOT NULL,
    email                VARCHAR(150) NOT NULL,
    telefono             VARCHAR(20) NOT NULL,
    dui                  VARCHAR(10) NOT NULL,
    anios_experiencia    INT NOT NULL DEFAULT 0,
    calificacion_promedio DECIMAL(3,2) NOT NULL DEFAULT 0.00,
    estado               VARCHAR(20) NOT NULL DEFAULT 'ACTIVO',
    fecha_registro       DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_GUIA PRIMARY KEY CLUSTERED (guia_id),
    CONSTRAINT UQ_GUIA_EMAIL UNIQUE (email),
    CONSTRAINT UQ_GUIA_DUI UNIQUE (dui),
    CONSTRAINT CK_GUIA_CALIFICACION CHECK (calificacion_promedio BETWEEN 0.00 AND 5.00),
    CONSTRAINT CK_GUIA_ESTADO CHECK (estado IN ('ACTIVO','SUSPENDIDO','CERTIFICADO')),
    CONSTRAINT CK_GUIA_DUI CHECK (dui LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]')
);

-- ============================================================
-- NÚCLEO (3 tablas)
-- ============================================================

CREATE TABLE EXPERIENCIA (
    experiencia_id   INT IDENTITY(1,1) NOT NULL,
    proveedor_id     INT NOT NULL,
    categoria_id     INT NOT NULL,
    destino_id       INT NOT NULL,
    nombre           VARCHAR(150) NOT NULL,
    descripcion      VARCHAR(1000) NULL,
    duracion_horas   DECIMAL(4,1) NOT NULL,
    dificultad       VARCHAR(20) NOT NULL DEFAULT 'MEDIA',
    edad_minima      INT NOT NULL DEFAULT 0,
    capacidad_maxima INT NOT NULL,
    precio_base      DECIMAL(10,2) NOT NULL,
    incluye          VARCHAR(500) NULL,
    itinerario       VARCHAR(1000) NULL,
    estado           BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_EXPERIENCIA PRIMARY KEY CLUSTERED (experiencia_id),
    CONSTRAINT FK_EXPERIENCIA_PROVEEDOR FOREIGN KEY (proveedor_id) REFERENCES PROVEEDOR(proveedor_id),
    CONSTRAINT FK_EXPERIENCIA_CATEGORIA FOREIGN KEY (categoria_id) REFERENCES CATEGORIA(categoria_id),
    CONSTRAINT FK_EXPERIENCIA_DESTINO FOREIGN KEY (destino_id) REFERENCES DESTINO(destino_id),
    CONSTRAINT CK_EXPERIENCIA_PRECIO CHECK (precio_base > 0),
    CONSTRAINT CK_EXPERIENCIA_DURACION CHECK (duracion_horas > 0),
    CONSTRAINT CK_EXPERIENCIA_CAPACIDAD CHECK (capacidad_maxima > 0),
    CONSTRAINT CK_EXPERIENCIA_DIFICULTAD CHECK (dificultad IN ('FACIL','MEDIA','DIFICIL','EXTREMA'))
);

CREATE TABLE TEMPORADA (
    temporada_id  INT IDENTITY(1,1) NOT NULL,
    nombre        VARCHAR(100) NOT NULL,
    fecha_inicio  DATE NOT NULL,
    fecha_fin     DATE NOT NULL,
    multiplicador DECIMAL(3,2) NOT NULL DEFAULT 1.00,
    descripcion   VARCHAR(300) NULL,
    estado        BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_TEMPORADA PRIMARY KEY CLUSTERED (temporada_id),
    CONSTRAINT CK_TEMPORADA_FECHAS CHECK (fecha_fin >= fecha_inicio),
    CONSTRAINT CK_TEMPORADA_MULTIPLICADOR CHECK (multiplicador BETWEEN 1.00 AND 2.00)
);

CREATE TABLE RESERVACION (
    reservacion_id    INT IDENTITY(1,1) NOT NULL,
    turista_id        INT NOT NULL,
    experiencia_id    INT NOT NULL,
    guia_id           INT NULL,
    temporada_id      INT NULL,
    estado_id         INT NOT NULL,
    fecha_reserva     DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_experiencia  DATE NOT NULL,
    cantidad_personas INT NOT NULL DEFAULT 1,
    precio_total      DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_RESERVACION PRIMARY KEY CLUSTERED (reservacion_id),
    CONSTRAINT FK_RESERVACION_TURISTA FOREIGN KEY (turista_id) REFERENCES TURISTA(turista_id),
    CONSTRAINT FK_RESERVACION_EXPERIENCIA FOREIGN KEY (experiencia_id) REFERENCES EXPERIENCIA(experiencia_id),
    CONSTRAINT FK_RESERVACION_GUIA FOREIGN KEY (guia_id) REFERENCES GUIA(guia_id),
    CONSTRAINT FK_RESERVACION_TEMPORADA FOREIGN KEY (temporada_id) REFERENCES TEMPORADA(temporada_id),
    CONSTRAINT FK_RESERVACION_ESTADO FOREIGN KEY (estado_id) REFERENCES ESTADO_RESERVACION(estado_id),
    CONSTRAINT CK_RESERVACION_PERSONAS CHECK (cantidad_personas > 0),
    CONSTRAINT CK_RESERVACION_PRECIO CHECK (precio_total >= 0)
);

CREATE TABLE DISPONIBILIDAD (
    disponibilidad_id INT IDENTITY(1,1) NOT NULL,
    experiencia_id    INT NOT NULL,
    guia_id           INT NOT NULL,
    fecha             DATE NOT NULL,
    hora_inicio       TIME NOT NULL,
    hora_fin          TIME NOT NULL,
    cupos_disponibles INT NOT NULL,
    CONSTRAINT PK_DISPONIBILIDAD PRIMARY KEY CLUSTERED (disponibilidad_id),
    CONSTRAINT FK_DISPONIBILIDAD_EXPERIENCIA FOREIGN KEY (experiencia_id) REFERENCES EXPERIENCIA(experiencia_id),
    CONSTRAINT FK_DISPONIBILIDAD_GUIA FOREIGN KEY (guia_id) REFERENCES GUIA(guia_id),
    CONSTRAINT CK_DISPONIBILIDAD_HORAS CHECK (hora_fin > hora_inicio),
    CONSTRAINT CK_DISPONIBILIDAD_CUPOS CHECK (cupos_disponibles >= 0)
);

-- ============================================================
-- TRANSACCIÓN (3 tablas)
-- ============================================================

CREATE TABLE PAGO (
    pago_id              INT IDENTITY(1,1) NOT NULL,
    reservacion_id       INT NOT NULL,
    metodo_id            INT NOT NULL,
    monto                DECIMAL(10,2) NOT NULL,
    comision_porcentaje  DECIMAL(5,2) NOT NULL DEFAULT 10.00,
    comision_monto       DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    monto_neto_proveedor DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fecha_pago           DATETIME NOT NULL DEFAULT GETDATE(),
    estado               VARCHAR(20) NOT NULL DEFAULT 'COMPLETADO',
    CONSTRAINT PK_PAGO PRIMARY KEY CLUSTERED (pago_id),
    CONSTRAINT FK_PAGO_RESERVACION FOREIGN KEY (reservacion_id) REFERENCES RESERVACION(reservacion_id),
    CONSTRAINT FK_PAGO_METODO FOREIGN KEY (metodo_id) REFERENCES METODO_PAGO(metodo_id),
    CONSTRAINT CK_PAGO_MONTO CHECK (monto > 0),
    CONSTRAINT CK_PAGO_ESTADO CHECK (estado IN ('PENDIENTE','COMPLETADO','REEMBOLSADO','CANCELADO'))
);

CREATE TABLE DESCUENTO_GRUPO (
    descuento_id         INT IDENTITY(1,1) NOT NULL,
    nombre               VARCHAR(100) NOT NULL,
    cantidad_minima      INT NOT NULL,
    cantidad_maxima      INT NULL,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,
    estado               BIT NOT NULL DEFAULT 1,
    CONSTRAINT PK_DESCUENTO_GRUPO PRIMARY KEY CLUSTERED (descuento_id),
    CONSTRAINT CK_DESCUENTO_MIN CHECK (cantidad_minima >= 1),
    CONSTRAINT CK_DESCUENTO_PORCENTAJE CHECK (porcentaje_descuento BETWEEN 0.00 AND 100.00)
);

-- ============================================================
-- CIERRE (3 tablas)
-- ============================================================

CREATE TABLE RESEÑA (
    resena_id                   INT IDENTITY(1,1) NOT NULL,
    reservacion_id              INT NOT NULL,
    turista_id                  INT NOT NULL,
    experiencia_id              INT NOT NULL,
    calificacion_experiencia    TINYINT NOT NULL,
    calificacion_guia           TINYINT NOT NULL,
    calificacion_calidad_precio TINYINT NOT NULL,
    comentario                  VARCHAR(1000) NULL,
    fecha_resena                DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_RESENA PRIMARY KEY CLUSTERED (resena_id),
    CONSTRAINT FK_RESENA_RESERVACION FOREIGN KEY (reservacion_id) REFERENCES RESERVACION(reservacion_id),
    CONSTRAINT FK_RESENA_TURISTA FOREIGN KEY (turista_id) REFERENCES TURISTA(turista_id),
    CONSTRAINT FK_RESENA_EXPERIENCIA FOREIGN KEY (experiencia_id) REFERENCES EXPERIENCIA(experiencia_id),
    CONSTRAINT UQ_RESENA_RESERVACION UNIQUE (reservacion_id),
    CONSTRAINT CK_RESENA_CAL_EXP CHECK (calificacion_experiencia BETWEEN 1 AND 5),
    CONSTRAINT CK_RESENA_CAL_GUIA CHECK (calificacion_guia BETWEEN 1 AND 5),
    CONSTRAINT CK_RESENA_CAL_PRECIO CHECK (calificacion_calidad_precio BETWEEN 1 AND 5)
);

CREATE TABLE CANCELACION (
    cancelacion_id       INT IDENTITY(1,1) NOT NULL,
    reservacion_id       INT NOT NULL,
    fecha_cancelacion    DATETIME NOT NULL DEFAULT GETDATE(),
    motivo               VARCHAR(500) NULL,
    horas_antelacion     INT NOT NULL,
    porcentaje_reembolso DECIMAL(5,2) NOT NULL,
    monto_reembolsado    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT PK_CANCELACION PRIMARY KEY CLUSTERED (cancelacion_id),
    CONSTRAINT FK_CANCELACION_RESERVACION FOREIGN KEY (reservacion_id) REFERENCES RESERVACION(reservacion_id),
    CONSTRAINT UQ_CANCELACION_RESERVACION UNIQUE (reservacion_id),
    CONSTRAINT CK_CANCELACION_PORCENTAJE CHECK (porcentaje_reembolso BETWEEN 0.00 AND 100.00),
    CONSTRAINT CK_CANCELACION_MONTO CHECK (monto_reembolsado >= 0),
    CONSTRAINT CK_CANCELACION_HORAS CHECK (horas_antelacion >= 0)
);

CREATE TABLE LIQUIDACION (
    liquidacion_id    INT IDENTITY(1,1) NOT NULL,
    proveedor_id      INT NOT NULL,
    periodo_inicio    DATE NOT NULL,
    periodo_fin       DATE NOT NULL,
    total_pagos       DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    total_comision    DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    monto_liquidado   DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    fecha_liquidacion DATETIME NOT NULL DEFAULT GETDATE(),
    estado            VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE',
    CONSTRAINT PK_LIQUIDACION PRIMARY KEY CLUSTERED (liquidacion_id),
    CONSTRAINT FK_LIQUIDACION_PROVEEDOR FOREIGN KEY (proveedor_id) REFERENCES PROVEEDOR(proveedor_id),
    CONSTRAINT CK_LIQUIDACION_FECHAS CHECK (periodo_fin >= periodo_inicio),
    CONSTRAINT CK_LIQUIDACION_ESTADO CHECK (estado IN ('PENDIENTE','PROCESADA','PAGADA'))
);

-- ============================================================
-- PUENTE N:M (2 tablas)
-- ============================================================

CREATE TABLE GUIA_IDIOMA (
    guia_id   INT NOT NULL,
    idioma_id INT NOT NULL,
    nivel     VARCHAR(20) NOT NULL DEFAULT 'INTERMEDIO',
    CONSTRAINT PK_GUIA_IDIOMA PRIMARY KEY CLUSTERED (guia_id, idioma_id),
    CONSTRAINT FK_GUIA_IDIOMA_GUIA FOREIGN KEY (guia_id) REFERENCES GUIA(guia_id),
    CONSTRAINT FK_GUIA_IDIOMA_IDIOMA FOREIGN KEY (idioma_id) REFERENCES IDIOMA(idioma_id),
    CONSTRAINT CK_GUIA_IDIOMA_NIVEL CHECK (nivel IN ('BASICO','INTERMEDIO','AVANZADO','NATIVO'))
);

CREATE TABLE GUIA_ESPECIALIDAD (
    guia_id          INT NOT NULL,
    especialidad_id  INT NOT NULL,
    CONSTRAINT PK_GUIA_ESPECIALIDAD PRIMARY KEY CLUSTERED (guia_id, especialidad_id),
    CONSTRAINT FK_GUIA_ESPECIALIDAD_GUIA FOREIGN KEY (guia_id) REFERENCES GUIA(guia_id),
    CONSTRAINT FK_GUIA_ESPECIALIDAD_ESP FOREIGN KEY (especialidad_id) REFERENCES ESPECIALIDAD(especialidad_id)
);

-- ============================================================
-- TRANSVERSAL
-- ============================================================

CREATE TABLE AUDITORIA (
    auditoria_id    INT IDENTITY(1,1) NOT NULL,
    tabla_afectada  VARCHAR(100) NOT NULL,
    tipo_operacion  VARCHAR(20) NOT NULL,
    registro_id     INT NOT NULL,
    usuario         VARCHAR(128) NOT NULL DEFAULT SYSTEM_USER,
    fecha_hora      DATETIME NOT NULL DEFAULT GETDATE(),
    datos_anteriores NVARCHAR(MAX) NULL,
    datos_nuevos    NVARCHAR(MAX) NULL,
    host_name       VARCHAR(128) NULL DEFAULT HOST_NAME(),
    CONSTRAINT PK_AUDITORIA PRIMARY KEY CLUSTERED (auditoria_id),
    CONSTRAINT CK_AUDITORIA_TIPO CHECK (tipo_operacion IN ('INSERT','UPDATE','DELETE'))
);

-- ============================================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- ============================================================

CREATE NONCLUSTERED INDEX IX_TURISTA_EMAIL ON TURISTA(email);
CREATE NONCLUSTERED INDEX IX_TURISTA_DUI ON TURISTA(dui);
CREATE NONCLUSTERED INDEX IX_GUIA_ESTADO ON GUIA(estado);
CREATE NONCLUSTERED INDEX IX_PROVEEDOR_ESTADO ON PROVEEDOR(estado);
CREATE NONCLUSTERED INDEX IX_EXPERIENCIA_PROVEEDOR ON EXPERIENCIA(proveedor_id);
CREATE NONCLUSTERED INDEX IX_EXPERIENCIA_CATEGORIA ON EXPERIENCIA(categoria_id);
CREATE NONCLUSTERED INDEX IX_EXPERIENCIA_DESTINO ON EXPERIENCIA(destino_id);
CREATE NONCLUSTERED INDEX IX_RESERVACION_TURISTA ON RESERVACION(turista_id);
CREATE NONCLUSTERED INDEX IX_RESERVACION_EXPERIENCIA ON RESERVACION(experiencia_id);
CREATE NONCLUSTERED INDEX IX_RESERVACION_FECHA ON RESERVACION(fecha_experiencia);
CREATE NONCLUSTERED INDEX IX_RESERVACION_ESTADO ON RESERVACION(estado_id);
CREATE NONCLUSTERED INDEX IX_PAGO_RESERVACION ON PAGO(reservacion_id);
CREATE NONCLUSTERED INDEX IX_PAGO_FECHA ON PAGO(fecha_pago);
CREATE NONCLUSTERED INDEX IX_DISPONIBILIDAD_FECHA ON DISPONIBILIDAD(fecha, experiencia_id);
CREATE NONCLUSTERED INDEX IX_AUDITORIA_TABLA ON AUDITORIA(tabla_afectada, tipo_operacion);
CREATE NONCLUSTERED INDEX IX_AUDITORIA_FECHA ON AUDITORIA(fecha_hora);
CREATE NONCLUSTERED INDEX IX_LIQUIDACION_PROVEEDOR ON LIQUIDACION(proveedor_id, periodo_inicio);

PRINT '>> 22 tablas y 17 índices creados correctamente.';
GO

-- ============================================================
-- DATOS DE PRUEBA
-- ============================================================

-- CATÁLOGOS
INSERT INTO CATEGORIA (nombre, descripcion) VALUES
('Surf', 'Surf y deportes acuáticos'),
('Volcanes', 'Tours y caminatas en volcanes'),
('Café', 'Rutas del café'),
('Gastronomía', 'Tours gastronómicos'),
('Aventura', 'Deportes extremos'),
('Cultura', 'Recorridos culturales'),
('Naturaleza', 'Ecoturismo');

INSERT INTO DESTINO (nombre, departamento) VALUES
('El Tunco', 'La Libertad'), ('Volcán de Santa Ana', 'Santa Ana'),
('Ruta de las Flores', 'Sonsonate'), ('Suchitoto', 'Cuscatlán'),
('Playa El Cuco', 'San Miguel'), ('Lago de Coatepeque', 'Santa Ana'),
('Tazumal', 'Santa Ana'), ('Cerro Verde', 'Santa Ana'),
('Joya de Cerén', 'La Libertad'), ('Boquerón', 'San Salvador');

INSERT INTO ROL (nombre) VALUES ('Administrador'), ('Turista'), ('Proveedor'), ('Guía');

INSERT INTO ESTADO_RESERVACION (nombre) VALUES ('Pendiente'), ('Confirmada'), ('Completada'), ('Cancelada'), ('En Proceso');

INSERT INTO IDIOMA (nombre, codigo_iso) VALUES
('Español','ES'),('Inglés','EN'),('Francés','FR'),('Alemán','DE'),
('Mandarín','ZH'),('Portugués','PT'),('Italiano','IT');

INSERT INTO ESPECIALIDAD (nombre) VALUES
('Surf'),('Senderismo'),('Historia'),('Gastronomía'),('Aventura extrema'),
('Avistamiento de aves'),('Fotografía'),('Buceo'),('Ciclismo de montaña'),('Cultura maya');

INSERT INTO METODO_PAGO (nombre) VALUES ('Efectivo'),('Tarjeta de Crédito'),('Tarjeta de Débito'),('Transferencia Bancaria'),('Billetera Digital');

-- PERSONAS
INSERT INTO TURISTA (nombre, apellido, email, telefono, dui, nacionalidad) VALUES
('Carlos','Martínez','carlos.martinez@email.com','7854-1234','01234567-8','Salvadoreño'),
('María','García','maria.garcia@email.com','6123-4567','02345678-9','Salvadoreña'),
('John','Smith','john.smith@email.com','7987-6543','03456789-0','Estadounidense'),
('Ana','López','ana.lopez@email.com','6543-2109','04567890-1','Salvadoreña'),
('Pierre','Dubois','pierre.dubois@email.com','7234-5678','05678901-2','Francés'),
('Elena','Rodríguez','elena.rodriguez@email.com','6876-5432','06789012-3','Salvadoreña'),
('Miguel','Hernández','miguel.hernandez@email.com','7654-3210','07890123-4','Salvadoreño'),
('Sofia','Anderson','sofia.anderson@email.com','6345-6789','08901234-5','Canadiense'),
('Diego','Ramírez','diego.ramirez@email.com','7567-8901','09012345-6','Salvadoreño'),
('Emma','Wilson','emma.wilson@email.com','6890-1234','00123456-7','Británica');

INSERT INTO PROVEEDOR (nombre_empresa, nombre_contacto, email, telefono, certificacion_mitur, tipo_comision, estado) VALUES
('Surf Adventures SV','Roberto Cálix','roberto@surfadventures.sv','7890-1234','MITUR-2024-001','PREMIUM','VERIFICADO'),
('Volcano Tours SA','Patricia Díaz','patricia@volcanotours.sv','6123-7890','MITUR-2024-002','ESTANDAR','VERIFICADO'),
('Coffee Experience','Mario Granados','mario@coffeeexp.sv','7567-2345','MITUR-2024-003','ESTANDAR','ACTIVO'),
('Aventura Extrema SV','Karla Flores','karla@aventuraextrema.sv','6890-4567','MITUR-2024-004','PREMIUM','VERIFICADO'),
('Cultura Viva Tours','Oscar Rivera','oscar@culturaviva.sv','6345-6789',NULL,'ESTANDAR','ACTIVO'),
('EcoTours El Salvador','Gabriela Mejía','gabriela@ecotours.sv','7987-8901','MITUR-2024-005','ESTANDAR','VERIFICADO');

INSERT INTO GUIA (nombre, apellido, email, telefono, dui, anios_experiencia, estado) VALUES
('José','Alvarado','jose.alvarado@experienciasv.sv','7876-5432','09876543-2',8,'CERTIFICADO'),
('Carmen','Santos','carmen.santos@experienciasv.sv','6543-2100','08765432-3',5,'CERTIFICADO'),
('David','Morales','david.morales@experienciasv.sv','7234-5670','07654321-4',12,'CERTIFICADO'),
('Laura','Pineda','laura.pineda@experienciasv.sv','6890-1230','06543210-5',3,'ACTIVO'),
('Francisco','Navarro','francisco.navarro@experienciasv.sv','7567-8900','05432109-6',15,'CERTIFICADO'),
('Andrea','Campos','andrea.campos@experienciasv.sv','6345-6780','04321098-7',6,'CERTIFICADO'),
('Ricardo','Fuentes','ricardo.fuentes@experienciasv.sv','7987-6540','03210987-8',10,'CERTIFICADO'),
('Valeria','Ortiz','valeria.ortiz@experienciasv.sv','6123-4560','02109876-9',2,'ACTIVO'),
('Alejandro','Rivas','alejandro.rivas@experienciasv.sv','7456-7890','01098765-0',7,'CERTIFICADO'),
('Natalia','Guzmán','natalia.guzman@experienciasv.sv','6678-9010','00987654-1',4,'CERTIFICADO');

-- IDIOMAS Y ESPECIALIDADES DE GUÍAS (tablas puente)
INSERT INTO GUIA_IDIOMA (guia_id, idioma_id, nivel) VALUES
(1,1,'NATIVO'),(1,2,'AVANZADO'),
(2,1,'NATIVO'),(2,2,'INTERMEDIO'),(2,3,'BASICO'),
(3,1,'NATIVO'),(3,2,'AVANZADO'),(3,4,'INTERMEDIO'),
(4,1,'NATIVO'),(4,2,'INTERMEDIO'),
(5,1,'NATIVO'),(5,2,'AVANZADO'),(5,3,'AVANZADO'),
(6,1,'NATIVO'),(6,2,'AVANZADO'),(6,6,'INTERMEDIO'),
(7,1,'NATIVO'),(7,2,'AVANZADO'),(7,5,'BASICO'),
(8,1,'NATIVO'),
(9,1,'NATIVO'),(9,2,'INTERMEDIO'),(9,7,'BASICO'),
(10,1,'NATIVO'),(10,2,'AVANZADO'),(10,4,'INTERMEDIO');

INSERT INTO GUIA_ESPECIALIDAD (guia_id, especialidad_id) VALUES
(1,1),(1,8),(2,2),(2,3),(3,2),(3,4),(3,10),(4,1),(4,5),
(5,2),(5,3),(5,7),(6,2),(6,6),(6,7),(7,2),(7,5),(7,9),
(8,1),(8,2),(9,3),(9,10),(9,7),(10,2),(10,6),(10,4);

-- TEMPORADAS Y DESCUENTOS
INSERT INTO TEMPORADA (nombre, fecha_inicio, fecha_fin, multiplicador, descripcion) VALUES
('Temporada Baja','2026-05-01','2026-06-30',1.00,'Precio base sin recargo'),
('Semana Santa','2026-03-28','2026-04-05',1.50,'Temporada alta por vacaciones'),
('Vacaciones Agosto','2026-08-01','2026-08-07',1.30,'Vacaciones de agosto'),
('Temporada Navideña','2026-12-15','2026-12-31',1.50,'Temporada alta de fin de año');

INSERT INTO DESCUENTO_GRUPO (nombre, cantidad_minima, cantidad_maxima, porcentaje_descuento) VALUES
('Grupo Mediano',5,9,10.00),
('Grupo Grande',10,20,15.00),
('Grupo VIP',21,NULL,20.00);

-- EXPERIENCIAS
INSERT INTO EXPERIENCIA (proveedor_id, categoria_id, destino_id, nombre, descripcion, duracion_horas, dificultad, edad_minima, capacidad_maxima, precio_base, incluye) VALUES
(1,1,1,'Clases de Surf en El Tunco','Aprende surf con instructores certificados en una de las mejores playas de Centroamérica',3.0,'MEDIA',10,15,35.00,'Tabla de surf, instructor, chaleco salvavidas, hidratación'),
(2,2,2,'Tour Volcán de Santa Ana','Ascenso al volcán más alto de El Salvador con vista a la laguna verde del cráter',6.0,'DIFICIL',12,20,25.00,'Guía certificado, entrada al parque, refrigerio'),
(3,3,3,'Ruta del Café','Visita a fincas cafetaleras con degustación y proceso artesanal del café',5.0,'FACIL',12,20,40.00,'Transporte, degustación, almuerzo típico, bolsa de café'),
(4,5,10,'Aventura en El Boquerón','Tirolesa y rappel en el cráter del volcán de San Salvador',4.0,'EXTREMA',14,10,55.00,'Equipo completo de seguridad, instructores, fotos'),
(5,6,4,'Tour Cultural Suchitoto','Recorrido por el centro histórico, iglesias coloniales y talleres de añil',5.0,'FACIL',0,20,22.00,'Guía histórico, entradas a museos, taller de añil'),
(6,7,6,'Eco Tour Lago de Coatepeque','Tour ecológico en el lago de origen volcánico con snorkel',5.0,'MEDIA',8,15,38.00,'Equipo snorkel, guía ecológico, lancha, almuerzo');

-- DISPONIBILIDAD
INSERT INTO DISPONIBILIDAD (experiencia_id, guia_id, fecha, hora_inicio, hora_fin, cupos_disponibles) VALUES
(1,1,'2026-06-01','08:00','11:00',15),
(1,8,'2026-06-01','14:00','17:00',15),
(2,3,'2026-06-01','06:00','12:00',20),
(3,3,'2026-06-03','09:00','14:00',20),
(4,7,'2026-06-04','08:00','12:00',10),
(5,5,'2026-06-02','10:00','15:00',20),
(6,6,'2026-06-03','09:00','14:00',15);

-- RESERVACIONES Y PAGOS
INSERT INTO RESERVACION (turista_id, experiencia_id, guia_id, temporada_id, estado_id, fecha_experiencia, cantidad_personas, precio_total) VALUES
(1,1,1,1,2,'2026-06-01',2,70.00),
(2,2,3,1,2,'2026-06-01',4,100.00),
(3,3,3,1,2,'2026-06-03',2,80.00),
(4,4,7,1,1,'2026-06-04',1,55.00),
(5,5,5,1,2,'2026-06-02',3,66.00),
(6,6,6,1,2,'2026-06-03',5,171.00);

INSERT INTO PAGO (reservacion_id, metodo_id, monto, comision_porcentaje, comision_monto, monto_neto_proveedor, estado) VALUES
(1,2,70.00,15.00,10.50,59.50,'COMPLETADO'),
(2,2,100.00,10.00,10.00,90.00,'COMPLETADO'),
(3,3,80.00,10.00,8.00,72.00,'COMPLETADO'),
(5,4,66.00,10.00,6.60,59.40,'COMPLETADO'),
(6,2,171.00,10.00,17.10,153.90,'COMPLETADO');

PRINT '>> Datos de prueba insertados correctamente.';
PRINT '>> 10 turistas, 6 proveedores, 10 guías, 6 experiencias, 6 reservaciones.';
GO
