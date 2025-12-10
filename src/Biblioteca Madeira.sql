-- -----------------------------
-- PROYECTO FINAL BIBLIOTECA MADEIRA
-- Lourdes Gabriela Gomez Sotelo
-- Isaac Antonio Antillano Cruiz 
-- Andres David Gaitan Cardona
-- Juan Camilo García Durango
-- Santiago Ruiz Gallego
-- -----------------------------

-- -----------------------------
-- 1. USUARIO
-- -----------------------------

CREATE TABLE usuario (
  id_usuario                VARCHAR (15),
  nombre_1                  VARCHAR (30) NOT NULL,
  nombre_2                  VARCHAR (30),
  ap_P                      VARCHAR (30) NOT NULL,
  ap_M                      VARCHAR (30),
  correo_institucional      VARCHAR (50) NOT NULL,
  PRIMARY KEY (id_usuario)
);

SELECT * FROM usuario;

-- -----------------------------
-- 2. ESTUDIANTE
-- -----------------------------

CREATE TABLE estudiante (
  id_estudiante           VARCHAR (15),
  codigo                  VARCHAR (20) NOT NULL,
  plan                    VARCHAR (50),
  semestre                VARCHAR (15),
  id_usuario              VARCHAR (15) NOT NULL,
  PRIMARY KEY (id_estudiante)
  FOREIGN KEY (id_usuario) REFERENCES usuario
);

SELECT * FROM estudiante;

-- -----------------------------
-- 3. PROFESOR
-- -----------------------------

CREATE TABLE profesor (
  id_profesor     VARCHAR (15),
  id_usuario      VARCHAR (15) NOT NULL, 
  PRIMARY KEY (id_profesor)
  FOREIGN KEY (id_usuario) REFERENCES usuario
);

SELECT * FROM profesor;

-- -----------------------------
-- 4. BIBLIOTECARIO
-- -----------------------------

CREATE TABLE bibliotecario (
  id_bibliotecario     VARCHAR (15),
  id_usuario           VARCHAR (15) NOT NULL, 
  PRIMARY KEY (id_bibliotecario)
  FOREIGN KEY (id_usuario) REFERENCES usuario
);

SELECT * FROM bibliotecario;

-- -----------------------------
-- 5. COLECCION
-- -----------------------------

CREATE TABLE coleccion (
  id_coleccion            VARCHAR (15),
  nombre                  VARCHAR (30)  NOT NULL,
  dias_prestamo           NUMERIC (2,0) NOT NULL,
  max_renovaciones        NUMERIC (2,0) NOT NULL,
  PRIMARY KEY (id_coleccion)
  CHECK (nombre IN ('General','Reserva','Referencia','Hemeroteca','Mapoteca','Tecnoteca'))
);

SELECT * FROM coleccion;

-- -----------------------------
-- 6. RECURSO 
-- -----------------------------

CREATE TABLE recurso (
  id_recurso          VARCHAR (15),
  nombre              VARCHAR (100) NOT NULL,
  estado              VARCHAR (20)  NOT NULL,
  id_coleccion        VARCHAR (15)  NOT NULL,
  PRIMARY KEY (id_recurso)
  FOREIGN KEY (id_coleccion) REFERENCES coleccion
  CHECK (estado IN ('Disponible','Prestado','Reservado','Perdido','Dado de baja'))
);

SELECT * FROM recurso;

-- -----------------------------
-- 7. EJEMPLAR 
-- -----------------------------

CREATE TABLE ejemplar (
  id_ejemplar     VARCHAR (15),
  id_recurso      VARCHAR (15) NOT NULL,
  num_ejemplar    VARCHAR (15) NOT NULL,
  PRIMARY KEY (id_ejemplar)
  FOREIGN KEY (id_recurso) REFERENCES recurso
);

SELECT * FROM ejemplar;

-- -----------------------------
-- 8. REVISTA
-- -----------------------------

CREATE TABLE revista (
  id_revista           VARCHAR (15),
  id_recurso           VARCHAR (15) NOT NULL,
  issn                 VARCHAR (40) NOT NULL,
  volumen              VARCHAR (20) ,
  num_edicion          VARCHAR (20) ,
  fecha_publicacion    DATE,
  editorial            VARCHAR (100),
  idioma               VARCHAR (50),
  periodicidad         VARCHAR (50),
  num_paginas          VARCHAR (20),
  PRIMARY KEY (id_revista)
  FOREIGN KEY (id_recurso) REFERENCES recurso
);

SELECT * FROM revista;

-- -----------------------------
-- 9. MAPA 
-- -----------------------------

CREATE TABLE mapa (
  id_mapa            VARCHAR (15),
  id_recurso         VARCHAR (15)   NOT NULL,
  formato            VARCHAR (10)   NOT NULL,
  descripcion        VARCHAR (100),
  PRIMARY KEY (id_coleccion)
  CHECK (formato IN ('JPG','PDF','SHAPE','DWG'))
);

SELECT * FROM mapa;