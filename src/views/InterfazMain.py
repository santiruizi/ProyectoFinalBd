"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

from tkinter import *
from tkinter import font

class InterfazMain:
    def __init__(self, ventana):
        self.ventana = ventana
        self.ventana.title("Biblioteca Madeira - Sistema de Gestión Bibliotecaria")
        self.ventana.geometry("500x450")  # Aumentado de 400 a 450
        self.ventana.resizable(0, 0)
        self.ventana.config(bg="#f0f0f0")
        
        self.crear_interfaz()
    
    def crear_interfaz(self):
        # ========== HEADER ==========
        frame_header = Frame(self.ventana, bg="#2c3e50", height=80)
        frame_header.pack(fill=X)
        
        titulo_font = font.Font(family="Arial", size=16, weight="bold")
        Label(frame_header, text="BIBLIOTECA MADEIRA", font=titulo_font, 
              bg="#2c3e50", fg="white").pack(pady=10)
        
        subtitulo_font = font.Font(family="Arial", size=10)
        Label(frame_header, text="Universidad de Madeira", font=subtitulo_font, 
              bg="#2c3e50", fg="#ecf0f1").pack()
        
        # ========== CONTENIDO PRINCIPAL ==========
        contenedor = LabelFrame(self.ventana, text="Sistema de Ingreso", 
                               font=("Arial", 11, "bold"), bg="#f0f0f0")
        contenedor.config(bd=5, relief="ridge", padx=20, pady=20)
        contenedor.pack(pady=20, padx=40, fill=BOTH, expand=True)
        
        # Mensaje de bienvenida
        Label(contenedor, text="Bienvenido al Sistema de Gestión Bibliotecaria", 
              font=("Arial", 10), bg="#f0f0f0").pack(pady=10)
        
        Label(contenedor, text="Seleccione una opción:", 
              font=("Arial", 9), bg="#f0f0f0").pack(pady=5)
        
        # ========== BOTONES ==========
        frame_botones = Frame(contenedor, bg="#f0f0f0")
        frame_botones.pack(pady=15)  # Reducido de 20 a 15
        
        # Botón Iniciar Sesión
        btn_login = Button(frame_botones, text="Iniciar Sesión", 
                          command=self.abrir_login,
                          bg="#3498db", fg="white", font=("Arial", 10, "bold"),
                          width=25, height=2, cursor="hand2",
                          activebackground="#2980b9", relief="raised", bd=3)
        btn_login.pack(pady=8)  # Reducido de 10 a 8
        
        # Botón Búsqueda Pública
        btn_busqueda = Button(frame_botones, text="Búsqueda de Material (Público)", 
                             command=self.abrir_busqueda,
                             bg="#27ae60", fg="white", font=("Arial", 10, "bold"),
                             width=25, height=2, cursor="hand2",
                             activebackground="#229954", relief="raised", bd=3)
        btn_busqueda.pack(pady=8)  # Reducido de 10 a 8
        
        # Footer
        Label(contenedor, text="© 2025 Universidad de Madeira", 
              font=("Arial", 8), bg="#f0f0f0", fg="#7f8c8d").pack(side=BOTTOM, pady=5)  # Reducido de 10 a 5
    
    def abrir_login(self):
        """Abre la interfaz de login y cierra la ventana actual"""
        self.ventana.destroy()
        nueva_ventana = Tk()
        
        # Importar aquí para evitar dependencias circulares
        import sys
        import os
        sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))
        from src.views.InterfazLogin import InterfazLogin
        
        InterfazLogin(nueva_ventana)
        nueva_ventana.mainloop()
    
    def abrir_busqueda(self):
        """Abre la interfaz de búsqueda pública y cierra la ventana actual"""
        self.ventana.destroy()
        nueva_ventana = Tk()
        
        # Importar aquí para evitar dependencias circulares
        import sys
        import os
        sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))
        from src.views.BusquedaSinIniciarCesion import BusquedaSinIniciarCesion
        
        BusquedaSinIniciarCesion(nueva_ventana)
        nueva_ventana.mainloop()

if __name__ == "__main__":
    ventana = Tk()
    app = InterfazMain(ventana)
    ventana.mainloop()