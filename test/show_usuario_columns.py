import sys
import os

# Add project root to sys.path
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, ROOT)

# Add PG bin to path
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

from src.DAO.Connection import Connection

try:
    conn = Connection.get_connection()
    cursor = conn.cursor()
    
    # Query PostgreSQL to get column names of 'usuario' table
    cursor.execute("""
        SELECT column_name, data_type, character_maximum_length, is_nullable
        FROM information_schema.columns 
        WHERE table_name = 'usuario'
        ORDER BY ordinal_position
    """)
    
    columns = cursor.fetchall()
    
    print("=== COLUMNAS DE LA TABLA 'usuario' ===")
    print(f"{'Columna':<30} {'Tipo':<20} {'Max Length':<15} {'Nullable'}")
    print("-" * 85)
    
    for col in columns:
        col_name, data_type, max_len, nullable = col
        max_len_str = str(max_len) if max_len else "N/A"
        print(f"{col_name:<30} {data_type:<20} {max_len_str:<15} {nullable}")
    
    cursor.close()
    Connection.put_connection(conn)
    
except Exception as e:
    print(f"ERROR: {e}")
