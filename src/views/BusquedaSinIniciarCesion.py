"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

from tkinter import *
from tkinter import ttk
import sys
import os

# Add PG bin to path
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

# Add project root to path
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
if project_root not in sys.path:
    sys.path.insert(0, project_root)

from src.DAO.RecursoDAO import RecursoDAO

class BusquedaSinIniciarCesion:
    def __init__(self, ventana):
        self.ventana = ventana
        self.ventana.title("Consulta de Recursos Bibliográficos")
        self.ventana.resizable(0, 0)
        self.ventana.geometry("900x550")
        
        self.var_codigo = StringVar()
        self.var_nombre = StringVar()
        
        # Inicializar el pool de conexiones antes de crear la interfaz
        try:
            from src.DAO.Connection import Connection
            pool = Connection.get_pool()  # Inicializar el pool
            if pool is None:
                raise Exception("El pool de conexiones no se pudo crear")
            print(f"Pool inicializado correctamente: {pool}")
        except Exception as e:
            error_msg = f"Error al inicializar el pool de conexiones: {e}"
            print(error_msg)
            import traceback
            traceback.print_exc()
            # Mostrar error en ventana emergente
            from tkinter import messagebox
            messagebox.showerror("Error de Conexión", 
                                f"No se pudo inicializar el pool de conexiones.\n\n"
                                f"Error: {str(e)}\n\n"
                                f"Verifique que PostgreSQL esté ejecutándose.")
            # No continuar si el pool no se puede inicializar
            raise
        
        self.crear_interfaz()
        # Cargar recursos después de que la interfaz esté completamente creada
        self.ventana.after(100, self.cargar_recursos)  # Esperar 100ms para asegurar que el treeview esté listo
    
    def crear_interfaz(self):
        # ========== HEADER ==========
        frame_header = Frame(self.ventana, bg="#16a085", height=60)
        frame_header.pack(fill=X)
        
        Label(frame_header, text="Catálogo Público de Recursos", font=("Arial", 14, "bold"),
              bg="#16a085", fg="white").pack(pady=15)
        
        # ========== BÚSQUEDA ==========
        contenedor1 = LabelFrame(self.ventana, text="Buscar Recursos")
        contenedor1.config(bd=5, relief="groove", padx=10, pady=10)
        contenedor1.pack(pady=10, padx=10, fill=X)
        
        # Código Recurso
        Label(contenedor1, text="Código Recurso:").grid(row=0, column=0, padx=5, pady=5, sticky=W)
        Entry(contenedor1, textvariable=self.var_codigo, width=20).grid(row=0, column=1, padx=5, pady=5)
        
        # Nombre o Título
        Label(contenedor1, text="Nombre / Título:").grid(row=0, column=2, padx=5, pady=5, sticky=W)
        Entry(contenedor1, textvariable=self.var_nombre, width=30).grid(row=0, column=3, padx=5, pady=5)
        
        # Botones
        Button(contenedor1, text="Buscar", command=self.buscar_recursos,
               bg="#3498db", fg="white", font=("Arial", 9, "bold")).grid(row=1, column=1, padx=5, pady=5)
        
        Button(contenedor1, text="Limpiar Filtros", command=self.limpiar_filtros,
               bg="#95a5a6", fg="white", font=("Arial", 9, "bold")).grid(row=1, column=2, padx=5, pady=5)
        
        Button(contenedor1, text="Mostrar Todos", command=self.cargar_recursos,
               bg="#27ae60", fg="white", font=("Arial", 9, "bold")).grid(row=1, column=3, padx=5, pady=5)
        
        # ========== TABLA DE RESULTADOS ==========
        contenedor2 = LabelFrame(self.ventana, text="Resultados")
        contenedor2.config(bd=5, relief="groove")
        contenedor2.pack(pady=10, padx=10, fill=BOTH, expand=True)
        
        # Scrollbar
        scroll = Scrollbar(contenedor2)
        scroll.pack(side=RIGHT, fill=Y)
        
        # Treeview
        self.tree = ttk.Treeview(contenedor2, yscrollcommand=scroll.set,
                                 columns=("codigo", "nombre", "estado", "coleccion"),
                                 show="headings", height=12)
        
        self.tree.heading("codigo", text="Código")
        self.tree.heading("nombre", text="Nombre/Título")
        self.tree.heading("estado", text="Estado")
        self.tree.heading("coleccion", text="Colección")
        
        self.tree.column("codigo", width=120)
        self.tree.column("nombre", width=350)
        self.tree.column("estado", width=150)
        self.tree.column("coleccion", width=150)
        
        self.tree.pack(fill=BOTH, expand=True, padx=5, pady=5)
        scroll.config(command=self.tree.yview)
        
        # ========== FOOTER ==========
        frame_footer = Frame(self.ventana)
        frame_footer.pack(pady=10)
        
        Button(frame_footer, text="Volver al Menú Principal", command=self.volver_main,
               bg="#e74c3c", fg="white", font=("Arial", 9, "bold"),
               width=20).pack()
    
    def cargar_recursos(self):
        """Carga todos los recursos de la base de datos"""
        try:
            # Limpiar tabla
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            print("Cargando recursos desde la base de datos...")
            # Obtener recursos
            recursos = RecursoDAO.get_all()
            print(f"Recursos obtenidos: {len(recursos)}")
            
            # Llenar tabla
            if recursos:
                for recurso in recursos:
                    self.tree.insert("", "end", values=(
                        recurso.getIdRecurso(),
                        recurso.getNombre(),
                        recurso.getEstado(),
                        recurso.getIdColeccion()
                    ))
                print(f"[OK] {len(recursos)} recursos cargados en la tabla")
            else:
                # Si no hay recursos, mostrar mensaje
                print("[ADVERTENCIA] No se encontraron recursos en la base de datos")
                self.tree.insert("", "end", values=(
                    "Sin datos",
                    "No hay recursos disponibles",
                    "",
                    ""
                ))
        
        except Exception as e:
            error_msg = f"Error al cargar recursos: {e}"
            print(error_msg)
            import traceback
            traceback.print_exc()
            # Mostrar mensaje en la interfaz
            from tkinter import messagebox
            messagebox.showerror("Error de Conexión", 
                                f"No se pudo conectar a la base de datos.\n\n"
                                f"Error: {str(e)}\n\n"
                                f"Verifique que:\n"
                                f"- PostgreSQL esté ejecutándose\n"
                                f"- Las credenciales sean correctas\n"
                                f"- La base de datos 'postgres' exista")
    
    def buscar_recursos(self):
        """Busca recursos por código o nombre"""
        try:
            # Limpiar tabla
            for item in self.tree.get_children():
                self.tree.delete(item)
            
            codigo = self.var_codigo.get().strip()
            nombre = self.var_nombre.get().strip().lower()
            
            # Si hay código, buscar por ID
            if codigo:
                recurso = RecursoDAO.get_by_id(codigo)
                if recurso:
                    self.tree.insert("", "end", values=(
                        recurso.getIdRecurso(),
                        recurso.getNombre(),
                        recurso.getEstado(),
                        recurso.getIdColeccion()
                    ))
            # Si hay nombre, filtrar por nombre
            elif nombre:
                recursos = RecursoDAO.get_all()
                for recurso in recursos:
                    if nombre in recurso.getNombre().lower():
                        self.tree.insert("", "end", values=(
                            recurso.getIdRecurso(),
                            recurso.getNombre(),
                            recurso.getEstado(),
                            recurso.getIdColeccion()
                        ))
            else:
                self.cargar_recursos()
        
        except Exception as e:
            error_msg = f"Error al buscar recursos: {e}"
            print(error_msg)
            import traceback
            traceback.print_exc()
            from tkinter import messagebox
            messagebox.showerror("Error de Búsqueda", 
                                f"No se pudo realizar la búsqueda.\n\n"
                                f"Error: {str(e)}")
    
    def limpiar_filtros(self):
        """Limpia los campos de búsqueda"""
        self.var_codigo.set("")
        self.var_nombre.set("")
        self.cargar_recursos()
    
    def volver_main(self):
        """Vuelve a la interfaz principal"""
        self.ventana.destroy()
        nueva_ventana = Tk()
        
        try:
            from src.views.InterfazMain import InterfazMain
            InterfazMain(nueva_ventana)
            nueva_ventana.mainloop()
        except ImportError as e:
            print(f"Error al importar InterfazMain: {e}")
            import traceback
            traceback.print_exc()
            nueva_ventana.destroy()

if __name__ == "__main__":
    ventana = Tk()
    app = BusquedaSinIniciarCesion(ventana)
    ventana.mainloop()
