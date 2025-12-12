"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

from pydoc import text
from tkinter import*
from turtle import title

ventana = Tk()
ventana.title("Biblioteca madeira")
ventana.resizable(0, 0)
ventana.geometry("300x150")

contenedor1 = LabelFrame(ventana, text = "Sistema de Ingreso de la Biblioteca Madeira")

contenedor1.config(bd= 5, relief = "sunken")

etBiblioteca = Label(contenedor1, text="Biblioteca Madeira").grid(row = 0, column = 0, padx= 5, pady= 5)

btIniciarSesion = Button(contenedor1, width=12, text="Iniciar sesion").grid(row= 1, column = 0, padx = 5, pady = 5)
btBusquedadSinIniciarSesion = Button(contenedor1, width=30, text="Busqueda del material sin inicar seción.").grid(row = 2, column=0, padx = 5, pady=5)


contenedor1.pack(pady=5)

ventana.mainloop()