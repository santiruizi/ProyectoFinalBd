"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
"""

class Renovacion:

    def __init__(self, id_renovacion, id_prestamo, id_bibliotecario, fecha_hora):
        self.id_renovacion = id_renovacion
        self.id_prestamo = id_prestamo
        self.id_bibliotecario = id_bibliotecario
        self.fecha_hora = fecha_hora

    # ID Renovación

    def getIdRenovacion(self):
        return self.id_renovacion

    def setIdRenovacion(self, id_renovacion):
        self.id_renovacion = id_renovacion

    # ID Prestamo

    def getIdPrestamo(self):
        return self.id_prestamo
    
    def setIdPrestamo(self, id_prestamo):
        self.id_prestamo = id_prestamo

    # ID Bibliotecario

    def getIdBibliotecario(self):
        return self.id_bibliotecario 

    def setIdBibliotecario(self, id_bibliotecario):
        self.id_bibliotecario = id_bibliotecario

    # Fecha hora

    def getFechaHora(self):
        return self.fecha_hora
    
    def setFechaHora(self, fecha_hora):
        self.fecha_hora = fecha_hora
        