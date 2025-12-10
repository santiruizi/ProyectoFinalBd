"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Gabriela Lourdes Gomez.
"""

# En src/modelos/usuarios_roles.py (o donde los tengas)

import Usuario

class Profesor(Usuario):

    def __init__(self, id_usuario, nombre1, apellido1, correo_institucional, id_profesor, nombre2=None, apellido2=None):
        super().__init__(id_usuario, nombre1, apellido1, correo_institucional, nombre2=nombre2, apellido2=apellido2)
        self.id_profesor = id_profesor

    # Id Profesor

    def getIdProfesor(self):
        return self.id_profesor
    
    def setIdProfesor(self, id_profesor):
        self.id_profesor = id_profesor

