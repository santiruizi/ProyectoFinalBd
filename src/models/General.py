"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class General:
    
    def __init__(self, id_libro_generico, volumen, num_edicion, id_libro):
        self.id_libro_generico = id_libro_generico
        self.volumen = volumen
        self.num_edicion = num_edicion
        self.id_libro = id_libro

    # Id libro generico

    def getIdLibroGenerico(self):
        return self.id_libro_generico
    
    def setIdLibroGenerico(self, id_libro_generico):
        self.id_libro_generico = id_libro_generico

    # Volumen

    def getVolumen(self):
        return self.volumen

    def setVolumen(self, volumen):
        self.volumen = volumen 

    # Numero de edición

    def getNumeroDeEdicion(self):
        return self.num_edicion
    
    def setNumeroDeEdicion(self, num_edicion):
        self.num_edicion = num_edicion

    # Id libro

    def getIdLibro(self):
        return self.id_libro
     
    def setIdLibro(self, id_libro):
        self.id_libro = id_libro
