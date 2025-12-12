from DAO.Connection import Connection
from Usuario import Usuario

class UsuarioDAO:
    @classmethod
    def get_all(cls):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("SELECT id_usuario, nombre_1, ap_P, correo_institucional, nombre_2, ap_M FROM usuario")
            rows = cursor.fetchall()
            usuarios = []
            for row in rows:
                # Constructor: id, nombre1, apellido1, correo, nombre2, apellido2
                usuarios.append(Usuario(row[0], row[1], row[2], row[3], row[4], row[5]))
            return usuarios
        except Exception as e:
            print(f"Error getting usuarios: {e}")
            return []
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def get_by_id(cls, id_usuario):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("SELECT id_usuario, nombre_1, ap_P, correo_institucional, nombre_2, ap_M FROM usuario WHERE id_usuario = %s", (id_usuario,))
            row = cursor.fetchone()
            if row:
                return Usuario(row[0], row[1], row[2], row[3], row[4], row[5])
            return None
        except Exception as e:
            print(f"Error getting usuario by id: {e}")
            return None
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def insert(cls, usuario):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            query = """
            INSERT INTO usuario (id_usuario, nombre_1, nombre_2, ap_P, ap_M, correo_institucional)
            VALUES (%s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query, (
                usuario.id_usuario, usuario.getNombre1(), usuario.getNombre2(),
                usuario.apellido1, usuario.apellido2, usuario.getCorreoInstitucional()
            ))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error inserting usuario: {repr(e)}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def update(cls, usuario):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            query = """
            UPDATE usuario SET nombre_1 = %s, nombre_2 = %s, ap_P = %s, ap_M = %s, correo_institucional = %s
            WHERE id_usuario = %s
            """
            cursor.execute(query, (
                usuario.getNombre1(), usuario.getNombre2(), usuario.apellido1,
                usuario.apellido2, usuario.getCorreoInstitucional(), usuario.id_usuario
            ))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error updating usuario: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def delete(cls, id_usuario):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("DELETE FROM usuario WHERE id_usuario = %s", (id_usuario,))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error deleting usuario: {repr(e)}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)
