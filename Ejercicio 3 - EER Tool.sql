CREATE SCHEMA EER_tool;

USE EER_tool;

# 1. Changing every symbol or name not allow to use in variables or table names in SQL (#, ., Time, Year, etc.)
# 2. Inserting every PRIMARY KEY in their appropriate table inside the create table query.
# 3. Introducing every FOREING KEY in their appropriate table into the create table query when possible.
# 4. Changing data types when needed

CREATE TABLE ATRIBUTOS
(
	N_atributo           VARCHAR(20) NOT NULL,
	N_T_Dato             VARCHAR(20) NULL,
    PRIMARY KEY (N_atributo)
);


CREATE TABLE CARDINALIDAD
(
	min                  CHAR NULL,
	max                  CHAR NULL
);

CREATE TABLE CATEGORIA
(
	N_T_Entidad         VARCHAR(20) NULL,
	N_T_Dato             VARCHAR(20) NULL
);

CREATE TABLE DERIVADOS
(
	N_atributo           VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_atributo),
    FOREIGN KEY (N_atributo) REFERENCES ATRIBUTOS (N_atributo)		ON DELETE CASCADE
);



CREATE TABLE ESPECIALIZACION
(
	N_T_Entidad         VARCHAR(20) NULL,
	N_T_Dato             VARCHAR(20) NULL
);

CREATE TABLE ESQUEMA_CONCEPTUAL
(
	Autor                VARCHAR(20) NULL,
	NombreProyecto       VARCHAR(20) NOT NULL,
    PRIMARY KEY (NombreProyecto)
);


CREATE TABLE MULTIVALUADOS
(
	N_atributo           VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_atributo),
    FOREIGN KEY (N_atributo) REFERENCES ATRIBUTOS (N_atributo)		ON DELETE CASCADE
);


CREATE TABLE PARTICIPACIÓN
(
	N_T_Relacion         VARCHAR(20) NULL,
	N_T_Dato             VARCHAR(20) NULL,
	N_T_Entidad         VARCHAR(20) NULL
);

CREATE TABLE T_ENTIDAD
(
	N_T_Entidad         VARCHAR(20) NOT NULL,
	N_T_Dato             VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_T_Entidad,N_T_Dato)
);

ALTER TABLE CATEGORIA
ADD CONSTRAINT Superclase_cat FOREIGN KEY (N_T_Entidad, N_T_Dato) REFERENCES T_ENTIDAD (N_T_Entidad, N_T_Dato);

ALTER TABLE ESPECIALIZACION
ADD CONSTRAINT Superclase_esp FOREIGN KEY (N_T_Entidad, N_T_Dato) REFERENCES T_ENTIDAD (N_T_Entidad, N_T_Dato);

ALTER TABLE PARTICIPACIÓN
ADD CONSTRAINT R_27 FOREIGN KEY (N_T_Entidad, N_T_Dato) REFERENCES T_ENTIDAD (N_T_Entidad, N_T_Dato);

CREATE TABLE T_ENTIDAD_DEBIL
(
	N_T_Entidad         VARCHAR(20) NOT NULL,
	N_T_Relacion         VARCHAR(20) NULL,
	N_T_Dato             VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_T_Entidad,N_T_Dato),
    FOREIGN KEY (N_T_Entidad, N_T_Dato) REFERENCES T_ENTIDAD (N_T_Entidad, N_T_Dato)		ON DELETE CASCADE
);


CREATE TABLE T_ENTIDAD_CATEGORIA
(
	N_T_Entidad         VARCHAR(20) NOT NULL,
	N_T_Dato             VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_T_Entidad,N_T_Dato),
    FOREIGN KEY (N_T_Entidad, N_T_Dato) REFERENCES T_ENTIDAD (N_T_Entidad, N_T_Dato)
);


CREATE TABLE T_ENTIDAD_ESPECIALIZACION
(
	N_T_Entidad         VARCHAR(20) NOT NULL,
	N_T_Dato             VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_T_Entidad,N_T_Dato),
    FOREIGN KEY (N_T_Entidad, N_T_Dato) REFERENCES T_ENTIDAD (N_T_Entidad, N_T_Dato)
);


CREATE TABLE T_RELACION
(
	N_T_Relacion         VARCHAR(20) NOT NULL,
	N_T_Dato             VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_T_Relacion,N_T_Dato)
);

ALTER TABLE PARTICIPACIÓN
ADD CONSTRAINT R_26 FOREIGN KEY (N_T_Relacion, N_T_Dato) REFERENCES T_RELACION (N_T_Relacion, N_T_Dato);


CREATE TABLE T_RELACION_DÉBIL
(
	N_T_R_Debil          VARCHAR(20) NULL,
	N_T_Relacion         VARCHAR(20) NOT NULL,
	N_T_Dato             VARCHAR(20) NOT NULL,
    PRIMARY KEY (N_T_Relacion,N_T_Dato),
    FOREIGN KEY (N_T_Relacion, N_T_Dato) REFERENCES T_RELACION (N_T_Relacion, N_T_Dato) ON DELETE CASCADE
);

ALTER TABLE T_ENTIDAD_DEBIL
ADD CONSTRAINT Identifica FOREIGN KEY (N_T_Relacion, N_T_Dato) REFERENCES T_RELACION_DÉBIL (N_T_Relacion, N_T_Dato);


CREATE TABLE TIPOS_DE_DATOS
(
	N_T_Dato             VARCHAR(20) NOT NULL,
	NombreProyecto       VARCHAR(20) NULL,
    PRIMARY KEY (N_T_Dato),
    FOREIGN KEY (NombreProyecto) REFERENCES ESQUEMA_CONCEPTUAL (NombreProyecto)
);


ALTER TABLE ATRIBUTOS
ADD CONSTRAINT Descrito_por FOREIGN KEY (N_T_Dato) REFERENCES TIPOS_DE_DATOS (N_T_Dato);

ALTER TABLE T_RELACION
ADD CONSTRAINT R_18 FOREIGN KEY (N_T_Dato) REFERENCES TIPOS_DE_DATOS (N_T_Dato)		ON DELETE CASCADE;

ALTER TABLE T_ENTIDAD
ADD CONSTRAINT R_19 FOREIGN KEY (N_T_Dato) REFERENCES TIPOS_DE_DATOS (N_T_Dato) 	ON DELETE CASCADE;
