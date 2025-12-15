import psycopg
import os

# Intentar importar psycopg_pool, si falla, intentar instalarlo
try:
    from psycopg_pool import ConnectionPool
    from psycopg import conninfo
except ImportError:
    import subprocess
    import sys
    print("psycopg-pool no encontrado. Intentando instalar...")
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", "psycopg-pool"], 
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        from psycopg_pool import ConnectionPool
        from psycopg import conninfo
        print("psycopg-pool instalado correctamente")
    except Exception as e:
        print(f"Error al instalar psycopg-pool: {e}")
        print("Por favor, ejecute: pip install psycopg-pool")
        raise ImportError("psycopg-pool no está instalado. Ejecute: pip install psycopg-pool")

class Connection:
    _pool = None

    @classmethod
    def get_pool(cls):
        if cls._pool is None:
            try:
                # Add PG bin to path si no está ya agregado
                pg_bin = r"C:\Program Files\PostgreSQL\17\bin"
                if os.path.exists(pg_bin) and pg_bin not in os.environ.get('PATH', ''):
                    os.environ['PATH'] = pg_bin + os.pathsep + os.environ['PATH']
                
                # Usar conninfo.make_conninfo para construir la cadena de conexión correctamente
                # Esto maneja correctamente los caracteres especiales en la contraseña
                # Base de datos actualizada a 'postgres'
                conninfo_str = conninfo.make_conninfo(
                    host="localhost",
                    port=5432,
                    dbname="postgres",
                    user="postgres",
                    password="5'F^?A8S5_5k"
                )
                cls._pool = ConnectionPool(
                    conninfo_str,
                    min_size=1,
                    max_size=20
                )
                print("Connection pool created successfully")
            except Exception as error:
                # Capturamos el error y lo imprimimos de forma segura
                error_msg = f"Error al conectar con PostgreSQL: {repr(error)}"
                print(error_msg)
                import traceback
                traceback.print_exc()
                cls._pool = None
                raise Exception(f"No se pudo crear el pool de conexiones.\n"
                              f"Error: {error_msg}\n\n"
                              f"Verifique si:\n"
                              f"- PostgreSQL está ejecutándose\n"
                              f"- La base de datos 'postgres' existe\n"
                              f"- Las credenciales son correctas\n"
                              f"- El puerto 5432 está disponible")
                
        if cls._pool is None:
             raise Exception("No se pudo crear el pool de conexiones. Verifique si:\n"
                           "- PostgreSQL está ejecutándose\n"
                           "- La base de datos 'postgres' existe\n"
                           "- Las credenciales son correctas\n"
                           "- El puerto 5432 está disponible")
             
        return cls._pool

    @classmethod
    def get_connection(cls):
        try:
            pool = cls.get_pool()
            if pool is None:
                raise Exception("El pool de conexiones no está disponible")
            return pool.getconn()
        except Exception as e:
            # Si hay un error al obtener conexión, intentar resetear el pool
            print(f"Error al obtener conexión del pool: {e}")
            import traceback
            traceback.print_exc()
            # Resetear el pool para intentar recrearlo
            cls._pool = None
            raise

    @classmethod
    def put_connection(cls, connection):
        cls.get_pool().putconn(connection)

    @classmethod
    def close_all_connections(cls):
        if cls._pool:
            cls._pool.close()
            print("PostgreSQL connection pool is closed")
