-- Tabla: pacientes

INSERT INTO pacientes (idpaciente, rutPaciente, nombre, apellido) VALUES (1, '15940287-3', 'Rodolfo', 'Nalgonius');
INSERT INTO pacientes (idpaciente, rutPaciente, nombre, apellido) VALUES (11, '92521621-8', 'Valerie', 'Panzoni');
INSERT INTO pacientes (idpaciente, rutPaciente, nombre, apellido) VALUES (21, '71488692-0', 'Ochovia', 'Beloseno');
INSERT INTO pacientes (idpaciente, rutPaciente, nombre, apellido) VALUES (31, '10748295-7', 'Quinn', 'Shelton');
INSERT INTO pacientes (idpaciente, rutPaciente, nombre, apellido) VALUES (41, '03528514-0', 'Arthur', 'Sanders');

-- Tabla: especialidades
insert into especialidades (idespecialidad, descripcion) values (1, 'Proctología');
insert into especialidades (idespecialidad, descripcion) values (2, 'Gastroenterología');
insert into especialidades (idespecialidad, descripcion) values (3, 'Ginecología');
insert into especialidades (idespecialidad, descripcion) values (4, 'Neurología');
insert into especialidades (idespecialidad, descripcion) values (5, 'Traumatología');
insert into especialidades (idespecialidad, descripcion) values (6, 'Cardiología');
insert into especialidades (idespecialidad, descripcion) values (7, 'Psiquiatría');

-- Tabla: doctores
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (1, '88043333-8', 'Emerson', 'Lucas', 6);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (11, '75287688-3', 'Chanda', 'Sanford', 7);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (21, '91861215-8', 'Peter', 'Hale', 4);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (31, '79410617-6', 'Tamekah', 'Bond', 3);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (41, '78920002-5', 'Juan', 'Manogrande', 1);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (51, '92757073-0', 'Rebeca', 'Güatuzi', 1);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (61, '91223342-7', 'Galvin', 'Lee', 5);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (71, '07017187-1', 'Jamal', 'Hinton', 7);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (81, '80724757-8', 'Josefa', 'Amasabubis', 2);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (91, '87427572-5', 'Nasim', 'Branch', 3);
INSERT INTO doctores (idDoctor, rutDoctor, nombre, apellido, idEspecialidad) VALUES (101, '53345395-4', 'Alika', 'Nixon', 5);

-- Tabla: agendas
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (1, 41, 1, TO_DATE('24/08/20', 'DD/MM/YY'), TO_DATE('12:00', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (11, 51, 2, TO_DATE('24/08/20', 'DD/MM/YY'), TO_DATE('14:15', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (21, 81, 3, TO_DATE('24/08/20', 'DD/MM/YY'), TO_DATE('17:30', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (31, 11, 4, TO_DATE('24/08/20', 'DD/MM/YY'), TO_DATE('18:00', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (41, 1, 5, TO_DATE('28/08/20', 'DD/MM/YY'), TO_DATE('18:15', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (1, 31, 6, TO_DATE('25/08/20', 'DD/MM/YY'), TO_DATE('09:00', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (11, 21, 7, TO_DATE('31/08/20', 'DD/MM/YY'), TO_DATE('10:45', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (21, 71, 8, TO_DATE('28/08/20', 'DD/MM/YY'), TO_DATE('11:30', 'HH24:MI'), 15);
INSERT INTO agendas (idPaciente, idDoctor, idAgenda, fecha, horaDesde, duracion) VALUES (31, 101, 9, TO_DATE('24/08/20', 'DD/MM/YY'), TO_DATE('19:45', 'HH24:MI'), 15);
