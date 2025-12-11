"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Autor:

    def __init__(self, id_autor, primerNombre, segundoNombre, primerApellido, segundoApellido):
        self.id_autor = id_autor        
        self.primerNombre = primerNombre
        self.segundoNombre = segundoNombre
        self.primerApellido = primerApellido
        self.segundoApellido = segundoApellido

    # ID Autor

    def getIdAutor(self):
        return self.id_autor

    def setIdAutor(self, id_autor):
        self.id_autor = id_autor

    # Primer nombre

    def getPrimerNombre(self):
        return self.primerNombre
    
    def setNombre(self, primerNombre):
        self.primerNombre = primerNombre

    # Segundo nombre

    def getSegundoNombre(self):
        return self.segundoNombre

    def setSegundoNombre(self, segundoNombre):
        self.segundoNombre = segundoNombre
        
    # Primer apellido

    def getPrimerApellido(self):
        return self.primerApellido
    
    def setPrimerApellido(self, primerApellido):
        self.primerApellido = primerApellido

    # Segundo Apellido

    def getSegundoApellido(self):
        return self.segundoApellido
    
    def setSegundoApellido(self, segundoApellido):
        self.segundoApellido