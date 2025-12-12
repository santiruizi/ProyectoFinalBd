from DAO.Connection import Connection
from models.Libro import Libro
from DAO.RecursoDAO import RecursoDAO

class LibroDAO:
    @classmethod
    def get_all(cls):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            # Join with Recurso to get common attributes if needed but Libro model has them? 
            # Looking at Libro.py, it stores id_recurso but not nombre/estado directly. 
            # However, typically when fetching a book we want all info.
            # For simplicity, let's fetch from libro and if needed we can fetch the resource part.
            # But wait, Libro references Recurso. 
            
            query = """
            SELECT l.id_libro, l.isbn, l.resumen, l.fecha_publicacion, l.editorial, l.idioma, 
                   l.num_paginas, l.largo, l.ancho, l.grosor, l.tipo_encuadernacion, l.id_recurso
            FROM libro l
            """
            cursor.execute(query)
            rows = cursor.fetchall()
            libros = []
            for row in rows:
                libros.append(Libro(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11]))
            return libros
        except Exception as e:
            print(f"Error getting libros: {e}")
            return []
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def get_by_id(cls, id_libro):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            query = """
            SELECT l.id_libro, l.isbn, l.resumen, l.fecha_publicacion, l.editorial, l.idioma, 
                   l.num_paginas, l.largo, l.ancho, l.grosor, l.tipo_encuadernacion, l.id_recurso
            FROM libro l
            WHERE l.id_libro = %s
            """
            cursor.execute(query, (id_libro,))
            row = cursor.fetchone()
            if row:
                return Libro(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11])
            return None
        except Exception as e:
            print(f"Error getting libro by id: {e}")
            return None
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def insert(cls, libro, recurso):
        # Transactional insert: Recurso first, then Libro
        connection = None
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            
            # Insert Recurso
            cursor.execute("INSERT INTO recurso (id_recurso, nombre, estado, id_coleccion) VALUES (%s, %s, %s, %s)",
                           (recurso.getIdRecurso(), recurso.getNombre(), recurso.getEstado(), recurso.getIdColeccion()))
            
            # Insert Libro
            query_libro = """
            INSERT INTO libro (id_libro, isbn, resumen, fecha_publicacion, editorial, idioma, 
                               num_paginas, largo, ancho, grosor, tipo_encuadernacion, id_recurso)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(query_libro, (
                libro.getIdLibro(), libro.getIsbn(), libro.getResumen(), libro.getFechaPublicacion(),
                libro.getEditorial(), libro.getIdioma(), libro.getNumeroPaginas(), libro.getLargo(),
                libro.getAncho(), libro.getGrosor(), libro.getTipoEncuadernacion(), libro.getIdRecurso()
            ))
            
            connection.commit()
            return True
        except Exception as e:
            print(f"Error inserting libro: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def update(cls, libro):
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            query = """
            UPDATE libro SET isbn = %s, resumen = %s, fecha_publicacion = %s, editorial = %s, idioma = %s, 
                             num_paginas = %s, largo = %s, ancho = %s, grosor = %s, tipo_encuadernacion = %s
            WHERE id_libro = %s
            """
            cursor.execute(query, (
                libro.getIsbn(), libro.getResumen(), libro.getFechaPublicacion(),
                libro.getEditorial(), libro.getIdioma(), libro.getNumeroPaginas(), libro.getLargo(),
                libro.getAncho(), libro.getGrosor(), libro.getTipoEncuadernacion(), libro.getIdLibro()
            ))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error updating libro: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)

    @classmethod
    def delete(cls, id_libro):
        # Be careful with foreign keys. If we delete libro, we might want to delete recurso too or check constraints.
        # For now, let's just delete the libro entry.
        try:
            connection = Connection.get_connection()
            cursor = connection.cursor()
            cursor.execute("DELETE FROM libro WHERE id_libro = %s", (id_libro,))
            connection.commit()
            return True
        except Exception as e:
            print(f"Error deleting libro: {e}")
            if connection:
                connection.rollback()
            return False
        finally:
            if connection:
                cursor.close()
                Connection.put_connection(connection)
