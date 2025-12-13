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
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, ROOT)

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
    with open("error_log.txt", "w", encoding="utf-8") as f:
        f.write(f"FULL ERROR: {repr(e)}")
    print(f"ERROR: {e}")