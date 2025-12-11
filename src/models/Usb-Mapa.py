"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Usb_Mapa:
    def __init__(self, id_usb, id_mapa):
        self.id_usb = id_usb
        self.id_mapa= id_mapa

    # Id_Usb

    def getIdUsb(self):
        return self.id_usb
    
    def setIdUsb(self, id_usb):
        self.id_usb = id_usb

    # Id_Mapa

    def getIdMapa(self):
        return self.id_mapa

    def setIdMapa(self, id_mapa):
        self.id_mapa = id_mapa