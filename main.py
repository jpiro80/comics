from src.dao.comic_dao import *

comic_buscar = input("Ingrese nombre o palabra clave del comic a buscar: ")

comics = ComicDAO.seleccionar_por_nombre(comic_buscar)
for comic in comics:
    log.debug(comic)