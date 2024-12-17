drop schema if exists tiendaRopa; 
drop user if exists pruebaUsuario; 
CREATE SCHEMA tiendaRopa ; 
use tiendaropa;
create user 'pruebaUsuario'@'%' identified by 'claveUsuario'; 

grant all privileges on tiendaRopa.* to 'pruebaUsuario'@'%'; 
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

create table tiendaRopa.rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol),
  foreign key fk_rol_usuario (id_usuario) references usuario(id_usuario)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE tiendaRopa.resena (
  id_resena INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR (50),
  comentario VARCHAR(1000),
  PRIMARY KEY (id_resena)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE tiendaRopa.cotizacion (
  id_cotizacion INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR (50),
  correo VARCHAR (50),
  detalle VARCHAR(1000),
  PRIMARY KEY (id_cotizacion)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

/*Se insertan 8 registros en la tabla usuario como ejemplo */
INSERT INTO tiendaRopa.usuario (username,password,nombre, apellidos, correo, telefono,ruta_imagen,activo) VALUES 
('juan','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Juan', 'Castro Mora',    'jcastro@gmail.com',    '4556-8978', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Juan_Diego_Madrigal.jpg/250px-Juan_Diego_Madrigal.jpg',true),
('rebeca','$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi','Rebeca',  'Contreras Mora', 'acontreras@gmail.com', '5456-8789','https://upload.wikimedia.org/wikipedia/commons/0/06/Photo_of_Rebeca_Arthur.jpg',true),
('pedro','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Pedro', 'Mena Loria',     'lmena@gmail.com',      '7898-8936','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Eduardo_de_Pedro_2019.jpg/480px-Eduardo_de_Pedro_2019.jpg?20200109230854',true),
('laura', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Laura', 'Rodríguez Salas', 'laura@gmail.com', '1234-5678', 'https://img.freepik.com/fotos-premium/sonrisa-retrato-negocios-carrera-mujer-profesional-inicio-confianza-ejecutivo-cara-mujer-empleada-agente-felicidad-empresa-consultora-alegria_590464-183766.jpg', true),
('carlos', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Carlos', 'Gutiérrez Pérez', 'carlos@gmail.com', '8765-4321', 'https://img.freepik.com/foto-gratis/hombre-posando-vista-frontal-fondo-azul_23-2149539632.jpg', true),
('ana', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Ana', 'Vargas Quesada', 'ana@gmail.com', '6543-2109', 'https://mundoejecutivo.com.mx/wp-content/uploads/2024/09/Rosa-Martha-Abascal-coparmex.jpg', true),
('mario', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Mario', 'Zamora Ramírez', 'mario@gmail.com', '3456-7890', 'https://static.wixstatic.com/media/4304a4_bbf59d15c02744cc94bd3feb11cb25ab~mv2.jpg/v1/fill/w_478,h_457,al_c,q_80,enc_auto/4304a4_bbf59d15c02744cc94bd3feb11cb25ab~mv2.jpg', true),
('paula', '$2a$10$abcd.efghijklmnopqrstuvwxyz1234567890', 'Paula', 'Jiménez Pineda', 'paula@gmail.com', '0987-6543', 'https://img.freepik.com/fotos-premium/cosmetica-belleza-retrato-mujer-estudio-cara-maquillada-o-rutina-natural-cosmeticos-cuidado-piel-modelo-femenina-feliz-brasil-tratamiento-piel-aislado-fondo-blanco_590464-126271.jpg', true);

/*Se insertan 9 categorias de productos como ejemplo */
INSERT INTO tiendaRopa.categoria (descripcion,ruta_imagen,activo) VALUES 
('Camisetas', 'https://d31f1ehqijlcua.cloudfront.net/n/1/e/5/d/1e5d74f4686c3b283e0ac2f1b88e7b6de6351997_MensTShirt_473051_01.jpg',   true), 
('Pantalones',  'https://acdn.mitiendanube.com/stores/870/804/products/whatsapp-image-2022-08-30-at-12-31-49-pm1-da4446a333ce3b9fff16618744837557-1024-1024.jpeg',   true),
('Chaquetas','https://m.media-amazon.com/images/I/510Aarmlm8L._AC_UF894,1000_QL80_.jpg',true),
('Zapatos','https://s.alicdn.com/@sc04/kf/Hdf6899bbcd974a90a7065b442f7b7193t.jpg',    false),
('Accesorios', 'https://img.freepik.com/fotos-premium/accesorios-ropa-viaje-ropa-viaje_11304-242.jpg', true),
('Vestidos', 'https://i.pinimg.com/736x/41/d9/16/41d91684727e59936cd7937102cce81e.jpg', true),
('Trajes de Baño', 'https://plus.unsplash.com/premium_photo-1721156656203-d5c9fc093086?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhamVzJTIwZGUlMjBiYSVDMyVCMW98ZW58MHx8MHx8fDA%3D', true),
('Suéteres', 'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/124152081_01/w=800,h=800,fit=pad', true),
('Ropa Interior', 'https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2023/12/22/17032503450824.jpg', true);

/*Se insertan 4 productos por categoria */
INSERT INTO tiendaRopa.producto (id_categoria, descripcion, detalle, precio, existencias, ruta_imagen, activo) VALUES
(1, 'Camiseta Negra', 'Camiseta de algodón 100% en color negro, perfecta para uso diario y combinable con cualquier atuendo.', 15000, 10, 'https://tiendaprado.com/24608-large_default/camiseta-negra-de-flores.jpg', true),
(1, 'Camiseta Blanca', 'Camiseta blanca básica hecha de algodón suave, ideal para cualquier ocasión casual.', 13000, 15, 'https://i.pinimg.com/736x/74/0e/42/740e42771b508711b694a0d26d7bb4b5.jpg', true),
(1, 'Camiseta Roja', 'Camiseta roja con un ajuste moderno, hecha de material transpirable para mayor comodidad.', 16000, 8, 'https://media.v2.siweb.es/uploaded_thumb_medium/e38df531dba53b06438b311cb6136e9e/camiseta_roja_frontal_personalizable.jpg', true),
(1, 'Camiseta Azul', 'Camiseta azul con estampado minimalista, ideal para un look relajado.', 17000, 5, 'https://camisetasxmayor.com/wp-content/uploads/2022/12/206-ef1bef3a-2129-4a4e-aad8-1662fd963b6b.png', true),

(2, 'Pantalón Vaquero', 'Pantalón vaquero clásico de mezclilla azul, resistente y cómodo para uso diario.', 35000, 20, 'https://www.vaqueroboots.com/cdn/shop/files/112338537_LF01_SWLL_PRD.jpg?v=1694815923&width=1600', true),
(2, 'Pantalón Chino', 'Pantalón chino de corte slim en color beige, ideal para un look semiformal.', 32000, 12, 'https://img.mytheresa.com/1094/1238/100/jpeg/catalog/product/51/P00948085.jpg', true),
(2, 'Pantalón Deportivo', 'Pantalón deportivo de algodón gris, perfecto para actividades físicas o estar en casa.', 25000, 18, 'https://f.fcdn.app/imgs/4dd3e3/www.otherside.com.uy/osiduy/b170/original/catalogo/OS9MGRPJ4-69-1/2000-2000/pantalon-deportivo-hombre-gris-melange.jpg', true),
(2, 'Pantalón Cargo', 'Pantalón cargo verde oliva con múltiples bolsillos, ideal para actividades al aire libre.', 30000, 10, 'https://m.media-amazon.com/images/I/41nr7WICN6L.jpg', true),

(3, 'Chaqueta de Cuero', 'Chaqueta de cuero negro, elegante y resistente, perfecta para un look audaz.', 75000, 5, 'https://i.pinimg.com/550x/b5/ff/c7/b5ffc7f3fcc3814399b14e46574945c0.jpg', true),
(3, 'Chaqueta de Jean', 'Chaqueta de mezclilla clásica con bolsillos frontales, ideal para cualquier temporada.', 50000, 7, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTl6rgEm-8ucRZgifz0E_hX53JGCbQwFTFySg&s', true),
(3, 'Chaqueta Impermeable', 'Chaqueta impermeable ligera, ideal para días lluviosos.', 45000, 10, 'https://http2.mlstatic.com/D_NQ_NP_737794-MLV79411796474_092024-O.webp', true),
(3, 'Chaqueta Acolchada', 'Chaqueta acolchada para invierno, muy cálida y cómoda.', 60000, 4, 'https://img.macson.es/fotos/638631_1_l.jpg', true),

(4, 'Zapatos Deportivos', 'Zapatos deportivos ligeros, diseñados para correr y actividades físicas.', 40000, 15, 'https://assets.adidas.com/images/w_1880,f_auto,q_auto/a131354e47ea4710aeebaf35011d48bf_9366/HP5776_01_standard.jpg', true),
(4, 'Botas de Montaña', 'Botas resistentes para montaña, con suela antideslizante.', 80000, 8, 'https://peralimonerashop.com/32044-large_default/paredes-botas-trekking-camel.jpg', true),
(4, 'Zapatos Casuales', 'Zapatos casuales de cuero marrón, perfectos para el uso diario.', 50000, 10, 'https://aldoecuador.vtexassets.com/arquivos/ids/191269/gladosen_brown_220-002-043_main.jpg?v=637888541842070000', true),
(4, 'Sandalias', 'Sandalias cómodas para verano, hechas de materiales duraderos.', 20000, 20, 'https://stevemadden.com.co/cdn/shop/files/STEVEMADDEN_SHOES_MAYVILLE_NATURALRAFFIA_SIDE.jpg?v=1715017251', true),

(5, 'Gorra Deportiva', 'Gorra deportiva ajustable, ideal para protegerse del sol durante actividades al aire libre.', 8000, 25, 'https://siman.vtexassets.com/arquivos/ids/6377404-800-800?v=638678226084870000&width=800&height=800&aspect=true', true),
(5, 'Bufanda de Lana', 'Bufanda hecha de lana suave, perfecta para mantenerse abrigado en invierno.', 12000, 15, 'https://abbacino.es/43321-medium_default/bufanda-de-de-mujer-de-lana-con-estampado-geometrico-en-burdeos.jpg', true),
(5, 'Cinturón de Cuero', 'Cinturón de cuero genuino, ideal para uso diario y eventos formales.', 15000, 10, 'https://disvasari.vteximg.com.br/arquivos/ids/164210-1000-1000/VIU172203-CF-28.jpg?v=637310271621570000', true),
(5, 'Gafas de Sol', 'Gafas de sol con protección UV400, estilo moderno.', 20000, 12, 'https://siman.vtexassets.com/arquivos/ids/342174-800-800?v=637250740071930000&width=800&height=800&aspect=true', true),

(6, 'Vestido de Verano', 'Vestido ligero y fresco, ideal para el verano, con estampado floral.', 30000, 8, 'https://media.vogue.mx/photos/629f733cf15012d11248171d/master/w_1600%2Cc_limit/vestito%2520a%2520fiori.jpeg', true),
(6, 'Vestido de Noche', 'Vestido elegante para ocasiones especiales, color negro.', 45000, 5, 'https://www.pronovias.com/media/catalog/product/s/p/sparkle_2424_b.jpg?quality=80&bg-color=255,255,255&fit=bounds&height=747&width=560&canvas=560:747', true),
(6, 'Vestido Casual', 'Vestido casual de manga corta, cómodo y moderno.', 28000, 10, 'https://m.media-amazon.com/images/I/71uRY2-VpdL._AC_SL1500_.jpg', true),
(6, 'Vestido de Fiesta', 'Vestido con detalles brillantes, perfecto para fiestas y eventos.', 50000, 4, 'https://img2.miravia.es/g/fb/kf/Edd84efdab7084ef2a80a239fc63d539aX.jpg_360x360q75.jpg_.webp', true),

(7, 'Bikini', 'Bikini de dos piezas, diseño moderno y cómodo.', 18000, 20, 'https://cdn.occtoo-media.com/995cf62a-7759-4681-a516-370aaabfd325/f9ebcf29-6713-5838-942c-157fe3074efe/239777-0046_01.jpg', true),
(7, 'Traje de Baño Entero', 'Traje de baño entero con soporte adicional, ideal para natación.', 22000, 15, 'https://images.fashiola.es/product-list/300x450/miinto/642454664/banador-de-una-sola-pieza-de-cuerdas-con-estampado-tresses-para-mujer-mujer-talla-xl.webp', true),
(7, 'Short de Baño', 'Short de baño para hombre, cómodo y resistente al cloro.', 15000, 18, 'https://f.fcdn.app/imgs/852c7f/mixup.com.uy/mixuuy/c63d/original/catalogo/2029117_-04_1/1920-1200/short-de-bano-hombre-estampado-palmas.jpg', true),
(7, 'Vestido de Playa', 'Vestido ligero para cubrir el traje de baño, ideal para la playa.', 25000, 10, 'https://www.masmodas.net/14034-thickbox_default/vestido-de-playa.jpg', true),

(8, 'Suéter de Lana', 'Suéter de lana gruesa, perfecto para el invierno.', 35000, 7, 'https://www.caserita-bolivia.es/1796/sueter-altiplano-en-lana-de-alpaca.jpg', true),
(8, 'Suéter con Capucha', 'Suéter con capucha y bolsillo delantero, ideal para un look casual.', 28000, 12, 'https://phantom-telva.unidadeditorial.es/6f63f17448eb1f084d195c8837c94d1f/resize/640/assets/multimedia/imagenes/2021/11/15/16369789804591.jpg', true),
(8, 'Suéter Ligero', 'Suéter ligero, ideal para las noches frescas.', 26000, 9, 'https://i.ebayimg.com/thumbs/images/g/QFUAAOSwk3pmpzkh/s-l1200.jpg', true),
(8, 'Suéter de Alpaca', 'Suéter hecho de lana de alpaca, muy suave y cálido, perfecto para el invierno.', 40000, 6, 'https://http2.mlstatic.com/D_NQ_NP_703557-MLA70044601587_062023-O.webp', true),

(9, 'Boxer de Algodón', 'Boxer de algodón suave y transpirable, ideal para el uso diario.', 12000, 20, 'https://wegatextil.com/media/products/9bf31c7ff062936a96d3c8bd1f8f2ff3/5003-map-boxer-algodon-100-tallas-extra-grandes-hombre-big-01.jpg', true),
(9, 'Bralette de Encaje', 'Bralette de encaje, cómodo y sexy, ideal para uso casual.', 15000, 15, 'https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaPE/126715096_01/w=1500,h=1500,fit=pad', true),
(9, 'Calcetines Invisibles', 'Calcetines invisibles de algodón, perfectos para usar con zapatillas.', 5000, 30, 'https://media.futbolmania.com/media/catalog/product/cache/1/image/0f330055bc18e2dda592b4a7c3a0ea22/S/X/SX4863-900_imagen-del-pack-3-calcetines-invisibles-nike-lightweight-2019-negro-blanco-carne_1_frontal.jpg', true),
(9, 'Calzoncillos Boxer', 'Calzoncillos tipo boxer, con soporte adicional y material transpirable.', 14000, 18, 'https://images.hugoboss.com/is/image/boss/hbeu50475282_999_100?$re_fullPageZoom$&qlt=85&fit=crop,1&align=1,1&bgcolor=ebebeb&lastModified=1716992584000&wid=1200&hei=1818', true);

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

insert into tiendaRopa.rol (id_rol, nombre, id_usuario) values
 (1,'ROLE_ADMIN',1), (2,'ROLE_VENDEDOR',1), (3,'ROLE_USER',1),
 (4,'ROLE_VENDEDOR',2), (5,'ROLE_USER',2),
 (6,'ROLE_USER',3);
