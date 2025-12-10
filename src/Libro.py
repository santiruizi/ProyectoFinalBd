"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

class Libro:

    def __init__(self, id_libro, isbn, resumen, fecha_publicacion, editorial, idioma, num_paginas, largo, ancho, grosor, tipo_encuadernacion, id_recurso):
        self.id_libro = id_libro
        self.isbn = isbn
        self.resumen = resumen
        self.fecha_publicacion = fecha_publicacion
        self.editorial = editorial
        self.idioma = idioma
        self.num_paginas = num_paginas
        self.largo = largo
        self.ancho = ancho
        self.grosor = grosor
        self.tipo_encuadernacion = tipo_encuadernacion
        self.id_recurso = id_recurso
        
    # ID libro

    def getIdLibro(self):
        return self.id_libro
    
    def setIdLibro(self, id_libro):
        self.id_libro = id_libro

    # Isbn

    def getIsbn(self):
        return self.isbn
    
    def setIsbn(self, isbn):
        self.isbn = isbn

    # Resumen

    def getResumen(self):
        return self.resumen
    
    def setResument(self, resumen):
        self.resumen = resumen


    # Fecha publicacion 

    def getFechaPublicacion(self):
        return self.fecha_publicacion
    
    def setFechaPublicacion(self, fecha_publicacion):
        self.fecha_publicacion = fecha_publicacion

    # Editorial

    def getEditorial(self):
        return self.editorial
    
    def setEditorial(self, editorial):
        self.editorial = editorial

    # Idioma 

    def getIdioma(self):
        return self.idioma
    
    def setIdioma(self, idioma):
        self.idioma = idioma

    # Numero de paginas

    def getNumeroPaginas(self):
        return self.num_paginas
    
    def setNumeroPaginas(self, num_paginas):
        self.num_paginas = num_paginas

    # Largo

    def getLargo(self):
        return self.largo
    
    def setLargo(self, largo):
        self.largo = largo

    # Ancho

    def getAncho(self):
        return self.ancho

    def setAncho(self, ancho):
        self.ancho = ancho

    # Grosor

    def getGrosor(self):
        return self.grosor
    
    def setGrosor(self, grosor):
        self.grosor = grosor

    # Tipo de encuadernación

    def getTipoEncuadernacion(self):
        return self.tipo_encuadernacion
    
    def setTipoEncuadernacion(self, tipo_encuadernacion):
        self.tipo_encuadernacion = tipo_encuadernacion

    # Id Recurso

    def getIdRecurso(self):
        return self.id_recurso
    
    def setRecurso(self, id_recurso):
        self.id_recurso = id_recurso