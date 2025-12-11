"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Reserva:

    def __init__(self, id_reserva, id_ejemplar, id_usuario, id_bibliotecario, fecha_reserva, hora_reserva,vence, cola):
        self.id_reserva = id_reserva
        self.id_ejemplar = id_ejemplar
        self.id_usuario = id_usuario
        self.id_bibliotecario = id_bibliotecario
        self.fecha_reserva = fecha_reserva
        self.hora_reserva = hora_reserva
        self.vence = vence
        self.cola = cola

    # ID reserva

    def getIdReserva(self):
        return self.id_reserva
    
    def setIdReserva(self, id_reserva):
        self.id_reserva = id_reserva

    # ID ejemplar

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
    
    # Fecha Reserva

    def getFechaReserva(self):
        return self.fecha_reserva
    
    def setFechaReserva(self, fecha_reserva):
        self.fecha_reserva = fecha_reserva

    # Hora Reserva

    def getHoraReserva(self):
        return self.hora_reserva 
    
    def setHoraReserva(self, hora_reserva):
        self.hora_reserva = hora_reserva

    # Vence

    def getVence(self):
        return self.vence
    
    def setVence(self, vence):
        self.vence = vence

    # Cola
    def getCola(self):
        return self.cola 
    

    def setCola(self, cola):
        self.cola = cola