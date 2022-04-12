from src.dao.conexion import Conexion
from src.entities.comic import Comic
from src.logger_base import log

class ComicDAO:
    '''
    DAO (Data Access Object)
    CRUD (Create-Read-Update-Delete)
    '''
    # _SELECCIONAR = 'SELECT * FROM comic ORDER BY comic_id'
    # _SELECCIONAR_POR_NOMBRE = 'SELECT * FROM comic WHERE comic.descripcion LIKE s% LIMIT 1', ('%' + comic.descripcion + '%',)
    # _INSERTAR = 'INSERT INTO comic(descripcion) VALUES(%s)'
    # _ACTUALIZAR = 'UPDATE comic SET descripcion=%s WHERE comic_id=%s'
    # _ELIMINAR = 'DELETE FROM comic WHERE comic_id=%s'

    # @classmethod
    # def seleccionar(cls):
    #     with Conexion.obtenerConexion() as conexion:
    #         with conexion.cursor() as cursor:
    #             cursor.execute(cls._SELECCIONAR)
    #             registros = cursor.fetchall()
    #             comics = []
    #             for registro in registros:
    #                 comic = Comic(registro[0], registro[1], registro[2], registro[3])
    #                 comics.append(comic)
    #             return comics

    @classmethod
    def seleccionar_por_nombre(cls, comic_buscar):
        with Conexion.obtenerConexion() as conexion:
            with conexion.cursor() as cursor:
                cursor.execute('SELECT * FROM comic WHERE comic.descripcion LIKE %s LIMIT 1', [comic_buscar])
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