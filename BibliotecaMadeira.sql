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
-- 2. COLECCION
-- -----------------------------

CREATE TABLE coleccion (
  id_coleccion            VARCHAR (15),
  nombre                  VARCHAR (30)  NOT NULL,
  dias_prestamo           NUMERIC (2,0) NOT NULL,
  max_renovaciones        NUMERIC (2,0) NOT NULL,
  PRIMARY KEY (id_coleccion),
  CHECK (nombre IN ('general','reserva','referencia','hemeroteca','mapoteca','tecnoteca'))
);

SELECT * FROM coleccion;

-- -----------------------------
-- 3. AUTOR
-- -----------------------------

CREATE TABLE autor (
    id_autor 	     VARCHAR(10),
    primer_nombre    VARCHAR(50)  NOT NULL,
    segundo_nombre   VARCHAR(50),
    primer_apellido  VARCHAR(50)  NOT NULL,
    segundo_apellido VARCHAR(50),
	PRIMARY KEY (id_autor)
);

SELECT * FROM autor;

-- -----------------------------
-- 4. RECURSO 
-- -----------------------------

CREATE TABLE recurso (
  id_recurso          VARCHAR (15),
  nombre              VARCHAR (100) NOT NULL,
  estado              VARCHAR (20)  NOT NULL,
  id_coleccion        VARCHAR (15)  NOT NULL,
  PRIMARY KEY (id_recurso),
  FOREIGN KEY (id_coleccion) REFERENCES coleccion,
  CHECK (estado IN ('disponible','prestado','reservado','perdido','dado de baja'))
);

SELECT * FROM recurso;

-- -----------------------------
-- 5. DISPOSITIVO
-- -----------------------------

CREATE TABLE dispositivo (
    id_dispositivo    VARCHAR(15),
    marca             VARCHAR(50),
    modelo            VARCHAR(50),
    cargador          INT            NOT NULL,
    funda             INT            NOT NULL,
    id_recurso        VARCHAR(15)    NOT NULL,
	PRIMARY KEY (id_dispositivo),
    FOREIGN KEY (id_recurso) REFERENCES recurso
);

SELECT * FROM dispositivo;

-- -----------------------------
-- 6. MAPA 
-- -----------------------------

CREATE TABLE mapa (
  id_mapa            VARCHAR (15),
  id_recurso         VARCHAR (15)   NOT NULL,
  formato            VARCHAR (10)   NOT NULL,
  descripcion        VARCHAR (100)  NOT NULL,
  PRIMARY KEY (id_mapa),
  CHECK (formato IN ('JPG','PDF','SHAPE','DWG')),
  FOREIGN KEY (id_recurso) REFERENCES recurso
);

SELECT * FROM mapa;


-- -----------------------------
-- 7. REVISTA
-- -----------------------------

CREATE TABLE revista (
  id_revista           VARCHAR (15),
  id_recurso           VARCHAR (15)  NOT NULL,
  issn                 VARCHAR (40)  NOT NULL,
  volumen              VARCHAR (20),
  num_edicion          VARCHAR (20)  NOT NULL,
  fecha_publicacion    DATE,
  editorial            VARCHAR (100) NOT NULL,
  idioma               VARCHAR (50)  NOT NULL,
  periodicidad         VARCHAR (50),
  num_paginas          INT,
  PRIMARY KEY (id_revista),
  FOREIGN KEY (id_recurso) REFERENCES recurso
);

SELECT * FROM revista;

-- -----------------------------
-- 8. USB
-- -----------------------------

CREATE TABLE usb (
    id_usb VARCHAR(10),
    estado VARCHAR(20) NOT NULL,
	PRIMARY KEY (id_usb),
	CHECK (estado IN ('disponible','prestado','reservado','perdido','dado de baja'))
);

SELECT * FROM usb;

-- -----------------------------
-- 9. USB_MAPA
-- -----------------------------

CREATE TABLE usb_mapa (
    id_usb VARCHAR(15)  NOT NULL,
    id_mapa VARCHAR(15) NOT NULL,
    FOREIGN KEY (id_usb) REFERENCES usb,
    FOREIGN KEY (id_mapa) REFERENCES mapa
);

SELECT * FROM usb_mapa;

-- -----------------------------
-- 10. EJEMPLAR 
-- -----------------------------

CREATE TABLE ejemplar (
  id_ejemplar     VARCHAR (15),
  id_recurso      VARCHAR (15)  NOT NULL,
  num_ejemplar    INT           NOT NULL,
  PRIMARY KEY (id_ejemplar),
  FOREIGN KEY (id_recurso) REFERENCES recurso
);

SELECT * FROM ejemplar;

-- -----------------------------
-- 11. LAPTOP 
-- -----------------------------

CREATE TABLE laptop (
    id_laptop       VARCHAR(15),
    id_dispositivo  VARCHAR(15)  NOT NULL,
	PRIMARY KEY (id_laptop),
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivo
);

SELECT * FROM laptop;

-- -----------------------------
-- 12. TABLETA 
-- -----------------------------

CREATE TABLE tableta (
    id_tableta      VARCHAR(15),
    id_dispositivo  VARCHAR(15) NOT NULL,
	PRIMARY KEY (id_tableta),
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivo
);

SELECT * FROM tableta;

-- -----------------------------
-- 13. ESTUDIANTE
-- -----------------------------

CREATE TABLE estudiante (
  id_estudiante           VARCHAR (15),
  codigo                  VARCHAR (20) NOT NULL,
  plan                    VARCHAR (50) NOT NULL,
  semestre                INT,
  id_usuario              VARCHAR (15) NOT NULL,
  PRIMARY KEY (id_estudiante),
  FOREIGN KEY (id_usuario) REFERENCES usuario
);

SELECT * FROM estudiante;

-- -----------------------------
-- 14. PROFESOR
-- -----------------------------

CREATE TABLE profesor (
  id_profesor     VARCHAR (15),
  id_usuario      VARCHAR (15) NOT NULL, 
  PRIMARY KEY (id_profesor),
  FOREIGN KEY (id_usuario) REFERENCES usuario
);

SELECT * FROM profesor;

DROP TABLE IF EXISTS profesor CASCADE;

CREATE TABLE profesor (
  id_profesor     VARCHAR (15),
  id_usuario      VARCHAR (15) NOT NULL, 
  PRIMARY KEY (id_profesor),
  FOREIGN KEY (id_usuario) REFERENCES usuario
);

-- -----------------------------
-- 15. BIBLIOTECARIO
-- -----------------------------

CREATE TABLE bibliotecario (
  id_bibliotecario     VARCHAR (15),
  id_usuario           VARCHAR (15) NOT NULL, 
  PRIMARY KEY (id_bibliotecario),
  FOREIGN KEY (id_usuario) REFERENCES usuario
);

SELECT * FROM bibliotecario;

-- -----------------------------
-- 16. LIBRO
-- -----------------------------

CREATE TABLE libro (
  id_libro             VARCHAR(15),
  isbn                 VARCHAR(30)     NOT NULL,
  resumen              VARCHAR(500),
  fecha_publicacion    DATE,
  editorial            VARCHAR(100)    NOT NULL,
  idioma               VARCHAR(50)     NOT NULL,
  num_paginas          INT,
  largo                INT,
  ancho                INT,
  grosor               INT,
  tipo_encuadernacion  VARCHAR(30),
  id_recurso           VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_libro),
  FOREIGN KEY (id_recurso) REFERENCES recurso,
  CHECK (tipo_encuadernacion IN ('Tapa blanda','Tapa dura'))
  
);

SELECT * FROM libro;

-- -----------------------------
-- 17. LIBRO GENERAL
-- -----------------------------

CREATE TABLE libro_general (
  id_libro_generico   VARCHAR(15),
  volumen             INT,
  num_edicion         INT,
  id_libro            VARCHAR(15)  NOT NULL,
  PRIMARY KEY (id_libro_generico),
  FOREIGN KEY (id_libro) REFERENCES libro
);

SELECT * FROM libro_general;

-- -----------------------------
-- 18. LIBRO ACADEMICO
-- -----------------------------

CREATE TABLE libro_academico (
  id_libro_academico  VARCHAR(15),
  id_libro            VARCHAR(15)  NOT NULL,
  PRIMARY KEY (id_libro_academico),
  FOREIGN KEY (id_libro) REFERENCES libro
);

SELECT * FROM libro_academico;

-- -----------------------------
-- 19. DICCIONARIO
-- -----------------------------

CREATE TABLE diccionario (
  id_diccionario   VARCHAR(15),
  id_libro         VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_diccionario),
  FOREIGN KEY (id_libro) REFERENCES libro
);

SELECT * FROM diccionario;

-- -----------------------------
-- 20. LIBRO_AUTOR
-- -----------------------------

CREATE TABLE autor_libro (
  id_autor   VARCHAR(15) NOT NULL,
  id_libro   VARCHAR(15) NOT NULL,
  FOREIGN KEY (id_autor) REFERENCES autor,
  FOREIGN KEY (id_libro) REFERENCES libro
);

SELECT * FROM autor_libro;

-- -----------------------------
-- 21. PRESTAMO
-- -----------------------------

CREATE TABLE prestamo (
  id_prestamo             VARCHAR(15),
  id_ejemplar             VARCHAR(15) NOT NULL,
  id_usb                  VARCHAR(15) NOT NULL,
  id_usuario              VARCHAR(15) NOT NULL,
  id_bibliotecario        VARCHAR(15) NOT NULL,
  fecha_prestamo          DATE        NOT NULL,
  hora_prestamo           TIME        NOT NULL,
  fecha_devolucion        DATE        NOT NULL,
  fecha_devolucion_real   DATE        NOT NULL,
  conteo_renovaciones     INT         NOT NULL,
  medio_entrega           VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_prestamo),
  FOREIGN KEY (id_ejemplar) REFERENCES ejemplar,
  FOREIGN KEY (id_usb) REFERENCES usb,
  FOREIGN KEY (id_usuario) REFERENCES usuario,
  FOREIGN KEY (id_bibliotecario) REFERENCES bibliotecario,
  CHECK (medio_entrega IN ('Fisico','Usb'))
);

SELECT * FROM prestamo;

-- -----------------------------
-- 22. RESERVA
-- -----------------------------

CREATE TABLE reserva (
  id_reserva        VARCHAR(15),
  id_ejemplar       VARCHAR(15) NOT NULL,
  id_usuario        VARCHAR(15) NOT NULL,
  id_bibliotecario  VARCHAR(15) NOT NULL,
  fecha_reserva     DATE        NOT NULL,
  hora_reserva      TIME        NOT NULL,
  vence             DATE        NOT NULL,
  cola              INT         NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_ejemplar) REFERENCES ejemplar(id_ejemplar),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_bibliotecario) REFERENCES bibliotecario(id_bibliotecario)
);

SELECT * FROM reserva;

-- -----------------------------
-- 23. RENOVACION
-- -----------------------------

CREATE TABLE renovacion (
  id_renovacion      VARCHAR(15),
  id_prestamo        VARCHAR(15)  NOT NULL,
  id_bibliotecario   VARCHAR(15)  NOT NULL,
  fecha_renovacion   DATE         NOT NULL,
  PRIMARY KEY (id_renovacion),
  FOREIGN KEY (id_prestamo) REFERENCES prestamo,
  FOREIGN KEY (id_bibliotecario) REFERENCES bibliotecario
);

SELECT * FROM renovacion;

-- -----------------------------
-- 24. MULTA
-- -----------------------------

CREATE TABLE multa (
  id_multa        VARCHAR(15),
  id_prestamo     VARCHAR(15)   NOT NULL,
  dias_atraso     INT           NOT NULL,
  valor_calculado NUMERIC(10,2) NOT NULL,
  pagada          BOOLEAN       NOT NULL,
  fecha_pago      DATE          NOT NULL,
  PRIMARY KEY (id_multa),
  FOREIGN KEY (id_prestamo) REFERENCES prestamo
);
 
SELECT * FROM multa;

-- ========================================================
-- DATOS DE LAS TABLAS 
-- ========================================================

-- 1. USUARIO

INSERT INTO usuario (id_usuario, nombre_1, nombre_2, ap_P, ap_M, correo_institucional) VALUES
('USR-001','santiago','sebastian','ruiz','gallego','ruiz.santiago@correounivalle.edu.co'),
('USR-002','andres','david','gaitan','cardona','gaitan.andres@correounivalle.edu.co'),
('USR-003','lourdes','gabriela','gomez','sotelo','gomez.lourdes@correounivalle.edu.co'),
('USR-004','juan','camilo','garcia','durango','garcia.juan@correounivalle.edu.co'),
('USR-005','isaac','antonio','antillano','cruiz','antillano.isaac@correounivalle.edu.co'),
('USR-006','maria','fernanda','lopez','martinez','lopez.maria@correounivalle.edu.co'),
('USR-007','camila','andrea','rodriguez','perez','rodriguez.camila@correounivalle.edu.co'),
('USR-008','sofia','alejandra','herrera','salazar','herrera.sofia@correounivalle.edu.co'),
('USR-009','valentina','paola','ramirez','mesa','ramirez.valentina@correounivalle.edu.co'),
('USR-010','laura','isabel','morales','hurtado','morales.laura@correounivalle.edu.co'),
('USR-011','juliana','andrea','castro','lozano','castro.juliana@correounivalle.edu.co'),
('USR-012','paula','andrea','ortiz','prado','ortiz.paula@correounivalle.edu.co'),
('USR-013','ana','maria','muñoz','garzon','munoz.ana@correounivalle.edu.co'),
('USR-014','diana','carolina','escobar','quintero','escobar.diana@correounivalle.edu.co'),
('USR-015','karen','lorena','salazar','rojas','salazar.karen@correounivalle.edu.co'),
('USR-016','melissa','andrea','castaño','bolaños','castano.melissa@correounivalle.edu.co'),
('USR-017','natalia','sofia','paredes','valencia','paredes.natalia@correounivalle.edu.co'),
('USR-018','andrea','milena','medina','torres','medina.andrea@correounivalle.edu.co'),
('USR-019','estefania','juliet','blanco','reyes','blanco.estefania@correounivalle.edu.co'),
('USR-020','carolina','maria','cardenas','suarez','cardenas.carolina@correounivalle.edu.co'),
('USR-021','daniel','andres','ramirez','salinas','ramirez.daniel@correounivalle.edu.co'),
('USR-022','sebastian','andres','lozano','gil','lozano.sebastian@correounivalle.edu.co'),
('USR-023','felipe','alejandro','gonzalez','prieto','gonzalez.felipe@correounivalle.edu.co'),
('USR-024','mateo','andres','perez','muñoz','perez.mateo@correounivalle.edu.co'),
('USR-025','nicolas','david','rojas','medina','rojas.nicolas@correounivalle.edu.co'),
('USR-026','simon','esteban','hurtado','cuellar','hurtado.simon@correounivalle.edu.co'),
('USR-027','diego','armando','martinez','soto','martinez.diego@correounivalle.edu.co'),
('USR-028','carlos','alberto','castillo','vargas','castillo.carlos@correounivalle.edu.co'),
('USR-029','jorge','luis','velasco','escobar','velasco.jorge@correounivalle.edu.co'),
('USR-030','david','santiago','arenas','marin','arenas.david@correounivalle.edu.co'),
('USR-031','tomas','felipe','villarreal','quiceno','villarreal.tomas@correounivalle.edu.co'),
('USR-032','gabriel','esteban','salinas','roja','salinas.gabriel@correounivalle.edu.co'),
('USR-033','samuel','david','espinosa','toro','espinosa.samuel@correounivalle.edu.co'),
('USR-034','julian','alonso','caicedo','bravo','caicedo.julian@correounivalle.edu.co'),
('USR-035','alexander','jose','murillo','solis','murillo.alexander@correounivalle.edu.co'),
('USR-036','lucia','fernanda','mejia','solano','mejia.lucia@correounivalle.edu.co'),
('USR-037','martina','valeria','molina','serna','molina.martina@correounivalle.edu.co'),
('USR-038','emilia','alejandra','giraldo','tamayo','giraldo.emilia@correounivalle.edu.co'),
('USR-039','sara','luciana','zapata','amaya','zapata.sara@correounivalle.edu.co'),
('USR-040','abigail','sofia','rios','castañeda','rios.abigail@correounivalle.edu.co'),
('USR-041','elena','maria','martinez','padilla','martinez.elena@correounivalle.edu.co'),
('USR-042','antonia','lucia','valencia','diaz','valencia.antonia@correounivalle.edu.co'),
('USR-043','victoria','andrea','barrios','londono','barrios.victoria@correounivalle.edu.co'),
('USR-044','renata','julieta','arenas','campos','arenas.renata@correounivalle.edu.co'),
('USR-045','isabella','sofia','bravo','ruiz','bravo.isabella@correounivalle.edu.co'),
('USR-046','benjamin','santiago','zapata','moreno','zapata.benjamin@correounivalle.edu.co'),
('USR-047','emilio','andres','cabrera','torres','cabrera.emilio@correounivalle.edu.co'),
('USR-048','maximiliano','jose','rios','arenas','rios.maximiliano@correounivalle.edu.co'),
('USR-049','martin','andres','romero','arango','romero.martin@correounivalle.edu.co'),
('USR-050','thiago','esteban','jimenez','colorado','jimenez.thiago@correounivalle.edu.co'),
('USR-051','dante','alejandro','cordero','sierra','cordero.dante@correounivalle.edu.co'),
('USR-052','bruno','emilio','aguilar','mejia','aguilar.bruno@correounivalle.edu.co'),
('USR-053','leonardo','javier','rubio','camacho','rubio.leonardo@correounivalle.edu.co'),
('USR-054','adrian','johan','nieves','alzate','nieves.adrian@correounivalle.edu.co'),
('USR-055','gael','esteban','villada','morales','villada.gael@correounivalle.edu.co'),
('USR-056','ricardo','jose','lozano','pardo','lozano.ricardo@correounivalle.edu.co'),
('USR-057','esteban','mateo','cepeda','rincon','cepeda.esteban@correounivalle.edu.co'),
('USR-058','marco','antonio','escamilla','vera','escamilla.marco@correounivalle.edu.co'),
('USR-059','enzo','david','barrera','rosero','barrera.enzo@correounivalle.edu.co'),
('USR-060','alan','felipe','arias','barbosa','arias.alan@correounivalle.edu.co'),
('USR-061','hugo','emilio','cotes','salgado','cotes.hugo@correounivalle.edu.co'),
('USR-062','oscar','daniel','pantoja','ibarra','pantoja.oscar@correounivalle.edu.co'),
('USR-063','elias','samuel','cifuentes','caro','cifuentes.elias@correounivalle.edu.co');

-- 2. COLECCION

INSERT INTO coleccion (id_coleccion, nombre, dias_prestamo, max_renovaciones) VALUES
('CO-01', 'general', '15', '5'),
('CO-02', 'reserva', '5', '0'),
('CO-03', 'referencia', '3', '2'),
('CO-04', 'hemeroteca', '1', '1'),
('CO-05', 'mapoteca', '1', '0'),
('CO-06', 'tecnoteca', '7', '2');

-- 3. AUTOR 

INSERT INTO autor (id_autor, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido) VALUES
('AU-01','Gabriel',null,'García','Márquez'),
('AU-02','Jorge','Luis','Borges',null),
('AU-03','Ricardo','Eliecer','Neftalí','Reyes'),
('AU-04','María','Fernanda','López','Castillo'),
('AU-05','Juan','Sebastián','Ramírez','Ocampo'),
('AU-06','Laura','Valentina','Torres','Medina'),
('AU-07','Andrés','Felipe','Gómez','Rivas'),
('AU-08','Sofía','Alejandra','Martínez','Díaz'),
('AU-09','Carlos','Eduardo','Herrera','Jiménez'),
('AU-10','Daniela','Carolina','Ruiz','Páez'),
('AU-11','Luis','Alberto','Salazar','Montoya'),
('AU-12','Paula','Andrea','Castaño','Rivera'),
('AU-13','Diego','Armando','Becerra','Quintero'),
('AU-14','Natalia','Sofía','Cabrera','Lozano'),
('AU-15','Sergio','Esteban','Vargas','Duarte'),
('AU-16','Karen','Juliana','Pineda','Roldán'),
('AU-17','Felipe','Andrés','Cardona','Ríos'),
('AU-18','Isabella','María','Alarcón','Vélez'),
('AU-19','Mateo','Julián','Pérez','Trujillo'),
('AU-20','Camila','Lucía','Castillo','Bermúdez'),
('AU-21','David','Alejandro','Franco','Guzmán'),
('AU-22','Juliana','Patricia','Luna','Hoyos'),
('AU-23','Santiago','Iván','Cárdenas','Beltrán'),
('AU-24','Ana','Gabriela','Rojas','Pardo'),
('AU-25','Tomás','Ignacio','Benítez','Cáceres'),
('AU-26','Valeria','Sofía','Montiel','Zamora'),
('AU-27','Marcos','Elías','Correa','Zapata'),
('AU-28','Lucía','Elena','Navarro','Patiño'),
('AU-29','Samuel','Fernando','Duarte','Sepúlveda'),
('AU-30','Adriana','Marcela','Rincón','Prieto'),
('AU-31','Esteban','Mauricio','León','Robledo'),
('AU-32','Mariana','Isabel','Rentería','Mena'),
('AU-33','Hugo','Alberto','Ramírez','Cifuentes'),
('AU-34','Alejandra','Sofía','Velasco','Molina'),
('AU-35','Cristian','David','Torres','Ceballos'),
('AU-36','Lina','Marcela','Castañeda','Hoyos'),
('AU-37','Pablo','Andrés','Jaramillo','Gómez'),
('AU-38','Fernanda','Lucía','Montaño','Rivera'),
('AU-39','Julián','Esteban','Pardo','Restrepo'),
('AU-40','Elisa','María','Osorio','Cañas'),
('AU-41','Camilo','José','Gutiérrez','Peña'),
('AU-42','Ariana','Beatriz','Castillo','Solís'),
('AU-43','Miguel','Ángel','Serrano','Zambrano'),
('AU-44','Rosa','Elena','Manrique','Duarte'),
('AU-45','Jaime','Eduardo','Sarmiento','Ulloa'),
('AU-46','Teresa','Inés','Bravo','Londoño'),
('AU-47','Bruno','Alejandro','Navarro','Castaño'),
('AU-48','Silvia','Andrea','Palacio','Lozada'),
('AU-49','Ramiro','José','Cifuentes','Arango'),
('AU-50','Diana','Marcela','Montoya','Laverde'),
('AU-51','Emiliano','Rafael','Padilla','Ospina'),
('AU-52','Rosaura','Elena','Zúñiga','Carrillo'),
('AU-53','Ignacio','Tomás','Caballero','Pineda'),
('AU-54','Mónica','Isabel','Andrade','Barrios'),
('AU-55','Juanita','María','Herrera','Villamil'),
('AU-56','Eduardo','Daniel','Pizarro','Ledesma'),
('AU-57','Catalina','Antonia','Delgado','Rincón'),
('AU-58','Damián','Joaquín','Figueroa','Acosta'),
('AU-59','Lorena','Patricia','Roldán','Mejía'),
('AU-60','Estela','Rosario','Aguirre','Mendoza');

-- 4. RECURSO

INSERT INTO recurso (id_recurso, nombre, estado, id_coleccion) VALUES
('R-001', 'Cien años de soledad', 'prestado', 'CO-01'),
('R-002', 'El amor en los tiempos del cólera', 'disponible', 'CO-01'),
('R-003', 'La sombra del viento', 'disponible', 'CO-01'),
('R-004', 'El túnel', 'disponible', 'CO-01'),
('R-005', 'Rayuela', 'disponible', 'CO-01'),
('R-006', 'Pedro Páramo', 'disponible', 'CO-01'),
('R-007', 'El viejo y el mar', 'disponible', 'CO-01'),
('R-008', 'La metamorfosis', 'disponible', 'CO-01'),
('R-009', 'Orgullo y prejuicio', 'disponible', 'CO-01'),
('R-010', 'Don Quijote de la Mancha', 'disponible', 'CO-01'),
('R-011', 'Fahrenheit 451', 'disponible', 'CO-01'),
('R-012', '1984', 'disponible', 'CO-01'),
('R-013', 'Rebelión en la granja', 'disponible', 'CO-01'),
('R-014', 'Crónica de una muerte anunciada', 'disponible', 'CO-01'),
('R-015', 'El perfume', 'disponible', 'CO-01'),
('R-016', 'El principito', 'reservado', 'CO-01'),
('R-017', 'La casa de los espíritus', 'disponible', 'CO-01'),
('R-018', 'Ensayo sobre la ceguera', 'perdido', 'CO-01'),
('R-019', 'El Hobbit', 'dado de baja', 'CO-01'),
('R-020', 'El guardián entre el centeno', 'prestado', 'CO-01'),
('R-021', 'Cálculo Diferencial – Stewart', 'disponible', 'CO-02'),
('R-022', 'Fundamentos de Física – Halliday & Resnick', 'disponible', 'CO-02'),
('R-023', 'Biología – Campbell', 'disponible', 'CO-02'),
('R-024', 'Álgebra Lineal – Lay', 'disponible', 'CO-02'),
('R-025', 'Estadística Aplicada – Walpole', 'disponible', 'CO-02'),
('R-026', 'Contabilidad Financiera – Horngren', 'disponible', 'CO-02'),
('R-027', 'Química General – Chang', 'disponible', 'CO-02'),
('R-028', 'Programación en C – Deitel', 'disponible', 'CO-02'),
('R-029', 'Microeconomía – Mankiw', 'perdido', 'CO-02'),
('R-030', 'Macroeconomía – Blanchard', 'perdido', 'CO-02'),
('R-031', 'Fundamentos de Administración – Koontz', 'disponible', 'CO-02'),
('R-032', 'Inteligencia Artificial – Russell & Norvig', 'disponible', 'CO-02'),
('R-033', 'Data Science from Scratch – Joel Grus', 'disponible', 'CO-02'),
('R-034', 'Database System Concepts – Silberschatz', 'disponible', 'CO-02'),
('R-035', 'Redes de Computadoras – Tanenbaum', 'disponible', 'CO-02'),
('R-036', 'Métodos Numéricos – Chapra', 'disponible', 'CO-02'),
('R-037', 'Ingeniería de Software – Sommerville', 'disponible', 'CO-02'),
('R-038', 'Cálculo Integral – Stewart', 'disponible', 'CO-02'),
('R-039', 'Física Moderna – Tipler', 'disponible', 'CO-02'),
('R-040', 'Probabilidad – Sheldon Ross', 'disponible', 'CO-02'),
('R-041', 'Diccionario de la Lengua Española (RAE)', 'prestado', 'CO-03'),
('R-042', 'Diccionario Oxford Inglés–Español', 'disponible', 'CO-03'),
('R-043', 'Larousse Francés–Español', 'disponible', 'CO-03'),
('R-044', 'Enciclopedia Britannica', 'dado de baja', 'CO-03'),
('R-045', 'Diccionario Médico Dorland', 'disponible', 'CO-03'),
('R-046', 'Diccionario Jurídico Cabanellas', 'disponible', 'CO-03'),
('R-047', 'Diccionario de Sinónimos y Antónimos Espasa', 'disponible', 'CO-03'),
('R-048', 'Diccionario Alemán–Español Pons', 'disponible', 'CO-03'),
('R-049', 'Diccionario de Física Oxford', 'disponible', 'CO-03'),
('R-050', 'Diccionario de Química McGraw-Hill', 'disponible', 'CO-03'),
('R-051', 'Diccionario de Matemáticas Wiley', 'disponible', 'CO-03'),
('R-052', 'Diccionario Filosófico – Ferrater Mora', 'disponible', 'CO-03'),
('R-053', 'Diccionario de Economía – Penguin', 'dado de baja', 'CO-03'),
('R-054', 'Diccionario de Biología – Oxford', 'disponible', 'CO-03'),
('R-055', 'Diccionario de Programación – O’Reilly', 'disponible', 'CO-03'),
('R-056', 'Diccionario Etimológico – Corominas', 'disponible', 'CO-03'),
('R-057', 'Diccionario Histórico de la Lengua', 'disponible', 'CO-03'),
('R-058', 'Diccionario Geográfico – Espasa', 'disponible', 'CO-03'),
('R-059', 'Diccionario Ilustrado Vox', 'disponible', 'CO-03'),
('R-060', 'Diccionario Literario – Larousse', 'perdido', 'CO-03'),
('R-061', 'National Geographic', 'disponible', 'CO-04'),
('R-062', 'Science Magazine', 'disponible', 'CO-04'),
('R-063', 'Nature', 'perdido', 'CO-04'),
('R-064', 'Muy Interesante', 'disponible', 'CO-04'),
('R-065', 'Revista Medicina Hoy', 'disponible', 'CO-04'),
('R-066', 'Historia y Sociedad', 'disponible', 'CO-04'),
('R-067', 'Revista de Economía y Finanzas', 'disponible', 'CO-04'),
('R-068', 'Química Hoy', 'disponible', 'CO-04'),
('R-069', 'Investigación y Ciencia', 'disponible', 'CO-04'),
('R-070', 'Revista de Biología Molecular', 'disponible', 'CO-04'),
('R-071', 'Revista Ingeniería Moderna', 'disponible', 'CO-04'),
('R-072', 'Arquitectura Viva', 'disponible', 'CO-04'),
('R-073', 'Revista Educación Global', 'disponible', 'CO-04'),
('R-074', 'Arte y Cultura Contemporánea', 'disponible', 'CO-04'),
('R-075', 'Salud y Ciencia', 'disponible', 'CO-04'),
('R-076', 'Mapa Político Mundial – Rand McNally', 'disponible', 'CO-05'),
('R-077', 'Mapa Físico Mundial – National Geographic', 'disponible', 'CO-05'),
('R-078', 'Mapa de Sudamérica – IGAC', 'disponible', 'CO-05'),
('R-079', 'Mapa de Colombia – IGAC', 'disponible', 'CO-05'),
('R-080', 'Mapa Histórico de Europa – Oxford', 'disponible', 'CO-05'),
('R-081', 'Mapa Temático: Climas del Mundo', 'disponible', 'CO-05'),
('R-082', 'Mapa Temático: Población Mundial', 'disponible', 'CO-05'),
('R-083', 'Mapa Vial del Valle del Cauca – INVIAS', 'disponible', 'CO-05'),
('R-084', 'Mapa Geológico Mundial', 'disponible', 'CO-05'),
('R-085', 'Mapa Hidrológico Mundial', 'disponible', 'CO-05'),
('R-086', 'Mapa Político de Asia', 'disponible', 'CO-05'),
('R-087', 'Mapa Físico de África', 'disponible', 'CO-05'),
('R-088', 'Mapa Turístico de Bogotá', 'disponible', 'CO-05'),
('R-089', 'Mapa Temático: Agricultura', 'disponible', 'CO-05'),
('R-090', 'Mapa de Rutas Marítimas', 'disponible', 'CO-05'),
('R-091', 'Laptop Lenovo ThinkPad E14', 'prestado', 'CO-06'),
('R-092', 'Laptop Dell Inspiron 3505', 'disponible', 'CO-06'),
('R-093', 'Laptop HP Pavilion 15', 'disponible', 'CO-06'),
('R-094', 'Laptop Asus VivoBook 16', 'disponible', 'CO-06'),
('R-095', 'Laptop Acer Aspire 5', 'disponible', 'CO-06'),
('R-096', 'Tableta Samsung Galaxy Tab A8', 'reservado', 'CO-06'),
('R-097', 'Tableta Lenovo Tab M10', 'disponible', 'CO-06');

-- 5. DISPOSITIVO 

INSERT INTO dispositivo (id_dispositivo, marca, modelo, cargador, funda, id_recurso) VALUES
('DP-01', 'Lenovo', 'T480', '2', '4', 'R-091'),
('DP-02', 'Samsung', 'Galaxy A7', '8', '12', 'R-092'),
('DP-03', 'Apple', 'iPad Air', '5', '10', 'R-093'),
('DP-04', 'HP', 'Pavilion X360', '3', '6', 'R-094'),
('DP-05', 'Huawei', 'MatePad 11', '4', '8', 'R-095'),
('DP-06', 'Dell', 'Latitude 5400', '2', '5', 'R-096'),
('DP-07', 'Amazon', 'Fire HD 10', '6', '9', 'R-097');

-- 6. MAPA 

INSERT INTO mapa (id_mapa, formato, descripcion, id_recurso) VALUES
('MP-01', 'JPG', 'Mapa político mundial en alta resolución', 'R-076'),
('MP-02', 'PDF', 'Mapa físico de América del Sur con curvas de nivel', 'R-077'),
('MP-03', 'SHAPE', 'Capas geográficas de municipios de Colombia', 'R-078'),
('MP-04', 'DWG', 'Plano urbano detallado de Cali zona norte', 'R-079'),
('MP-05', 'JPG', 'Mapa turístico del Valle del Cauca', 'R-080'),
('MP-06', 'JPG', 'Mapa hidrográfico del territorio colombiano', 'R-081'),
('MP-07', 'PDF', 'Mapa temático de densidad poblacional de Latinoamérica', 'R-082'),
('MP-08', 'SHAPE', 'Base cartográfica de vías principales en Colombia', 'R-083'),
('MP-09', 'DWG', 'Plano arquitectónico del centro histórico', 'R-084'),
('MP-10', 'JPG', 'Mapa climático mundial por zonas térmicas', 'R-085'),
('MP-11', 'JPG', 'Mapa de parques naturales nacionales', 'R-086'),
('MP-12', 'PDF', 'Mapa histórico de los imperios europeos', 'R-087'),
('MP-13', 'SHAPE', 'Capas de uso del suelo para análisis ambiental', 'R-088'),
('MP-14', 'DWG', 'Plano estructural de infraestructura vial', 'R-089'),
('MP-15', 'JPG', 'Mapa político de Asia actualizado', 'R-090');

-- 7. REVISTA 

INSERT INTO revista (id_revista,issn, volumen, num_edicion, fecha_publicacion, editorial, idioma, periodicidad, num_paginas,id_recurso) VALUES
('RV-01','1234-5879','15','6','10/06/2023','IEEE','Inglés','mensual','85','R-061'),
('RV-02','2345-8798','12','3','5/09/2022','Univalle','Español','trimestral','65','R-062'),
('RV-03','9876-5432','10','4','15/02/2023','National Geographic','Inglés','mensual','78','R-063'),
('RV-04','7654-3210','8','2','20/11/2022','Springer','Inglés','bimestral','92','R-064'),
('RV-05','8899-1122','14','7','10/05/2023','Elsevier','Inglés','trimestral','110','R-065'),
('RV-06','5566-7788','11','3','30/08/2022','Oxford','Inglés','mensual','64','R-066'),
('RV-07','3344-5566','9','1','12/01/2023','Univalle','Español','trimestral','70','R-067'),
('RV-08','4433-2211','13','5','22/07/2023','IEEE','Inglés','mensual','88','R-068'),
('RV-09','2211-8899','7','2','18/12/2022','Harvard Press','Inglés','anual','130','R-069'),
('RV-10','9988-7766','12','4','5/03/2023','Universidad Nacional','Español','bimestral','90','R-070'),
('RV-11','1122-3344','10','3','19/04/2023','Wiley','Inglés','mensual','72','R-071'),
('RV-12','6677-8899','8','2','7/10/2022','Elsevier','Inglés','trimestral','95','R-072'),
('RV-13','5544-3322','6','1','16/09/2023','Nature Publishing','Inglés','mensual','105','R-073'),
('RV-14','7788-5566','11','3','27/06/2023','Springer','Inglés','trimestral','85','R-074'),
('RV-15','9900-1122','9','2','14/07/2022','Univalle','Español','bimestral','68','R-075');

-- 8. USB 

INSERT INTO usb (id_usb, estado) VALUES 
('USB-01', 'disponible');

-- 9. USB_MAPA

INSERT INTO usb_mapa (id_usb, id_mapa) VALUES
('USB-01', 'MP-01'),
('USB-01', 'MP-02'),
('USB-01', 'MP-03'),
('USB-01', 'MP-04'),
('USB-01', 'MP-05'),
('USB-01', 'MP-06'),
('USB-01', 'MP-07'),
('USB-01', 'MP-08'),
('USB-01', 'MP-09'),
('USB-01', 'MP-10'),
('USB-01', 'MP-11'),
('USB-01', 'MP-12'),
('USB-01', 'MP-13'),
('USB-01', 'MP-14'),
('USB-01', 'MP-15');

-- 10. EJEMPLAR 

INSERT INTO ejemplar (id_ejemplar, id_recurso, num_ejemplar) VALUES
('EJ-01','R-001','1'),
('EJ-02','R-001','2'),
('EJ-03','R-001','3'),
('EJ-04','R-001','4'),
('EJ-05','R-001','5'),
('EJ-06','R-002','1'),
('EJ-07','R-002','2'),
('EJ-08','R-002','3'),
('EJ-09','R-002','4'),
('EJ-10','R-002','5'),
('EJ-11','R-003','1'),
('EJ-12','R-003','2'),
('EJ-13','R-003','3'),
('EJ-14','R-003','4'),
('EJ-15','R-003','5'),
('EJ-16','R-004','1'),
('EJ-17','R-004','2'),
('EJ-18','R-004','3'),
('EJ-19','R-004','4'),
('EJ-20','R-004','5'),
('EJ-21','R-005','1'),
('EJ-22','R-005','2'),
('EJ-23','R-005','3'),
('EJ-24','R-005','4'),
('EJ-25','R-005','5'),
('EJ-26','R-006','1'),
('EJ-27','R-006','2'),
('EJ-28','R-006','3'),
('EJ-29','R-006','4'),
('EJ-30','R-006','5'),
('EJ-31','R-007','1'),
('EJ-32','R-007','2'),
('EJ-33','R-007','3'),
('EJ-34','R-007','4'),
('EJ-35','R-007','5'),
('EJ-36','R-008','1'),
('EJ-37','R-008','2'),
('EJ-38','R-008','3'),
('EJ-39','R-008','4'),
('EJ-40','R-008','5'),
('EJ-41','R-009','1'),
('EJ-42','R-009','2'),
('EJ-43','R-009','3'),
('EJ-44','R-009','4'),
('EJ-45','R-009','5'),
('EJ-46','R-010','1'),
('EJ-47','R-010','2'),
('EJ-48','R-010','3'),
('EJ-49','R-010','4'),
('EJ-50','R-010','5'),
('EJ-51','R-011','1'),
('EJ-52','R-011','2'),
('EJ-53','R-011','3'),
('EJ-54','R-011','4'),
('EJ-55','R-011','5'),
('EJ-56','R-012','1'),
('EJ-57','R-012','2'),
('EJ-58','R-012','3'),
('EJ-59','R-012','4'),
('EJ-60','R-012','5'),
('EJ-61','R-013','1'),
('EJ-62','R-013','2'),
('EJ-63','R-013','3'),
('EJ-64','R-013','4'),
('EJ-65','R-013','5'),
('EJ-66','R-014','1'),
('EJ-67','R-014','2'),
('EJ-68','R-014','3'),
('EJ-69','R-014','4'),
('EJ-70','R-014','5'),
('EJ-71','R-015','1'),
('EJ-72','R-015','2'),
('EJ-73','R-015','3'),
('EJ-74','R-015','4'),
('EJ-75','R-015','5'),
('EJ-76','R-016','1'),
('EJ-77','R-016','2'),
('EJ-78','R-016','3'),
('EJ-79','R-016','4'),
('EJ-80','R-016','5'),
('EJ-81','R-017','1'),
('EJ-82','R-017','2'),
('EJ-83','R-017','3'),
('EJ-84','R-017','4'),
('EJ-85','R-017','5'),
('EJ-86','R-018','1'),
('EJ-87','R-018','2'),
('EJ-88','R-018','3'),
('EJ-89','R-018','4'),
('EJ-90','R-018','5'),
('EJ-91','R-019','1'),
('EJ-92','R-019','2'),
('EJ-93','R-019','3'),
('EJ-94','R-019','4'),
('EJ-95','R-019','5'),
('EJ-96','R-020','1'),
('EJ-97','R-020','2'),
('EJ-98','R-020','3'),
('EJ-99','R-020','4'),
('EJ-100','R-020','5'),
('EJ-101','R-021','1'),
('EJ-102','R-021','2'),
('EJ-103','R-021','3'),
('EJ-104','R-021','4'),
('EJ-105','R-021','5'),
('EJ-106','R-021','6'),
('EJ-107','R-021','7'),
('EJ-108','R-021','8'),
('EJ-109','R-021','9'),
('EJ-110','R-021','10'),
('EJ-111','R-022','1'),
('EJ-112','R-022','2'),
('EJ-113','R-022','3'),
('EJ-114','R-022','4'),
('EJ-115','R-022','5'),
('EJ-116','R-022','6'),
('EJ-117','R-022','7'),
('EJ-118','R-022','8'),
('EJ-119','R-022','9'),
('EJ-120','R-022','10'),
('EJ-121','R-023','1'),
('EJ-122','R-023','2'),
('EJ-123','R-023','3'),
('EJ-124','R-023','4'),
('EJ-125','R-023','5'),
('EJ-126','R-023','6'),
('EJ-127','R-023','7'),
('EJ-128','R-023','8'),
('EJ-129','R-023','9'),
('EJ-130','R-023','10'),
('EJ-131','R-024','1'),
('EJ-132','R-024','2'),
('EJ-133','R-024','3'),
('EJ-134','R-024','4'),
('EJ-135','R-024','5'),
('EJ-136','R-024','6'),
('EJ-137','R-024','7'),
('EJ-138','R-024','8'),
('EJ-139','R-024','9'),
('EJ-140','R-024','10'),
('EJ-141','R-025','1'),
('EJ-142','R-025','2'),
('EJ-143','R-025','3'),
('EJ-144','R-025','4'),
('EJ-145','R-025','5'),
('EJ-146','R-025','6'),
('EJ-147','R-025','7'),
('EJ-148','R-025','8'),
('EJ-149','R-025','9'),
('EJ-150','R-025','10'),
('EJ-151','R-026','1'),
('EJ-152','R-026','2'),
('EJ-153','R-026','3'),
('EJ-154','R-026','4'),
('EJ-155','R-026','5'),
('EJ-156','R-026','6'),
('EJ-157','R-026','7'),
('EJ-158','R-026','8'),
('EJ-159','R-026','9'),
('EJ-160','R-026','10'),
('EJ-161','R-027','1'),
('EJ-162','R-027','2'),
('EJ-163','R-027','3'),
('EJ-164','R-027','4'),
('EJ-165','R-027','5'),
('EJ-166','R-027','6'),
('EJ-167','R-027','7'),
('EJ-168','R-027','8'),
('EJ-169','R-027','9'),
('EJ-170','R-027','10'),
('EJ-171','R-028','1'),
('EJ-172','R-028','2'),
('EJ-173','R-028','3'),
('EJ-174','R-028','4'),
('EJ-175','R-028','5'),
('EJ-176','R-028','6'),
('EJ-177','R-028','7'),
('EJ-178','R-028','8'),
('EJ-179','R-028','9'),
('EJ-180','R-028','10'),
('EJ-181','R-029','1'),
('EJ-182','R-029','2'),
('EJ-183','R-029','3'),
('EJ-184','R-029','4'),
('EJ-185','R-029','5'),
('EJ-186','R-029','6'),
('EJ-187','R-029','7'),
('EJ-188','R-029','8'),
('EJ-189','R-029','9'),
('EJ-190','R-029','10'),
('EJ-191','R-030','1'),
('EJ-192','R-030','2'),
('EJ-193','R-030','3'),
('EJ-194','R-030','4'),
('EJ-195','R-030','5'),
('EJ-196','R-030','6'),
('EJ-197','R-030','7'),
('EJ-198','R-030','8'),
('EJ-199','R-030','9'),
('EJ-200','R-030','10'),
('EJ-201','R-031','1'),
('EJ-202','R-031','2'),
('EJ-203','R-031','3'),
('EJ-204','R-031','4'),
('EJ-205','R-031','5'),
('EJ-206','R-031','6'),
('EJ-207','R-031','7'),
('EJ-208','R-031','8'),
('EJ-209','R-031','9'),
('EJ-210','R-031','10'),
('EJ-211','R-032','1'),
('EJ-212','R-032','2'),
('EJ-213','R-032','3'),
('EJ-214','R-032','4'),
('EJ-215','R-032','5'),
('EJ-216','R-032','6'),
('EJ-217','R-032','7'),
('EJ-218','R-032','8'),
('EJ-219','R-032','9'),
('EJ-220','R-032','10'),
('EJ-221','R-033','1'),
('EJ-222','R-033','2'),
('EJ-223','R-033','3'),
('EJ-224','R-033','4'),
('EJ-225','R-033','5'),
('EJ-226','R-033','6'),
('EJ-227','R-033','7'),
('EJ-228','R-033','8'),
('EJ-229','R-033','9'),
('EJ-230','R-033','10'),
('EJ-231','R-034','1'),
('EJ-232','R-034','2'),
('EJ-233','R-034','3'),
('EJ-234','R-034','4'),
('EJ-235','R-034','5'),
('EJ-236','R-034','6'),
('EJ-237','R-034','7'),
('EJ-238','R-034','8'),
('EJ-239','R-034','9'),
('EJ-240','R-034','10'),
('EJ-241','R-035','1'),
('EJ-242','R-035','2'),
('EJ-243','R-035','3'),
('EJ-244','R-035','4'),
('EJ-245','R-035','5'),
('EJ-246','R-035','6'),
('EJ-247','R-035','7'),
('EJ-248','R-035','8'),
('EJ-249','R-035','9'),
('EJ-250','R-035','10'),
('EJ-251','R-036','1'),
('EJ-252','R-036','2'),
('EJ-253','R-036','3'),
('EJ-254','R-036','4'),
('EJ-255','R-036','5'),
('EJ-256','R-036','6'),
('EJ-257','R-036','7'),
('EJ-258','R-036','8'),
('EJ-259','R-036','9'),
('EJ-260','R-036','10'),
('EJ-261','R-037','1'),
('EJ-262','R-037','2'),
('EJ-263','R-037','3'),
('EJ-264','R-037','4'),
('EJ-265','R-037','5'),
('EJ-266','R-037','6'),
('EJ-267','R-037','7'),
('EJ-268','R-037','8'),
('EJ-269','R-037','9'),
('EJ-270','R-037','10'),
('EJ-271','R-038','1'),
('EJ-272','R-038','2'),
('EJ-273','R-038','3'),
('EJ-274','R-038','4'),
('EJ-275','R-038','5'),
('EJ-276','R-038','6'),
('EJ-277','R-038','7'),
('EJ-278','R-038','8'),
('EJ-279','R-038','9'),
('EJ-280','R-038','10'),
('EJ-281','R-039','1'),
('EJ-282','R-039','2'),
('EJ-283','R-039','3'),
('EJ-284','R-039','4'),
('EJ-285','R-039','5'),
('EJ-286','R-039','6'),
('EJ-287','R-039','7'),
('EJ-288','R-039','8'),
('EJ-289','R-039','9'),
('EJ-290','R-039','10'),
('EJ-291','R-040','1'),
('EJ-292','R-040','2'),
('EJ-293','R-040','3'),
('EJ-294','R-040','4'),
('EJ-295','R-040','5'),
('EJ-296','R-040','6'),
('EJ-297','R-040','7'),
('EJ-298','R-040','8'),
('EJ-299','R-040','9'),
('EJ-300','R-040','10'),
('EJ-301','R-041','1'),
('EJ-302','R-041','2'),
('EJ-303','R-041','3'),
('EJ-304','R-042','1'),
('EJ-305','R-042','2'),
('EJ-306','R-042','3'),
('EJ-307','R-043','1'),
('EJ-308','R-043','2'),
('EJ-309','R-043','3'),
('EJ-310','R-044','1'),
('EJ-311','R-044','2'),
('EJ-312','R-044','3'),
('EJ-313','R-045','1'),
('EJ-314','R-045','2'),
('EJ-315','R-045','3'),
('EJ-316','R-046','1'),
('EJ-317','R-046','2'),
('EJ-318','R-046','3'),
('EJ-319','R-047','1'),
('EJ-320','R-047','2'),
('EJ-321','R-047','3'),
('EJ-322','R-048','1'),
('EJ-323','R-048','2'),
('EJ-324','R-048','3'),
('EJ-325','R-049','1'),
('EJ-326','R-049','2'),
('EJ-327','R-049','3'),
('EJ-328','R-050','1'),
('EJ-329','R-050','2'),
('EJ-330','R-050','3'),
('EJ-331','R-051','1'),
('EJ-332','R-051','2'),
('EJ-333','R-051','3'),
('EJ-334','R-052','1'),
('EJ-335','R-052','2'),
('EJ-336','R-052','3'),
('EJ-337','R-053','1'),
('EJ-338','R-053','2'),
('EJ-339','R-053','3'),
('EJ-340','R-054','1'),
('EJ-341','R-054','2'),
('EJ-342','R-054','3'),
('EJ-343','R-055','1'),
('EJ-344','R-055','2'),
('EJ-345','R-055','3'),
('EJ-346','R-056','1'),
('EJ-347','R-056','2'),
('EJ-348','R-056','3'),
('EJ-349','R-057','1'),
('EJ-350','R-057','2'),
('EJ-351','R-057','3'),
('EJ-352','R-058','1'),
('EJ-353','R-058','2'),
('EJ-354','R-058','3'),
('EJ-355','R-059','1'),
('EJ-356','R-059','2'),
('EJ-357','R-059','3'),
('EJ-358','R-060','1'),
('EJ-359','R-060','2'),
('EJ-360','R-060','3'),
('EJ-361','R-061','1'),
('EJ-362','R-061','2'),
('EJ-363','R-062','1'),
('EJ-364','R-062','2'),
('EJ-365','R-063','1'),
('EJ-366','R-063','2'),
('EJ-367','R-064','1'),
('EJ-368','R-064','2'),
('EJ-369','R-065','1'),
('EJ-370','R-065','2'),
('EJ-371','R-066','1'),
('EJ-372','R-066','2'),
('EJ-373','R-067','1'),
('EJ-374','R-067','2'),
('EJ-375','R-068','1'),
('EJ-376','R-068','2'),
('EJ-377','R-069','1'),
('EJ-378','R-069','2'),
('EJ-379','R-070','1'),
('EJ-380','R-070','2'),
('EJ-381','R-071','1'),
('EJ-382','R-071','2'),
('EJ-383','R-072','1'),
('EJ-384','R-072','2'),
('EJ-385','R-073','1'),
('EJ-386','R-073','2'),
('EJ-387','R-074','1'),
('EJ-388','R-074','2'),
('EJ-389','R-075','1'),
('EJ-390','R-075','2'),
('EJ-391','R-091','1'),
('EJ-392','R-091','2'),
('EJ-393','R-091','3'),
('EJ-394','R-092','1'),
('EJ-395','R-092','2'),
('EJ-396','R-092','3'),
('EJ-397','R-093','1'),
('EJ-398','R-093','2'),
('EJ-399','R-093','3'),
('EJ-400','R-094','1'),
('EJ-401','R-094','2'),
('EJ-402','R-094','3'),
('EJ-403','R-095','1'),
('EJ-404','R-095','2'),
('EJ-405','R-095','3'),
('EJ-406','R-096','1'),
('EJ-407','R-096','2'),
('EJ-408','R-096','3'),
('EJ-409','R-096','4'),
('EJ-410','R-096','5'),
('EJ-411','R-096','6'),
('EJ-412','R-096','7'),
('EJ-413','R-096','8'),
('EJ-414','R-096','9'),
('EJ-415','R-096','10'),
('EJ-416','R-097','1'),
('EJ-417','R-097','2'),
('EJ-418','R-097','3'),
('EJ-419','R-097','4'),
('EJ-420','R-097','5'),
('EJ-421','R-097','6'),
('EJ-422','R-097','7'),
('EJ-423','R-097','8'),
('EJ-424','R-097','9'),
('EJ-425','R-097','10');

-- 11. LAPTOP

INSERT INTO laptop (id_laptop, id_dispositivo) VALUES
('LP-01', 'DP-01'),
('LP-02', 'DP-02'),
('LP-03', 'DP-03'),
('LP-04', 'DP-04'),
('LP-05', 'DP-05');

-- 12. TABLETA

INSERT INTO tableta (id_tableta, id_dispositivo) VALUES
('TB-01', 'DP-06'),
('TB-02', 'DP-07');

-- 13. ESTUDIANTE

INSERT INTO estudiante (id_estudiante, codigo, plan, semestre, id_usuario) VALUES
('ES-01','2401583','Tedesoft','1','USR-001'),
('ES-02','2403927','Comercio','2','USR-002'),
('ES-03','2407641','Administración','3','USR-003'),
('ES-04','2410285','Química','4','USR-004'),
('ES-05','2413952','Tedesoft','5','USR-005'),
('ES-06','2418726','Comercio','6','USR-006'),
('ES-07','2420164','Administración','1','USR-007'),
('ES-08','2424839','Química','2','USR-008'),
('ES-09','2427591','Tedesoft','3','USR-009'),
('ES-10','2431048','Comercio','4','USR-010'),
('ES-11','2435890','Administración','5','USR-011'),
('ES-12','2439725','Química','6','USR-012'),
('ES-13','2441386','Tedesoft','1','USR-013'),
('ES-14','2445079','Comercio','2','USR-014'),
('ES-15','2449862','Administración','3','USR-015'),
('ES-16','2450734','Química','4','USR-016'),
('ES-17','2456920','Tedesoft','5','USR-017'),
('ES-18','2458197','Comercio','6','USR-018'),
('ES-19','2460573','Administración','1','USR-019'),
('ES-20','2463951','Química','2','USR-020'),
('ES-21','2467830','Tedesoft','3','USR-021'),
('ES-22','2470194','Comercio','4','USR-022'),
('ES-23','2475682','Administración','5','USR-023'),
('ES-24','2479036','Química','6','USR-024'),
('ES-25','2481627','Tedesoft','1','USR-025'),
('ES-26','2485309','Comercio','2','USR-026'),
('ES-27','2487914','Administración','3','USR-027'),
('ES-28','2490186','Química','4','USR-028'),
('ES-29','2493751','Tedesoft','5','USR-029'),
('ES-30','2496820','Comercio','6','USR-030'),
('ES-31','2406178','Administración','1','USR-031'),
('ES-32','2417840','Química','2','USR-032'),
('ES-33','2429315','Tedesoft','3','USR-033'),
('ES-34','2432689','Comercio','4','USR-034'),
('ES-35','2447203','Administración','5','USR-035'),
('ES-36','2451047','Química','6','USR-036'),
('ES-37','2468921','Tedesoft','1','USR-037'),
('ES-38','2472510','Comercio','2','USR-038'),
('ES-39','2486043','Administración','3','USR-039'),
('ES-40','2499076','Química','4','USR-040'),
('ES-41','2408429','Tedesoft','5','USR-041'),
('ES-42','2413608','Comercio','6','USR-042'),
('ES-43','2425071','Administración','1','USR-043'),
('ES-44','2437960','Química','2','USR-044'),
('ES-45','2449502','Tedesoft','3','USR-045'),
('ES-46','2452318','Comercio','4','USR-046'),
('ES-47','2465793','Administración','5','USR-047'),
('ES-48','2478642','Química','6','USR-048'),
('ES-49','2481175','Tedesoft','1','USR-049'),
('ES-50','2496430','Comercio','2','USR-050');

-- 14. PROFESOR 

INSERT INTO profesor (id_profesor, id_usuario) VALUES
('PR-01','USR-051'),
('PR-02','USR-052'),
('PR-03','USR-053'),
('PR-04','USR-054'),
('PR-05','USR-055'),
('PR-06','USR-056'),
('PR-07','USR-057'),
('PR-08','USR-058'),
('PR-09','USR-059'),
('PR-10','USR-060');

SELECT *
FROM profesor
-- 15. BIBLIOTECARIO 

INSERT INTO bibliotecario (id_bibliotecario, id_usuario) VALUES
('BL-01', 'USR-061'),
('BL-02', 'USR-062'),
('BL-03', 'USR-063');

-- 16. LIBRO

INSERT INTO libro (id_libro, isbn, resumen, fecha_publicacion, editorial, idioma,num_paginas, largo, ancho, grosor, tipo_encuadernacion, id_recurso) VALUES
('LB-01','7143-0469-4','Relato sobre viajes y memoria.','12/03/2019','Diego LLC','Español','124','21','25','7','Tapa blanda','R-001'),
('LB-02','792-27436-1','Drama intenso sobre decisiones difíciles.','15/05/2020','Berenguer-Carpio','Inglés','264','22','30','10','Tapa dura','R-002'),
('LB-03','77385-935-4','Aventura épica en tierras desconocidas.','22/07/2018','Mora-Raya','Español','440','28','35','14','Tapa blanda','R-003'),
('LB-04','46385-935-4','Historia familiar llena de secretos.','17/07/2016','Mora-Raya','Español','398','21','30','8','Tapa dura','R-004'),
('LB-05','43695-935-4','Cuentos breves sobre esperanza humana.','26/10/2014','Edición Planeta','Español','101','20','29','10','Tapa blanda','R-005'),
('LB-06','81245-672-1','Reflexiones sobre identidad y destino.','10/01/2021','Alfaguara','Español','320','23','28','9','Tapa blanda','R-006'),
('LB-07','97845-112-3','Romance marcado por segundas oportunidades.','04/11/2020','HarperCollins','Inglés','210','21','26','7','Tapa dura','R-007'),
('LB-08','66543-890-2','Crónica histórica de un reino perdido.','18/06/2019','Ediciones B','Español','450','27','34','12','Tapa blanda','R-008'),
('LB-09','55432-778-4','Suspenso sobre una desaparición misteriosa.','27/02/2022','Penguin Random','Inglés','198','20','25','6','Tapa blanda','R-009'),
('LB-10','99812-443-6','Novela sobre ambición y sacrificio.','13/08/2017','Planeta','Español','350','24','30','11','Tapa dura','R-010'),
('LB-11','87341-665-2','Viaje emocional hacia el perdón.','22/03/2018','Vicens Vives','Español','380','26','32','10','Tapa blanda','R-011'),
('LB-12','76254-331-0','Introducción clara a conceptos científicos.','05/12/2016','McGraw-Hill','Inglés','140','19','24','6','Tapa blanda','R-012'),
('LB-13','55412-998-6','Ensayo profundo sobre sociedad moderna.','29/04/2023','Norma','Español','470','28','35','15','Tapa dura','R-013'),
('LB-14','66991-437-3','Crónica íntima de crecimiento personal.','17/09/2021','Taurus','Español','230','22','27','8','Tapa blanda','R-014'),
('LB-15','44123-765-1','Revelaciones sorprendentes sobre la mente humana.','11/03/2020','Blackwell','Inglés','390','25','31','11','Tapa dura','R-015'),
('LB-16','55678-224-8','Historia marcada por culpa y redención.','08/07/2019','Anagrama','Español','310','23','29','9','Tapa blanda','R-016'),
('LB-17','44721-988-5','Aventura juvenil con toques fantásticos.','21/10/2022','Ediciones SM','Español','200','20','26','7','Tapa blanda','R-017'),
('LB-18','33119-544-9','Investigación profunda sobre cambios sociales.','14/02/2023','Random House','Inglés','560','29','36','16','Tapa dura','R-018'),
('LB-19','11543-829-7','Reflexión sobre vínculos familiares.','09/09/2018','Ediciones Urano','Español','290','22','28','8','Tapa blanda','R-019'),
('LB-20','88234-909-5','Tragedia conmovedora en un pequeño pueblo.','03/04/2017','HarperOne','Inglés','340','24','30','10','Tapa dura','R-020'),
('LB-21','77123-554-2','Relato sobre amistad inesperada.','12/04/2020','Alfaguara','Español','210','21','26','7','Tapa blanda','R-021'),
('LB-22','66231-908-1','Thriller político de gran tensión.','08/01/2019','HarperCollins','Inglés','320','23','30','9','Tapa dura','R-022'),
('LB-23','99812-001-7','Fábula moderna sobre libertad personal.','19/11/2018','Planeta','Español','410','24','32','13','Tapa blanda','R-023'),
('LB-24','55321-778-5','Historia corta llena de melancolía.','30/06/2021','Salamandra','Español','180','20','25','6','Tapa blanda','R-024'),
('LB-25','88971-432-0','Saga familiar de generaciones enteras.','23/07/2022','Anagrama','Español','520','28','35','15','Tapa dura','R-025'),
('LB-26','71234-665-8','Manual práctico para nuevos proyectos.','15/09/2020','McGraw-Hill','Inglés','260','22','28','8','Tapa blanda','R-026'),
('LB-27','44982-110-3','Narrativa histórica de un héroe olvidado.','14/03/2019','Vicens Vives','Español','430','27','34','12','Tapa blanda','R-027'),
('LB-28','66789-541-2','Romance entre dos mundos distintos.','10/12/2017','Penguin Random','Inglés','220','21','25','7','Tapa dura','R-028'),
('LB-29','55782-239-0','Crónica social de una ciudad cambiante.','17/05/2016','Norma','Español','460','26','33','11','Tapa blanda','R-029'),
('LB-30','32114-908-6','Testimonio inspirador sobre superación.','22/10/2018','Ediciones B','Español','300','22','27','8','Tapa blanda','R-030'),
('LB-31','81231-446-4','Reflexiones filosóficas sobre el tiempo.','02/04/2023','Taurus','Español','360','26','32','9','Tapa blanda','R-031'),
('LB-32','99812-665-3','Búsqueda espiritual a través del viaje.','11/11/2021','HarperOne','Inglés','340','25','31','10','Tapa dura','R-032'),
('LB-33','44567-331-9','Colección de cuentos humorísticos.','13/02/2020','Alfaguara','Español','190','20','26','6','Tapa blanda','R-033'),
('LB-34','33782-998-1','Misterio clásico con giros inesperados.','01/06/2019','Penguin Books','Inglés','345','23','28','9','Tapa blanda','R-034'),
('LB-35','22911-445-2','Investigación profunda en ciencias modernas.','29/09/2022','McGraw-Hill','Inglés','580','29','36','16','Tapa dura','R-035'),
('LB-36','88765-112-0','Poemario sobre amor y pérdida.','09/05/2018','Ediciones Urano','Español','390','25','30','10','Tapa blanda','R-036'),
('LB-37','55231-776-8','Novela juvenil de autodescubrimiento.','14/03/2017','Planeta','Español','230','22','27','8','Tapa dura','R-037'),
('LB-38','99876-543-1','Vida de un artista incomprendido.','22/11/2019','HarperCollins','Inglés','310','23','29','9','Tapa blanda','R-038'),
('LB-39','71234-221-5','Tragedia familiar en tiempos difíciles.','05/01/2021','Norma','Español','360','26','32','10','Tapa dura','R-039'),
('LB-40','66543-902-3','Reflexiones sobre la naturaleza humana.','16/04/2018','Planeta','Español','330','24','30','9','Tapa blanda','R-040'),
('LB-41','88112-334-0','Crónica de una revolución silenciosa.','20/08/2017','Salamandra','Español','410','27','33','12','Tapa dura','R-041'),
('LB-42','77221-665-9','Relatos breves sobre vidas cruzadas.','12/03/2016','Anagrama','Español','220','21','26','7','Tapa blanda','R-042'),
('LB-43','11239-554-1','Viaje fantástico a mundos imposibles.','14/05/2023','HarperOne','Inglés','350','25','31','10','Tapa dura','R-043'),
('LB-44','22119-888-2','Crónica urbana de personajes comunes.','29/09/2020','Ediciones SM','Español','300','23','29','8','Tapa blanda','R-044'),
('LB-45','33451-221-6','Biografía inspiradora de un líder.','07/07/2021','Penguin Random','Inglés','290','22','27','7','Tapa blanda','R-045'),
('LB-46','55678-119-8','Ensayo crítico sobre tecnología actual.','18/12/2019','McGraw-Hill','Inglés','590','30','37','17','Tapa dura','R-046'),
('LB-47','99123-443-5','Romance trágico marcado por el destino.','02/08/2018','Taurus','Español','380','26','32','11','Tapa blanda','R-047'),
('LB-48','66589-001-8','Relato épico de una guerra antigua.','22/03/2022','Norma','Español','470','28','35','15','Tapa dura','R-048'),
('LB-49','77234-665-0','Historias sobre valentía y comunidad.','30/11/2021','Alfaguara','Español','250','22','27','8','Tapa blanda','R-049'),
('LB-50','88123-990-4','Novela futurista sobre mundos paralelos.','09/06/2020','HarperCollins','Inglés','400','25','31','10','Tapa dura','R-050'),
('LB-51','55123-769-3','Manual práctico para nuevas habilidades.','10/10/2019','Ediciones B','Español','320','23','28','8','Tapa blanda','R-051'),
('LB-52','77245-112-8','Relato histórico de resistencia colectiva.','21/01/2018','Planeta','Español','450','27','34','12','Tapa dura','R-052'),
('LB-53','33421-989-6','Guía sencilla para mejorar hábitos.','15/05/2017','Nova Press','Inglés','370','25','30','10','Tapa blanda','R-053'),
('LB-54','55631-443-0','Compilación de discursos influyentes.','12/08/2022','McGraw-Hill','Inglés','210','21','26','7','Tapa blanda','R-054'),
('LB-55','88912-667-5','Crónica épica sobre un héroe caído.','04/04/2021','Norma','Español','480','28','35','15','Tapa dura','R-055'),
('LB-56','99821-332-9','Reflexión sobre ética contemporánea.','18/03/2019','Tauros','Español','300','23','29','8','Tapa blanda','R-056'),
('LB-57','44731-889-3','Viaje épico lleno de magia antigua.','09/02/2023','Blackwell','Inglés','600','30','37','18','Tapa dura','R-057'),
('LB-58','33119-441-7','Memorias de una vida extraordinaria.','02/09/2017','Planeta','Español','230','22','26','7','Tapa blanda','R-058'),
('LB-59','55129-882-5','Ensayo sobre educación y futuro.','28/04/2016','McGraw-Hill','Inglés','365','25','31','10','Tapa blanda','R-059'),
('LB-60','77233-554-4','Narración íntima sobre un amor perdido.','19/07/2018','Salamandra','Español','330','24','30','9','Tapa dura','R-060');

SELECT *
FROM libro

-- 17. LIBRO GENERAL 

INSERT INTO libro_general (id_libro_generico, volumen, num_edicion, id_libro) VALUES
('LG-01','4','2','LB-01'),
('LG-02','2','4','LB-02'),
('LG-03','2','1','LB-03'),
('LG-04','1','8','LB-04'),
('LG-05','3','6','LB-05'),
('LG-06','4','4','LB-06'),
('LG-07','2','7','LB-07'),
('LG-08','5','5','LB-08'),
('LG-09','1','9','LB-09'),
('LG-10','3','3','LB-10'),
('LG-11','5','1','LB-11'),
('LG-12','4','4','LB-12'),
('LG-13','2','5','LB-13'),
('LG-14','1','9','LB-14'),
('LG-15','2','8','LB-15'),
('LG-16','3','7','LB-16'),
('LG-17','5','5','LB-17'),
('LG-18','4','6','LB-18'),
('LG-19','2','2','LB-19'),
('LG-20','1','5','LB-20');

SELECT *
FROM libro_general

-- 18. LIBRO ACADEMICO 

INSERT INTO libro_academico (id_libro_academico, id_libro) VALUES
('LA-01', 'LB-21'),
('LA-02', 'LB-22'),
('LA-03', 'LB-23'),
('LA-04', 'LB-24'),
('LA-05', 'LB-25'),
('LA-06', 'LB-26'),
('LA-07', 'LB-27'),
('LA-08', 'LB-28'),
('LA-09', 'LB-29'),
('LA-10', 'LB-30'),
('LA-11', 'LB-31'),
('LA-12', 'LB-32'),
('LA-13', 'LB-33'),
('LA-14', 'LB-34'),
('LA-15', 'LB-35'),
('LA-16', 'LB-36'),
('LA-17', 'LB-37'),
('LA-18', 'LB-38'),
('LA-19', 'LB-39'),
('LA-20', 'LB-40');

SELECT *
FROM libro_academico

-- 19. DICCIONARIO 

INSERT INTO diccionario (id_diccionario, id_libro) VALUES
('DC-01', 'LB-41'),
('DC-02', 'LB-42'),
('DC-03', 'LB-43'),
('DC-04', 'LB-44'),
('DC-05', 'LB-45'),
('DC-06', 'LB-46'),
('DC-07', 'LB-47'),
('DC-08', 'LB-48'),
('DC-09', 'LB-49'),
('DC-10', 'LB-50'),
('DC-11', 'LB-51'),
('DC-12', 'LB-52'),
('DC-13', 'LB-53'),
('DC-14', 'LB-54'),
('DC-15', 'LB-55'),
('DC-16', 'LB-56'),
('DC-17', 'LB-57'),
('DC-18', 'LB-58'),
('DC-19', 'LB-59'),
('DC-20', 'LB-60');

SELECT *
FROM diccionario

-- 20. LIBRO_AUTOR

INSERT INTO autor_libro (id_autor, id_libro) VALUES
('AU-01','LB-01'),
('AU-02','LB-02'),
('AU-03','LB-03'),
('AU-04','LB-04'),
('AU-05','LB-05'),
('AU-06','LB-06'),
('AU-07','LB-07'),
('AU-08','LB-08'),
('AU-09','LB-09'),
('AU-10','LB-10'),
('AU-11','LB-11'),
('AU-12','LB-12'),
('AU-13','LB-13'),
('AU-14','LB-14'),
('AU-15','LB-15'),
('AU-16','LB-16'),
('AU-17','LB-17'),
('AU-18','LB-18'),
('AU-19','LB-19'),
('AU-20','LB-20'),
('AU-21','LB-21'),
('AU-22','LB-22'),
('AU-23','LB-23'),
('AU-24','LB-24'),
('AU-25','LB-25'),
('AU-26','LB-26'),
('AU-27','LB-27'),
('AU-28','LB-28'),
('AU-29','LB-29'),
('AU-30','LB-30'),
('AU-31','LB-31'),
('AU-32','LB-32'),
('AU-33','LB-33'),
('AU-34','LB-34'),
('AU-35','LB-35'),
('AU-36','LB-36'),
('AU-37','LB-37'),
('AU-38','LB-38'),
('AU-39','LB-39'),
('AU-40','LB-40'),
('AU-41','LB-41'),
('AU-42','LB-42'),
('AU-43','LB-43'),
('AU-44','LB-44'),
('AU-45','LB-45'),
('AU-46','LB-46'),
('AU-47','LB-47'),
('AU-48','LB-48'),
('AU-49','LB-49'),
('AU-50','LB-50'),
('AU-51','LB-51'),
('AU-52','LB-52'),
('AU-53','LB-53'),
('AU-54','LB-54'),
('AU-55','LB-55'),
('AU-56','LB-56'),
('AU-57','LB-57'),
('AU-58','LB-58'),
('AU-59','LB-59'),
('AU-60','LB-60');

SELECT *
FROM autor_libro

-- 21. PRESTAMO

INSERT INTO prestamo (id_prestamo, id_ejemplar, id_usb, id_usuario, id_bibliotecario, fecha_prestamo, hora_prestamo, fecha_devolucion, fecha_devolucion_real, conteo_renovaciones, medio_entrega) VALUES
('PR-01','EJ-96',NULL,'USR-002','BL-01','2/12/2025','11:50','17/12/2025','17/12/2025','0','Fisico'),
('PR-02','EJ-97',NULL,'USR-005','BL-02','14/07/2025','11:51','29/07/2025','29/07/2025','0','Fisico'),
('PR-03','EJ-98',NULL,'USR-007','BL-03','12/08/2025','11:52','27/08/2025','27/08/2025','0','Fisico'),
('PR-04','EJ-99',NULL,'USR-008','BL-01','25/06/2025','11:53','10/07/2025','10/07/2025','0','Fisico'),
('PR-05','EJ-100',NULL,'USR-051','BL-02','20/01/2025','11:54','4/02/2025','4/02/2025','0','Fisico'),
('PR-06','EJ-01',NULL,'USR-007','BL-03','23/04/2025','11:55','7/05/2025','22/05/2025','1','Fisico'),
('PR-07','EJ-02',NULL,'USR-008','BL-01','13/03/2025','11:56','28/03/2025','28/03/2025','0','Fisico'),
('PR-08','EJ-03',NULL,'USR-054','BL-02','14/03/2025','11:57','29/03/2025','29/03/2025','0','Fisico'),
('PR-09','EJ-04',NULL,'USR-056','BL-03','19/07/2025','11:58','3/08/2025','3/08/2025','0','Fisico'),
('PR-10','EJ-05',NULL,'USR-010','BL-01','12/09/2025','11:59','27/09/2025','27/09/2025','0','Fisico'),
('PR-11','EJ-391',NULL,'USR-014','BL-02','8/06/2025','12:00','15/06/2025','22/06/2025','1','Fisico'),
('PR-12','EJ-392',NULL,'USR-020','BL-03','2/01/2025','12:01','9/01/2025','9/01/2025','0','Fisico'),
('PR-13','EJ-393',NULL,'USR-021','BL-01','12/12/2025','12:02','19/12/2025','19/12/2025','0','Fisico'),
('PR-14','EJ-301',NULL,'USR-030','BL-02','2/07/2025','12:03','5/07/2025','8/07/2025','1','Fisico'),
('PR-15','EJ-302',NULL,'USR-036','BL-03','5/02/2025','12:04','8/02/2025','11/02/2025','1','Fisico'),
('PR-16','EJ-303',NULL,'USR-045','BL-01','27/08/2025','12:05','30/08/2025','30/08/2025','0','Fisico'),
('PR-17',NULL,'USB-01','USR-003','BL-02','10/12/2025','10:00','10/12/2025','10/12/2025','0','Usb');

SELECT *
FROM prestamo

-- 22. RESERVA

INSERT INTO reserva (id_reserva, id_ejemplar, id_usuario, id_bibliotecario, fecha_reserva, hora_reserva, vence, cola) VALUES
('RS-891','EJ-76','USR-004','BL-01','27/08/2025','11:30','1/09/2025','3'),
('RS-892','EJ-77','USR-011','BL-02','2/12/2025','9:20','7/12/2025','6'),
('RS-893','EJ-78','USR-044','BL-03','4/03/2025','10:00','9/03/2025','1'),
('RS-894','EJ-79','USR-015','BL-01','12/03/2025','9:21','17/03/2025','1'),
('RS-895','EJ-80','USR-025','BL-02','2/12/2025','6:00','7/12/2025','1'),
('RS-896','EJ-406','USR-018','BL-03','26/08/2025','5:00','31/08/2025','3'),
('RS-897','EJ-407','USR-032','BL-01','6/07/2025','12:00','11/07/2025','2'),
('RS-898','EJ-408','USR-038','BL-02','14/02/2025','9:00','19/02/2025','3'),
('RS-899','EJ-409','USR-050','BL-03','17/05/2025','11:00','22/05/2025','3'),
('RS-900','EJ-410','USR-055','BL-01','9/09/2025','8:18','14/09/2025','4'),
('RS-901','EJ-411','USR-001','BL-02','19/11/2025','7:40','24/12/2025','5'),
('RS-902','EJ-412','USR-029','BL-03','23/09/2025','6:50','28/09/2025','1'),
('RS-903','EJ-413','USR-015','BL-01','11/02/2025','9:30','16/02/2025','2'),
('RS-904','EJ-414','USR-022','BL-02','6/09/2025','12:12','11/09/2025','3'),
('RS-905','EJ-415','USR-053','BL-03','4/12/2025','1:12','9/12/2025','4');

SELECT *
FROM reserva

-- 23. RENOVACION

INSERT INTO renovacion (id_renovacion, id_prestamo, id_bibliotecario, fecha_renovacion) VALUES
('RN-01', 'PR-06', 'BL-01', '2025-05-07'),
('RN-02', 'PR-11', 'BL-02', '2025-06-15'),
('RN-03', 'PR-14', 'BL-03', '2025-07-05'),
('RN-04', 'PR-15', 'BL-01', '2025-02-08');

SELECT *
FROM renovacion

-- 24. MULTA 

INSERT INTO multa (id_multa, id_prestamo, dias_atraso, valor_calculado, pagada, fecha_pago) VALUES
('ML-01', 'PR-01', '3', '2500', TRUE, '2025-12-20'),
('ML-02', 'PR-04', '8', '2600', TRUE, '2025-07-18'),
('ML-03', 'PR-09', '10', '2800', TRUE, '2025-08-13'),
('ML-04', 'PR-12', '1', '1000', FALSE, NULL),
('ML-05', 'PR-17', '4', '2500', FALSE, NULL);

SELECT *
FROM multa

-- ========================================================
-- SENTENCIAS DML 
-- ========================================================

-- 1. SELECT - SELECCION:

SELECT *
FROM prestamo
WHERE fecha_prestamo='27-08-2025';

-- 2. SELECT - PROYECCION:

SELECT id_prestamo, dias_atraso, pagada
FROM multa;

-- 3. SELECT RENOMBRAMIENTO:

ALTER TABLE reserva
RENAME COLUMN cola to fila;

-- 4. SELECT - PRODUCTO CARTESIANO:

SELECT *
FROM coleccion, recurso
WHERE coleccion.id_coleccion=recurso.id_coleccion and coleccion.nombre='tecnoteca'and recurso.estado='prestado';

-- 5. DIFERENCIA DE CONJUNTOS:

SELECT resumen
FROM libro
EXCEPT 
SELECT id_diccionario
FROM diccionario;

-- 6. SELECT - UNION:

SELECT id_recurso,fecha_publicacion,editorial,idioma FROM revista
UNION 
SELECT id_recurso,fecha_publicacion,editorial,idioma FROM libro;

-- OPERACIONES UPDATE:

-- 7. UPDATE:

UPDATE multa
SET dias_atraso=dias_atraso+1;

-- 8. UPDATE:

UPDATE prestamo
SET conteo_renovaciones = conteo_renovaciones+1
WHERE id_prestamo = 'PR-05';

-- 9. UPDATE: 

UPDATE reserva
SET fila=CASE  
             WHEN fila<=10 THEN fila+1
			 ELSE fila-1
	     END;

-- OPERACIONES DELETE:
			
-- 9. DELETE - 1:

DROP TABLE multa;

-- 10. DELETE - 2:

DELETE FROM autor_libro; 

-- ========================================================
-- SENTENCIAS DCL
-- ========================================================

-- 1. GRANT:

GRANT INSERT, UPDATE 
ON prestamo
TO bibliotecario;

-- 2. REVOKE:

REVOKE INSERT 
ON prestamo
FROM bibliotecario;

-- ========================================================
-- VISTAS 
-- ========================================================

-- VISTAS NORMALES CON SUBCONSULTAS: 

-- 1. VISTA:  

CREATE VIEW vista_recursos_general AS
SELECT id_recurso, nombre
FROM recurso 
WHERE id_coleccion = (
     SELECT id_coleccion 
	 FROM coleccion
	 WHERE nombre = 'general'
);

SELECT * FROM vista_recursos_general;

-- 2. VISTA: 

CREATE VIEW vista_usuario_reserva AS
SELECT id_usuario, id_ejemplar, fecha_reserva, hora_reserva, vence
FROM reserva
WHERE id_ejemplar = (
     SELECT id_ejemplar 
	 FROM ejemplar
	 WHERE num_ejemplar > 4
);

SELECT * FROM vista_usuario_reserva;

-- VISTAS MATERIALIZADAS CON SUBCONSULTAS: 

-- 1. VISTA M:

CREATE MATERIALIZED VIEW suma_valor_usuario AS 
SELECT id_prestamo, SUM (valor_calculado) AS multa_total
FROM multa
WHERE id_prestamo = (
     SELECT id_prestamo 
	 FROM prestamo
	 WHERE id_usuario = 'U101'
)

GROUP BY id_prestamo;

SELECT * FROM suma_valor_usuario;

-- 2. VISTA M: 

CREATE MATERIALIZED VIEW total_coleccion_tecnoteca AS 
SELECT id_coleccion, COUNT (*) AS total_tecnoteca
FROM recurso
WHERE id_coleccion = (
     SELECT id_coleccion 
	 FROM coleccion 
	 WHERE nombre = 'tecnoteca'
)

GROUP BY id_coleccion;

SELECT * FROM total_coleccion_tecnoteca;

-- ========================================================
-- CONSULTAS
-- ========================================================

-- 1. CONSULTA:

SELECT id_prestamo, id_usuario, conteo_renovaciones
FROM prestamo
WHERE medio_entrega='Fisico'
AND conteo_renovaciones='0';

-- ========================================================
--  SUBCONSULTAS
-- ========================================================

-- 1. SUBCONSULTA:

SELECT id_usuario
FROM usuario
WHERE id_usuario IN (
    SELECT id_usuario
	FROM prestamo
);

-- ========================================================
-- FUNCIONES AGREGADAS
-- ========================================================

-- 1. MEDIA AVG - 1: 

SELECT AVG (num_ejemplar)
FROM ejemplar; 

-- 2. TOTAL SUM - 1:

SELECT SUM (valor_calculado)
FROM multa;

-- 3. MINIMO MIN - 1:

SELECT MIN (num_paginas)
FROM libro;

-- 4. MAXIMO MAX - 1:

SELECT MAX (grosor)
FROM libro
WHERE tipo_encuadernacion LIKE 'Tapa dura';

-- 5. RECUENTO COUNT - 1:

SELECT COUNT (*)
FROM recurso
WHERE id_coleccion LIKE 'CO-02';

-- 6. GROUP BY - 1:

SELECT COUNT (id_recurso),estado 
FROM recurso 
GROUP BY estado; 

-- 7. HAVING - 1:

SELECT COUNT (id_recurso),estado 
FROM recurso 
GROUP BY estado
HAVING COUNT (id_recurso) >= 4;

-- 8. NATURAL JOIN - 1:

SELECT *
FROM recurso NATURAL JOIN libro;

-- 9. INNER JOIN - 1:

SELECT *
FROM coleccion INNER JOIN recurso
ON coleccion.id_coleccion = recurso.id_coleccion;

-- 10. LEFT JOIN - 1:

SELECT estudiante.codigo,usuario.nombre_1, usuario.ap_P, estudiante.plan, estudiante.semestre
FROM usuario LEFT JOIN estudiante 
ON usuario.id_usuario = estudiante.id_usuario;

-- 11. RIGHT JOIN - 1:

SELECT *
FROM usuario RIGHT JOIN bibliotecario
ON usuario.id_usuario = bibliotecario.id_usuario;

-- 12. FULL OUTER JOIN - 1:

SELECT *
FROM usuario FULL OUTER JOIN profesor
ON usuario.id_usuario = profesor.id_usuario;

-- ========================================================
-- FUNCIONES QUE SE APLICARON PARA ALGUNAS TABLAS
-- ========================================================

ALTER TABLE prestamo
ALTER COLUMN id_usb DROP NOT NULL;

ALTER TABLE prestamo
ALTER COLUMN id_ejemplar DROP NOT NULL;

ALTER TABLE multa
ALTER COLUMN fecha_pago DROP NOT NULL;