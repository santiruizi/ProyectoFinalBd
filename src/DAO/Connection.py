import psycopg
from psycopg_pool import ConnectionPool
import os

class Connection:
    _pool = None

    @classmethod
    def get_pool(cls):
        if cls._pool is None:
            try:
                # TODO: Verify if dbname is correct. Password updated to candidate '2006'
                conninfo = "host=localhost port=5432 dbname=Biblioteca_BD_2025-2 user=postgres password=5'F^?A8S5_5k"
                cls._pool = ConnectionPool(
                    conninfo,
                    min_size=1,
                    max_size=20
                )
                print("Connection pool created successfully")
            except Exception as error:
                # Capturamos el error y lo imprimimos de forma segura
                print(f"Error al conectar con PostgreSQL: {repr(error)}")
                cls._pool = None
                
        if cls._pool is None:
             raise Exception("No se pudo crear el pool de conexiones. Verifique si la base de datos está encendida y las credenciales son correctas.")
             
        return cls._pool

    @classmethod
    def get_connection(cls):
        return cls.get_pool().getconn()

    @classmethod
    def put_connection(cls, connection):
        cls.get_pool().putconn(connection)

    @classmethod
    def close_all_connections(cls):
        if cls._pool:
            cls._pool.close()
            print("PostgreSQL connection pool is closed")
