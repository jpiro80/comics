-- Consultas SQL
-- completar en donde dice <completar> (ver ejercicio 1 de ejemplo)

-------------- Ejercicio 1 --------------
-- Listar la columna nombre y apellido de todos los autores
-- SELECT nombre, <completar> FROM <completar>;
-- Solucion:

SELECT nombre, apellido FROM autor;

-------------- Ejercicio 2 --------------
-- Listar el nombre y apellido de los autores llamados "Stan"
-- SELECT <completar> FROM autor WHERE nombre = <completar>;
-- Solucion:

SELECT nombre, apellido FROM autor WHERE nombre = 'Stan';

-------------- Ejercicio 3 --------------
-- Listar todos los autores cuyo apellido contenga al menos una letra "l"
-- SELECT <completar> FROM autor WHERE apellido LIKE <completar>;
-- Solucion:

SELECT nombre, apellido FROM autor WHERE apellido LIKE 'l';

-------------- Ejercicio 4 --------------
-- Listar todos los comic cuya descripcion contenga la palabra "er"
-- SELECT <completar> FROM comic WHERE <completar>
-- Solucion:

SELECT descripcion FROM comic WHERE descripcion LIKE 'er';

-------------- Ejercicio 5 --------------
-- Listar todos los comics con sus autores respectivos (Utilizar JOIN)
-- SELECT <completar> FROM comic c INNER JOIN autor a ON (c.autor_id = a.autor_id)
-- Solucion:

SELECT descripcion, nombre, apellido FROM comic c INNER JOIN autor a ON (c.autor_id = a.autor_id);

-------------- Ejercicio 6 --------------
-- Listar todos los comics con sus respectivas editoriales
-- SELECT <completar>
-- Solucion:

SELECT descripcion, nombre FROM comic d INNER JOIN editorial a ON (d.editorial_id = a.editorial_id);

-------------- Ejercicio 7 --------------
-- Listar todos los comics (solo descripcion) cuyo autor tengan "Lee" como apellido
-- SELECT <completar> FROM comic c 
-- 	INNER JOIN autor a ON (c.autor_id = a.autor_id) 
--  WHERE <completar>
-- Solucion:

SELECT descripcion, nombre, apellido FROM comic c INNER JOIN autor a ON (c.autor_id = a.autor_id) WHERE apellido = 'Lee';

-------------- Ejercicio 8 --------------
-- Listar todos los locales cuyo encargado sea Jorge Lopez
-- <completar>
-- Solucion:

SELECT b.nombre FROM local b INNER JOIN encargado a ON (b.encargado_id = a.encargado_id) WHERE apellido = 'Lopez';

-------------- Ejercicio 9 --------------
-- Listar todos los locales cuyo encargado contenga en su nombre la letra "e"
-- <completar>
-- Solucion:

SELECT b.nombre, b.direccion FROM local b INNER JOIN encargado c ON (b.encargado_id = c.encargado_id) WHERE b.nombre LIKE '%e%';