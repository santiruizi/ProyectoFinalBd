import sys
import os

# Add PG bin to path
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, ROOT)

from src.DAO.Connection import Connection

try:
    conn = Connection.get_connection()
    cursor = conn.cursor()
    
    print("=== Creando Tablas Necesarias ===\n")
    
    # 1. Crear tabla coleccion
    print("1. Creando tabla 'coleccion'...")
    cursor.execute("DROP TABLE IF EXISTS coleccion CASCADE")
    cursor.execute("""
        CREATE TABLE coleccion (
          id_coleccion VARCHAR(15) PRIMARY KEY,
          nombre VARCHAR(30) NOT NULL,
          dias_prestamo NUMERIC(2,0) NOT NULL,
          max_renovaciones NUMERIC(2,0) NOT NULL,
          CHECK (nombre IN ('General','Reserva','Referencia','Hemeroteca','Mapoteca','Tecnoteca'))
        )
    """)
    print("   ✅ Tabla 'coleccion' creada")
    
    # 2. Crear tabla recurso
    print("2. Creando tabla 'recurso'...")
    cursor.execute("DROP TABLE IF EXISTS recurso CASCADE")
    cursor.execute("""
        CREATE TABLE recurso (
          id_recurso VARCHAR(15) PRIMARY KEY,
          nombre VARCHAR(100) NOT NULL,
          estado VARCHAR(20) NOT NULL,
          id_coleccion VARCHAR(15) NOT NULL,
          FOREIGN KEY (id_coleccion) REFERENCES coleccion,
          CHECK (estado IN ('Disponible','Prestado','Reservado','Perdido','Dado de baja'))
        )
    """)
    print("   ✅ Tabla 'recurso' creada")
    
    # 3. Insertar datos de prueba en coleccion
    print("\n3. Insertando colecciones de prueba...")
    colecciones = [
        ("COL-001", "General", 7, 2),
        ("COL-002", "Referencia", 3, 0),
        ("COL-003", "Hemeroteca", 5, 1)
    ]
    
    for col in colecciones:
        cursor.execute("""
            INSERT INTO coleccion (id_coleccion, nombre, dias_prestamo, max_renovaciones)
            VALUES (%s, %s, %s, %s)
        """, col)
        print(f"   ✅ Colección {col[0]} - {col[1]}")
    
    # 4. Insertar datos de prueba en recurso
    print("\n4. Insertando recursos de prueba...")
    recursos = [
        ("REC-001", "Don Quijote de la Mancha - Miguel de Cervantes", "Disponible", "COL-001"),
        ("REC-002", "Cien Años de Soledad - Gabriel García Márquez", "Disponible", "COL-001"),
        ("REC-003", "El Principito - Antoine de Saint-Exupéry", "Prestado", "COL-001"),
        ("REC-004", "Diccionario de la Real Academia Española", "Disponible", "COL-002"),
        ("REC-005", "Revista National Geographic - Edición Mayo 2024", "Disponible", "COL-003"),
        ("REC-006", "1984 - George Orwell", "Disponible", "COL-001"),
        ("REC-007", "Crónica de una Muerte Anunciada - Gabriel García Márquez", "Reservado", "COL-001")
    ]
    
    for rec in recursos:
        cursor.execute("""
            INSERT INTO recurso (id_recurso, nombre, estado, id_coleccion)
            VALUES (%s, %s, %s, %s)
        """, rec)
        print(f"   ✅ {rec[0]}: {rec[1][:50]}... ({rec[2]})")
    
    conn.commit()
    print("\n✅ COMPLETADO: Todas las tablas y datos creados exitosamente")
    
    cursor.close()
    Connection.put_connection(conn)

except Exception as e:
    print(f"❌ ERROR: {repr(e)}")
