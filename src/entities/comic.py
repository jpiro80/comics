from src.logger_base import log

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