"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Ejemplar:

    def __init__(self, id_ejemplar, id_recurso, num_ejemplar):
        self.id_ejemplar = id_ejemplar
        self.id_recurso = id_recurso

    # ID ejemplar

    def getIdEjemplar(self):
        return self.id_ejemplar
    
    def setIdEjemplar(self, id_ejemplar):
        self.id_ejemplar = id_ejemplar

    # ID recurso

    def getIdRecurso(self):
        return self.id_recurso
    
    def setIdRecurso(self, id_recurso):
        self.id_recurso = id_recurso
