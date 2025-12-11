"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan,
-   Lourdes Gabriela Gomez.
"""

class Tableta:

    def __init__(self, id_tableta, id_dispositivo):
        self.id_tableta = id_tableta
        self.id_dispositivo = id_dispositivo

    # ID tableta

    def getIdTableta(self):
        return self.id_tableta
    
    def setIdTableta(self, id_tableta):
        self.id_tableta = id_tableta

    # ID dispositivo

    def getIdDispositivo(self):
        return self.id_dispositivo
    
    def setIdDispositivo(self, id_dispositivo):
        self.id_dispositivo = id_dispositivo

    