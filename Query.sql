drop schema if exists tiendaRopa; 
drop user if exists pruebaUsuario; 
CREATE SCHEMA tiendaRopa ; 
use tiendaropa;
create user 'pruebaUsuario'@'%' identified by 'claveUsuario'; 

grant all privileges on tiendaRopa.* to 'usuario_prueba'@'%'; 
flush privileges;

create table tiendaRopa.categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen varchar(1024),
  activo bool,
  PRIMARY KEY (id_categoria))
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8mb4;

create table tiendaRopa.producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(30) NOT NULL,  
  detalle VARCHAR(1600) NOT NULL, 
  precio double,
  existencias int,  
  ruta_imagen varchar(1024),
  activo bool,
  PRIMARY KEY (id_producto),
  foreign key fk_producto_caregoria (id_categoria) references categoria(id_categoria)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*Se crea la tabla de clientes llamada cliente... igual que la clase Cliente */
CREATE TABLE tiendaRopa.usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  password varchar(512) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(25) NULL,
  telefono VARCHAR(15) NULL,
  ruta_imagen varchar(1024),
  activo boolean,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table tiendaRopa.factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha date,  
  total double,
  estado int,
  PRIMARY KEY (id_factura),
  foreign key fk_factura_usuario (id_usuario) references usuario(id_usuario)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

create table tiendaRopa.venta (
  id_venta INT NOT NULL AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  precio double, 
  cantidad int,
  PRIMARY KEY (id_venta),
  foreign key fk_ventas_factura (id_factura) references factura(id_factura),
  foreign key fk_ventas_producto (id_producto) references producto(id_producto) 
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/* Se crea la tabla para reseñas */
CREATE TABLE tiendaRopa.resena (
  id_resena INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_producto INT NOT NULL,
  calificacion INT NOT NULL,
  comentario VARCHAR(1000),
  fecha DATE,
  PRIMARY KEY (id_resena),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*Se insertan 3 registros en la tabla cliente como ejemplo */
INSERT INTO tiendaRopa.usuario (id_usuario, username,password,nombre, apellidos, correo, telefono,ruta_imagen,activo) VALUES 
(1,'juan','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Juan', 'Castro Mora',    'jcastro@gmail.com',    '4556-8978', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Juan_Diego_Madrigal.jpg/250px-Juan_Diego_Madrigal.jpg',true),
(2,'rebeca','$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi','Rebeca',  'Contreras Mora', 'acontreras@gmail.com', '5456-8789','https://upload.wikimedia.org/wikipedia/commons/0/06/Photo_of_Rebeca_Arthur.jpg',true),
(3,'pedro','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Pedro', 'Mena Loria',     'lmena@gmail.com',      '7898-8936','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Eduardo_de_Pedro_2019.jpg/480px-Eduardo_de_Pedro_2019.jpg?20200109230854',true);

/*Se insertan 3 categorias de productos como ejemplo */
INSERT INTO tiendaRopa.categoria (id_categoria,descripcion,ruta_imagen,activo) VALUES 
(1,'Camisetas', 'https://example.com/camisetas.jpg',   true), 
(2,'Pantalones',  'https://example.com/pantalones.jpg',   true),
(3,'Chaquetas','https://example.com/chaquetas.jpg',true),
(4,'Zapatos','https://example.com/zapatos.jpg',    false);

/*Se insertan 4 productos por categoria */
INSERT INTO tiendaRopa.producto (id_producto,id_categoria,descripcion,detalle,precio,existencias,ruta_imagen,activo) VALUES
(1,1,'Camiseta Negra','Camiseta de algodón 100% en color negro, perfecta para uso diario y combinable con cualquier atuendo.',15000,10,'https://example.com/camiseta_negra.jpg',true),
(2,1,'Camiseta Blanca','Camiseta blanca básica hecha de algodón suave, ideal para cualquier ocasión casual.',13000,15,'https://example.com/camiseta_blanca.jpg',true),
(3,1,'Camiseta Roja','Camiseta roja con un ajuste moderno, hecha de material transpirable para mayor comodidad.',16000,8,'https://example.com/camiseta_roja.jpg',true),
(4,1,'Camiseta Azul','Camiseta azul con estampado minimalista, ideal para un look relajado.',17000,5,'https://example.com/camiseta_azul.jpg',true),
(5,2,'Pantalón Vaquero','Pantalón vaquero clásico de mezclilla azul, resistente y cómodo para uso diario.',35000,20,'https://example.com/pantalon_vaquero.jpg',true),
(6,2,'Pantalón Chino','Pantalón chino de corte slim en color beige, ideal para un look semiformal.',32000,12,'https://example.com/pantalon_chino.jpg',true),
(7,2,'Pantalón Deportivo','Pantalón deportivo de algodón gris, perfecto para actividades físicas o estar en casa.',25000,18,'https://example.com/pantalon_deportivo.jpg',true),
(8,2,'Pantalón Cargo','Pantalón cargo verde oliva con múltiples bolsillos, ideal para actividades al aire libre.',30000,10,'https://example.com/pantalon_cargo.jpg',true),
(9,3,'Chaqueta de Cuero','Chaqueta de cuero negro, elegante y resistente, perfecta para un look audaz.',75000,5,'https://example.com/chaqueta_cuero.jpg',true),
(10,3,'Chaqueta de Jean','Chaqueta de mezclilla clásica con bolsillos frontales, ideal para cualquier temporada.',50000,7,'https://example.com/chaqueta_jean.jpg',true),
(11,3,'Chaqueta Impermeable','Chaqueta impermeable ligera, ideal para días lluviosos.',45000,10,'https://example.com/chaqueta_impermeable.jpg',true),
(12,3,'Chaqueta Acolchada','Chaqueta acolchada para invierno, muy cálida y cómoda.',60000,4,'https://example.com/chaqueta_acolchada.jpg',true),
(13,4,'Zapatos Deportivos','Zapatos deportivos ligeros, diseñados para correr y actividades físicas.',40000,15,'https://example.com/zapatos_deportivos.jpg',true),
(14,4,'Botas de Montaña','Botas resistentes para montaña, con suela antideslizante.',80000,8,'https://example.com/botas_montana.jpg',true),
(15,4,'Zapatos Casuales','Zapatos casuales de cuero marrón, perfectos para el uso diario.',50000,10,'https://example.com/zapatos_casuales.jpg',true),
(16,4,'Sandalias','Sandalias cómodas para verano, hechas de materiales duraderos.',20000,20,'https://example.com/sandalias.jpg',true);

/*Se crean 6 facturas */   /*'Activa','Pagada','Anulada')*/
INSERT INTO tiendaRopa.factura (id_factura,id_usuario,fecha,total,estado) VALUES
(1,1,'2022-01-05',211560,2),
(2,2,'2022-01-07',554340,2),
(3,3,'2022-01-07',871000,2),
(4,1,'2022-01-15',244140,1),
(5,2,'2022-01-17',414800,1),
(6,3,'2022-01-21',420000,1);

INSERT INTO tiendaRopa.venta (id_venta,id_factura,id_producto,precio,cantidad) values
(1,1,5,35000,3),
(2,1,9,75000,2),
(3,1,10,50000,3),
(4,2,5,35000,1),
(5,2,14,80000,3),
(6,2,9,75000,3),
(7,3,14,80000,1),
(8,3,6,32000,1),
(9,3,15,50000,2),
(10,1,6,32000,2),
(11,1,8,30000,3),
(12,1,9,75000,3),
(13,2,8,30000,3),
(14,2,14,80000,2),
(15,2,3,16000,1),
(16,3,15,50000,1),
(17,3,12,60000,1),
(18,3,10,50000,3);

create table tiendaRopa.rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol),
  foreign key fk_rol_usuario (id_usuario) references usuario(id_usuario)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

insert into tiendaRopa.rol (id_rol, nombre, id_usuario) values
 (1,'ROLE_ADMIN',1), (2,'ROLE_VENDEDOR',1), (3,'ROLE_USER',1),
 (4,'ROLE_VENDEDOR',2), (5,'ROLE_USER',2),
 (6,'ROLE_USER',3);
 

 
 INSERT INTO tiendaRopa.producto (id_categoria, descripcion, detalle, precio, existencias, ruta_imagen, activo) VALUES
(5, 'Gorra Deportiva', 'Gorra deportiva ajustable, ideal para protegerse del sol durante actividades al aire libre.', 8000, 25, 'https://example.com/gorra_deportiva.jpg', true),
(5, 'Bufanda de Lana', 'Bufanda hecha de lana suave, perfecta para mantenerse abrigado en invierno.', 12000, 15, 'https://example.com/bufanda_lana.jpg', true),
(5, 'Cinturón de Cuero', 'Cinturón de cuero genuino, ideal para uso diario y eventos formales.', 15000, 10, 'https://example.com/cinturon_cuero.jpg', true),
(5, 'Gafas de Sol', 'Gafas de sol con protección UV400, estilo moderno.', 20000, 12, 'https://example.com/gafas_sol.jpg', true),
(6, 'Vestido de Verano', 'Vestido ligero y fresco, ideal para el verano, con estampado floral.', 30000, 8, 'https://example.com/vestido_verano.jpg', true),
(6, 'Vestido de Noche', 'Vestido elegante para ocasiones especiales, color negro.', 45000, 5, 'https://example.com/vestido_noche.jpg', true),
(6, 'Vestido Casual', 'Vestido casual de manga corta, cómodo y moderno.', 28000, 10, 'https://example.com/vestido_casual.jpg', true),
(6, 'Vestido de Fiesta', 'Vestido con detalles brillantes, perfecto para fiestas y eventos.', 50000, 4, 'https://example.com/vestido_fiesta.jpg', true),
(7, 'Bikini', 'Bikini de dos piezas, diseño moderno y cómodo.', 18000, 20, 'https://example.com/bikini.jpg', true),
(7, 'Traje de Baño Entero', 'Traje de baño entero con soporte adicional, ideal para natación.', 22000, 15, 'https://example.com/traje_bano_entero.jpg', true),
(7, 'Short de Baño', 'Short de baño para hombre, cómodo y resistente al cloro.', 15000, 18, 'https://example.com/short_bano.jpg', true),
(7, 'Vestido de Playa', 'Vestido ligero para cubrir el traje de baño, ideal para la playa.', 25000, 10, 'https://example.com/vestido_playa.jpg', true),
(8, 'Suéter de Lana', 'Suéter de lana gruesa, perfecto para el invierno.', 35000, 7, 'https://example.com/sueter_lana.jpg', true),
(8, 'Suéter con Capucha', 'Suéter con capucha y bolsillo delantero, ideal para un look casual.', 28000, 12, 'https://example.com/sueter_capucha.jpg', true),
(8, 'Suéter Ligero', 'Suéter ligero, ideal para las noches frescas.', 26000, 9, 'https://example.com/sueter_ligero.jpg', true);

INSERT INTO tiendaRopa.categoria (descripcion, ruta_imagen, activo) VALUES
('Accesorios', 'https://example.com/accesorios.jpg', true),
('Vestidos', 'https://example.com/vestidos.jpg', true),
('Trajes de Baño', 'https://example.com/trajes_bano.jpg', true),
('Suéteres', 'https://example.com/sueteres.jpg', true),
('Ropa Interior', 'https://example.com/ropa_interior.jpg', true);

INSERT INTO tiendaRopa.usuario (username, password, nombre, apellidos, correo, telefono, ruta_imagen, activo) VALUES
('laura', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Laura', 'Rodríguez Salas', 'laura@gmail.com', '1234-5678', 'https://example.com/laura.jpg', true),
('carlos', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Carlos', 'Gutiérrez Pérez', 'carlos@gmail.com', '8765-4321', 'https://example.com/carlos.jpg', true),
('ana', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Ana', 'Vargas Quesada', 'ana@gmail.com', '6543-2109', 'https://example.com/ana.jpg', true),
('mario', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Mario', 'Zamora Ramírez', 'mario@gmail.com', '3456-7890', 'https://example.com/mario.jpg', true),
('paula', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Paula', 'Jiménez Pineda', 'paula@gmail.com', '0987-6543', 'https://example.com/paula.jpg', true);

INSERT INTO tiendaRopa.resena (id_usuario, id_producto, calificacion, comentario, fecha) VALUES
(1, 1, 5, 'La camiseta es de excelente calidad, muy cómoda y el color es perfecto.', '2024-11-01'),
(2, 5, 4, 'El pantalón vaquero es muy cómodo y resistente, aunque el ajuste no fue perfecto.', '2024-11-02'),
(3, 9, 5, 'La chaqueta de cuero tiene un diseño increíble y se siente muy resistente. Me encantó.', '2024-11-03');

