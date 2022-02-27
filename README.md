# Tiendas de Comics
Repositorio de ejemplo para simular tiendas de comics con sus respectivos stocks y operaciones.
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/der_comics.jpg"/></p>

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
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura01.jpg"/></p>

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
<p align="center"><img src="https://github.com/jpiro80/comics/blob/master/imagenes/captura07.jpg"/></p>
