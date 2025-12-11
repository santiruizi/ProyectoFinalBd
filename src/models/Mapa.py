"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Mapa:

    def __init__(self, id_mapa, formato, descripcion, id_recurso):
        self.id_mapa = id_mapa
        self.formato = formato
        self.descripcion = descripcion
        self.id_recurso = id_recurso

    # ID mapa

    def getIdMapa(self):
        return self.id_mapa
    
    def setIdMapa(self, id_mapa):
        self.id_mapa = id_mapa

    # Formato

    def getFormato(self):
        return self.formato
    
    def setFormato(self, formato):
        self.formato = formato

    # Descripción

    def getDescripcion(self):
        return self.descripcion
    
    def setDescripcion(self, descripcion):
        self.descripcion = descripcion

    # ID Recurso

    def getIdRecurso(self):
        return self.id_recurso
    

    def setIdRecurso(self, id_recurso):
        self.id_recurso = id_recurso
