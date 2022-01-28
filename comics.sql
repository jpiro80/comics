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

INSERT INTO encargado(encargado_id,nombre,apellido,dni,direccion)values(1,'Jorge Lopez','21954682','San Juan 1854');
INSERT INTO encargado(encargado_id,nombre,apellido,dni,direccion)values(2,'Ruben Garcia','25842598','Donado 3645');

INSERT INTO local(local_id,encargado_id,nombre,direccion,latitud,longitud)values(1,1,'Comic Center','Elcano 3017','34','58');
INSERT INTO local(local_id,encargado_id,nombre,direccion,latitud,longitud)values(2,2,'The GF Comics','Corrientes 5239','35','57');

INSERT INTO medio_de_pago(medio_de_pago_id,descripcion,slug)values(1,'debito',NULL);
INSERT INTO medio_de_pago(medio_de_pago_id,descripcion,slug)values(2,'credito',NULL);
INSERT INTO medio_de_pago(medio_de_pago_id,descripcion,slug)values(3,'efectivo',NULL);