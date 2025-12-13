"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

from tkinter import *
from tkinter import messagebox
import sys
import os

# Add PG bin to path
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

# Add project root to path
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
sys.path.insert(0, project_root)

from src.DAO.UsuarioDAO import UsuarioDAO

class InterfazLogin:
    def __init__(self, ventana):
        self.ventana = ventana
        self.ventana.title("Inicio de Sesión - Biblioteca Madeira")
        self.ventana.geometry("400x300")
        self.ventana.resizable(0, 0)
        self.ventana.config(bg="#f0f0f0")
        
        self.var_usuario = StringVar()
        self.var_password = StringVar()
        
        self.crear_interfaz()
    
    def crear_interfaz(self):
        # ========== HEADER ==========
        frame_header = Frame(self.ventana, bg="#34495e", height=60)
        frame_header.pack(fill=X)
        
        Label(frame_header, text="Inicio de Sesión", font=("Arial", 14, "bold"),
              bg="#34495e", fg="white").pack(pady=15)
        
        # ========== FORMULARIO ==========
        frame_form = Frame(self.ventana, bg="#f0f0f0")
        frame_form.pack(pady=30, padx=40)
        
        # Usuario
        Label(frame_form, text="Usuario (ID):", font=("Arial", 10),
              bg="#f0f0f0").grid(row=0, column=0, sticky=W, pady=10)
        Entry(frame_form, textvariable=self.var_usuario, width=25,
              font=("Arial", 10)).grid(row=0, column=1, pady=10, padx=10)
        
        # Contraseña
        Label(frame_form, text="Contraseña:", font=("Arial", 10),
              bg="#f0f0f0").grid(row=1, column=0, sticky=W, pady=10)
        Entry(frame_form, textvariable=self.var_password, width=25,
              font=("Arial", 10), show="*").grid(row=1, column=1, pady=10, padx=10)
        
        # ========== BOTONES ==========
        frame_botones = Frame(self.ventana, bg="#f0f0f0")
        frame_botones.pack(pady=20)
        
        Button(frame_botones, text="Iniciar Sesión", command=self.validar_login,
               bg="#27ae60", fg="white", font=("Arial", 10, "bold"),
               width=12, cursor="hand2").pack(side=LEFT, padx=5)
        
        Button(frame_botones, text="Volver", command=self.volver_main,
               bg="#95a5a6", fg="white", font=("Arial", 10, "bold"),
               width=12, cursor="hand2").pack(side=LEFT, padx=5)
    
    def validar_login(self):
        """Valida las credenciales y abre la interfaz del bibliotecario"""
        usuario_id = self.var_usuario.get()
        password = self.var_password.get()
        
        if not usuario_id or not password:
            messagebox.showwarning("Campos Vacíos", 
                                 "Por favor ingrese usuario y contraseña")
            return
        
        try:
            # Verificar si el usuario existe en la BD
            usuario = UsuarioDAO.get_by_id(usuario_id)
            
            if usuario:
                # Por ahora aceptamos cualquier password si el usuario existe
                # En producción, esto debería validar contra un hash almacenado
                messagebox.showinfo("Bienvenido", 
                                  f"Bienvenido {usuario.getNombre1()} {usuario.apellido1}")
                self.abrir_bibliotecario()
            else:
                messagebox.showerror("Error", 
                                   "Usuario no encontrado.\nVerifique sus credenciales.")
        
        except Exception as e:
            messagebox.showerror("Error", f"Error al validar credenciales:\n{str(e)}")
    
    def abrir_bibliotecario(self):
        """Abre la interfaz del bibliotecario"""
        self.ventana.destroy()
        nueva_ventana = Tk()
        
        from src.views.InterfazBibliotecario import InterfazBibliotecario
        InterfazBibliotecario(nueva_ventana)
        nueva_ventana.mainloop()
    
    def volver_main(self):
        """Vuelve a la interfaz principal"""
        self.ventana.destroy()
        nueva_ventana = Tk()
        
        from src.views.InterfazMain import InterfazMain
        InterfazMain(nueva_ventana)
        nueva_ventana.mainloop()

if __name__ == "__main__":
    ventana = Tk()
    app = InterfazLogin(ventana)
    ventana.mainloop()
