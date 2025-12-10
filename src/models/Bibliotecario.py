"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Gabriela Lourdes Gomez.
"""

import Usuario

class Bibliotecario(Usuario):

    def __init__(self, id_usuario,nombre1, apellido1, correo_institucional, id_bibliotecario,nombre2 = None, apellido2 = None):
        super().__init__(id_usuario,nombre1, apellido1, correo_institucional, nombre2 = None, apellido2 = None)
        self.id_bibliotecario = id_bibliotecario

    # ID bibliotecario

    def getIdBibliotecario(self):
        return self.id_bibliotecario 
    
    def setIdBibliotecario(self, id_bibliotecario):
        self.id_bibliotecario = id_bibliotecario