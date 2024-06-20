create database tienda;
use tienda;
# tablas
CREATE TABLE categoria (
    IdCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(500),
    Activo bit DEFAULT 1,
    FechaRegistro datetime default current_timestamp()
);

CREATE TABLE marca (
    Idmarca INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(500),
    Activo bit DEFAULT 1,
    FechaRegistro datetime default current_timestamp()
);

CREATE TABLE producto (
    Idproducto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre varchar(20),
    Descripcion VARCHAR(500),
    Idmarca int,
    IdCategoria int,
    Precio decimal(10,2) DEFAULT 0,
    Stock int,
    RutaImagen VARCHAR(100),
    NombreDeImagen VARCHAR(40),
    Activo bit DEFAULT 1,
    FechaRegistro datetime default current_timestamp(),
    FOREIGN KEY (Idmarca) REFERENCES marca(Idmarca),
    FOREIGN KEY (IdCategoria) REFERENCES categoria(IdCategoria)
);

CREATE TABLE cliente (
    Idcliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre varchar(20),
    Apellido VARCHAR(500),
    Correo VARCHAR(100),
    Clave VARCHAR(200),
    Restablecer bit DEFAULT 0,
    FechaRegistro datetime default current_timestamp()
);

CREATE TABLE carrito (
    Idcarrito INT AUTO_INCREMENT PRIMARY KEY,
    Idcliente int,
    Idproducto int,
    Cantidad VARCHAR(500),
    FOREIGN KEY (Idcliente) REFERENCES cliente(Idcliente),
    FOREIGN KEY (Idproducto) REFERENCES producto(Idproducto)
);

CREATE TABLE venta (
    Idventa INT AUTO_INCREMENT PRIMARY KEY,
    Idcliente int,
    TotalProducto int,
    MontoTotal decimal(10,2),
    Contacto VARCHAR(50),
    Ciudad VARCHAR(100),
    Telefono VARCHAR(12),
    Direccion VARCHAR(40),
    Idtransaccion VARCHAR(500),
    Fechaventa datetime default current_timestamp(),
    FOREIGN KEY (Idcliente) REFERENCES cliente(Idcliente)
);

CREATE TABLE detalle_venta (
    Iddetalleventa INT AUTO_INCREMENT PRIMARY KEY,
    Idventa int,
    Idproducto int,
    Cantidad VARCHAR(500),
    Total decimal(10,2),
    FOREIGN KEY (Idventa) REFERENCES venta(Idventa),
    FOREIGN KEY (Idproducto) REFERENCES producto(Idproducto)
);
CREATE TABLE usuario (
    Idusuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre varchar(20),
    Apellido VARCHAR(500),
    Correo VARCHAR(100),
    Clave VARCHAR(200),
    Restablecer bit DEFAULT 1,
    Activo bit DEFAULT 1,
    FechaRegistro datetime default current_timestamp()
);
CREATE TABLE departamento (
    Iddepartamento VARCHAR(4) not null,
    Descripcion VARCHAR(50) not NULL,
    PRIMARY KEY (Iddepartamento)
);

CREATE TABLE provincia (
    Idprovincia VARCHAR(4) not null,
    Descripcion VARCHAR(50) not NULL,
    Iddepartamento VARCHAR(4) not NULL,
    PRIMARY KEY (Idprovincia),
    FOREIGN KEY (Iddepartamento) REFERENCES departamento(Iddepartamento)
);

CREATE TABLE distrito (
    Iddistrito VARCHAR(6) not null,
    Idprovincia VARCHAR(4) not null,
    Iddepartamento VARCHAR(4) not NULL,
    PRIMARY KEY (Iddistrito),
    FOREIGN KEY (Idprovincia) REFERENCES provincia(Idprovincia),
    FOREIGN KEY (Iddepartamento) REFERENCES departamento(Iddepartamento)
);
# tablas log de recuperacion
CREATE TABLE categoria_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    IdCategoria INT,
    Descripcion VARCHAR(500),
    Activo bit,
    FechaRegistro datetime,
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marca_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Idmarca INT,
    Descripcion VARCHAR(500),
    Activo bit,
    FechaRegistro datetime,
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE producto_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Idproducto INT,
    Nombre varchar(20),
    Descripcion VARCHAR(500),
    Idmarca int,
    IdCategoria int,
    Precio decimal(10,2),
    Stock int,
    RutaImagen VARCHAR(100),
    NombreDeImagen VARCHAR(40),
    Activo bit,
    FechaRegistro datetime,
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cliente_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Idcliente INT,
    Nombre varchar(20),
    Apellido VARCHAR(500),
    Correo VARCHAR(100),
    Clave VARCHAR(200),
    Restablecer bit,
    FechaRegistro datetime,
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE carrito_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Idcarrito INT,
    Idcliente int,
    Idproducto int,
    Cantidad VARCHAR(500),
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE venta_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Idventa INT,
    Idcliente int,
    TotalProducto int,
    MontoTotal decimal(10,2),
    Contacto VARCHAR(50),
    Ciudad VARCHAR(100),
    Telefono VARCHAR(12),
    Direccion VARCHAR(40),
    Idtransaccion VARCHAR(500),
    Fechaventa datetime,
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE detalle_venta_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Iddetalleventa INT,
    Idventa int,
    Idproducto int,
    Cantidad VARCHAR(500),
    Total decimal(10,2),
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuario_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Idusuario INT,
    Nombre varchar(20),
    Apellido VARCHAR(500),
    Correo VARCHAR(100),
    Clave VARCHAR(200),
    Restablecer bit,
    Activo bit,
    FechaRegistro datetime,
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE departamento_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Iddepartamento VARCHAR(4),
    Descripcion VARCHAR(50),
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE provincia_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Idprovincia VARCHAR(4),
    Descripcion VARCHAR(50),
    Iddepartamento VARCHAR(4),
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE distrito_log (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    Iddistrito VARCHAR(6),
    Idprovincia VARCHAR(4),
    Iddepartamento VARCHAR(4),
    LogTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
# disparadores
DELIMITER //

-- Disparadores de Inserción --
CREATE TRIGGER categoria_insert_trigger AFTER INSERT ON categoria
FOR EACH ROW
BEGIN
    INSERT INTO categoria_log (IdCategoria, Descripcion, Activo, FechaRegistro, LogTimestamp)
    VALUES (NEW.IdCategoria, NEW.Descripcion, NEW.Activo, NEW.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER marca_insert_trigger AFTER INSERT ON marca
FOR EACH ROW
BEGIN
    INSERT INTO marca_log (Idmarca, Descripcion, Activo, FechaRegistro, LogTimestamp)
    VALUES (NEW.Idmarca, NEW.Descripcion, NEW.Activo, NEW.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER producto_insert_trigger AFTER INSERT ON producto
FOR EACH ROW
BEGIN
    INSERT INTO producto_log (Idproducto, Nombre, Descripcion, Idmarca, IdCategoria, Precio, Stock, RutaImagen, NombreDeImagen, Activo, FechaRegistro, LogTimestamp)
    VALUES (NEW.Idproducto, NEW.Nombre, NEW.Descripcion, NEW.Idmarca, NEW.IdCategoria, NEW.Precio, NEW.Stock, NEW.RutaImagen, NEW.NombreDeImagen, NEW.Activo, NEW.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER cliente_insert_trigger AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO cliente_log (Idcliente, Nombre, Apellido, Correo, Clave, Restablecer, FechaRegistro, LogTimestamp)
    VALUES (NEW.Idcliente, NEW.Nombre, NEW.Apellido, NEW.Correo, NEW.Clave, NEW.Restablecer, NEW.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER carrito_insert_trigger AFTER INSERT ON carrito
FOR EACH ROW
BEGIN
    INSERT INTO carrito_log (Idcarrito, Idcliente, Idproducto, Cantidad, LogTimestamp)
    VALUES (NEW.Idcarrito, NEW.Idcliente, NEW.Idproducto, NEW.Cantidad, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER venta_insert_trigger AFTER INSERT ON venta
FOR EACH ROW
BEGIN
    INSERT INTO venta_log (Idventa, Idcliente, TotalProducto, MontoTotal, Contacto, Ciudad, Telefono, Direccion, Idtransaccion, Fechaventa, LogTimestamp)
    VALUES (NEW.Idventa, NEW.Idcliente, NEW.TotalProducto, NEW.MontoTotal, NEW.Contacto, NEW.Ciudad, NEW.Telefono, NEW.Direccion, NEW.Idtransaccion, NEW.Fechaventa, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER detalle_venta_insert_trigger AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    INSERT INTO detalle_venta_log (Iddetalleventa, Idventa, Idproducto, Cantidad, Total, LogTimestamp)
    VALUES (NEW.Iddetalleventa, NEW.Idventa, NEW.Idproducto, NEW.Cantidad, NEW.Total, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER usuario_insert_trigger AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO usuario_log (Idusuario, Nombre, Apellido, Correo, Clave, Restablecer, Activo, FechaRegistro, LogTimestamp)
    VALUES (NEW.Idusuario, NEW.Nombre, NEW.Apellido, NEW.Correo, NEW.Clave, NEW.Restablecer, NEW.Activo, NEW.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER departamento_insert_trigger AFTER INSERT ON departamento
FOR EACH ROW
BEGIN
    INSERT INTO departamento_log (Iddepartamento, Descripcion, LogTimestamp)
    VALUES (NEW.Iddepartamento, NEW.Descripcion, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER provincia_insert_trigger AFTER INSERT ON provincia
FOR EACH ROW
BEGIN
    INSERT INTO provincia_log (Idprovincia, Descripcion, Iddepartamento, LogTimestamp)
    VALUES (NEW.Idprovincia, NEW.Descripcion, NEW.Iddepartamento, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER distrito_insert_trigger AFTER INSERT ON distrito
FOR EACH ROW
BEGIN
    INSERT INTO distrito_log (Iddistrito, Idprovincia, Iddepartamento, LogTimestamp)
    VALUES (NEW.Iddistrito, NEW.Idprovincia, NEW.Iddepartamento, CURRENT_TIMESTAMP);
END//

-- Disparadores de Actualización --
CREATE TRIGGER categoria_update_trigger AFTER UPDATE ON categoria
FOR EACH ROW
BEGIN
    INSERT INTO categoria_log (IdCategoria, Descripcion, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.IdCategoria, OLD.Descripcion, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER marca_update_trigger AFTER UPDATE ON marca
FOR EACH ROW
BEGIN
    INSERT INTO marca_log (Idmarca, Descripcion, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idmarca, OLD.Descripcion, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER producto_update_trigger AFTER UPDATE ON producto
FOR EACH ROW
BEGIN
    INSERT INTO producto_log (Idproducto, Nombre, Descripcion, Idmarca, IdCategoria, Precio, Stock, RutaImagen, NombreDeImagen, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idproducto, OLD.Nombre, OLD.Descripcion, OLD.Idmarca, OLD.IdCategoria, OLD.Precio, OLD.Stock, OLD.RutaImagen, OLD.NombreDeImagen, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER cliente_update_trigger AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO cliente_log (Idcliente, Nombre, Apellido, Correo, Clave, Restablecer, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idcliente, OLD.Nombre, OLD.Apellido, OLD.Correo, OLD.Clave, OLD.Restablecer, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER carrito_update_trigger AFTER UPDATE ON carrito
FOR EACH ROW
BEGIN
    INSERT INTO carrito_log (Idcarrito, Idcliente, Idproducto, Cantidad, LogTimestamp)
    VALUES (OLD.Idcarrito, OLD.Idcliente, OLD.Idproducto, OLD.Cantidad, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER venta_update_trigger AFTER UPDATE ON venta
FOR EACH ROW
BEGIN
    INSERT INTO venta_log (Idventa, Idcliente, TotalProducto, MontoTotal, Contacto, Ciudad, Telefono, Direccion, Idtransaccion, Fechaventa, LogTimestamp)
    VALUES (OLD.Idventa, OLD.Idcliente, OLD.TotalProducto, OLD.MontoTotal, OLD.Contacto, OLD.Ciudad, OLD.Telefono, OLD.Direccion, OLD.Idtransaccion, OLD.Fechaventa, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER detalle_venta_update_trigger AFTER UPDATE ON detalle_venta
FOR EACH ROW
BEGIN
    INSERT INTO detalle_venta_log (Iddetalleventa, Idventa, Idproducto, Cantidad, Total, LogTimestamp)
    VALUES (OLD.Iddetalleventa, OLD.Idventa, OLD.Idproducto, OLD.Cantidad, OLD.Total, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER usuario_update_trigger AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO usuario_log (Idusuario, Nombre, Apellido, Correo, Clave, Restablecer, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idusuario, OLD.Nombre, OLD.Apellido, OLD.Correo, OLD.Clave, OLD.Restablecer, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER departamento_update_trigger AFTER UPDATE ON departamento
FOR EACH ROW
BEGIN
    INSERT INTO departamento_log (Iddepartamento, Descripcion, LogTimestamp)
    VALUES (OLD.Iddepartamento, OLD.Descripcion, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER provincia_update_trigger AFTER UPDATE ON provincia
FOR EACH ROW
BEGIN
    INSERT INTO provincia_log (Idprovincia, Descripcion, Iddepartamento, LogTimestamp)
    VALUES (OLD.Idprovincia, OLD.Descripcion, OLD.Iddepartamento, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER distrito_update_trigger AFTER UPDATE ON distrito
FOR EACH ROW
BEGIN
    INSERT INTO distrito_log (Iddistrito, Idprovincia, Iddepartamento, LogTimestamp)
    VALUES (OLD.Iddistrito, OLD.Idprovincia, OLD.Iddepartamento, CURRENT_TIMESTAMP);
END//

-- Disparadores de Eliminación --
CREATE TRIGGER categoria_delete_trigger AFTER DELETE ON categoria
FOR EACH ROW
BEGIN
    INSERT INTO categoria_log (IdCategoria, Descripcion, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.IdCategoria, OLD.Descripcion, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER marca_delete_trigger AFTER DELETE ON marca
FOR EACH ROW
BEGIN
    INSERT INTO marca_log (Idmarca, Descripcion, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idmarca, OLD.Descripcion, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER producto_delete_trigger AFTER DELETE ON producto
FOR EACH ROW
BEGIN
    INSERT INTO producto_log (Idproducto, Nombre, Descripcion, Idmarca, IdCategoria, Precio, Stock, RutaImagen, NombreDeImagen, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idproducto, OLD.Nombre, OLD.Descripcion, OLD.Idmarca, OLD.IdCategoria, OLD.Precio, OLD.Stock, OLD.RutaImagen, OLD.NombreDeImagen, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER cliente_delete_trigger AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO cliente_log (Idcliente, Nombre, Apellido, Correo, Clave, Restablecer, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idcliente, OLD.Nombre, OLD.Apellido, OLD.Correo, OLD.Clave, OLD.Restablecer, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER carrito_delete_trigger AFTER DELETE ON carrito
FOR EACH ROW
BEGIN
    INSERT INTO carrito_log (Idcarrito, Idcliente, Idproducto, Cantidad, LogTimestamp)
    VALUES (OLD.Idcarrito, OLD.Idcliente, OLD.Idproducto, OLD.Cantidad, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER venta_delete_trigger AFTER DELETE ON venta
FOR EACH ROW
BEGIN
    INSERT INTO venta_log (Idventa, Idcliente, TotalProducto, MontoTotal, Contacto, Ciudad, Telefono, Direccion, Idtransaccion, Fechaventa, LogTimestamp)
    VALUES (OLD.Idventa, OLD.Idcliente, OLD.TotalProducto, OLD.MontoTotal, OLD.Contacto, OLD.Ciudad, OLD.Telefono, OLD.Direccion, OLD.Idtransaccion, OLD.Fechaventa, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER detalle_venta_delete_trigger AFTER DELETE ON detalle_venta
FOR EACH ROW
BEGIN
    INSERT INTO detalle_venta_log (Iddetalleventa, Idventa, Idproducto, Cantidad, Total, LogTimestamp)
    VALUES (OLD.Iddetalleventa, OLD.Idventa, OLD.Idproducto, OLD.Cantidad, OLD.Total, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER usuario_delete_trigger AFTER DELETE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO usuario_log (Idusuario, Nombre, Apellido, Correo, Clave, Restablecer, Activo, FechaRegistro, LogTimestamp)
    VALUES (OLD.Idusuario, OLD.Nombre, OLD.Apellido, OLD.Correo, OLD.Clave, OLD.Restablecer, OLD.Activo, OLD.FechaRegistro, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER departamento_delete_trigger AFTER DELETE ON departamento
FOR EACH ROW
BEGIN
    INSERT INTO departamento_log (Iddepartamento, Descripcion, LogTimestamp)
    VALUES (OLD.Iddepartamento, OLD.Descripcion, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER provincia_delete_trigger AFTER DELETE ON provincia
FOR EACH ROW
BEGIN
    INSERT INTO provincia_log (Idprovincia, Descripcion, Iddepartamento, LogTimestamp)
    VALUES (OLD.Idprovincia, OLD.Descripcion, OLD.Iddepartamento, CURRENT_TIMESTAMP);
END//

CREATE TRIGGER distrito_delete_trigger AFTER DELETE ON distrito
FOR EACH ROW
BEGIN
    INSERT INTO distrito_log (Iddistrito, Idprovincia, Iddepartamento, LogTimestamp)
    VALUES (OLD.Iddistrito, OLD.Idprovincia, OLD.Iddepartamento, CURRENT_TIMESTAMP);
END//

DELIMITER ;

# vista
-- VISTA PARA LA TABLA categoria
CREATE VIEW vista_categoria AS
SELECT IdCategoria, Descripcion, Activo, FechaRegistro
FROM categoria;

-- VISTA PARA LA TABLA marca
CREATE VIEW vista_marca AS
SELECT Idmarca, Descripcion, Activo, FechaRegistro
FROM marca;

-- VISTA PARA LA TABLA producto
CREATE VIEW vista_producto AS
SELECT p.Idproducto, p.Nombre, p.Descripcion, m.Descripcion AS Marca, c.Descripcion AS Categoria,
       p.Precio, p.Stock, p.RutaImagen, p.NombreDeImagen, p.Activo, p.FechaRegistro
FROM producto p
INNER JOIN marca m ON p.Idmarca = m.Idmarca
INNER JOIN categoria c ON p.IdCategoria = c.IdCategoria;

-- VISTA PARA LA TABLA cliente
CREATE VIEW vista_cliente AS
SELECT Idcliente, Nombre, Apellido, Correo, Clave, Restablecer, FechaRegistro
FROM cliente;

-- VISTA PARA LA TABLA carrito
CREATE VIEW vista_carrito AS
SELECT Idcarrito, c.Idcliente, c.Idproducto, c.Cantidad, p.Nombre AS NombreProducto, cl.Nombre AS NombreCliente
FROM carrito c
INNER JOIN producto p ON c.Idproducto = p.Idproducto
INNER JOIN cliente cl ON c.Idcliente = cl.Idcliente;

-- VISTA PARA LA TABLA venta
CREATE VIEW vista_venta AS
SELECT v.Idventa, v.Idcliente, v.TotalProducto, v.MontoTotal, v.Contacto, v.Ciudad,
       v.Telefono, v.Direccion, v.Idtransaccion, v.Fechaventa, cl.Nombre AS NombreCliente
FROM venta v
INNER JOIN cliente cl ON v.Idcliente = cl.Idcliente;

-- VISTA PARA LA TABLA detalle_venta
CREATE VIEW vista_detalle_venta AS
SELECT dv.Iddetalleventa, dv.Idventa, dv.Idproducto, dv.Cantidad, dv.Total,
       p.Nombre AS NombreProducto, v.Idcliente
FROM detalle_venta dv
INNER JOIN producto p ON dv.Idproducto = p.Idproducto
INNER JOIN venta v ON dv.Idventa = v.Idventa;

-- VISTA PARA LA TABLA usuario
CREATE VIEW vista_usuario AS
SELECT Idusuario, Nombre, Apellido, Correo, Clave, Restablecer, Activo, FechaRegistro
FROM usuario;

-- VISTA PARA LA TABLA departamento
CREATE VIEW vista_departamento AS
SELECT Iddepartamento, Descripcion
FROM departamento;

-- VISTA PARA LA TABLA provincia
CREATE VIEW vista_provincia AS
SELECT Idprovincia, Descripcion, Iddepartamento
FROM provincia;

-- VISTA PARA LA TABLA distrito
CREATE VIEW vista_distrito AS
SELECT Iddistrito, Idprovincia, Iddepartamento
FROM distrito;

#insertar datos de ejemplo
-- Tabla: categoria
INSERT INTO categoria (Descripcion, Activo) VALUES 
('Electrónica', 1),
('Ropa', 1),
('Hogar', 1),
('Juguetes', 1),
('Libros', 1);

-- Tabla: marca
INSERT INTO marca (Descripcion, Activo) VALUES 
('Sony', 1),
('Samsung', 1),
('Apple', 1),
('LG', 1),
('Adidas', 1);

-- Tabla: producto
INSERT INTO producto (Nombre, Descripcion, Idmarca, IdCategoria, Precio, Stock, RutaImagen, NombreDeImagen, Activo) VALUES 
('iPhone 13', 'Smartphone de última generación', 3, 1, 999.99, 50, '/images/iphone13.jpg', 'iphone13.jpg', 1),
('Televisor LG 55"', 'Televisor LED 55 pulgadas', 4, 1, 799.99, 30, '/images/tvlg55.jpg', 'tvlg55.jpg', 1),
('Zapatillas Adidas', 'Zapatillas deportivas', 5, 2, 59.99, 100, '/images/adidas.jpg', 'adidas.jpg', 1),
('Laptop Sony VAIO', 'Laptop de alto rendimiento', 1, 1, 1200.00, 20, '/images/vaio.jpg', 'vaio.jpg', 1),
('Refrigerador Samsung', 'Refrigerador de dos puertas', 2, 3, 1500.00, 10, '/images/fridge.jpg', 'fridge.jpg', 1);

-- Tabla: cliente
INSERT INTO cliente (Nombre, Apellido, Correo, Clave, Restablecer) VALUES 
('Juan', 'Pérez', 'juan.perez@example.com', 'hashedpassword1', 0),
('María', 'González', 'maria.gonzalez@example.com', 'hashedpassword2', 0),
('Pedro', 'Martínez', 'pedro.martinez@example.com', 'hashedpassword3', 0),
('Ana', 'López', 'ana.lopez@example.com', 'hashedpassword4', 0),
('Luis', 'Sánchez', 'luis.sanchez@example.com', 'hashedpassword5', 0);

-- Tabla: carrito
INSERT INTO carrito (Idcliente, Idproducto, Cantidad) VALUES 
(1, 1, '1'),
(2, 3, '2'),
(3, 5, '1'),
(4, 2, '1'),
(5, 4, '1');

-- Tabla: venta
INSERT INTO venta (Idcliente, TotalProducto, MontoTotal, Contacto, Ciudad, Telefono, Direccion, Idtransaccion) VALUES 
(1, 2, 1059.98, 'Juan Pérez', 'Ciudad A', '1234567890', 'Calle 123', 'TXN001'),
(2, 1, 59.99, 'María González', 'Ciudad B', '0987654321', 'Avenida 456', 'TXN002'),
(3, 1, 1500.00, 'Pedro Martínez', 'Ciudad C', '1122334455', 'Boulevard 789', 'TXN003');

-- Tabla: detalle_venta
INSERT INTO detalle_venta (Idventa, Idproducto, Cantidad, Total) VALUES 
(1, 1, '1', 999.99),
(1, 3, '1', 59.99),
(2, 3, '1', 59.99),
(3, 5, '1', 1500.00);

-- Tabla: usuario
INSERT INTO usuario (Nombre, Apellido, Correo, Clave, Restablecer, Activo) VALUES 
('Carlos', 'Ramírez', 'carlos.ramirez@example.com', 'hashedpassword6', 1, 1),
('Lucía', 'Fernández', 'lucia.fernandez@example.com', 'hashedpassword7', 1, 1),
('Jorge', 'Hernández', 'jorge.hernandez@example.com', 'hashedpassword8', 1, 1),
('Sofía', 'Torres', 'sofia.torres@example.com', 'hashedpassword9', 1, 1),
('Miguel', 'García', 'miguel.garcia@example.com', 'hashedpassword10', 1, 1);

-- Tabla: departamento
INSERT INTO departamento (Iddepartamento, Descripcion) VALUES 
('01', 'Lima'),
('02', 'Cusco'),
('03', 'Arequipa');

-- Tabla: provincia
INSERT INTO provincia (Idprovincia, Descripcion, Iddepartamento) VALUES 
('0101', 'Lima', '01'),
('0201', 'Cusco', '02'),
('0301', 'Arequipa', '03');

-- Tabla: distrito
INSERT INTO distrito (Iddistrito, Idprovincia, Iddepartamento) VALUES 
('010101', '0101', '01'),
('020101', '0201', '02'),
('030101', '0301', '03');
