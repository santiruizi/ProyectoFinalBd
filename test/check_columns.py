import sys
import os

# Add project root to sys.path
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, ROOT)

# Add PG bin to path
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

try:
    from src.DAO.Connection import Connection
    
    conn = Connection.get_connection()
    cursor = conn.cursor()
    
    # Query to get column names
    cursor.execute("""
        SELECT column_name
        FROM information_schema.columns 
        WHERE table_name = 'usuario'
        ORDER BY ordinal_position
    """)
    
    columns = cursor.fetchall()
    
    with open("columns_output.txt", "w", encoding="utf-8") as f:
        f.write("=== COLUMNAS DE LA TABLA 'usuario' ===\n")
        for col in columns:
            f.write(f"- {col[0]}\n")
    
    print("Columnas guardadas en columns_output.txt")
    
    cursor.close()
    Connection.put_connection(conn)
    
except Exception as e:
    with open("columns_error.txt", "w", encoding="utf-8") as f:
        f.write(f"ERROR: {repr(e)}")
    print(f"Error guardado en columns_error.txt")
