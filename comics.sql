CREATE TABLE autor (
autor_id int,
nombre varchar (15),
apellido varchar (15),
CONSTRAINT autores_pk PRIMARY KEY(autor_id)
);

CREATE TABLE editorial (
editorial_id int,
nombre varchar (15),
CONSTRAINT editoriales_pk PRIMARY KEY(editorial_id)
);

CREATE TABLE comic (
comic_id int,
descripcion varchar (15),
autor_id int,
editorial_id int,
CONSTRAINT comics_pk PRIMARY KEY(comic_id),
CONSTRAINT fk_autores
FOREIGN KEY (autor_id)
REFERENCES autor(autor_id),
CONSTRAINT fk_editoriales
FOREIGN KEY (editorial_id)
REFERENCES editorial(editorial_id)
);

CREATE TABLE encargado (
encargado_id int,
nombre varchar (15),
apellido varchar (15),
DNI int NOT NULL,
direccion varchar (15),
CONSTRAINT encargados_pk PRIMARY KEY(encargado_id)
);

CREATE TABLE local (
local_id int,
encargado_id int NOT NULL,
nombre varchar (15),
direccion varchar (15),
latitud int NOT NULL,
longitud int NOT NULL,
CONSTRAINT locales_pk PRIMARY KEY(local_id),
CONSTRAINT fk_encargados
FOREIGN KEY (encargado_id)
REFERENCES encargado(encargado_id)
);

CREATE TABLE stock_comic (
stock_comic_id int,
comic_id int NOT NULL,
local_id int NOT NULL,
cantidad int,
CONSTRAINT stock_comics_pk PRIMARY KEY(stock_comic_id),
CONSTRAINT fk_locales
FOREIGN KEY (local_id)
REFERENCES local(local_id),
CONSTRAINT fk_comics
FOREIGN KEY (comic_id)
REFERENCES comic(comic_id)
);

CREATE TABLE medio_de_pago (
medio_de_pago_id int,
descripcion varchar (15),
slug varchar (15),
CONSTRAINT medios_de_pago_pk PRIMARY KEY(medio_de_pago_id)
);

CREATE TABLE tipo_operacion (
tipo_operacion_id int,
descripcion varchar (15),
CONSTRAINT tipos_operacion_pk PRIMARY KEY(tipo_operacion_id)
);

CREATE TABLE operacion (
medio_de_pago_id int NOT NULL,
tipo_operacion_id int NOT NULL,
comic_id int NOT NULL,
local_id int NOT NULL,
operacion_id int,
monto int,
CONSTRAINT operaciones_pk PRIMARY KEY(operacion_id),
CONSTRAINT fk_medios_de_pago
FOREIGN KEY (medio_de_pago_id)
REFERENCES medio_de_pago(medio_de_pago_id),
CONSTRAINT fk_tipos_operacion
FOREIGN KEY (tipo_operacion_id)
REFERENCES tipo_operacion(tipo_operacion_id),
CONSTRAINT fk_comics
FOREIGN KEY (comic_id)
REFERENCES comic(comic_id),
CONSTRAINT fk_locales
FOREIGN KEY (local_id)
REFERENCES local(local_id)
);

INSERT INTO autor(autor_id,nombre,apellido)values(1,'Stan','Lee');
INSERT INTO autor(autor_id,nombre,apellido)values(2,'Jerry','Siegel');
INSERT INTO autor(autor_id,nombre,apellido)values(3,'Bob','Kane');

INSERT INTO editorial(editorial_id,nombre)values(1,'Vid');
INSERT INTO editorial(editorial_id,nombre)values(2,'Action');
INSERT INTO editorial(editorial_id,nombre)values(3,'ECC');

INSERT INTO comic(comic_id,descripcion,autor_id,editorial_id)values(1,'X-MEN #2 - 1995',1,1);
INSERT INTO comic(comic_id,descripcion,autor_id,editorial_id)values(2,'Spiderman-1990',1,1);
INSERT INTO comic(comic_id,descripcion,autor_id,editorial_id)values(3,'Superman-2011',2,2);
INSERT INTO comic(comic_id,descripcion,autor_id,editorial_id)values(4,'Batman A1-2020',3,3);
INSERT INTO comic(comic_id,descripcion,autor_id,editorial_id)values(5,'Batman A3-2020',3,3);

INSERT INTO encargado(encargado_id,nombre,apellido,dni,direccion)values(1,'Jorge','Lopez','21954682','San Juan 1854');
INSERT INTO encargado(encargado_id,nombre,apellido,dni,direccion)values(2,'Ruben','Garcia','25842598','Donado 3645');

INSERT INTO local(local_id,encargado_id,nombre,direccion,latitud,longitud)values(1,1,'Comic Center','Elcano 3017','34','58');
INSERT INTO local(local_id,encargado_id,nombre,direccion,latitud,longitud)values(2,2,'The GF Comics','Corrientes 5239','35','57');

INSERT INTO medio_de_pago(medio_de_pago_id,descripcion,slug)values(1,'debito',NULL);
INSERT INTO medio_de_pago(medio_de_pago_id,descripcion,slug)values(2,'credito',NULL);
INSERT INTO medio_de_pago(medio_de_pago_id,descripcion,slug)values(3,'efectivo',NULL);

--1-- Insertar el tipo de operacion compra y el tipo venta, con id 1 y 2 respectivamente (no esta el insert en comics.sql)
INSERT INTO tipo_operacion(tipo_operacion_id,descripcion) VALUES(1,'compra')
INSERT INTO tipo_operacion(tipo_operacion_id,descripcion) VALUES(2,'venta')

--2-- Insertar 1 nuevo local llamado 'Comic DC'
INSERT INTO local(local_id,encargado_id,nombre,direccion,latitud,longitud) VALUES(3,2,'Comic DC','Florida 235','33','56')

--3-- Insertar 15 unidades de cada comic dentro del local 'Comic Center'
INSERT INTO stock_comic(stock_comic_id,comic_id,local_id,cantidad) VALUES(1,1,1,'15')
INSERT INTO stock_comic(stock_comic_id,comic_id,local_id,cantidad) VALUES(2,2,1,'15')
INSERT INTO stock_comic(stock_comic_id,comic_id,local_id,cantidad) VALUES(3,3,1,'15')
INSERT INTO stock_comic(stock_comic_id,comic_id,local_id,cantidad) VALUES(4,4,1,'15')
INSERT INTO stock_comic(stock_comic_id,comic_id,local_id,cantidad) VALUES(5,5,1,'15')

--4-- Insertar 20 unidades de 'X-MEN #2 - 1995' y 'Spiderman-1990' en el local 'The GF Comics'
INSERT INTO stock_comic(stock_comic_id,comic_id,local_id,cantidad) VALUES(6,1,2,'20')
INSERT INTO stock_comic(stock_comic_id,comic_id,local_id,cantidad) VALUES(7,2,2,'20')

--5-- Modificar el dni del encargado Jorge Lopez por '31954682' (UPDATE)
UPDATE encargado SET dni='31954682' WHERE encargado_id=1

--6-- Modificar la direccion del local Comic Center por Elcano 1233 (UPDATE)
UPDATE local SET direccion='Elcano 1233' WHERE local_id=1

--7-- Insertar 1 nuevo autor
INSERT INTO autor(autor_id,nombre,apellido) VALUES(4,'Akira','Toriyama')

--8-- Modificar la tabla operaciones agregando el campo fecha_operacion DATETIME (ALTER TABLE ADD COLUMN)
ALTER TABLE operacion
ADD COLUMN fecha_operacion TIMESTAMP NOT NULL

--9-- Modificar la tabla Medios de pago quitando el campo slug (DROP COLUMN)
ALTER TABLE medio_de_pago
DROP COLUMN slug

--10-- Agregar en encargado el campo fecha_nacimiento con valor por default 01-01-1999
ALTER TABLE encargado
ADD COLUMN fecha_nacimiento TIMESTAMP NOT NULL DEFAULT '01-01-1999'

--11-- Insertar dos operaciones de compra sobre el local 1 y 1 de venta sobre todos los locales
INSERT INTO operacion(medio_de_pago_id,tipo_operacion_id,comic_id,local_id,operacion_id,monto,fecha_operacion) VALUES(1,1,1,1,1,'1200','14-02-2022 14:36:57')
INSERT INTO operacion(medio_de_pago_id,tipo_operacion_id,comic_id,local_id,operacion_id,monto,fecha_operacion) VALUES(3,1,2,1,2,'900','15-02-2022 16:05:16')
INSERT INTO operacion(medio_de_pago_id,tipo_operacion_id,comic_id,local_id,operacion_id,monto,fecha_operacion) VALUES(3,2,4,1,3,'1600','02-02-2022 15:08:24')
INSERT INTO operacion(medio_de_pago_id,tipo_operacion_id,comic_id,local_id,operacion_id,monto,fecha_operacion) VALUES(1,2,2,2,4,'1650','03-02-2022 15:28:31')
INSERT INTO operacion(medio_de_pago_id,tipo_operacion_id,comic_id,local_id,operacion_id,monto,fecha_operacion) VALUES(3,2,5,3,5,'850','11-02-2022 11:34:08')