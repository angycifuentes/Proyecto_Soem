-- Crear la base de datos
CREATE DATABASE  Soem_Oficial;
USE Soem_Oficial;

-- 1. Tabla: Roles
CREATE TABLE Roles (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(45) NOT NULL,
    Descripcion_roll VARCHAR(45)
);

-- 2. Tabla: TipoDocumento
CREATE TABLE TipoDocumento (
    idTipoDocumento INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion VARCHAR(45) NOT NULL
);

-- 3. Tabla: Categoria
CREATE TABLE Categoria (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(45) NOT NULL
);

-- 4. Tabla: Unidad
CREATE TABLE Unidad (
    id_unidad INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion_unidad VARCHAR(45) NOT NULL
);

-- 5. Tabla: Talla
CREATE TABLE Talla (
    Id_Talla INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion_talla VARCHAR(100) NOT NULL
);

-- 6. Tabla: Colores
CREATE TABLE Colores (
    id_nombrecolor INT PRIMARY KEY AUTO_INCREMENT,
    codigoRGB VARCHAR(45)
);

-- 7. Tabla: Metododepago
CREATE TABLE Metododepago (
    id_metodoPago INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion_metodoPago VARCHAR(100) NOT NULL
);

-- 8. Tabla: Usuario
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    Apellido VARCHAR(45) NOT NULL,
    NumeroDocumento VARCHAR(45) NOT NULL,
    Telefono VARCHAR(45),
    correo VARCHAR(45) NOT NULL,
    Clave VARCHAR(45) NOT NULL,
    direccion VARCHAR(45),
    Roles_id_rol INT,
    Producto_id_producto INT, -- Nota: En el diagrama aparece una relación aquí
    TipoDocumento_idTipoDocumento INT,
    CONSTRAINT fk_usuario_rol FOREIGN KEY (Roles_id_rol) REFERENCES Roles(id_rol),
    CONSTRAINT fk_usuario_documento FOREIGN KEY (TipoDocumento_idTipoDocumento) REFERENCES TipoDocumento(idTipoDocumento)
);

-- 9. Tabla: Producto
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion VARCHAR(100),
    stock VARCHAR(45), -- Considerar cambiar a INT en el futuro
    precio_producto DECIMAL(10,2) NOT NULL,
    Categoria_idCategoria INT,
    Talla_id_Talla INT,
    Unidad_id_unidad INT,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (Categoria_idCategoria) REFERENCES Categoria(idCategoria),
    CONSTRAINT fk_producto_talla FOREIGN KEY (Talla_id_Talla) REFERENCES Talla(Id_Talla),
    CONSTRAINT fk_producto_unidad FOREIGN KEY (Unidad_id_unidad) REFERENCES Unidad(id_unidad)
);

-- 10. Tabla: Cabeza_Factura
CREATE TABLE Cabeza_Factura (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    numero_fac INT NOT NULL,
    fecha_factura DATE NOT NULL,
    total_factura DECIMAL(10,2),
    Usuario_id_usuario INT,
    CONSTRAINT fk_factura_usuario FOREIGN KEY (Usuario_id_usuario) REFERENCES Usuario(id_usuario)
);

-- 11. Tabla: Detalle_Factura
CREATE TABLE Detalle_Factura (
    idDetalle_Factura INT PRIMARY KEY AUTO_INCREMENT,
    cantidad INT NOT NULL,
    subtotal_fac DECIMAL(10,2),
    Cabeza_Factura_id_factura INT,
    Producto_id_producto INT,
    CONSTRAINT fk_detalle_factura FOREIGN KEY (Cabeza_Factura_id_factura) REFERENCES Cabeza_Factura(id_factura),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (Producto_id_producto) REFERENCES Producto(id_producto)
);

-- 12. Tabla: Pagos
CREATE TABLE Pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    fecha_pago DATETIME NOT NULL,
    montoPago DECIMAL(10,2) NOT NULL,
    Metododepago_id_metodoPago INT,
    Cabeza_Factura_id_factura INT,
    CONSTRAINT fk_pagos_metodo FOREIGN KEY (Metododepago_id_metodoPago) REFERENCES Metododepago(id_metodoPago),
    CONSTRAINT fk_pagos_factura FOREIGN KEY (Cabeza_Factura_id_factura) REFERENCES Cabeza_Factura(id_factura)
);

-- 13. Tabla Intermedia: Producto_has_Colores (Muchos a Muchos)
CREATE TABLE Producto_has_Colores (
    Producto_id_producto INT,
    Colores_id_nombrecolor INT,
    PRIMARY KEY (Producto_id_producto, Colores_id_nombrecolor),
    CONSTRAINT fk_prod_col_producto FOREIGN KEY (Producto_id_producto) REFERENCES Producto(id_producto),
    CONSTRAINT fk_prod_col_color FOREIGN KEY (Colores_id_nombrecolor) REFERENCES Colores(id_nombrecolor)
);