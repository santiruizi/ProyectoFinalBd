"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

from tkinter import *

ventana = Tk()
ventana.title("Consulta de recursos bibliografico sin iniciar sesión.")
ventana.resizable(0,0)
ventana.geometry("900x500")

# El contenedor cabeza
contenedor1 = LabelFrame(ventana, text= "Buscar recursos")
contenedor1.config(bd = 5, relief="sunken", width= 850)

# Codigo Recurso
etCodigoRecurso = Label(contenedor1, text="Código recurso: ").grid(row = 0, column= 0, padx = 5, pady = 5)
ctCodigoRecurso = Entry(contenedor1)
ctCodigoRecurso.grid(row = 0, column=1, padx = 5, pady = 5)

# Nombre o titulo
etNombreTitulo = Label(contenedor1, text="Nombre / Titulo: ").grid(row = 0, column=3, padx=5, pady=5)
ctNombreTitulo = Entry(contenedor1)
ctNombreTitulo.grid(row = 0, column = 4, padx=5, pady=5)

# ISBN / ISSN
etIssnIssn = Label(contenedor1, text = "ISBN / ISSN: ").grid(row = 0, column=5, padx = 5, pady=5 )
ctIsbnIssn = Entry(contenedor1)
ctIsbnIssn.grid(row = 0, column = 6, padx = 5, pady=5)

# Botones
btBuscar = Button(contenedor1, text= "Buscar").grid(row = 1, column =4, padx = 5, pady = 5)
btLimpiarFiltros = Button(contenedor1, text="Limpiar filtros").grid(row = 1, column=5, padx=5, pady=5)
btMostrarTodos = Button(contenedor1, text="Mostrar todos").grid(row= 1, column= 6, padx= 5, pady= 5)

contenedor1.pack(pady=5)

# 2 Contenedor
contenedor2 = Frame(ventana)
contenedor2.config(bd=5, relief="sunken", padx=5, pady=5)
contenedor2.pack()

# Text donde se mostrará el reporte
reporteT = Text(contenedor2)
reporteT.config(width=90, height=23)
reporteT.grid(row=0, column=0)

# --- ENCABEZADO DEL TEXT ---
reporteT.config(state="normal")

encabezado = (
    "Código".ljust(12) +
    "Título".ljust(25) +
    "Colección".ljust(15) +
    "Tipo".ljust(12) +
    "ISBN/ISSN".ljust(15) +
    "Estado".ljust(12) +
    "\n"
)

reporteT.insert("end", encabezado)
reporteT.insert("end", "-" * 90 + "\n")  # Línea separadora

reporteT.config(state="disabled")

ventana.mainloop()
