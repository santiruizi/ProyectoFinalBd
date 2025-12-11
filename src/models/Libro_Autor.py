"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""


class Libro_Autor:

    def __init__(self, id_autor, id_libro):
        self.id_autor = id_autor
        self.id_libro = id_libro


    # ID Autor

    def getIdAutor(self):
        return self.id_autor
    

    def setIdAutor(self, id_autor):
        self.id_autor = id_autor

    # ID Libro

    def getIdLibro(self):
        self.id_libro 

    def setIdLibro(self, id_libro):
        self.id_libro = id_libro