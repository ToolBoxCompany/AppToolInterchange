CREATE DATABASE TOOL_INTERCHANGE;
USE TOOL_INTERCHANGE;

CREATE TABLE COMUNITY (
  idComunity INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE CITY (
  idCity INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  postalCode CHAR(5) NOT NULL,
  idComunity INT,
  province VARCHAR(100),
  
  FOREIGN KEY (idComunity) REFERENCES COMUNITY(idComunity)
);

CREATE TABLE DIRECTION (
  idDirection INT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(150) NOT NULL,
  postalCode CHAR(5) NOT NULL,
  Number INT NOT NULL,
  idCity INT,
  DoorNumber VARCHAR(5),
  StairNumber VARCHAR(5),
  
  FOREIGN KEY (idCity) REFERENCES CITY(idCity)
);

CREATE TABLE USERS (
  idUser INT AUTO_INCREMENT PRIMARY KEY,
  nameUser VARCHAR(40) NOT NULL,
  firtSurname VARCHAR(40) NOT NULL,
  lastSurname VARCHAR(40) NOT NULL,
  mail VARCHAR(100) NOT NULL,
  phoneNumber CHAR(9) NOT NULL CHECK (phoneNumber REGEXP '^[0-9]{9}$'),
  dateOfBirth DATE NOT NULL,
  isSeller TINYINT(1) NOT NULL,
  idDirection INT,
  
  FOREIGN KEY (idDirection) REFERENCES DIRECTION(idDirection)
);

CREATE TABLE CATEGORY (
  idCategory INT AUTO_INCREMENT PRIMARY KEY,
  nameCategory VARCHAR(50) NOT NULL
);

CREATE TABLE TOOL (
  idTool INT AUTO_INCREMENT PRIMARY KEY,
  idUser INT,
  nameTool VARCHAR(100) NOT NULL,
  stock SMALLINT NOT NULL CHECK (stock >= 0),
  idCategory INT,
  pricePerDay DECIMAL(10,2) NOT NULL,
  
  CHECK (pricePerDay > 0),

  FOREIGN KEY (idCategory) REFERENCES category(idCategory),
  FOREIGN KEY (idUser) REFERENCES users(idUser)
);

CREATE TABLE PAYMETHOD (
  idPaymethod INT AUTO_INCREMENT PRIMARY KEY,
  namePaymethod VARCHAR(50)
);

CREATE TABLE ORDERS (
  idOrder INT AUTO_INCREMENT PRIMARY KEY,
  idUser INT,
  idTool INT,
  idPaymethod INT,
  totalAmount DECIMAL(10,2),
  Quantity SMALLINT NOT NULL CHECK (Quantity > 0),
  reservationStart DATE NOT NULL,
  reservationEnd DATE NOT NULL,
  orderStatus VARCHAR(9) NOT NULL DEFAULT 'New',

  CHECK (reservationEnd > reservationStart),
  CHECK (orderStatus IN ('New','Paid','Cancelled','Sended','Returned','Closed')),

  FOREIGN KEY (idUser) REFERENCES USERS(idUser),
  FOREIGN KEY (idTool) REFERENCES TOOL(idTool) ON DELETE CASCADE,
  FOREIGN KEY (idPaymethod) REFERENCES PAYMETHOD(idPaymethod)
);

CREATE TABLE DELIVERY (
  idDelivery INT AUTO_INCREMENT PRIMARY KEY,
  idOrder INT,
  departureDate DATE NOT NULL,
  estimatedDate DATE NOT NULL,
  deliveryDate DATE,
  
  CHECK (deliveryDate > departureDate),

  FOREIGN KEY (idOrder) REFERENCES ORDERS(idOrder) ON DELETE CASCADE
);

CREATE TABLE ASSESSMENT (
  idAssessment INT AUTO_INCREMENT PRIMARY KEY,
  idOrder INT,
  mark CHAR(1) NOT NULL,
  comment TEXT,
  
  CHECK (mark BETWEEN '1' AND '5'),

  FOREIGN KEY (idOrder) REFERENCES ORDERS(idOrder) ON DELETE CASCADE
);

-- Inserts

INSERT INTO COMUNITY (name) 
VALUES 
	('Andalucía'),
	('Cataluña'),
	('Madrid'),
	('Comunidad Valenciana'),
	('Galicia'),
	('País Vasco'),
	('Castilla y León'),
	('Aragón'),
	('Canarias'),
	('Castilla-La Mancha');

INSERT INTO CITY (name, postalCode, idComunity, province)
VALUES 
	('Sevilla', '41001', 1, 'Sevilla'),
	('Granada', '18001', 1, 'Granada'),
	('Barcelona', '08001', 2, 'Barcelona'),
	('Girona', '17001', 2, 'Girona'),
	('Madrid', '28001', 3, 'Madrid'),
	('Valencia', '46001', 4, 'Valencia'),
	('A Coruña', '15001', 5, 'A Coruña'),
	('Bilbao', '48001', 6, 'Bizkaia'),
	('Zaragoza', '50001', 8, 'Zaragoza'),
	('Toledo', '45001', 10, 'Toledo');

INSERT INTO DIRECTION (street, postalCode, Number, idCity, DoorNumber, StairNumber)
VALUES 
	('Calle Sierpes', '41001', 12, 1, '1A', 'B'),
	('Av. Constitución', '18001', 20, 2, '3B', 'C'),
	('Carrer de Balmes', '08001', 5, 3, '2C', 'A'),
	('Plaça de Catalunya', '17001', 8, 4, '1D', 'B'),
	('Calle Alcalá', '28001', 30, 5, '4A', 'C'),
	('Av. del Puerto', '46001', 18, 6, '3C', 'A'),
	('Rúa Real', '15001', 22, 7, '2B', 'C'),
	('Gran Vía', '48001', 15, 8, '3D', 'B'),
	('Paseo Independencia', '50001', 10, 9, '1A', 'A'),
	('Calle Comercio', '45001', 25, 10, '4B', 'C');

INSERT INTO USERS (nameUser, firtSurname, lastSurname,mail,phoneNumber ,dateOfBirth, isSeller, idDirection)
VALUES 
	('maria.lopez88', 'López', 'Ramírez', 'maria.lopez88@gmail.com', '612783945', '1988-04-12', 1, 1),
	('javi_mg90', 'Martín', 'González', 'javimartin90@hotmail.com', '634982173', '1990-06-25', 0, 2),
	('sofi_garciapz', 'García', 'Pérez', 'sofia.garcia.pz@gmail.com', '647192834', '1995-01-15', 1, 3),
	('luis.hdez', 'Hernández', 'Santos', 'luis.hdez@outlook.es', '665018273', '1987-12-09', 0, 4),
	('carmen_dz93', 'Díaz', 'Ruiz', 'carmen.dz93@gmail.com', '678134259', '1993-03-03', 1, 5),
	('pablojm01', 'Jiménez', 'Molina', 'pablo.jimenez01@yahoo.es', '690327814', '2001-07-30', 0, 6),
	('laura_tsnchz', 'Torres', 'Sánchez', 'laura.torres99@gmail.com', '623481729', '1999-09-17', 1, 7),
	('alex_mcastro92', 'Moreno', 'Castro', 'alex.castro92@gmail.com', '654982103', '1992-05-05', 0, 8),
	('raqueelnav', 'Navarro', 'Ortega', 'raquel.navarro85@hotmail.com', '667310849', '1985-11-11', 1, 9),
	('david_rn2000', 'Romero', 'Nieto', 'david.romero2000@gmail.com', '639582740', '2000-02-20', 0, 10);

INSERT INTO CATEGORY (nameCategory) 
VALUES 
	('Jardinería'),
	('Carpintería'),
	('Fontanería'),
	('Electricidad'),
	('Construcción'),
	('Mecánica'),
	('Pintura'),
	('Cerrajería'),
	('Domótica'),
	('Agricultura');

INSERT INTO TOOL (nameTool, idUser, idCategory, stock, pricePerDay) 
VALUES 
  ('Cortacésped eléctrico', 1, 1, 4, 6.50),
  ('Taladro inalámbrico', 3, 2, 6, 4.00),
  ('Llave grifa', 5, 3, 3, 3.50),
  ('Multímetro digital', 7, 4, 2, 5.00),
  ('Hormigonera portátil', 9, 5, 1, 12.00),
  ('Gato hidráulico', 1, 6, 2, 7.00),
  ('Pistola de pintura', 3, 7, 3, 6.00),
  ('Juego de ganzúas', 5, 8, 1, 8.50),
  ('Sensor de movimiento', 7, 9, 4, 4.50),
  ('Desbrozadora a gasolina', 9, 10, 2, 7.50),
	('Sierra circular', 1, 2, 2, 7.00),
	('Pistola de calor', 1, 2, 1, 6.00),
	('Sierra caladora', 1, 2, 2, 5.50),
	('Martillo percutor', 1, 5, 2, 8.00),
	('Pala de punta', 1, 1, 3, 3.50),
	('Escalera telescópica', 1, 1, 1, 7.50),
	('Lijadora de banda', 1, 2, 1, 6.50),
	('Multímetro profesional', 3, 4, 2, 6.00),
	('Taladro percutor', 3, 2, 2, 6.50),
	('Set de llaves combinadas', 3, 3, 3, 4.00),
	('Caladora orbital', 3, 2, 1, 5.00),
	('Pistola neumática', 3, 2, 1, 7.00),
	('Cepillo manual de carpintero', 5, 2, 2, 3.50),
	('Juego de cinceles', 5, 3, 4, 3.00),
	('Extractor de rodamientos', 5, 3, 1, 5.50),
	('Llave de torque', 5, 3, 1, 6.00),
	('Tester de voltaje', 7, 4, 2, 3.00),
	('Sensor ultrasónico', 7, 4, 1, 4.50),
	('Detector de metales', 7, 4, 1, 8.00),
	('Kit Arduino', 7, 4, 3, 5.50),
	('Temporizador digital', 7, 4, 2, 3.50),
	('Andamio plegable', 9, 5, 1, 12.00),
	('Carretilla de carga', 9, 5, 1, 7.50),
	('Compresor de aire', 9, 5, 2, 10.00),
	('Lijadora orbital', 9, 2, 1, 6.00);

INSERT INTO PAYMETHOD (namePaymethod)
VALUES 
	('Tarjeta de crédito'),
	('Bizum'),
	('Efectivo'),
	('Transferencia'),
	('PayPal'),
	('Crédito interno'),
	('Apple Pay'),
	('Google Pay'),
	('Cheque regalo'),
	('Pago en tienda');

INSERT INTO ORDERS (idUser, idTool, idPaymethod, totalAmount, Quantity, reservationStart, reservationEnd)
VALUES 
	(2, 11, 2, 21.00, 1, '2025-07-01', '2025-07-04'),
	(2, 13, 3, 24.00, 2, '2025-07-05', '2025-07-07'),
	(2, 15, 1, 7.50, 1, '2025-07-08', '2025-07-09'),
	(2, 17, 5, 13.00, 2, '2025-07-10', '2025-07-12'),
	(2, 18, 4, 6.50, 1, '2025-07-13', '2025-07-14'),
	(4, 12, 1, 12.00, 2, '2025-07-01', '2025-07-03'),
	(4, 16, 2, 14.00, 1, '2025-07-04', '2025-07-06'),
	(4, 19, 3, 8.00, 1, '2025-07-07', '2025-07-08'),
	(4, 20, 5, 16.50, 3, '2025-07-09', '2025-07-11'),
	(4, 21, 6, 7.00, 1, '2025-07-12', '2025-07-13'),
	(6, 14, 4, 15.00, 1, '2025-07-02', '2025-07-04'),
	(6, 22, 2, 5.50, 1, '2025-07-05', '2025-07-06'),
	(6, 24, 3, 24.00, 2, '2025-07-07', '2025-07-10'),
	(6, 23, 1, 13.00, 1, '2025-07-11', '2025-07-13'),
	(6, 25, 5, 6.00, 1, '2025-07-14', '2025-07-15'),
	(8, 26, 1, 22.00, 2, '2025-07-01', '2025-07-03'),
	(8, 27, 3, 10.00, 1, '2025-07-04', '2025-07-05'),
	(8, 28, 2, 8.50, 1, '2025-07-06', '2025-07-08'),
	(8, 29, 4, 7.00, 1, '2025-07-09', '2025-07-10'),
	(8, 30, 1, 10.00, 2, '2025-07-11', '2025-07-13'),
	(10, 31, 6, 9.00, 1, '2025-07-02', '2025-07-04'),
	(10, 32, 3, 12.00, 1, '2025-07-05', '2025-07-06'),
	(10, 33, 2, 12.00, 2, '2025-07-07', '2025-07-09'),
	(10, 34, 5, 15.00, 1, '2025-07-10', '2025-07-11'),
	(10, 35, 1, 6.00, 1, '2025-07-12', '2025-07-13');
	
INSERT INTO DELIVERY (idOrder, departureDate, estimatedDate, deliveryDate) 
VALUES 
	(1, '2025-07-01', '2025-07-02', '2025-07-02'),
	(2, '2025-07-05', '2025-07-06', '2025-07-06'),
	(3, '2025-07-08', '2025-07-09', '2025-07-09'),
	(4, '2025-07-10', '2025-07-11', '2025-07-11'),
	(5, '2025-07-13', '2025-07-14', '2025-07-14'),
	(6, '2025-07-01', '2025-07-02', '2025-07-02'),
	(7, '2025-07-04', '2025-07-05', '2025-07-05'),
	(8, '2025-07-07', '2025-07-08', '2025-07-08'),
	(9, '2025-07-09', '2025-07-10', '2025-07-10'),
	(10, '2025-07-12', '2025-07-13', '2025-07-13'),
	(11, '2025-07-02', '2025-07-03', '2025-07-03'),
	(12, '2025-07-05', '2025-07-06', '2025-07-06'),
	(13, '2025-07-07', '2025-07-08', '2025-07-08'),
	(14, '2025-07-11', '2025-07-12', '2025-07-12'),
	(15, '2025-07-14', '2025-07-15', '2025-07-15'),
	(16, '2025-07-01', '2025-07-02', '2025-07-02'),
	(17, '2025-07-04', '2025-07-05', '2025-07-05'),
	(18, '2025-07-06', '2025-07-07', '2025-07-07'),
	(19, '2025-07-09', '2025-07-10', '2025-07-10'),
	(20, '2025-07-11', '2025-07-12', '2025-07-12'),
	(21, '2025-07-02', '2025-07-03', '2025-07-03'),
	(22, '2025-07-05', '2025-07-06', '2025-07-06'),
	(23, '2025-07-07', '2025-07-08', '2025-07-08'),
	(24, '2025-07-10', '2025-07-11', '2025-07-11'),
	(25, '2025-07-12', '2025-07-13', '2025-07-13');

INSERT INTO ASSESSMENT (idOrder, mark, comment) 
	VALUES
	(1, '5', 'Herramienta perfecta, como nueva.'),
	(2, '4', 'Buen estado general, algo de polvo.'),
	(3, '3', 'Correcta, aunque esperaba mejor.'),
	(4, '5', 'Funciona perfectamente, entrega rápida.'),
	(5, '2', 'Problemas al arrancar la máquina.'),
	(6, '4', 'Buen rendimiento en el uso.'),
	(7, '3', 'Algo ruidosa, pero funcional.'),
	(8, '5', 'Todo excelente. Muy recomendable.'),
	(9, '4', 'Cumple su función correctamente.'),
	(10, '5', 'Muy buena calidad.');
