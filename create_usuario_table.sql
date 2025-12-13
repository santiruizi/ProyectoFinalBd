-- Recreate usuario table with all columns
DROP TABLE IF EXISTS usuario CASCADE;

CREATE TABLE usuario (
  id_usuario                VARCHAR (15),
  nombre_1                  VARCHAR (30) NOT NULL,
  nombre_2                  VARCHAR (30),
  ap_P                      VARCHAR (30) NOT NULL,
  ap_M                      VARCHAR (30),
  correo_institucional      VARCHAR (50) NOT NULL,
  PRIMARY KEY (id_usuario)
);
