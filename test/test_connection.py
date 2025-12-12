import unittest
import sys
import os

# Agregamos el directorio raíz del proyecto al path de Python para poder importar 'src'
# Esto es necesario porque la carpeta 'test' está al mismo nivel que 'src'
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from src.DAO.Connection import Connection

class TestConnection(unittest.TestCase):
    """
    Clase de prueba para verificar la funcionalidad de la conexión a la base de datos.
    Utiliza el módulo 'unittest' de Python.
    """

    def setUp(self):
        """
        Este método se ejecuta ANTES de cada prueba.
        Aquí podemos preparar cualquier cosa que necesitemos para las pruebas.
        En este caso, nos aseguramos de que el pool esté limpio o inicializado si fuera necesario.
        """
        # No es estrictamente necesario reiniciar el pool aquí dado que es un Singleton,
        # pero es bueno saber que este método existe para configuración previa.
        pass

    def test_1_conexion_singleton(self):
        """
        Prueba para verificar que la conexión sigue el patrón Singleton.
        Esto significa que 'get_pool()' siempre debe devolver la MISMA instancia del pool de conexiones.
        """
        print("\nEjecutando: test_1_conexion_singleton")
        
        # Obtenemos la instancia del pool por primera vez
        pool1 = Connection.get_pool()
        
        # Obtenemos la instancia del pool por segunda vez
        pool2 = Connection.get_pool()
        
        # Verificamos que pool1 no sea None (que se haya creado)
        self.assertIsNotNone(pool1, "El pool de conexiones no debería ser None")
        
        # Verificamos que ambas variables apunten al MISMO objeto en memoria
        # Si esto falla, significa que se están creando múltiples pools, lo cual es incorrecto.
        self.assertIs(pool1, pool2, "El pool debería ser un Singleton (la misma instancia siempre)")
        print("  -> Éxito: El pool es una instancia única (Singleton).")

    def test_2_obtener_conexion(self):
        """
        Prueba para verificar que podemos obtener una conexión válida del pool.
        """
        print("\nEjecutando: test_2_obtener_conexion")
        
        # Solicitamos una conexión al pool
        conn = Connection.get_connection()
        
        # Verificamos que la conexión no sea None
        self.assertIsNotNone(conn, "No se pudo obtener una conexión del pool")
        
        # Verificamos que la conexión esté abierta (psycopg 3 usa bool False para abierta)
        self.assertFalse(conn.closed, "La conexión obtenida debería estar abierta")
        
        # MUY IMPORTANTE: Devolver la conexión al pool para no agotarlo
        Connection.put_connection(conn)
        print("  -> Éxito: Se obtuvo y verificó una conexión activa.")

    def test_3_ejecutar_consulta_simple(self):
        """
        Prueba de integración real: Intentar ejecutar una consulta SQL simple (SELECT 1).
        Esto confirma que la conexión realmente funciona contra la base de datos.
        """
        print("\nEjecutando: test_3_ejecutar_consulta_simple")
        conn = None
        try:
            # 1. Obtener conexión
            conn = Connection.get_connection()
            
            # 2. Crear un cursor para ejecutar comandos SQL
            cursor = conn.cursor()
            
            # 3. Ejecutar una consulta simple
            cursor.execute("SELECT 1;")
            
            # 4. Obtener el resultado
            resultado = cursor.fetchone()
            
            # 5. Verificar que el resultado sea lo esperado (una tupla con el valor 1)
            self.assertEqual(resultado[0], 1, "La consulta SELECT 1 debería devolver 1")
            
            print("  -> Éxito: La consulta SQL simple se ejecutó correctamente.")
            
            # Cerrar el cursor
            cursor.close()
            
        except Exception as e:
            # Si algo falla, hacemos fallar la prueba mostrando el error
            self.fail(f"La prueba de consulta falló con el error: {e}")
        finally:
            # Siempre devolvemos la conexión al pool, incluso si hubo error
            if conn:
                Connection.put_connection(conn)

    def test_4_cerrar_conexiones(self):
        """
        Prueba para verificar el cierre del pool de conexiones.
        """
        print("\nEjecutando: test_4_cerrar_conexiones")
        
        # Cerramos todas las conexiones
        Connection.close_all_connections()
        
        # Verificamos accediendo a la variable interna (privada) _pool si es posible, 
        # o verificamos que al intentar usarlo obtengamos un error o un nuevo pool.
        # En la implementación actual, _pool sigue existiendo pero cerrado.
        
        pool = Connection._pool
        if pool:
            # Si el pool existe, verificamos que esté cerrado (closed == 1 o True)
            # Nota: La implementación exacta de 'closed' depende de la versión de psycopg2
            self.assertTrue(pool.closed, "El pool de conexiones debería estar cerrado")
            print("  -> Éxito: El pool de conexiones se cerró correctamente.")

if __name__ == '__main__':
    # Ejecutar todas las pruebas
    unittest.main()
