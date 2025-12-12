# from DAO.Connection import Connection
import sys
import os

# Add src to path
sys.path.append(os.path.join(os.getcwd(), 'src'))

# Add PG bin to path just in case
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

try:
    from DAO.Connection import Connection
    conn = Connection.get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT column_name FROM information_schema.columns WHERE table_name = 'usuario'")
    rows = cursor.fetchall()
    print("Columns in 'usuario' table:")
    for row in rows:
        print(f" - {row[0]}")
    
    cursor.close()
    Connection.put_connection(conn)

except Exception as e:
    print(f"Error inspecting schema: {e}")
