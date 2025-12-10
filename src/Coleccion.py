"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Gabriela Lourdes Gomez.
"""

class Coleccion:

    def __init__(self, id_coleccion, nombre, dias_prestamo, max_renovaciones):
        self.id_coleccion = id_coleccion
        self.nombre = nombre
        self.dias_prestamo = dias_prestamo
        max_renovaciones = max_renovaciones

    # Id Coleccion

    def getColeccion(self):
        return self.id_coleccion
    
    def setColeccion(self, id_coleccion):
        self.id_coleccion = id_coleccion

    # Nombre

    def getNombre(self):
        return self.nombre
    
    def setNombre(self, nombre):
        self.nombre = nombre

    # Dias de prestamo

    def getDiasDePrestamo(self):
        return self.dias_prestamo
    

    # Maximo de renovaciones

    def getMaximoDeRenovaciones(self):
        return self.max_renovaciones
    

    def setMaximoDeRenovaciones(self, max_renovaciones):
        self.max_renovaciones = max_renovaciones
        