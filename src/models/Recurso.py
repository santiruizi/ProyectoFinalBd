"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Recurso:

    def __init__(self, id_recurso, nombre, estado, id_coleccion):
        self.id_recurso = id_recurso
        self.nombre = nombre
        self.estado = estado
        self.id_coleccion = id_coleccion

    # ID Recurso

    def getIdRecurso(self):
        return self.id_recurso

    def setIdRecurso(self, id_recurso):
        self.id_recurso = id_recurso

    # Nombre

    def getNombre(self):
        return self.nombre
    
    def setNombre(self, nombre):
        self.nombre = nombre

    # Estado

    def getEstado(self):
        return self.estado
    

    def setEstado(self, estado):
        self.estado = estado

    # ID de colección

    def getIdColeccion(self):
        return self.id_coleccion
    

    def setIdColeccion(self, id_coleccion):
        self.id_coleccion = id_coleccion
        