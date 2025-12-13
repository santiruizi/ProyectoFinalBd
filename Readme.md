# Sistema de Gestión Bibliotecaria (SGB)
**Universidad de Madeira**

## 📋 Descripción

Sistema de gestión bibliotecaria desarrollado en Python con Tkinter y PostgreSQL. Permite administrar usuarios, recursos bibliográficos, préstamos, reservas y multas. Incluye interfaz gráfica profesional y capa DAO robusta para persistencia de datos.

---

## 👥 Equipo de Desarrollo

- Santiago Ruiz Gallego
- Juan Camilo Garcia Durango
- Isaac Antillano Cruiz
- Andres David Gaitan
- Gabriela Lourdes Gomez

---

## 🏗️ Arquitectura del Sistema

El proyecto sigue el patrón **MVC (Modelo-Vista-Controlador)** adaptado:

```
┌──────────────────┐
│   VISTA (UI)     │  Tkinter - Interfaces gráficas
│   InterfazMain   │
│   InterfazLogin  │
│   Interfaz...    │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│   DAO (Acceso)   │  Capa de acceso a datos
│   UsuarioDAO     │  Operaciones CRUD
│   RecursoDAO     │  Transacciones ACID
│   LibroDAO       │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│  MODELO (BD)     │  PostgreSQL 17
│  usuario         │  Esquema relacional
│  recurso         │  Integridad referencial
│  prestamo        │
└──────────────────┘
```

---

## 🚀 Inicio Rápido

### Requisitos Previos

- **Python 3.8+**
- **PostgreSQL 17**
- **Tkinter** (incluido en Python estándar)

### Instalación

1. **Clonar el repositorio**
   ```bash
   git clone [URL_DEL_REPO]
   cd ProyectoBd
   ```

2. **Instalar dependencias**
   ```bash
   pip install -r requirements.txt
   ```

3. **Configurar la base de datos**
   - Crear base de datos en PostgreSQL: `Biblioteca_BD_2025-2`
   - Actualizar credenciales en `src/DAO/Connection.py` (línea 13)
   
4. **Crear tabla de usuarios** (primera vez)
   ```bash
   python test/create_table.py
   ```

5. **Ejecutar la aplicación**
   ```bash
   python src/views/InterfazMain.py
   ```

---

## 📁 Estructura del Proyecto

```
ProyectoBd/
├── src/
│   ├── DAO/                    # Capa de acceso a datos
│   │   ├── Connection.py       # Pool de conexiones PostgreSQL
│   │   ├── UsuarioDAO.py       # CRUD de usuarios
│   │   ├── RecursoDAO.py       # CRUD de recursos
│   │   ├── LibroDAO.py         # CRUD de libros (transaccional)
│   │   └── PrestamoDAO.py      # CRUD de préstamos
│   ├── models/                 # Modelos de entidades
│   │   ├── Usuario.py
│   │   ├── Recurso.py
│   │   ├── Prestamo.py
│   │   └── ...
│   └── views/                  # Interfaces gráficas (Tkinter)
│       ├── InterfazMain.py            # ★ PUNTO DE ENTRADA
│       ├── InterfazLogin.py           # Autenticación
│       ├── InterfazBibliotecario.py   # Gestión de usuarios
│       └── BusquedaSinIniciarCesion.py # Catálogo público
├── test/                       # Scripts de prueba
│   ├── test_usuario.py         # Tests CRUD usuario
│   └── create_table.py         # Inicialización BD
├── requirements.txt            # Dependencias Python
├── LICENSE                     # MIT License
└── README.md                   # Este archivo
```

---

## 🖥️ Módulos de la Interfaz

### 1. InterfazMain (Pantalla Principal)

**Punto de entrada del sistema**

Opciones:
- **Iniciar Sesión** → Acceso al sistema bibliotecario
- **Búsqueda Pública** → Consulta del catálogo sin autenticación

**Ejecutar**:
```bash
python src/views/InterfazMain.py
```

---

### 2. InterfazLogin (Autenticación)

Validación de credenciales contra la base de datos.

**Flujo**:
1. Ingresa ID de usuario
2. Ingresa contraseña (temporal: cualquier valor si el usuario existe)
3. Si válido → InterfazBibliotecario
4. Si inválido → Mensaje de error

---

### 3. InterfazBibliotecario (Gestión)

**Funcionalidades**:
- ✅ **Registrar Usuarios**: Formulario completo (ID, nombres, apellidos, correo)
- ✅ **Visualizar Usuarios**: Tabla en tiempo real desde PostgreSQL
- ✅ **Actualizar Lista**: Recarga datos de la BD
- ✅ **Cerrar Sesión**: Vuelve al menú principal

**Validaciones**:
- Campos obligatorios marcados
- Verificación contra duplicados
- Mensajes de confirmación/error

---

### 4. BusquedaSinIniciarCesion (Catálogo Público)

**Funcionalidades**:
- ✅ **Búsqueda por Código**: ID exacto del recurso
- ✅ **Búsqueda por Nombre**: Filtro por título (parcial)
- ✅ **Mostrar Todos**: Catálogo completo
- ✅ **Solo Lectura**: No permite modificaciones

**Datos mostrados**:
- Código del recurso
- Nombre/Título
- Estado (Disponible, Prestado, etc.)
- Colección

---

## 🗄️ Capa de Datos (DAO)

### Connection.py

**Pool de Conexiones** con `psycopg-pool`:
- Mínimo: 1 conexión
- Máximo: 20 conexiones
- Conexión automática a `Biblioteca_BD_2025-2`

### DAOs Implementados

| DAO | Operaciones | Características |
|-----|-------------|-----------------|
| **UsuarioDAO** | `get_all()`, `get_by_id()`, `insert()`, `update()`, `delete()` | Validación de campos obligatorios |
| **RecursoDAO** | `get_all()`, `get_by_id()`, `insert()`, `update()`, `delete()` | Gestión de estados |
| **LibroDAO** | `insert()` (transaccional), `update()`, `delete()` | Inserta Recurso + Libro atómicamente |
| **PrestamoDAO** | `get_all()`, `insert()` | Referencias a Usuario y Ejemplar |

**Principios aplicados**:
- Transacciones ACID (commit/rollback)
- Prevención de inyección SQL (parámetros vinculados)
- Manejo robusto de excepciones

---

## 🧪 Testing

### Tests Unitarios

**test_usuario.py**: Valida CRUD completo de UsuarioDAO

```bash
python test/test_usuario.py
```

**Cobertura**:
- ✅ INSERT: Crear usuario
- ✅ SELECT: Obtener por ID
- ✅ UPDATE: Modificar datos
- ✅ DELETE: Eliminar usuario

---

## 🔧 Configuración Avanzada

### Cambiar Base de Datos

Editar `src/DAO/Connection.py` (línea 13):
```python
conninfo = "host=localhost port=5432 dbname=TU_BD user=TU_USER password=TU_PASS"
```

### Agregar Nuevos DAOs

1. Crear archivo en `src/DAO/NuevoDAO.py`
2. Importar `Connection` y modelo correspondiente
3. Implementar métodos CRUD siguiendo patrón existente
4. Conectar a interfaz en `src/views/`

---

## 📄 Licencia

Este proyecto está bajo la **MIT License**.

```
Copyright (c) 2025 Santiago Ruiz Gallego, Juan Camilo Garcia Durango, 
Isaac Antillano Cruiz, Andres David Gaitan, Gabriela Lourdes Gomez
```

Consulte el archivo [LICENSE](LICENSE) para más detalles.

