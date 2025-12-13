"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez. 
"""

from tkinter import *
from tkinter import ttk, messagebox
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
from src.Usuario import Usuario

class InterfazBibliotecario:
    def __init__(self, ventana):
        self.ventana = ventana
        self.ventana.title("Sistema Bibliotecario - Gestión de Usuarios")
        self.ventana.geometry("800x600")
        self.ventana.resizable(0, 0)
        
        # Variables para los campos
        self.var_id = StringVar()
        self.var_nombre1 = StringVar()
        self.var_nombre2 = StringVar()
        self.var_apellido1 = StringVar()
        self.var_apellido2 = StringVar()
        self.var_correo = StringVar()
        
        self.crear_interfaz()
        self.cargar_usuarios()
    
    def crear_interfaz(self):
        # ========== HEADER ==========
        header = LabelFrame(self.ventana, text="Sistema Bibliotecario - Universidad de Madeira", 
                           font=("Arial", 12, "bold"))
        header.config(bd=5, relief="ridge")
        header.pack(pady=10, padx=10, fill=X)
        
        frame_header_content = Frame(header)
        frame_header_content.pack(fill=X, padx=5, pady=5)
        
        Label(frame_header_content, text="Gestión de Usuarios", font=("Arial", 10)).pack(side=LEFT, padx=10)
        
        Button(frame_header_content, text="Cerrar Sesión", command=self.cerrar_sesion,
               bg="#e74c3c", fg="white", font=("Arial", 9, "bold"),
               cursor="hand2").pack(side=RIGHT, padx=10)
        
        # ========== FORMULARIO DE REGISTRO ==========
        frame_form = LabelFrame(self.ventana, text="Registro de Nuevo Usuario", 
                               font=("Arial", 10, "bold"))
        frame_form.config(bd=3, relief="groove")
        frame_form.pack(pady=10, padx=10, fill=BOTH)
        
        # Campos del formulario
        campos = [
            ("ID Usuario:", self.var_id, 0),
            ("Primer Nombre:", self.var_nombre1, 1),
            ("Segundo Nombre:", self.var_nombre2, 2),
            ("Primer Apellido:", self.var_apellido1, 3),
            ("Segundo Apellido:", self.var_apellido2, 4),
            ("Correo Institucional:", self.var_correo, 5)
        ]
        
        for label_text, variable, row in campos:
            Label(frame_form, text=label_text, font=("Arial", 9)).grid(
                row=row, column=0, sticky=W, padx=10, pady=5)
            Entry(frame_form, textvariable=variable, width=40, font=("Arial", 9)).grid(
                row=row, column=1, padx=10, pady=5)
        
        # Botones
        frame_botones = Frame(frame_form)
        frame_botones.grid(row=6, column=0, columnspan=2, pady=10)
        
        Button(frame_botones, text="Registrar Usuario", command=self.registrar_usuario,
               bg="#4CAF50", fg="white", font=("Arial", 10, "bold"), 
               width=15).pack(side=LEFT, padx=5)
        
        Button(frame_botones, text="Limpiar Campos", command=self.limpiar_campos,
               bg="#FF9800", fg="white", font=("Arial", 10, "bold"), 
               width=15).pack(side=LEFT, padx=5)
        
        # ========== LISTA DE USUARIOS ==========
        frame_lista = LabelFrame(self.ventana, text="Usuarios Registrados", 
                                font=("Arial", 10, "bold"))
        frame_lista.config(bd=3, relief="groove")
        frame_lista.pack(pady=10, padx=10, fill=BOTH, expand=True)
        
        # Scrollbar
        scroll = Scrollbar(frame_lista)
        scroll.pack(side=RIGHT, fill=Y)
        
        # Treeview
        self.tree = ttk.Treeview(frame_lista, yscrollcommand=scroll.set, 
                                 columns=("id", "nombre", "apellido", "correo"), 
                                 show="headings", height=10)
        
        self.tree.heading("id", text="ID Usuario")
        self.tree.heading("nombre", text="Nombres")
        self.tree.heading("apellido", text="Apellidos")
        self.tree.heading("correo", text="Correo Institucional")
        
        self.tree.column("id", width=100)
        self.tree.column("nombre", width=200)
        self.tree.column("apellido", width=200)
        self.tree.column("correo", width=250)
        
        self.tree.pack(fill=BOTH, expand=True, padx=5, pady=5)
        scroll.config(command=self.tree.yview)
        
        # Botón actualizar
        Button(frame_lista, text="Actualizar Lista", command=self.cargar_usuarios,
               bg="#2196F3", fg="white", font=("Arial", 9, "bold")).pack(pady=5)
    
    def registrar_usuario(self):
        """Registra un nuevo usuario en la base de datos"""
        try:
            # Validar campos obligatorios
            if not self.var_id.get() or not self.var_nombre1.get() or \
               not self.var_apellido1.get() or not self.var_correo.get():
                messagebox.showwarning("Campos Incompletos", 
                                     "Por favor complete todos los campos obligatorios:\n" +
                                     "- ID Usuario\n- Primer Nombre\n- Primer Apellido\n- Correo")
                return
            
            # Crear objeto Usuario
            usuario = Usuario(
                self.var_id.get(),
                self.var_nombre1.get(),
                self.var_apellido1.get(),
                self.var_correo.get(),
                self.var_nombre2.get() if self.var_nombre2.get() else None,
                self.var_apellido2.get() if self.var_apellido2.get() else None
            )
            
            # Insertar en BD
            if UsuarioDAO.insert(usuario):
                messagebox.showinfo("Éxito", 
                                  f"Usuario {self.var_id.get()} registrado exitosamente")
                self.limpiar_campos()
                self.cargar_usuarios()
            else:
                messagebox.showerror("Error", 
                                   "No se pudo registrar el usuario.\n" +
                                   "Verifique que el ID no exista ya.")
        
        except Exception as e:
            messagebox.showerror("Error", f"Error al registrar usuario:\n{str(e)}")
    
    def cargar_usuarios(self):
        """Carga la lista de usuarios desde la base de datos"""
        try:
            # Limpiar tabla
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            # Obtener usuarios de la BD
            usuarios = UsuarioDAO.get_all()
            
            # Llenar tabla
            for usuario in usuarios:
                nombres = f"{usuario.getNombre1()} {usuario.getNombre2() or ''}".strip()
                apellidos = f"{usuario.apellido1} {usuario.apellido2 or ''}".strip()
                
                self.tree.insert("", "end", values=(
                    usuario.id_usuario,
                    nombres,
                    apellidos,
                    usuario.getCorreoInstitucional()
                ))
        
        except Exception as e:
            messagebox.showerror("Error", f"Error al cargar usuarios:\n{str(e)}")
    
    def limpiar_campos(self):
        """Limpia todos los campos del formulario"""
        self.var_id.set("")
        self.var_nombre1.set("")
        self.var_nombre2.set("")
        self.var_apellido1.set("")
        self.var_apellido2.set("")
        self.var_correo.set("")
    
    def cerrar_sesion(self):
        """Cierra sesión y vuelve a la interfaz principal"""
        from tkinter import messagebox
        if messagebox.askyesno("Cerrar Sesión", "¿Está seguro de cerrar sesión?"):
            self.ventana.destroy()
            nueva_ventana = Tk()
            
            import sys
            import os
            sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "../..")))
            from src.views.InterfazMain import InterfazMain
            
            InterfazMain(nueva_ventana)
            nueva_ventana.mainloop()

if __name__ == "__main__":
    ventana = Tk()
    app = InterfazBibliotecario(ventana)
    ventana.mainloop()