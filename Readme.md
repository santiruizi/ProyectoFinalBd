# Sistema de Gestión Bibliotecaria (SGB)

Sistema desarrollado para la Universidad de Madeira, orientado a la administración eficiente de recursos bibliográficos, control de usuarios y gestión de transacciones.

## Equipo de Desarrollo
*   Santiago Ruiz Gallego
*   Juan Camilo Garcia Durango
*   Isaac Antillano Cruiz
*   Andres David Gaitan
*   Gabriela Lourdes Gomez

## Especificaciones Técnicas

### 1. Capa de Persistencia (DAO)
Implementación del patrón **Data Access Object (DAO)** para desacoplar la lógica de negocio del acceso a datos.
*   **Conexión**: Uso de `psycopg-pool` para gestionar un pool de conexiones a PostgreSQL, optimizando la concurrencia y reduciendo el overhead de conexión.
*   **Transaccionalidad**: Manejo explícito de transacciones (ACID) para operaciones de escritura. Inserciones complejas (ej. `Libro` + `Recurso`) se ejecutan atómicamente; cualquier fallo provoca un `rollback` automático.

### 2. Modelo de Datos Relacional
El esquema de base de datos utiliza **integridad referencial fuerte** y normalización.
*   **Herencia de Usuarios**: Estrategia *Table-per-Type* lógica. La tabla `usuario` centraliza credenciales y datos comunes, mientras `estudiante`, `profesor` y `bibliotecario` almacenan atributos específicos, vinculados por FK `id_usuario`.
*   **Polimorfismo de Recursos**: La entidad `recurso` actúa como supertipo. Las tablas hijas (`libro`, `revista`, `dispositivo`) extienden la funcionalidad mediante FK `id_recurso`, permitiendo consultas unificadas de estado.

### 3. Funcionalidades Core
*   **CRUD Avanzado**: Operaciones de Crear, Leer, Actualizar y Eliminar implementadas con prevención de inyección SQL (uso de parámetros vinculados `%s`).
*   **Gestión de Estados**: Lógica de negocio para transiciones de estado de recursos (`Disponible` ↔ `Prestado` ↔ `Reservado`).
*   **Validación de Esquema**: Verificación estricta de tipos de datos y restricciones (`NOT NULL`, `CHECK`) desde el diseño de la BD.

## Licencia
Este proyecto está bajo la Licencia MIT. Consulte el archivo `LICENSE` para más detalles.
