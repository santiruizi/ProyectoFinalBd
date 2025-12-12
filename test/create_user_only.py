"""
-   Santiago Ruiz Gallego.
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

import sys
import os

# Add project root to sys.path
# Add src to path explicitly - ensure it's at the front
project_root = os.getcwd()
src_path = os.path.join(project_root, 'src')
sys.path.insert(0, src_path)
sys.path.insert(0, project_root) # Also add root if needed for direct naming

from src.DAO.UsuarioDAO import UsuarioDAO
from src.Usuario import Usuario

try:
    print("--- Manual Verification: Inserting User ---")
    
    new_user = Usuario("MAN-001", "Manual", "TestUser",
                       "manual.user@univalle.edu.co",
                       "Middle", "Last")
    
    if UsuarioDAO.insert(new_user):
        print(f"SUCCESS: User {new_user.id_usuario} inserted.")
    else:
        print("FAILURE: Could not insert user.")

except Exception as e:
    print(f"ERROR: {e}")