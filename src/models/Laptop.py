"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Duango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Laptop:

    def __init__(self, id_laptop, id_dispositivo):
        self.id_laptop = id_laptop
        self.id_dispositivo = id_dispositivo

    # ID Laptop

    def getIdLaptop(self):
        return self.id_laptop
    
    def setIdLaptop(self, id_laptop):
        self.id_laptop = id_laptop

    # ID dispositivo

    def getIdDispositivo(self):
        return self.id_dispositivo 
    
    def setIdDispositivo(self, id_dispositivo):
        self.id_dispositivo = id_dispositivo