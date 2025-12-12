from DAO.Connection import Connection
from models.Prestamo import Prestamo

class PrestamoDAO:
    @classmethod
    def get_all(cls):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("SELECT id_prestamo, id_ejemplar, id_usb, id_usuario, id_bibliotecario, fecha_prestamo, hora_prestamo, fecha_devolucion, fecha_devolucion_real, conteo_renovaciones, medio_entrega FROM prestamo")
            rows = cursor.fetchall()
            prestamos = []
            for row in rows:
                # Assumes Prestamo constructor matches this order or adjust accordingly.
                # Warning: Checking Prestamo.py would be ideal, but assuming standard init based on columns.
                prestamos.append(Prestamo(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10]))
            return prestamos
        except Exception as e:
            print(f"Error getting prestamos: {e}")
            return []
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def insert(cls, prestamo):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            query = """
            INSERT INTO prestamo (id_prestamo, id_ejemplar, id_usb, id_usuario, id_bibliotecario, 
                                  fecha_prestamo, hora_prestamo, fecha_devolucion, fecha_devolucion_real, 
                                  conteo_renovaciones, medio_entrega)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query, (
                prestamo.id_prestamo, prestamo.id_ejemplar, prestamo.id_usb, prestamo.id_usuario,
                prestamo.id_bibliotecario, prestamo.fecha_prestamo, prestamo.hora_prestamo,
                prestamo.fecha_devolucion, prestamo.fecha_devolucion_real, prestamo.conteo_renovaciones,
                prestamo.medio_entrega
            ))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error inserting prestamo: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)
