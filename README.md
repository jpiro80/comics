# Tiendas de Comics
Repositorio de ejemplo para simular tiendas de comics con sus respectivos stocks y operaciones.
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/database/der_comics.jpg"/></p>

## Objetivo
_La idea de este proyecto es poner en práctica el almacenamiento de base de datos y el uso de los comandos SQL en forma independiente y a través de Python._
## Requisitos
_El software necesario para este proyecto es el Python 3, el Pycharm y el PostgreSQL_
```
Links de descarga:
https://www.python.org/downloads/
https://www.jetbrains.com/es-es/pycharm-edu/
https://www.postgresql.org/download/
```
## Creación de base de datos
_Una vez instalados los programas, lo primero es ingresar al PostgreSQL mediante el acceso directo "PGAdmin" con la contraseña "admin" y crear una base de datos. Para ello, dar click derecho sobre "databases", ir a "Create" y luego ingresar en "Database" como indica la imagen._
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/database/imagenes/captura01.jpg"/></p>

_El el campo "Database" ingresar el nombre "comics" y dar click en "Save"_
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura02.jpg"/></p>

_Una vez creada la base de datos "comics", la misma aparecerá en la columna izquierda. Dar click derecho sobre la misma y luego ejecutar "Query Tool"_
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura03.jpg"/></p>

_Por último, abrir el archivo del repositorio "comics.sql", copiar y pegar todo su contenido en el Query Editor. Luego dar click sobre el botón de ejecutar, indicado en la imagen._
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura04.jpg"/></p>

## Conexión de Python a PostgreSQL
_Ya desde el Pycharm, conectaremos desde Python a la base de datos creada. Para eso comenzamos creando un nuevo proyecto. Vamos a "File" - "New Project" y luego creamos la carpeta "C:\Cursos\Python\BD\Leccion01", en "New environment using" seleccionamos "virtualenv" para crear un entorno virtual y en "interpreter" la versión de Python que tenemos instalada. Luego clickeamos en "Create"_
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura05.jpg"/></p>

_A continuación damos click sobre el botón "Terminal", escribimos "pip install psycopg2" y damos ENTER_
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura06.jpg"/></p>

_Para crear un archivo Python dentro del proyecto, damos click derecho sobre "Lección01" y seleccionamos "New" - "Python file" y llamamos al archivo "prueba_bd". Damos ENTER para crearlo._
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura07.jpg"/></p>

_Ingresamos el siguiente código en el archivo para iniciar la conexión a la base de datos y verificarla con la sentencia SELECT:_
```
import psycopg2

conexion = psycopg2.connect(user='postgres',password='admin',host='127.0.0.1',port='5432',database='comics')

cursor = conexion.cursor()
sentencia = 'SELECT * FROM comic'
cursor.execute(sentencia)
registros = cursor.fetchall()
print(registros)
```

_Una vez copiado y pegado damos click derecho sobre el campo de edición del archivo y seleccionamos "Run 'prueba_bd'"_
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura08.jpg"/></p>

_Al realizar esta conexión es necesario cerrarla. Por esta vez lo haremos manualmente, pero más adelante cuando usemos "with" se cerrará automáticamente y no será necesario. Escribimos entonces el siguiente código debajo de todo y ejecutamos el archivo:_
```
cursor.close()
conexion.close()
```
_Pero como se ha dicho anteriormente, este código no es necesario si utilizamos el método "with". Para ello, borramos todo el código y lo reemplazamos por el siguiente:_
```
import psycopg2

conexion = psycopg2.connect(user='postgres',password='admin',host='127.0.0.1',port='5432',database='comics')

try:
    with conexion:
        with conexion.cursor() as cursor:
            sentencia = 'SELECT * FROM comic'
            cursor.execute(sentencia)
            registros = cursor.fetchall()
            print(registros)
except Exception as e:
    print(f'Ocurrió un error: {e}')
finally:
    conexion.close()
```

## Transacciones
_A continuación, agregaremos un código de ejemplo para manejo de transacciones desde Python, mediante las cuales podremos modificar el contenido de la base de datos. Para ello primero debemos crear un archivo en nuestro proyecto llamado "transacciones.py" tal y como se muestra en la imagen._
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura09.jpg"/></p>

_Luego copiaremos como se ve en la imagen, el siguiente código en el cuerpo del archivo, pero no lo ejecutamos. Sólo lo guardamos por ahora._
```
import psycopg2 as bd

conexion = bd.connect(user='postgres',password='admin',host='127.0.0.1',port='5432',database='comics')

try:
    with conexion:
        with conexion.cursor() as cursor:
            sentencia = 'INSERT INTO comic(comic_id, descripcion, autor_id, editorial_id) VALUES(%s, %s, %s, %s)'
            valores = (2, 'Spiderman-1990', 1, 1)
            cursor.execute(sentencia, valores)

            sentencia = 'UPDATE comic SET comic_id=%s, descripcion=%s, autor_id=%s, editorial_id=%s WHERE comic_id=%s'
            valores = (3, 'Superman-2011', 2, 2)
            cursor.execute(sentencia, valores)
except Exception as e:
    print(f'Ocurrió un error, se hizo rollback: {e}')
finally:
    conexion.close()

print('Termina la transacción, se hizo commit')
```

## Capas de datos
Entramos de lleno a la creación de capas de datos.

_Crearemos un nuevo proyecto llamado "capa_datos_comic", luego iremos a la terminal como en el proyecto anterior para instalar el psycopg2 de la misma forma y como se ve en la pantalla. Y luego dentro del proyecto crearemos cuatro archivos: "logger_base.py", "conexion.py", "comic.py" y "comic_dao.py"._
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura10.jpg"/></p>

_En el archivo "logger_base.py" escribimos el siguiente código y ejecutamos:_
```
import logging as log

log.basicConfig(level=log.DEBUG,
                format='%(asctime)s: %(levelname)s [%(filename)s:%(lineno)s] %(message)s',
                datefmt='%I:%M:%S %p',
                handlers=[
                    log.FileHandler('capa_datos.log'),
                    log.StreamHandler()
                ])

if __name__ == '__main__':
    log.debug('Mensaje a nivel debug')
    log.info('Mensaje a nivel info')
    log.warning('Mensaje a nivel de warning')
    log.error('Mensaje a nivel de error')
    log.critical('Mensaje a nivel critico')
```

_Si no ocurrieron errores, en el archivo "conexion.py" escribimos el siguiente código y ejecutamos:_
```
from logger_base import log
import psycopg2 as bd
import sys

class Conexion:
    _DATABASE = 'comics'
    _USERNAME = 'postgres'
    _PASSWORD = 'admin'
    _DB_PORT = '5432'
    _HOST = '127.8.8.1'
    _conexion = None
    _cursor = None

    @classmethod
    def obtenerConexion(cls):
        if cls._conexion is None:
            try:
                cls._conexion = bd.connect(host=cls._HOST,
                                           user=cls._USERNAME,
                                           password=cls._PASSWORD,
                                           port=cls._DB_PORT,
                                           database=cls._DATABASE)
                log.debug(f'Conexión exitosa: {cls._conexion}')
                return cls._conexion
            except Exception as e:
                log.debug(f'Ocurrió una excepción {e}')
                sys.exit()
        else:
            return cls._conexion

    @classmethod
    def obtenerCursor(cls):
        if cls._cursor is None:
            try:
                cls._cursor = cls.obtenerConexion().cursor()
                log.debug(f'Se abrió correctamente el cursor: {cls._cursor}')
                return cls._cursor
            except Exception as e:
                log.error(f'Ocurrió una excepción al obtener el cursor: {e}')
                sys.exit()
        else:
            return cls._cursor

if __name__ == '__main__':
    Conexion.obtenerConexion()
    Conexion.obtenerCursor()
```

_Si no se produjeron errores, en el archivo "comic.py" escribir el siguiente código y ejecutar:_
```
from logger_base import log

class Comic:
    def __init__(self, comic_id=None, descripcion=None, autor_id=None, editorial_id=None):
        self._comic_id = comic_id
        self._descripcion = descripcion
        self._autor_id = autor_id
        self._editorial_id = editorial_id

    def __str__(self):
        return f'''
            Comic Id: {self._comic_id}, Descripcion: {self._descripcion},
            Autor Id: {self._autor_id}, Editorial Id: {self._editorial_id}
        '''
    @property
    def comic_id(self):
        return self._comic_id

    @comic_id.setter
    def comic_id(self, comic_id):
        self._comic_id = comic_id

    @property
    def descripcion(self):
        return self._descripcion

    @descripcion.setter
    def descripcion(self, descripcion):
        self._descripcion = descripcion

    @property
    def autor_id(self):
        return self._autor_id

    @autor_id.setter
    def autor_id(self, autor_id):
        self._autor_id = autor_id

    @property
    def editorial_id(self):
        return self._editorial_id

    @editorial_id.setter
    def editorial_id(self, editorial_id):
        self._editorial_id = editorial_id

if __name__ == '__main__':
    comic1 = Comic(1, 'X-MEN #2 - 1995', 1, 1)
    log.debug(comic1)
    # Simular un insert
    comic1 = Comic(descripcion='X-MEN #2 - 1995')
    log.debug(comic1)
    # Simular un delete
    comic1 = Comic(comic_id=1)
    log.debug(comic1)
```

_Si no se produjeron errores, insertamos por último el siguiente código en el archivo "comicDAO.py" y ejecutamos:_
```
from conexion import Conexion
from comic import Comic
from logger_base import log

class ComicDAO:
    '''
    DAO (Data Access Object)
    CRUD (Create-Read-Update-Delete)
    '''
    _SELECCIONAR = 'SELECT * FROM comic ORDER BY comic_id'
    # _INSERTAR = 'INSERT INTO comic(descripcion) VALUES(%s)'
    # _ACTUALIZAR = 'UPDATE comic SET descripcion=%s WHERE comic_id=%s'
    # _ELIMINAR = 'DELETE FROM comic WHERE comic_id=%s'

    @classmethod
    def seleccionar(cls):
        with Conexion.obtenerConexion() as conexion:
            with conexion.cursor() as cursor:
                cursor.execute(cls._SELECCIONAR)
                registros = cursor.fetchall()
                comics = []
                for registro in registros:
                    comic = Comic(registro[0], registro[1], registro[2], registro[3])
                    comics.append(comic)
                return comics

    # @classmethod
    # def insertar(cls, comic):
    #     with Conexion.obtenerConexion() as conexion:
    #         with conexion.cursor() as cursor:
    #             valores = (comic.descripcion)
    #             cursor.execute(cls._INSERTAR, valores)
    #             log.debug(f'Comic insertado: {comic}')
    #             return cursor.rowcount

    # @classmethod
    # def actualizar(cls, comic):
    #     with Conexion.obtenerConexion():
    #         with Conexion.obtenerCursor() as cursor:
    #             valores = (comic.comic_id, comic.descripcion, comic.autor_id, comic.editorial_id)
    #             cursor.execute(cls._ACTUALIZAR, valores)
    #             log.debug(f'Comic actualizado: {comic}')
    #             return cursor.rowcount

    # @classmethod
    # def eliminar(cls, comic):
    #     with Conexion.obtenerConexion():
    #         with Conexion.obtenerCursor() as cursor:
    #             valores = (comic.comic_id,)
    #             cursor.execute(cls._ELIMINAR, valores)
    #             log.debug(f'Objeto eliminado: {comic}')
    #             return cursor.rowcount

if __name__ == '__main__':
    # Insertar un registro
    # comic1 = Comic(descripcion='Spiderman-1990')
    # comics_insertados = ComicDAO.insertar(comic1)
    # log.debug(f'Comics insertados: {comics_insertados}')

    # Actualizar un registro
    # comic1 = Comic(1, 'Spiderman-1990', 1, 1)
    # comics_actualizados = ComicDAO.actualizar(comic1)
    # log.debug(f'Comics actualizados: {comics_actualizados}')

    # Eliminar un registro
    # comic1 = Comic(comic_id=1)
    # comics_eliminados = ComicDAO.eliminar(comic1)
    # log.debug(f'Comics eliminados: {comics_eliminados}')

    # Seleccionar objetos
    comics = ComicDAO.seleccionar()
    for comic in comics:
        log.debug(comic)
```
