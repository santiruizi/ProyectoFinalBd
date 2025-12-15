"""
-   Santiago Ruiz Gallego
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""


import sys
import os

print(f"Python executable: {sys.executable}")
print(f"CWD: {os.getcwd()}")
print(f"Path: {sys.path}")

try:
    import psycopg2
    print("SUCCESS: psycopg2 imported")
except ImportError as e:
    print(f"ERROR: psycopg2 not found: {e}")

sys.path.append(os.path.abspath(os.getcwd()))
try:
    from src.DAO.Connection import Connection
    print("SUCCESS: src.DAO.Connection imported")
except Exception as e:
    print(f"ERROR: Could not import src.DAO.Connection: {e}")
