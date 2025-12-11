"""
-   Santiago Ruiz gallego
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez. 
"""

class Dispositivo:

    def __init__(self, id_dispositivo, marca, modelo, cargador, funda, id_recurso):
        self.id_dispositivo = id_dispositivo
        self.marca = marca
        self.modelo = modelo
        self.cargador = cargador
        self.funda = funda
        self.id_recurso = id_recurso

    # ID dispositivo

    def getIdDispositivo(self):
        return self.id_dispositivo
    
    def setIdDispositivo(self, id_dispositivo):
        self. id_dispositivo = id_dispositivo

    # Marca

    def getMarca(self):
        return self.marca
    
    def setMarca(self, marca):
        self.marca = marca

    # Modelo

    def getModelo(self):
        return self.modelo
    
    def setModelo(self, modelo):
        self.modelo = modelo

    # Cargador

    def getCargador(self):
        return self.cargador
    
    def setCargador(self, cargador):
        self.cargador = cargador

    # Funda

    def getFunda(self):
        return self.funda
    
    def setFunda(self, funda):
        self.funda = funda

    # ID Recurso

    def getIdRecurso(self):
        return self.id_recurso
    
    def setIdRecurso(self, id_recurso):
        self.id_recurso = id_recurso