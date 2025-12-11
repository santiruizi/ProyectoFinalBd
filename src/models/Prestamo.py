"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Prestamo:

    def __init__(self, id_prestamo, id_ejemplar, id_usb, id_usuario, id_bibliotecario, fecha_prestamo, hora_prestamo,fecha_devolucion, conteo_renovaciones, medio_entrega, fecha_devolucion_real = None):
        self.id_prestamo = id_prestamo
        self.id_ejemplar = id_ejemplar
        self.id_usb = id_usb
        self.id_usuario = id_usuario
        self.id_bibliotecario = id_bibliotecario
        self.fecha_prestamo = fecha_prestamo
        self.hora_prestamo = hora_prestamo
        self.fecha_devolucion = fecha_devolucion
        self.fecha_devolucion_real = fecha_devolucion_real
        self.conteo_renovaciones = conteo_renovaciones
        self.medio_entrega = medio_entrega

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
    
    # Hora prestamo

    def getHoraPrestamo(self):
        return self.hora_prestamo
    
    def setHoraPrestamo(self, hora_prestamo):
        self.hora_prestamo = hora_prestamo

    # Fecha Devolución

    def getFechaDevolucion(self):
        return self.fecha_devolucion 

    def setFechaDevolucion(self, fecha_devolucion):
        self.fecha_devolucion = fecha_devolucion

    # Fecha devolución real

    def getFechaDevolucionReal(self):
        return self.fecha_devolucion_real
    
    def setFechaDevolucionReal(self, fecha_devolucion_real):
        self.fecha_devolucion_real = fecha_devolucion_real

    # Conteo de renovaciones

    def getConteoRenovaciones(self):
        return self.conteo_renovaciones 
    
    def setConteoRenovaciones(self, conteo_renovaciones):
        self.conteo_renovaciones = conteo_renovaciones

    # Medio de entrega

    def getMedioEntrega(self):
        return self.medio_entrega
    
    def setMedioEntrega(self, medio_entrega):
        self.medio_entrega = medio_entrega