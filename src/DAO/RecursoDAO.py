from DAO.Connection import Connection
from models.Recurso import Recurso

class RecursoDAO:
    @classmethod
    def get_all(cls):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("SELECT id_recurso, nombre, estado, id_coleccion FROM recurso")
            rows = cursor.fetchall()
            recursos = []
            for row in rows:
                recursos.append(Recurso(row[0], row[1], row[2], row[3]))
            return recursos
        except Exception as e:
            print(f"Error getting recursos: {e}")
            return []
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def get_by_id(cls, id_recurso):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("SELECT id_recurso, nombre, estado, id_coleccion FROM recurso WHERE id_recurso = %s", (id_recurso,))
            row = cursor.fetchone()
            if row:
                return Recurso(row[0], row[1], row[2], row[3])
            return None
        except Exception as e:
            print(f"Error getting recurso by id: {e}")
            return None
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def insert(cls, recurso):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("INSERT INTO recurso (id_recurso, nombre, estado, id_coleccion) VALUES (%s, %s, %s, %s)",
                           (recurso.getIdRecurso(), recurso.getNombre(), recurso.getEstado(), recurso.getIdColeccion()))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error inserting recurso: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def update(cls, recurso):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("UPDATE recurso SET nombre = %s, estado = %s, id_coleccion = %s WHERE id_recurso = %s",
                           (recurso.getNombre(), recurso.getEstado(), recurso.getIdColeccion(), recurso.getIdRecurso()))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error updating recurso: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def delete(cls, id_recurso):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("DELETE FROM recurso WHERE id_recurso = %s", (id_recurso,))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error deleting recurso: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)
