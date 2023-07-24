CREATE TABLE if NOT EXISTS Usuario (id serial, email varchar unique, activo boolean);
CREATE TABLE if NOT EXISTS Prioridad (id serial, nombre varchar, descripcion varchar);
CREATE TABLE if NOT EXISTS Tarea (
    id serial,
    titulo varchar,
    prioridad_id int,
    usuario_id int,
    completado boolean
);
--@block
ALTER TABLE prioridad
ADD CONSTRAINT pk_Prioridad PRIMARY KEY (id);
ALTER TABLE tarea
ADD CONSTRAINT fk_TarPri FOREIGN KEY (prioridad_id) REFERENCES Prioridad(id);
--@block
ALTER TABLE usuario
ADD CONSTRAINT pk_Usuario PRIMARY KEY (id);
ALTER TABLE tarea
ADD CONSTRAINT fk_TarUsu FOREIGN KEY (usuario_id) REFERENCES Usuario(id);
--@block
INSERT INTO prioridad (nombre, descripcion)
VALUES ('ALTA', 'Prioridad ALTA'),
    ('MEDIA', 'Prioridad MEDIA'),
    ('BAJA', 'Prioridad BAJA');
--@block
INSERT INTO usuario (email, activo)
VALUES ('usu1@senpai.com', true),
    ('usu2@senpai.com', true),
    ('usu3@senpai.com', true),
    ('usu4@senpai.com', false);
--@block
INSERT INTO tarea (titulo, prioridad_id, usuario_id, completado)
VALUES ('Tarea1', 1, 1, true),
    ('Tarea2', 1, 2, false),
    ('Tarea3', 2, 3, true),
    ('Tarea4', 3, 4, true);
--@block
SELECT *
FROM tarea
SELECT titulo,
    usuario_id
FROM tarea;
--@block
SELECT *
FROM tarea
WHERE completado = FALSE;
--@block
DELETE FROM tarea
where id = 4;
--Como el value email en la tabla USUARIO tiene la propiedad 'Unique', no deja repetir el mismo value, por lo que da error.
--Al agregar como llave primaria 'prioridad(id)'' y foreign key 'tareas(prioridad_id)', no se puede eliminar.
--@block
UPDATE tarea
SET completado = CASE
        WHEN completado = true THEN false
        ELSE true
    END
WHERE id = (
        select max(id)
        from tarea
    )