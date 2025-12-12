"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez. 
"""


from tkinter import *

ventana = Tk()
ventana.title("Interfaz Bibliotecario")
ventana.geometry("900x500")
ventana.resizable(0,0)

# Contenedor cabez

contenedor1 = LabelFrame(ventana, text="Sistema bibliotecario")
contenedor1.config(bd=5, relief="sunken")
contenedor1.pack(pady=5)