"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""



import sys
import os

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, ROOT)

pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

from src.DAO.Connection import Connection

try:
    conn = Connection.get_connection()
    cursor = conn.cursor()
    
    # Drop and recreate usuario table
    cursor.execute("DROP TABLE IF EXISTS usuario CASCADE")
    
    cursor.execute("""
        CREATE TABLE usuario (
          id_usuario                VARCHAR (15),
          nombre_1                  VARCHAR (30) NOT NULL,
          nombre_2                  VARCHAR (30),
          ap_P                      VARCHAR (30) NOT NULL,
          ap_M                      VARCHAR (30),
          correo_institucional      VARCHAR (50) NOT NULL,
          PRIMARY KEY (id_usuario)
        )
    """)
    
    conn.commit()
    print("✅ Tabla 'usuario' creada exitosamente")
    
    cursor.close()
    Connection.put_connection(conn)
    
except Exception as e:
    print(f"❌ ERROR: {e}")
