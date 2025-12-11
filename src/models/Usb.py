"""
-   Santiago ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Usb:

    def __init__(self, id_usb, estado):
        self.id_usb = id_usb
        self.estado = estado

    # ID usb

    def getIdUsb(self):
        self.id_usb

    def setIdUsb(self, id_usb):
        self.id_usb = id_usb

    # Estado

    def getEstado(self):
        return self.estado
     
    def setEstado(self, estado):
        self.estado = estado
