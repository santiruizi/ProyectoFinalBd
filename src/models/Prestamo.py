"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Prestamo:

    def __init__(self, id_prestamo, id_ejemplar, id_usb, id_usuario, id_bibliotecario, fecha_prestamo, hora_prestamo, fecha_devolucion, conteo_renovaciones, medio_entrega):
        self.id_prestamo = id_prestamo
        self.id_ejemplar = id_ejemplar
        self.id_usb = id_usb
        self.id_usuario = id_usuario
        self.id_bibliotecario = id_bibliotecario
        self.fecha_prestamo = fecha_prestamo

    # ID Prestamo

    def getIdPrestamo(self):
        return self.id_prestamo
    
    def setIdPrestamo(self, id_prestamo):
        self.id_prestamo = id_prestamo

    # ID Ejemplar

    def getIdEjemplar(self):
        return self.id_ejemplar

    def setIdEjemplar(self, id_ejemplar):
        self.id_ejemplar = id_ejemplar 

    # ID Usuario

    def getIdUsuario(self):
        return self.id_usuario
    
    def setIdUsuario(self, id_usuario):
        self.id_usuario = id_usuario

    # ID bibliotecario

    def getIdBibliotecario(self):
        return self.id_bibliotecario

    def setIdBibliotecario(self, id_bibliotecario):
        self.id_bibliotecario = id_bibliotecario

    # Fecha prestamo

    def getFechaPrestamo(self):
        return self.fecha_prestamo
    
    def setFechaPrestamo(self,fecha_prestamo):
        self.fecha_prestamo = fecha_prestamo
    