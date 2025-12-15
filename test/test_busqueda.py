"""
-   Santiago Ruiz Gallego
-   Juan Camilo Garcia Durango.
-   Isaac Antillano Cruiz.
-   Andres David Gaitan.
-   Lourdes Gabriela Gomez.
"""

import sys
import os

# Add PG bin to path
pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
if os.path.exists(pg_bin):
    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']

# Add project root to path
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, ROOT)

from src.DAO.RecursoDAO import RecursoDAO
from src.models.Recurso import Recurso

print("=== TEST: Búsqueda Pública - Verificación ===\n")

try:
    # 1. Verificar conexión RecursoDAO
    print("1. Probando RecursoDAO.get_all()...")
    recursos = RecursoDAO.get_all()
    
    if recursos:
        print(f"   ✅ SUCCESS: {len(recursos)} recursos encontrados")
        for r in recursos[:3]:  # Mostrar primeros 3
            print(f"      - {r.getIdRecurso()}: {r.getNombre()} ({r.getEstado()})")
    else:
        print("   ⚠️  WARNING: No hay recursos en la BD")
        print("   Creando datos de prueba...\n")
        
        # Crear recursos de prueba
        recursos_prueba = [
            Recurso("REC-001", "Don Quijote de la Mancha", "Disponible", "COL-001"),
            Recurso("REC-002", "Cien Años de Soledad", "Disponible", "COL-001"),
            Recurso("REC-003", "El Principito", "Prestado", "COL-001")
        ]
        
        for recurso in recursos_prueba:
            if RecursoDAO.insert(recurso):
                print(f"   ✅ Recurso {recurso.getIdRecurso()} insertado")
            else:
                print(f"   ❌ Error insertando {recurso.getIdRecurso()}")
        
        print("\n   Verificando inserción...")
        recursos = RecursoDAO.get_all()
        print(f"   ✅ Ahora hay {len(recursos)} recursos")

except Exception as e:
    print(f"   ❌ ERROR: {repr(e)}")

print("\n=== Test Complete ===")
