from src.dao.comic_dao import *

comics = ComicDAO.seleccionar()
for comic in comics:
    log.debug(comic)