import sys
import os

# Add src to path
sys.path.append(os.path.join(os.getcwd(), 'src'))

# Add PG bin to path just in case
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

# Add src to path explicitly - ensure it's at the front
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, project_root)

from src.DAO.UsuarioDAO import UsuarioDAO
from src.Usuario import Usuario

try:
    print("--- Testing UsuarioDAO ---")
    
    # 1. Insert Validation
    # Usuario(id_usuario, nombre1, apellido1, correoInstitucional, nombre2=None, apellido2=None)
    new_user = Usuario("TEST-001", "Test", "User", "test.user@univalle.edu.co", "Middle", "Last2")
    
    print(f"\n1. Inserting user {new_user.id_usuario}...")
    # First, try to delete if exists to ensure clean state
    UsuarioDAO.delete("TEST-001")
    
    if UsuarioDAO.insert(new_user):
        print("   SUCCESS: User inserted.")
    else:
        print("   FAILURE: User insert failed.")

    # 2. Get By ID Validation
    print(f"\n2. Getting user {new_user.id_usuario}...")
    fetched_user = UsuarioDAO.get_by_id("TEST-001")
    if fetched_user:
        print(f"   SUCCESS: User found: {fetched_user.getNombre1()} {fetched_user.apellido1}")
        if fetched_user.getCorreoInstitucional() == "test.user@univalle.edu.co":
             print("   SUCCESS: Data matches.")
        else:
             print("   FAILURE: Data mismatch.")
    else:
        print("   FAILURE: User not found.")

    # 3. Update Validation
    print(f"\n3. Updating user {new_user.id_usuario}...")
    if fetched_user:
        fetched_user.setNombre1("UpdatedName")
        if UsuarioDAO.update(fetched_user):
            print("   SUCCESS: User updated.")
            updated_user = UsuarioDAO.get_by_id("TEST-001")
            if updated_user and updated_user.getNombre1() == "UpdatedName":
                print("   SUCCESS: Update verified.")
            else:
                print("   FAILURE: Update verification failed.")
        else:
            print("   FAILURE: Update failed.")

    # 4. Delete Validation
    print(f"\n4. Deleting user {new_user.id_usuario}...")
    if UsuarioDAO.delete("TEST-001"):
        print("   SUCCESS: User deleted.")
        if not UsuarioDAO.get_by_id("TEST-001"):
            print("   SUCCESS: Deletion verified.")
        else:
            print("   FAILURE: User still exists after deletion.")
    else:
        print("   FAILURE: Delete failed.")

    print("\n--- Test Complete ---")

except ImportError as e:
    print(f"IMPORT ERROR: {e}")
except Exception as e:
    print(f"UNEXPECTED ERROR: {e}")
