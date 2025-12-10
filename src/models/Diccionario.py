"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Diccionario:

    def __init__(self, id_diccionario, id_libro):
        self.id_diccionario = id_diccionario 
        self.id_libro = id_libro

    # ID diccionario

    def getIdDiccionario(self):
        return self.id_diccionario
    
    def setIdDiccionario(self, id_diccionario):
        self.id_diccionario = id_diccionario

    # ID libro

    def getIdLibro(self):
        return self.id_libro
    
    def setIdLibro(self, id_libro):
        self.id_libro = id_libro