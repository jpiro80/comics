CREATE TABLE autor (
    autor_id int NOT NULL AUTO_INCREMENT,
    nombre varchar (15),
    apellido varchar (15),
    CONSTRAINT autores_pk PRIMARY KEY(autor_id)
);

CREATE TABLE editorial (
    editorial_id int NOT NULL AUTO_INCREMENT,
    nombre varchar (15),
    CONSTRAINT editoriales_pk PRIMARY KEY(editorial_id)
);

CREATE TABLE comic (
    comic_id int NOT NULL AUTO_INCREMENT,
    descripcion varchar (15),
    autor_id int,
    editorial_id int,
    CONSTRAINT comics_pk PRIMARY KEY(comic_id),
    CONSTRAINT fk_autores
        FOREIGN KEY (autor_id)
        REFERENCES autores(autor_id),
    CONSTRAINT fk_editoriales
        FOREIGN KEY (editorial_id)
        REFERENCES editoriales(editorial_id)
);

CREATE TABLE encargado (
    encargado_id int NOT NULL AUTO_INCREMENT,
    nombre varchar (15),
    apellido varchar (15),
    DNI int NOT NULL,
    direccion varchar (15),
    CONSTRAINT encargados_pk PRIMARY KEY(encargado_id)
);

CREATE TABLE local (
    local_id int NOT NULL AUTO_INCREMENT,
    encargado_id int NOT NULL,
    nombre varchar (15),
    direccion varchar (15),
    latitud int NOT NULL,
    longitud int NOT NULL,
    CONSTRAINT locales_pk PRIMARY KEY(local_id),
    CONSTRAINT fk_encargados
        FOREIGN KEY (encargado_id)
        REFERENCES encargados(encargado_id)
);

CREATE TABLE stock_comic (
    stock_comic_id int NOT NULL AUTO_INCREMENT,
    comic_id int NOT NULL,
    local_id int NOT NULL,
    cantidad int,
    CONSTRAINT stock_comics_pk PRIMARY KEY(stock_comic_id),
    CONSTRAINT fk_locales
        FOREIGN KEY (local_id)
        REFERENCES locales(local_id),
    CONSTRAINT fk_comics
        FOREIGN KEY (comic_id)
        REFERENCES comics(comic_id)
);

CREATE TABLE medio_de_pago (
    medio_de_pago_id int NOT NULL AUTO_INCREMENT,
    descripcion varchar (15),
    slug varchar (15),
    CONSTRAINT medios_de_pago_pk PRIMARY KEY(medio_de_pago_id)
);

CREATE TABLE tipo_operacion (
    tipo_operacion_id int NOT NULL AUTO_INCREMENT,
    descripcion varchar (15),
    CONSTRAINT tipos_operacion_pk PRIMARY KEY(tipo_operacion_id)
);

CREATE TABLE operacion (
    operacion_id int NOT NULL AUTO_INCREMENT,
    monto int,
    CONSTRAINT operaciones_pk PRIMARY KEY(operacion_id),
    CONSTRAINT fk_medios_de_pago
        FOREIGN KEY (medio_de_pago_id)
        REFERENCES medios_de_pago(medio_de_pago_id),
    CONSTRAINT fk_tipos_operacion
        FOREIGN KEY (tipo_operacion_id)
        REFERENCES tipos_operacion(tipo_operacion_id),
    CONSTRAINT fk_comics
        FOREIGN KEY (comic_id)
        REFERENCES comics(comic_id),
    CONSTRAINT fk_locales
        FOREIGN KEY (local_id)
        REFERENCES locales(local_id)
);