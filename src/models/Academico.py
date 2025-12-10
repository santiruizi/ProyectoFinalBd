"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Academico:

    def __init__(self, id_libro_academico, id_libro):
        self.id_libro_academico = id_libro_academico
        self.id_libro = id_libro

    # ID libro academico

    def getIDLibroAcademico(self):
        return self.id_libro_academico
    
    def setIdLibroAcademico(self, id_libro_academico):
        self.id_libro_academico = id_libro_academico
    
    # ID libro

    def getIdLibro(self):
        return self.id_libro
    
    def setIdLibro(self, id_libro):
        self.id_libro = id_libro