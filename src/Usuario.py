"""

- Santiago Ruiz Gallego.
- Juan Camilo Garcia Durango.
- Isaac Antillano Cruiz.
- Andres David Gaitan.
- Gabriela Lourdes Gomez.
"""

class Usuario:

    # Ingreso de creacion de dato.
        
    def __init__(self, id_usuario,nombre1, apellido1, correoInstitucional, nombre2 = None, apellido2 = None):
        self.id_usuario = id_usuario
        self.nombre1 = nombre1
        self.nombre2 = nombre2
        self.apellido1 = apellido1
        self.apellido2 = apellido2
        self.correoInstitucional = correoInstitucional

    # Nombre 1

    def getNombre1(self):
        return self.nombre1
    
    def setNombre(self, nombre1):
        self.nombre1 = nombre1

    # Nombre 2

    def getNombre2(self):
        return self.nombre2
    
    def setNombre2(self, nombre2):
        self.nombre2 = nombre2

    # Correo Institucional

    def getCorreoInstitucional(self):
        return self.correoInstitucional
    
    def setCorreoInstitucional(self, correoInstitucional):
        self.correoInstitucional = correoInstitucional
