/* Relación tipo 1:1 */
-- PASO 1
CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
edad INT
);

INSERT INTO usuarios (nombre, apellido, email, edad) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);


-- PASO 2
CREATE TABLE roles (
id_rol INT AUTO_INCREMENT PRIMARY KEY,
nombre_rol VARCHAR(50) NOT NULL
);

INSERT INTO roles (nombre_rol) VALUES
('Bronce'),
('Plata'),
('Oro'),
('Platino');


-- PASO 3
ALTER TABLE usuarios ADD COLUMN id_rol INT;

UPDATE usuarios SET id_rol = 1 WHERE id_usuario IN (3, 9, 14, 17, 20);
UPDATE usuarios SET id_rol = 2 WHERE id_usuario IN (2, 8, 12, 16, 19);
UPDATE usuarios SET id_rol = 3 WHERE id_usuario IN (1, 5, 10, 13, 15);
UPDATE usuarios SET id_rol = 4 WHERE id_usuario IN (4, 6, 7, 11, 18);

ALTER TABLE usuarios ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);


-- PASO 4
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol
FROM usuarios
JOIN roles ON usuarios.id_rol = roles.id_rol
ORDER BY id_usuario;


/* Relación tipo 1:N */
-- PASO 1
CREATE TABLE categorias (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES
('Electrónicos'),
('Ropa y Accesorios'),
('Libros'),
('Hogar y Cocina'),
('Deportes y aire libre'),
('Salud y cuidado personal'),
('Herramientas y mejoras para el hogar'),
('Juguetes y juegos'),
('Automotriz'),
('Música y Películas');


-- PASO 2
ALTER TABLE usuarios ADD COLUMN id_categoria INT;


-- PASO 3
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (7, 12);
UPDATE usuarios SET id_categoria = 2 WHERE id_usuario IN (5, 14);
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (2, 9);
UPDATE usuarios SET id_categoria = 4 WHERE id_usuario IN (4, 11);
UPDATE usuarios SET id_categoria = 5 WHERE id_usuario IN (3, 6);
UPDATE usuarios SET id_categoria = 6 WHERE id_usuario IN (1, 17);
UPDATE usuarios SET id_categoria = 7 WHERE id_usuario IN (8, 13);
UPDATE usuarios SET id_categoria = 8 WHERE id_usuario IN (10, 18);
UPDATE usuarios SET id_categoria = 9 WHERE id_usuario IN (15, 20);
UPDATE usuarios SET id_categoria = 10 WHERE id_usuario IN (16, 19);

-- Debería haberse añadido una FOREIGN KEY, se ha dejado deliberadamente en blanco para comprobar que JOIN funciona también sin ella.

-- PASO 4
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria
FROM usuarios
JOIN roles ON usuarios.id_rol = roles.id_rol
JOIN categorias ON usuarios.id_categoria = categorias.id_categoria
ORDER BY id_usuario;

/* Relación tipo N:M */
-- PASO 1
CREATE TABLE usuarios_categorias (
id_usuario_categoria INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT,
id_categoria INT,
FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);


-- PASO 2
INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);


-- PASO 3
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria
FROM usuarios
JOIN usuarios_categorias ON usuarios.id_usuario = usuarios_categorias.id_usuario
JOIN roles ON usuarios.id_rol = roles.id_rol
JOIN categorias ON usuarios_categorias.id_categoria = categorias.id_categoria
ORDER BY id_usuario;

SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.edad, r.nombre_rol, c.nombre_categoria
FROM usuarios u
JOIN roles r ON u.id_rol = r.id_rol
JOIN usuarios_categorias ON u.id_usuario = usuarios_categorias.id_usuario
JOIN categorias c ON usuarios_categorias.id_categoria = c.id_categoria
ORDER BY id_usuario;