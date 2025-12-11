"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gomez Gabriela. 
"""

class Multa:

    def __init__(self, id_multa, id_prestamo, dias_atraso, valor_calculado, pagada, fecha_pago):
        self.id_multa = id_multa
        self.id_prestamo = id_prestamo
        self.dias_atraso = dias_atraso
        self.valor_calculado = valor_calculado
        self.pagada = pagada
        self.fecha_pago = fecha_pago

    # ID multa

    def getIdMulta(self):
        return self.id_multa
    
    def setIdMulta(self, id_multa):
        self.id_multa = id_multa

    # ID Prestamo

    def getIdPrestamo(self):
        return self.id_prestamo
    
    def setIdPrestamo(self, id_prestamo):
        self.id_prestamo = id_prestamo

    # Dias de atraso

    def getIdAtraso(self):
        self.dias_atraso 

    def setIdAtraso(self, dias_atraso):
        self.dias_atraso = dias_atraso

    # Valor Calculado

    def getValorCalculado(self):
        return self.valor_calculado

    def setValorCalculado(self, valor_calculado):
        self.valor_calculado = valor_calculado 

    # Pagada

    def getPagada(self):
        return self.pagada 
    
    def setPagada(self, pagada):
        self.pagada = pagada

    # Fecha de pago

    def getFechaPago(self):
        return self.fecha_pago
    
    def setFechaPago(self, fecha_pago):
        self.fecha_pago = fecha_pago