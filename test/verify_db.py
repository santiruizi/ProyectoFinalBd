import sys
import os

# Add src to path explicitly
sys.path.append(os.path.join(os.getcwd(), 'src'))

# Fix for "no pq wrapper available": Add PostgreSQL bin to PATH
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

try:
    from DAO.Connection import Connection
    import psycopg

    print("Attempting to connect to configured database...")
    try:
        conn = Connection.get_connection()
        print("SUCCESS: Connected to database!")
        cursor = conn.cursor()
        cursor.execute("SELECT current_database();")
        db_name = cursor.fetchone()[0]
        print(f"Connected to: {db_name}")
        cursor.close()
        Connection.put_connection(conn)
        
    except Exception as e:
        print(f"FAILURE connecting to target DB: {e}")
        
        # Fallback diagnostics
        print("\n--- DIAGNOSTICS ---")
        print("Attempting to connect to default 'postgres' database to list available databases...")
        
        # Parse credentials from Connection.py manually or just hardcode for the test if possible?
        # Better: use the same user/password but dbname='postgres'
        # We can inspect the exception or just try a new connection string.
        # Let's try to extract user/pass from Connection.py? No, that's brittle.
        # Let's assume user=postgres and password from the file.
        
        # We'll just define a new pool/connection for diagnostic
        # CAUTION: We need the password. I will read it from the file since I can't access Connection internal logic easily if it fails.
        # Actually, let's use psycopg directly.
        
        # Extract password from the file content I know (it was 5'F^?A8S5_5k)
        # Or better, read the file and extract it.
        # But for now, let's use the one I saw in the file.
        
        user = "postgres"
        password = "5'F^?A8S5_5k" # From previous step view
        
        try:
            diag_conn = psycopg.connect(
                host="localhost",
                port="5432",
                user=user,
                password=password, # password I saw in file
                dbname="postgres"
            )
            print("SUCCESS: Connected to 'postgres' database.")
            
            cur = diag_conn.cursor()
            cur.execute("SELECT datname FROM pg_database WHERE datistemplate = false;")
            rows = cur.fetchall()
            print("\nAvailable Databases:")
            for row in rows:
                print(f" - {row[0]}")
            
            diag_conn.close()
            
        except Exception as diag_e:
            print(f"DIAGNOSTICS FAILURE: Could not connect to 'postgres' database either. Error: {diag_e}")

except ImportError as e:
    print(f"IMPORT ERROR: {e}")
except Exception as e:
    print(f"UNEXPECTED ERROR: {e}")
