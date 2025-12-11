"""
-   Santiago Ruiz Gallego.
-   Andres David Gaitan.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Gabriela Lourdes Gomez.
"""

class Revista:

    def __init__(self, id_revista, issn, volumen, num_edicion, fecha_publicacion, editorial, idioma, periocidad, num_paginas, id_recurso):
        self.id_revista = id_revista
        self.issn = issn
        self.volumen = volumen
        self.num_edicion = num_edicion
        self.fecha_publicacion = fecha_publicacion
        self.editorial = editorial
        self.idioma = idioma
        self.periocidad = periocidad
        self.num_paginas = num_paginas
        self.id_recurso = id_recurso

    # ID Revista

    def getIdRevista(self):
        return self.id_revista

    def setIdRevista(self, id_revista):
        self.id_revista = id_revista

    # Issn

    def getIssn(self):
        return self.issn
    
    def setIssn(self, issn):
        self.issn = issn

    # Volumen

    def getVolumen(self):
        return self.volumen

    def setVolumen(self, volumen):
        self.volumen = volumen

    # Numero de edición

    def getNumeroDeEdición(self):
        return self.num_edicion
    
    def setNumeroDeEdicion(self, num_edicion):
        self.num_edicion = num_edicion

    # Fecha publicación

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

    # Periocidad

    def getPeriocidad(self):
        return self.periocidad
    
    def setPeriocidad(self, periocidad):
        self.periocidad = periocidad

    # Numero de paginas

    def getNumeroDePaginas(self):
        return self.num_paginas
    
    def setNumeroDePaginas(self, num_paginas):
        self.num_paginas = num_paginas

    # ID Recurso

    def getIdRecurso(self):
        return self.id_recurso
    
    def setIdRecurso(self, id_recurso):
        self.id_recurso = id_recurso