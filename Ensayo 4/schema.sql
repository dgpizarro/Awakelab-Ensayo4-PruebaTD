
CREATE TABLE agendas (
    idpaciente  INTEGER NOT NULL,
    iddoctor    INTEGER NOT NULL,
    idagenda    INTEGER NOT NULL,
    fecha       DATE NOT NULL,
    horadesde   DATE NOT NULL,
    duracion    INTEGER NOT NULL
);

ALTER TABLE agendas ADD CONSTRAINT agendas_pk PRIMARY KEY ( idagenda );

CREATE TABLE doctores (
    iddoctor        INTEGER NOT NULL,
    rutdoctor       VARCHAR2(11 CHAR) NOT NULL,
    nombre          VARCHAR2(50 CHAR) NOT NULL,
    apellido        VARCHAR2(50 CHAR) NOT NULL,
    idespecialidad  INTEGER NOT NULL
);

ALTER TABLE doctores ADD CONSTRAINT doctores_pk PRIMARY KEY ( iddoctor );

CREATE TABLE especialidades (
    idespecialidad  INTEGER NOT NULL,
    descripcion     VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE especialidades ADD CONSTRAINT especialidades_pk PRIMARY KEY ( idespecialidad );

CREATE TABLE pacientes (
    idpaciente   INTEGER NOT NULL,
    rutpaciente  VARCHAR2(11 CHAR) NOT NULL,
    nombre       VARCHAR2(50 CHAR) NOT NULL,
    apellido     VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE pacientes ADD CONSTRAINT pacientes_pk PRIMARY KEY ( idpaciente );

ALTER TABLE agendas
    ADD CONSTRAINT agendas_doctores_fk FOREIGN KEY ( iddoctor )
        REFERENCES doctores ( iddoctor );

ALTER TABLE agendas
    ADD CONSTRAINT agendas_pacientes_fk FOREIGN KEY ( idpaciente )
        REFERENCES pacientes ( idpaciente );

ALTER TABLE doctores
    ADD CONSTRAINT doctores_especialidades_fk FOREIGN KEY ( idespecialidad )
        REFERENCES especialidades ( idespecialidad );
