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
  PRIMARY KEY (id_coleccion)
  CHECK (nombre IN ('General','Reserva','Referencia','Hemeroteca','Mapoteca','Tecnoteca'))
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
  PRIMARY KEY (id_recurso)
  FOREIGN KEY (id_coleccion) REFERENCES coleccion
  CHECK (estado IN ('Disponible','Prestado','Reservado','Perdido','Dado de baja'))
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
	CHECK (estado IN ('Disponible','Prestado','Reservado','Perdido','Dado de baja'))
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
  PRIMARY KEY (id_ejemplar)
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
  PRIMARY KEY (id_estudiante)
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
  FOREIGN KEY (id_recurso) REFERENCES recurso
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
  PRIMARY KEY (id_diccionario)
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
('CO-01', 'general', 15, 5),
('CO-02', 'reserva', 5, 0),
('CO-03', 'referencia', 3, 2),
('CO-04', 'hemeroteca', 1, 1),
('CO-05', 'mapoteca', 1, 0),
('CO-06', 'tecnoteca', 7, 2);

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
('DP-01', 'Lenovo', 'T480', 2, 4, 'R-091'),
('DP-02', 'Samsung', 'Galaxy A7', 8, 12, 'R-092'),
('DP-03', 'Apple', 'iPad Air', 5, 10, 'R-093'),
('DP-04', 'HP', 'Pavilion X360', 3, 6, 'R-094'),
('DP-05', 'Huawei', 'MatePad 11', 4, 8, 'R-095'),
('DP-06', 'Dell', 'Latitude 5400', 2, 5, 'R-096'),
('DP-07', 'Amazon', 'Fire HD 10', 6, 9, 'R-097');