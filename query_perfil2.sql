DROP DATABASE IF EXISTS EduManageDB;

CREATE DATABASE EduManageDB;

USE EduManageDB;

CREATE TABLE tb_alumnos(
id_alumno CHAR(36) PRIMARY KEY NOT NULL,
carnet_alumno VARCHAR(10) NOT NULL,
nombre_alumno VARCHAR(50) NOT NULL,
apellido_alumno VARCHAR(50) NOT NULL,
edad_alumno INT NOT NULL
);

ALTER TABLE tb_alumnos ADD CONSTRAINT check_edad CHECK(edad_alumno > 17);

CREATE TABLE tb_profesores(
id_profesor CHAR(36) PRIMARY KEY NOT NULL,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL,
correo_electronico VARCHAR(100) NOT NULL
);

CREATE TABLE tb_materias(
id_materia CHAR(36) PRIMARY KEY NOT NULL,
nombre_materia VARCHAR(100) NOT NULL,
grupo_materia INT NOT NULL,
id_profesor CHAR(36) NOT NULL,
cupos INT
);

ALTER TABLE tb_materias ADD CONSTRAINT check_cupos CHECK(cupos > 0);
ALTER TABLE tb_materias ADD CONSTRAINT check_grupo CHECK(grupo_materia > 0);
ALTER TABLE tb_materias ADD CONSTRAINT fk_materias_profesores FOREIGN KEY(id_profesor) REFERENCES tb_profesores(id_profesor);

CREATE TABLE tb_inscripciones (
id_inscripcion CHAR(36) PRIMARY KEY NOT NULL,
id_alumno CHAR(36) NOT NULL,
id_materia CHAR(36) NOT NULL,
fecha_inscripcion DATE NOT NULL,
estado ENUM("Activo", "Inactivo") NOT NULL
);

ALTER TABLE tb_inscripciones ADD CONSTRAINT fk_inscripcion_alumno FOREIGN KEY (id_alumno) REFERENCES tb_alumnos(id_alumno);
ALTER TABLE tb_inscripciones ADD CONSTRAINT fk_inscripcion_materia foreign key(id_materia) REFERENCES tb_materias(id_materia);

CREATE TABLE tb_calificaciones(
id_calificacion CHAR(36) PRIMARY KEY NOT NULL,
id_inscripcion CHAR(36) NOT NULL,
calificacion_final DECIMAL(5,2) NOT NULL,
fecha_calificacion DATE NOT NULL
);

ALTER TABLE tb_calificaciones ADD CONSTRAINT check_calificacion CHECK(calificacion_final > 0);
ALTER TABLE tb_calificaciones ADD CONSTRAINT fk_calificacion_inscripcion FOREIGN KEY(id_inscripcion) REFERENCES tb_inscripciones(id_inscripcion);


CREATE USER 'edu_manage'@'localhost' IDENTIFIED BY 'edu_manage_2024';
GRANT SELECT, INSERT, UPDATE, DELETE ON edumanagedb.* TO 'edu_manage'@'localhost';
GRANT CREATE, ALTER, DROP ON edumanagedb.* TO 'edu_manage'@'localhost';
GRANT CREATE VIEW, TRIGGER ON edumanagedb.* TO 'edu_manage'@'localhost';
GRANT DROP ON edumanagedb.* TO 'edu_manage'@'localhost';
GRANT CREATE ROUTINE ON edumanagedb.* TO 'edu_manage'@'localhost';

SELECT USER, HOST FROM mysql.user;
SHOW GRANTS FOR 'edu_manage'@'localhost';

DELIMITER //

CREATE TRIGGER actualizarcupos
AFTER INSERT ON tb_inscripciones
FOR EACH ROW
BEGIN
UPDATE tb_materias
SET cupos = cupos - 1
WHERE id_materia = NEW.id_materia;
END//

DELIMITER ;

SELECT * FROM tb_materias;
SELECT * FROM tb_profesores;
SELECT * FROM tb_alumnos;
SELECT * FROM tb_inscripciones;


-- procedimientos almacenados
DELIMITER //
CREATE PROCEDURE insercciones_profesores
(
    IN id_profesor CHAR(36),
    IN nombre VARCHAR(100),
    IN apellido VARCHAR(100),
    IN correo_electronico VARCHAR(100)
)
BEGIN
    INSERT INTO tb_profesores (id_profesor, nombre, apellido, correo_electronico)
    VALUES (id_profesor, nombre, apellido, correo_electronico);
END //
DELIMITER ;

CALL insercciones_profesores(UUID(), 'María', 'García', 'maria.garcia@gmail.com');
CALL insercciones_profesores(UUID(), 'Juan', 'Martínez', 'juan.martinez@gmail.com');
CALL insercciones_profesores(UUID(), 'Ana', 'López', 'ana.lopez@gmail.com');
CALL insercciones_profesores(UUID(), 'Pablo', 'Rodríguez', 'pablo.rodriguez@gmail.com');
CALL insercciones_profesores(UUID(), 'Carmen', 'Sánchez', 'carmen.sanchez@gmail.com');
CALL insercciones_profesores(UUID(), 'David', 'Pérez', 'david.perez@gmail.com');
CALL insercciones_profesores(UUID(), 'Laura', 'Gómez', 'laura.gomez@gmail.com');
CALL insercciones_profesores(UUID(), 'Diego', 'Díaz', 'diego.diaz@gmail.com');
CALL insercciones_profesores(UUID(), 'Elena', 'Fernández', 'elena.fernandez@gmail.com');
CALL insercciones_profesores(UUID(), 'Sara', 'Ruiz', 'sara.ruiz@gmail.com');
CALL insercciones_profesores(UUID(), 'Carlos', 'Muñoz', 'carlos.munoz@gmail.com');
CALL insercciones_profesores(UUID(), 'Marta', 'Jiménez', 'marta.jimenez@gmail.com');
CALL insercciones_profesores(UUID(), 'Daniel', 'Álvarez', 'daniel.alvarez@gmail.com');
CALL insercciones_profesores(UUID(), 'Lucía', 'Romero', 'lucia.romero@gmail.com');
CALL insercciones_profesores(UUID(), 'Javier', 'Gutiérrez', 'javier.gutierrez@gmail.com');


/PROCEDIMIENTO DE MATERIAS/
DELIMITER //
CREATE PROCEDURE insercciones_materias
(
    IN id_materia CHAR(36),
    IN nombre_materia VARCHAR(100),
    IN grupo_materia INT,
    IN id_profesor CHAR (36),
    IN cupos INT
)
BEGIN
    INSERT INTO tb_materias (id_materia, nombre_materia, grupo_materia, id_profesor, cupos)
    VALUES (id_materia, nombre_materia, grupo_materia, id_profesor, cupos);
END //
DELIMITER ;

select * from tb_profesores;

CALL insercciones_materias(UUID(), 'Matemáticas', 1, '72f954ce-d664-11ee-814f-4cebb4c4b953', 30);
CALL insercciones_materias(UUID(), 'Historia', 2, '72f99dda-d664-11ee-814f-4cebb4c4b953', 25);
CALL insercciones_materias(UUID(), 'Literatura', 1, '72f9d071-d664-11ee-814f-4cebb4c4b953', 20);
CALL insercciones_materias(UUID(), 'Biología', 2, '72fa0ef1-d664-11ee-814f-4cebb4c4b953', 30);
CALL insercciones_materias(UUID(), 'Física', 1, '72fa4179-d664-11ee-814f-4cebb4c4b953', 25);
CALL insercciones_materias(UUID(), 'Química', 2, '72fa733d-d664-11ee-814f-4cebb4c4b953', 20);
CALL insercciones_materias(UUID(), 'Inglés', 1, '72faa3e7-d664-11ee-814f-4cebb4c4b953', 30);
CALL insercciones_materias(UUID(), 'Educación Física', 2, '72fadde7-d664-11ee-814f-4cebb4c4b953', 25);
CALL insercciones_materias(UUID(), 'Arte', 1, '72fb1a81-d664-11ee-814f-4cebb4c4b953', 20);
CALL insercciones_materias(UUID(), 'Informática', 2, '72fb6159-d664-11ee-814f-4cebb4c4b953', 30);
CALL insercciones_materias(UUID(), 'Geografía', 1, '72fbabcd-d664-11ee-814f-4cebb4c4b953', 25);
CALL insercciones_materias(UUID(), 'Ciencias Sociales', 2, '72fbe977-d664-11ee-814f-4cebb4c4b953', 20);
CALL insercciones_materias(UUID(), 'Filosofía', 1, '72fc23f0-d664-11ee-814f-4cebb4c4b953', 30);
CALL insercciones_materias(UUID(), 'Economía', 2, '72fc6c9d-d664-11ee-814f-4cebb4c4b953', 25);
CALL insercciones_materias(UUID(), 'Psicología', 1, '72fca995-d664-11ee-814f-4cebb4c4b953', 20);

/PROCEDIMIENTO DE ALUMNOS/
DELIMITER //
CREATE PROCEDURE insercciones_alumnos
(
	IN id_alumno CHAR(36),
	IN carnet_alumno VARCHAR(10),
	IN nombre_alumno VARCHAR(100),
	IN apellido_alumno VARCHAR(100),
	IN edad_alumno INT
)
BEGIN
	INSERT INTO tb_alumnos (id_alumno, carnet_alumno, nombre_alumno, apellido_alumno, edad_alumno)
    VALUES (id_alumno, carnet_alumno, nombre_alumno, apellido_alumno, edad_alumno);
END //
DELIMITER ;

CALL insercciones_alumnos(uuid(), '000001', 'Rodrigo', 'Machado', 18);
CALL insercciones_alumnos(uuid(), '000002', 'Diego', 'Lourdes', 19);
CALL insercciones_alumnos(uuid(), '000003', 'Ivan', 'Salguero', 18);
CALL insercciones_alumnos(uuid(), '000004', 'Alberto', 'Bonilla', 21);
CALL insercciones_alumnos(uuid(), '000005', 'Adriana', 'Orellana', 19);
CALL insercciones_alumnos(uuid(), '000006', 'Daniela', 'Cubas', 18);
CALL insercciones_alumnos(uuid(), '000007', 'Fernando', 'Cortez', 20);
CALL insercciones_alumnos(uuid(), '000008', 'Joshua', 'Hernandes', 18);
CALL insercciones_alumnos(uuid(), '000009', 'Emmanuel', 'Rivas', 20);
CALL insercciones_alumnos(uuid(), '000010', 'Daniel', 'Machado', 20);
CALL insercciones_alumnos(uuid(), '000011', 'Ricardo', 'Paniagua', 21);
CALL insercciones_alumnos(uuid(), '000012', 'Rebeca', 'Cortez', 19);
CALL insercciones_alumnos(uuid(), '000013', 'Dennis', 'Villalta', 18);
CALL insercciones_alumnos(uuid(), '000014', 'Alejandro', 'Villatoro', 19);
CALL insercciones_alumnos(uuid(), '000015', 'Andrea', 'Marquez', 18);

SELECT * FROM tb_alumnos;
SELECT * FROM  tb_materias;


/procedimiento de inscripciones/
DELIMITER //
CREATE PROCEDURE insercciones_inscripciones
(
	IN id_inscripcion CHAR(36),
	IN id_alumno CHAR(36), 
	IN id_materia CHAR(36),
	IN fecha_inscripcion DATE,
	IN estado ENUM('Activo','INACTIVO')
)
BEGIN 
	INSERT INTO tb_inscripciones(id_inscripcion, id_alumno, id_materia, fecha_inscripcion, estado)
	VALUES(id_inscripcion, id_alumno, id_materia, fecha_inscripcion, estado);
	
END //
DELIMITER ;

CALL insercciones_inscripciones(UUID(), 'a0e39266-d66b-11ee-814f-4cebb4c4b953', 'af5cad34-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e483b4-d66b-11ee-814f-4cebb4c4b953', 'e72a3a4f-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e4ce15-d66b-11ee-814f-4cebb4c4b953', 'e72b03ac-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e51c38-d66b-11ee-814f-4cebb4c4b953', 'e72b4fe1-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e55b27-d66b-11ee-814f-4cebb4c4b953', 'e72b94e4-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e5920e-d66b-11ee-814f-4cebb4c4b953', 'e72bcf45-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e5cfe2-d66b-11ee-814f-4cebb4c4b953', 'e72c0062-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e5fc3d-d66b-11ee-814f-4cebb4c4b953', 'e72c4386-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e62758-d66b-11ee-814f-4cebb4c4b953', 'e72c7d1e-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e65651-d66b-11ee-814f-4cebb4c4b953', 'e72cb339-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e69bad-d66b-11ee-814f-4cebb4c4b953', 'e72ce9e7-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e6cdb9-d66b-11ee-814f-4cebb4c4b953', 'e72d1f5e-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e70310-d66b-11ee-814f-4cebb4c4b953', 'e72d6785-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e735b8-d66b-11ee-814f-4cebb4c4b953', 'e72d9fc2-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');
CALL insercciones_inscripciones(UUID(), 'a0e78990-d66b-11ee-814f-4cebb4c4b953', 'e72de211-d664-11ee-814f-4cebb4c4b953', '2024-02-28', 'Activo');

SELECT * FROM tb_inscripciones

/PROCEDIMIENTO DE CALIFICACIONES/

DELIMITER //
CREATE PROCEDURE insercciones_calificaciones
(
	id_calificacion CHAR(36),
	id_inscripcion CHAR(36),
	calificacion_final DECIMAL(5,2),
	fecha_calificacion DATE
)
BEGIN
		INSERT INTO tb_calificaciones(id_calificacion, id_inscripcion, calificacion_final, fecha_calificacion)
		VALUES(id_calificacion, id_inscripcion, calificacion_final, fecha_calificacion);
END//
DELIMITER ;

CALL insercciones_calificaciones(UUID(), '166f8ede-d66c-11ee-814f-4cebb4c4b953', 85.5, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '16707134-d66c-11ee-814f-4cebb4c4b953', 90.0, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '1670df25-d66c-11ee-814f-4cebb4c4b953', 78.3, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '167158be-d66c-11ee-814f-4cebb4c4b953', 95.7, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '1671dbc1-d66c-11ee-814f-4cebb4c4b953', 88.9, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '167236a3-d66c-11ee-814f-4cebb4c4b953', 92.4, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '167284e0-d66c-11ee-814f-4cebb4c4b953', 79.8, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '1672eb26-d66c-11ee-814f-4cebb4c4b953', 84.6, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '16734498-d66c-11ee-814f-4cebb4c4b953', 91.2, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '16739db5-d66c-11ee-814f-4cebb4c4b953', 87.1, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '167400d1-d66c-11ee-814f-4cebb4c4b953', 83.0, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '16745da9-d66c-11ee-814f-4cebb4c4b953', 89.6, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '167496e3-d66c-11ee-814f-4cebb4c4b953', 75.5, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '167496e3-d66c-11ee-814f-4cebb4c4b953', 94.3, '2024-02-28');
CALL insercciones_calificaciones(UUID(), '16754b44-d66c-11ee-814f-4cebb4c4b953', 82.8, '2024-02-28');


SELECT * from tb_inscripciones;

select * from tb_calificaciones