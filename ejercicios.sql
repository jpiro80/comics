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

SELECT nombre, apellido FROM autor WHERE apellido LIKE '%l%';

-------------- Ejercicio 4 --------------
-- Listar todos los comic cuya descripcion contenga la palabra "er"
-- SELECT <completar> FROM comic WHERE <completar>
-- Solucion:

SELECT descripcion FROM comic WHERE descripcion LIKE '%er%';

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

SELECT b.nombre FROM local b INNER JOIN encargado a ON (b.encargado_id = a.encargado_id) WHERE a.nombre = 'Jorge' AND a.apellido = 'Lopez';

-------------- Ejercicio 9 --------------
-- Listar todos los locales cuyo encargado contenga en su nombre la letra "e"
-- <completar>
-- Solucion:

SELECT b.nombre, b.direccion FROM local b INNER JOIN encargado c ON (b.encargado_id = c.encargado_id) WHERE b.nombre LIKE '%e%';

-------------- Ejercicio 10 --------------
-- Listar todos los autores cuyo apellido comience con la letra L
-- Solucion:

SELECT nombre, apellido FROM autor WHERE apellido LIKE 'L%';

-------------- Ejercicio 11 --------------
-- Listar todos los autores cuyo apellido finalice con la letra l
-- Solucion:

SELECT nombre, apellido FROM autor WHERE apellido LIKE '%l';

-------------- Ejercicio 12 --------------
-- Listar todos los autores cuyo apellido contengan la letra l (no distinguir entre mayuscula y minuscula)
-- Ver https://es.stackoverflow.com/questions/205056/c%C3%B3mo-puedo-hacer-una-consulta-en-postgresql-sin-discriminar-min%C3%BAsculas-y-may%C3%BAsc
-- Solucion:

SELECT nombre, apellido FROM autor WHERE apellido ILIKE '%l%';

-------------- Ejercicio 13 --------------
-- Listar todos los comics cuya descripcion comience con la letra s (no distinguir entre mayuscula y minuscula)
-- Ver https://es.stackoverflow.com/questions/205056/c%C3%B3mo-puedo-hacer-una-consulta-en-postgresql-sin-discriminar-min%C3%BAsculas-y-may%C3%BAsc
-- Solucion:

SELECT descripcion FROM comic WHERE descripcion ILIKE 's%';

-------------- Ejercicio 14 --------------
-- Listar nombre apellido y dni de los encargados cuyo nombre o apellido contengan una letra r (no distinguir mayuscula y minuscula)
-- Ver https://es.stackoverflow.com/questions/205056/c%C3%B3mo-puedo-hacer-una-consulta-en-postgresql-sin-discriminar-min%C3%BAsculas-y-may%C3%BAsc
-- Solucion:

SELECT nombre, apellido, dni FROM encargado WHERE nombre ILIKE '%r%' OR apellido ILIKE '%r%';

-------------- Ejercicio 15 --------------
-- Listar encargados cuyo nombre comience con j o termine con n (no distinguir mayuscula y minuscula)
-- Ver https://es.stackoverflow.com/questions/205056/c%C3%B3mo-puedo-hacer-una-consulta-en-postgresql-sin-discriminar-min%C3%BAsculas-y-may%C3%BAsc
-- Solucion:

SELECT nombre, apellido, dni FROM encargado WHERE nombre ILIKE 'j%' OR nombre ILIKE '%n';

-------------- Ejercicio 16 --------------
-- Listar todos los autores cuyo apellido comience con la letra L (Mayuscula)
-- Solucion:

SELECT nombre, apellido FROM autor WHERE apellido LIKE 'L%';

-------------- Ejercicio 17 --------------
-- Listar todos los autores cuyo apellido finalice con la letra l (minuscula)
-- Solucion:

SELECT nombre, apellido FROM autor WHERE apellido LIKE '%l';

-------------- Ejercicio 18 --------------
-- Listar el stock total de cada comic por cada tienda
-- Ejemplo: local           comic           stock
--			'Comic Center' 'Spiderman-1990' 24
-- Ver https://www.tutorialesprogramacionya.com/postgresqlya/temarios/descripcion.php?cod=190&punto=&inicio=
-- Solucion:

SELECT local.nombre,comic.descripcion,stock_comic.cantidad
	FROM stock_comic INNER JOIN comic ON stock_comic.comic_id = comic.comic_id
					 INNER JOIN local ON stock_comic.local_id = local.local_id
GROUP BY local.nombre,comic.descripcion, stock_comic.cantidad;

-------------- Ejercicio 19 --------------
-- Listar el stock total de cada comic de todas las tiendas
-- Ej:	comic 				total
--		'Spiderman-1990'	120
-- Ver https://www.tutorialesprogramacionya.com/postgresqlya/temarios/descripcion.php?cod=190&punto=&inicio=
-- Solucion:

SELECT descripcion,cantidad FROM comic,stock_comic GROUP BY comic.descripcion,stock_comic.cantidad ORDER BY comic.descripcion;

-------------- Ejercicio 20 --------------
-- Listar la cantidad de locales (utilizar count)
-- Ver https://www.tutorialesprogramacionya.com/postgresqlya/temarios/descripcion.php?cod=190&punto=&inicio=
-- Solucion:

SELECT nombre,count(*) FROM local GROUP BY local.nombre;

-------------- Ejercicio 21 --------------
-- Listar la cantidad de operaciones por cada local
-- Ver https://www.tutorialesprogramacionya.com/postgresqlya/temarios/descripcion.php?cod=190&punto=&inicio=
-- Solucion: 

SELECT operacion_id,nombre,descripcion FROM operacion,local,tipo_operacion GROUP BY operacion.operacion_id,local.nombre,tipo_operacion.descripcion ORDER BY operacion.operacion_id;