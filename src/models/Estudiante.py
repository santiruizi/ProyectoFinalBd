"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Gabriela Lourdes Gomez.
"""
import Usuario

class Estudiante(Usuario):

    def  __init__(self, id_usuario,nombre1, apellido1, correoInstitucional,  id_estudiante, codigo, plan, semestre,nombre2 = None, apellido2 = None):
        super().__init__(id_usuario,nombre1, apellido1, correoInstitucional, nombre2 = None, apellido2 = None)
        self.id_estudiante = id_estudiante
        self.codigo = codigo
        self.plan = plan
        self.semestre = semestre

    # ID de estudiante

    def getIdEstudiante(self):
        return self.id_estudiante

    def setIdEstudiante(self, id_estudiante):
        self.id_estudiante = id_estudiante

    # Codigo
     
    def getCodigo(self):
        return self.codigo

    def setCodigo(self, codigo):
        self.codigo = codigo

    # Plan
     
    def getPlan(self):
        return self.plan

    def setPlan(self, plan):
        self.plan = plan

    # Semestre
     
    def getSemestre(self):
        return self.semestre

    def setSemestre(self, semestre):
        self.semestre = semestre 