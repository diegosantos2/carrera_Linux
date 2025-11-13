create database ipm;

select * from querys_lg order by id_querys_lg desc;

-- Manejo de la Estructura -----------

-- Crear una tabla
create table gente(nombre varchar(60) not null, fecha date null, comentario varchar(60) not null, ID int AUTO_INCREMENT, PRIMARY KEY (ID) );

-- Muestra el query que se puede usar para crear la misma tabla
show create table gente;
-- Se puede usar este sql para poder copiar la stru de la tabla.

-- muestra todos las tablas
show tables;

-- Borra una tabla
drop table gente;

-- Borrar una tabla con incluso el autoincrementable
truncate gente;

-- Description de una tabla
desc gente;

-- Agregar un campo a la tabla
alter table gente add comentario2 varchar(200);


-- Setting de seguridad -----------
set sql_safe_updates = 0;
-- 1175 si esta habilitado y se intenta borrar o modificar mas de un registros les mostrara el error 1175.



-- Manejo de Datos -----------------

-- Update 
update gente set comentario='x' where id=1;

-- Insert (definicion nombre de campos y valores)
insert into gente (nombre, comentario) VALUES ('nombre_1', 'comn_1');
insert into gente (nombre, comentario) VALUES ('nombre_2', 'comn_2');
insert into gente (nombre, comentario) VALUES ('nombre_3', 'comn_3');

-- Insert (sin definir los campos, se puse 0 en el ID de la tabla que luego el motor de SQL pondra el autoincrementable.
select * from confg__permis;
insert into confg__Permis 
( descri, name_, value_, grp )
VALUES 
('cliente_SOLID 0', 'c', '0,1,1,0', 'cliente'),
('cliente_SOLID 1', '', '0,1,1,0', 'cliente'),
('cliente_SOLID 2', '', '0,1,1,0', 'cliente'),
('cliente_SOLID 3', '', '0,1,1,0', 'cliente') ;

-- insert con definicion de campo y valores multiples.
insert into confg__Permis 
( descri, value, grp )
VALUES 
('udas', '0,1,1,0', 'cliente'),
('nombre', '0,1,1,0', 'cliente'),
('', '0,1,1,0', 'cliente'),
('cliente_SOLID', '0,1,1,0', 'cliente') ;







select * from customers;

insert into customers
( b_Office, post, type_, zone )
VALUES 
('Office 1 cln 1 ' , 'post cln 1', 1, 1),
('Office 1 cln 2 ' , 'post cln 2', 2, 2),
('Office 1 cln 3 ' , 'post cln 3', 1, 3),
('Office 1 cln 4 ' , 'post cln 4', 4, 4)
;

-- CRUD (create, read, update, delete)

-- Funciones predefinidas

-- count (cuenta los registros que coincidan con las opciones de busqueda)
select count(price) from invoices_Det;

-- Localiza el minimo valor.
select min(price) from invoices_Det; 

-- Localiza el maximo valor.
select max(price) from invoices_Det; 

-- Suma la columnas.
select sum(price) from invoices_Det; 

-- Obtiene el promedio rendodeado
select round(avg(price),2) from invoices_Det
where descri='art 4';

-- Obtener el registro con el precio mas alto.
select * from invoices_Det where price= (select max(price) from invoices_Det); 

-- Obtener el registro con el precio mas bajo.
select * from invoices_Det where price= (select min(price) from invoices_Det); 

-- Agrupamiento:
-- Obtener la cantidad de registros por Articulo
select * from invoices_Det where descri='art 1'; -- 3 
select * from invoices_Det where descri='art 2'; -- 3
select * from invoices_Det where descri='art 3'; -- 2
select * from invoices_Det where descri='art 4'; -- 1
select * from invoices_Det where descri='art 5'; -- 10
select * from invoices_Det where descri='art 6'; -- 8
select * from invoices_Det where descri='art 7'; -- 3

-- Listado de cuantos articulos se han vendidos.
select descri, count(descri) as cuantas from invoices_Det 
group by descri
order by cuantas;

-- Otras funciones con el mismo grupo
select descri, count(descri) as cuantas, sum(price) from invoices_Det 
group by descri
order by cuantas;

-- Otras funciones con el mismo grupo
select descri, count(descri) as cuantas, sum(price) from invoices_Det 
group by descri
order by cuantas;

-- Agrupando + incluyendo la condicion del valor de cada registro.
select descri, count(descri) as cuantas, sum(price) from invoices_Det 
where price > 1000
group by descri
order by cuantas;

-- Agrupando + incluyendo que el total de lo agrupado esta condicionado.
select descri, count(descri) as cuantas, sum(price) as precio from invoices_Det 
group by descri 
having precio > 1000
order by cuantas;




-- Manipulando texto en el select --

-- CONCAT
-- muestra el delimitador entre los campos.
select CONCAT_WS(' - ',price, quantity, art_code) from invoices_det;
  
  
-- Mostrar un limite de caracter desde la izquierda 
select id_invoice, left(descri,3) as sas from invoices_Det;

-- Mostrar un limite de caracter desde la derecha
select id_invoice, right(descri,2) as sas from invoices_Det;

-- Mostrar un grupo de carcteres en un campo.
select id_invoice, substring(descri, 2,4) as sas from invoices_Det;

-- Mostrar un grupo de carcteres en un campo.
select id_invoice, replace(descri, 'art','ART') as sas from invoices_Det;

-- Funciones de Fecha
select id_invoice, date_ from invoices;
select id_invoice, year(date_) from invoices;
select id_invoice, concat ('Hoy es: ', curdate()) ,concat(day(date_) , '/', month(date_), '/', year(date_))from invoices;
select id_invoice, concat ('Ahora son: ', curtime()) , concat(hour(date_) , ':', minute(date_), ':', second(date_)) as hora from invoices;
-- restar fecha
select 'Dia que faltan para mi cumpleaños: ', datediff('2022/08/29' , curdate()) ;
-- nombre de dia
select 'Mi cumpleaños sera un ', dayname('2022/08/29');
select 'Mi cumpleaños sera en el dia ', dayofweek('2022/08/29') , ' de la semana';
select 'Mi cumpleaños el año ', dayofyear('2022/08/29');
select 'Mi cumpleaños es en el mes de ', monthname('2022/08/29');
select 'Un dia despues de mi cumpleaños es ', adddate('2022/08/29', interval 1 DAY);
select 'el modulo de 10 modulo 3' , MOD(10,3);


-- Insert desde un select
insert into users
	(nombre, apellido)
    select nombre, apellido from cliente;

-- Historial de cliente: Debe de guardar el historial desde un trigger de que lo que se ha cambiado.
-- (checando desde el registro anterior)
-- Debe de haber una funcion para reconstruir los datos.

-- Backup rapido de una tabla
create table back_1
select * from users;






-- Select de toda la tabla
select * from gente;

-- Elimina valores duplicados de un campo.
select distinct(nombre) from gente;
-- * Solo se puede hacer el select del campo que engloba a la funcion.


-- Manejo de NULL 
SELECT * FROM querys.users where post is null;
SELECT * FROM querys.users where post is not null;
-- Subcaso: Solo trae los que no tienen NULL ni espacio en blanco o nada.
select post, f_name from users where post is not NULL and TRIM(post) <> '';



-- Distinct
select distinct(post), f_name from users;
-- Aqui hace el distinct de post y f_name , en este caso debe de ser diferencia tanto la columan f_name como el post para que aparezcan. 
-- Si el post y f_name son iguales solo se mostrara una fila.







-- 

# Table, Create Table

-- ddl: lenguaje de definicion de datos

drop table users;
show create table users;
select * from users;

select * from querys ;

-- Borrar un campo de una tabla:
alter table users drop f_Name;

-- Agregar una restriccion o carac de un campo
alter table persons modify f_Name varchar(41) null;
-- Aqui solo se pase el tipo nuevo que se va a cambiar.

-- Modificar el nombre de un campo, el nombre del dato, etc.
alter table persons change type_P type_ int;
-- Aqui se necesita por ejemplo que se pase el nuevo nombre y tipo.

-- agregar columna
alter table persons add algomas int;

-- renombrar el nombre de una tabla

-- Creacion de indice:
create index query_Index on querys(descri);
-- Nota: Esto no se va a ver en el cuadro de esquemas.

-- Mostrar los indices creados
show index from querys;

-- Eliminar index
drop index query_Index on querys;


-- dml lenguaje de manipulacion de datos (select, insert, update)   

-- upper casa y lower case
select id_query, query, lcase(note) as nota_Lower, ucase(note) as nota_Upper from querys;

-- Where (condicion)
select id_query, query, lcase(note) as nota_Lower, ucase(note) as nota_Upper from querys
where note='SOLO II' ;

-- modificar un valor de un campo de una tabla
update querys set note='SOLO 2' where note='SOLO II';
select id_query, query, lcase(note) as nota_Lower, ucase(note) as nota_Upper from querys
where note='SOLO 2' ;

-- Round Decimal
select id_inv_Det as details, id_inv, price, round(price * .16, 2) as iva, art_Code  from invoices_Det;

-- between
select * from invoices_Det where price between 1 and 10;
select * from invoices_Det where price not between 1 and 10;

-- in / not in
select * from users where user_Name in ('user 1', 'user 3') ;
select * from users where user_Name not in ('user 1', 'user 3') ;

-- Like
select * from users where user_Name like '%ser%';
select * from users where f_Name like '%ombre%';
select * from users where f_Name like 'ombre%';

-- Order by (ordernar) 
select * from users order by user_name ASC;
-- ASC es el default. (desde la A.... Z, 0 .... 9)

--  listado de todas las tablas
show tables;

-- Listado de todas las DBs
show databases;



-- dcl - Lenguaje de control de datos -
create user 'new_User1'@'localhost' identified by '1234'; 
-- otorgar permiso solo para la tabla users
-- Esto sirve para que el usuario solo puede acceder a ciertas tablas.alter
-- Un ejemplo sera que habra solo unos pocos usuarios puedan acceder a la tabla nomina.
grant select on querys.users to 'new_User1'@'localhost';
grant delete on querys.users to 'new_User1'@'localhost';
grant select, insert, update, delete on querys.users to 'new_User1'@'localhost';

-- otorgar permiso solo para la tabla users
-- Esto es vital porque estamos usando un usuario para la coneccion hacia una DB y no usando el usuario root.
grant select on querys.* to 'new_User1'@'localhost';
flush privileges;

-- Revocar permisos:
revoke all on querys.users from 'new_User1'@'localhost';
revoke all on querys.* from 'new_User1'@'localhost';
flush privileges;

-- Eliminar el usuario:
drop user 'new_User1'@'localhost';
flush privileges;
-- * Son dos cosas: 1) el usuario como registro y el registro de la conecccion. Uno puede existir aunque el otro no exista.

-- Listar usuarios:
select user from mysql.user;



-- ------------ TABLAS DE RVC ------------
 
-- PERMIS --
drop table confg__Permis;
create table confg__Permis(
id_Permis int AUTO_INCREMENT, PRIMARY KEY (id_Permis),
descri varchar(90) NOT NULL,
name_ varchar(16) NOT NULL UNIQUE,
value_Type varchar(20) NOT NULL DEFAULT 'B',
value_ varchar(20) NOT NULL DEFAULT 0,
grp varchar(10) NULL,
enabled int NOT NULL DEFAULT 1
);

drop table permis_Det;
create table confg__Permis_Det(
id_Permis_Det int AUTO_INCREMENT, PRIMARY KEY (id_Permis_Det),
value_ varchar(20) NOT NULL,
id_Permis int NOT NULL,
id_User int NOT NULL,
enabled int NOT NULL DEFAULT 1
);

-- ALTER TABLE confg__Permis_Det DROP FOREIGN KEY fk_Permis_Det_Permis;

alter table confg__Permis_Det 
add constraint fk_Permis_Det_Permis
foreign key(id_Permis)
references confg__Permis(id_Permis);

alter table confg__Permis_Det 
add constraint fk_Permis_Det_Users
foreign key(id_User)
references entity__Users(id_User);

-- truncate confg__Permis;

select * from users;
select * from confg__permis;
select * from confg__permis_Det;
delete from permis_Det;
insert into confg__Permis_Det
( value_, id_Permis, id_User )
VALUES 
(1 , 1 , 5),
(0 , 2 , 5),
(1 , 3 , 5),
(0 , 4 , 5),
(1 , 5 , 5),
(0 , 6 , 5),
(1 , 7 , 5),
(0 , 8 , 5),
(1 , 9 , 5),
(0 , 10 ,5);


insert into confg__Permis
( descri, name_, value_ )
VALUES 
('Clientes, Crear, Leer, Actualizar y Borrar Cliente (NO inlcuye el nombre)' , 'cust_CRUD' , 'customer'),
('Clientes, Importar contactos', 'import_Cust', 'customer'),
('Clientes, Cambiar la fase del cliente (1-6)','chg_Fase_Cust', 'customer'),
('Clientes, Modificar informacion crediticia','Finan_Data', 'customer'),
('Clientes, Modificar Status del cliente', 'chg_Status', 'customer'),
('Clientes, Ver clientes de otros usuarios', 'see_Other_Cust', 'customer'),
('Clientes, Asignar a otros usuarios', 'asigner_Cust',  'customer'),
('Clientes, Autorizacion para modificar los datos de clientes que son de otros Usuarios', 'upd_Other_Cust' , 'customer'),
('Clientes, Borrar (que no tengan documentos generados)', 'del_Cust', 'customer'),
('Contactos, Crear, Leer, Actualizar y Borrar', 'cont_CRUD', 'contacts');


-- SALESPERSONS --
create table sales__SalesPersons(
id_SalesPerson int AUTO_INCREMENT, PRIMARY KEY (id_SalesPerson),
type_ int null, 
comition decimal (18.2) NULL,
id_Territory int null, 
id_User int NOT NULL,
enabled int NOT NULL DEFAULT 1
);
insert into sales__SalesPersons (type_, comition, id_Territory, id_User) VALUES 
(2, 2, 4, 1), (2, 3, 3, 2), (0, 4, 2, 3), (1, 6, 1, 4);
select * from entity__Sales_Persons;


-- PERSONS --
create table person__Persons(
id_Person int AUTO_INCREMENT, PRIMARY KEY (id_Person),
f_Name varchar(40) null, 
m_Name varchar(40) null, 
l_Name varchar(40) null,
o_Name varchar(40) null,
type_P int NOT NULL DEFAULT 0,
buss_Name varchar(80) NULL,
post varchar(50) null,
enabled int NOT NULL DEFAULT 1,
id_User int NULL,
id_Customer int NULL,
id_Provider int NULL,
id_SalesPerson int NULL,
last_Log timestamp DEFAULT CURRENT_TIMESTAMP
);
alter table person__Persons 
add constraint fk_Persons_Users
foreign key(id_User)
references enityt__Users(id_User);
alter table person__Persons 
add constraint fk_Persons_Customers
foreign key(id_Customer)
references entity__Customers(id_Customer);
alter table person__Persons 
add constraint fk_Persons_Provider
foreign key(id_Provider)
references entity__Providers(id_Provider);
alter table person__Persons 
add constraint fk_Persons_SalesPerson
foreign key(id_SalesPerson)
references sales__SalesPersons(id_SalesPerson);

insert into person__Persons (f_name, m_Name, l_Name, o_Name, id_SalesPerson) VALUES
('nom 1 SM','nomM SM 1','apeF SM 1','nomM SM 1', 1 ),
('nom 2 SM','nomM SM 2','apeF SM 2','nomM SM 2', 2 ),
('nom 3 SM','nomM SM 3','apeF SM 3','nomM SM 3', 3 ),
('nom 4 SM','nomM SM 4','apeF SM 4','nomM SM 4', 4 );



select * from entity__Customer_Types;
insert into entity__Customer_Types (descri) VALUES ('Tipo Cln 1'), ('Tipo Cln 2'), ('Tipo Cln 3'), ('Tipo Cln 4');
select * from entity__Customers;

select * from entity__Customer_Type;


ALTER TABLE persons DROP FOREIGN KEY fk_Persons_Users;

show create table persons;

-- GENERALS --
CREATE TABLE status_Types(
	id_Status_Type int AUTO_INCREMENT, PRIMARY KEY (id_Status_Type),
	descri varchar(50) NULL,
	enabled int NOT NULL DEFAULT 1
);

-- ADDRESSES --
CREATE TABLE person__Cities(
	id_City int AUTO_INCREMENT, PRIMARY KEY (id_City),
	descri varchar(50) NULL,
	enabled int NOT NULL DEFAULT 1
);

CREATE TABLE person__Addresses_Types(
	id_Addresses_Type int AUTO_INCREMENT, PRIMARY KEY (id_Addresses_Type),
	descri varchar(50) NULL,
	enabled int NOT NULL DEFAULT 1
);

CREATE TABLE person__Countries(
	id_Country int AUTO_INCREMENT, PRIMARY KEY (id_Country),
	descri varchar(50) NULL,
	enabled int NOT NULL DEFAULT 1
);
insert into person__Countries(descri) VALUES 
('Argentina'),
('Chile'),
('EEUU')
;
select * from person__countries;

CREATE TABLE person__State_Provinces(
	id_State_Province int AUTO_INCREMENT, PRIMARY KEY (id_State_Province),
	id_Country int NOT NULL,
	descri varchar(50) NULL,
	enabled int NOT NULL DEFAULT 1
);
alter table person__State_Provinces
add constraint fk_State_Provinces_Country
foreign key(id_Country)
references person__Countries(id_Country);
insert into person__State_Provinces (descri, id_Country) VALUES
( 'zacatecas', 1 ),
( 'jalisco', 1 ),
( 'df', 1 ),
( 'guanajuato', 1 );
insert into person__State_Provinces (descri, id_Country) VALUES
( 'Buenos Aires', 2 ),
( 'Capital Federal', 2 ),
( 'Salta', 2 ),
( 'tucuman', 2 );
insert into person__State_Provinces (descri, id_Country) VALUES
( 'DF chile', 3 )
;
insert into person__State_Provinces (descri, id_Country) VALUES
( 'Kansas', 4 ),
( 'DC', 4 ),
( 'Arizona', 4 ),
( 'California', 4 ),
( 'Masachusset', 4 );

CREATE TABLE person__Cities(
	id_City int AUTO_INCREMENT, PRIMARY KEY (id_City),
	id_State_Province int NOT NULL,
	descri varchar(50) NULL,
	enabled int NOT NULL DEFAULT 1
);
alter table person__Cities
add constraint fk_Cities_State_Provinces
foreign key(id_State_Province)
references person__State_Provinces(id_State_Province);
select * from person__Cities;

select * from person__State_Provinces;
insert into person__Cities (descri, id_State_Province) VALUES
( 'zacatecas', 1 ),
( 'Guadalajara', 2 ),
( 'ALvaro obregon', 3 ),
( 'Benito juarez', 3 ),
( 'Leon', 4 ),
( 'San Isidro', 5 ),
( 'Martinez', 5 ),
( 'La Plata', 5 ),
( 'San telmo', 6 ),
( 'La recoleta', 6 ),
( 'Salta', 7 ),
( 'Saltita', 7 ),
( 'Tucuman', 8 ),
( 'Santiago de Chile', 9 ),
( 'Arkansas', 10 ),
( 'Washinton', 11 ),
( 'Phoenix', 12),
( 'San Diego', 13 ),
( 'Boston', 14 );
select * from person__Cities ;


CREATE TABLE person__Addresses(
	id_Address int AUTO_INCREMENT, PRIMARY KEY (id_Address),
	AddressLine1 varchar(50) NULL,
	AddressLine1 varchar(50) NULL,
	zipCode varchar(15) NULL,
	loc varchar(50) NULL,
	loc_2 varchar(50) NULL,
	id_City int NULL,
	id_Person int NULL,
	id_Addresses_Type int NULL,
	id_Status_Type int NULL,
	enabled int not null DEFAULT 1
);
alter table addresses drop id_Country;

alter table person__Addresses 
add constraint fk_Addresses_Cities
foreign key(id_City)
references person__Cities(id_City);

alter table person__Addresses 
add constraint fk_Addresses_Addresses_Type
foreign key(id_Addresses_Type)
references person__Addresses_Types(id_Addresses_Type);

alter table person__Addresses 
add constraint fk_Addresses_Status_Type
foreign key(id_Status_Type)
references person__Status_Types(id_Status_Type);
ALTER TABLE person__Addresses DROP FOREIGN KEY fk_Addresses_Status_Type;

alter table person__Addresses 
add constraint fk_Addresses_id_Person
foreign key(id_Person)
references Persons(id_Person);

select * from person__Cities;
select * from person__Addresses;
insert into person__Addresses
( addressLine1, PostalCode, loc, id_City, id_Person, id_Addresses_Type, id_status_type ) VALUES
( 'calle 1', '002', 'localidad 1', 3, 1, 1, 1),
( 'calle 2', '003', 'localidad 2', 4, 1, 2, 1),
( 'calle 3', '004', 'localidad 3', 5, 2, 2, 1),
( 'calle 4', '005', 'localidad 4', 6, 3, 1, 1),
( 'calle 5', '006', 'localidad 5', 7, 3, 1, 1),
( 'calle 6', '007', 'localidad 6', 8, 3, 1, 1),
( 'calle 7', '008', 'localidad 7', 9, 4, 1, 1),
( 'calle 8', '009', 'localidad 8', 10, 4, 1, 1),
( 'calle 9', '010', 'localidad 9', 11, 5, 2, 1),
( 'calle 10','011', 'localidad 10',12, 5, 3, 1),
( 'calle 11','012', 'localidad 11',13, 5, 1, 1),
( 'calle 12','013', 'localidad 12',14, 5, 2, 1)
;


-- addresses_Status_Type
select * from addresses_Status_Types;


-- addresses_Type
select * from person__addresses_types ;
-- delete from person__addresses_types  where id_addresses_Type > 4;
insert into person__addresses_types (descri) VALUES
( 'add type 1' ),
( 'add type 2' ),
( 'add type 3' ),
( 'add type 4' );



-- USERS
create table entity__Users(
id_User int AUTO_INCREMENT, PRIMARY KEY (id_User),
user_Name varchar(20) not null, UNIQUE KEY user_Name_UNIQUE (user_Name), -- unique
b_Office int null, --  default= null -- es null cuando el usuario no tiene acceso pero es empleado de la empresa y esta tomando en cuenta para funciones escenciales del software.
post varchar(50) null,
status_InOu int not null DEFAULT 0,
pass varchar(300) null,
last_Log timestamp DEFAULT CURRENT_TIMESTAMP,
type_ int not null DEFAULT 0,
enabled int not null DEFAULT 1
);

insert into entity__Users (user_Name, b_Office, enabled, f_Name) VALUES ('user 4', 4, 1, 'nombre 4' );


-- PROVIDERS --
 -- prov_Type (provider)
create table entity__Prov_Types(
id_Prov_Type int AUTO_INCREMENT, PRIMARY KEY (id_Prov_Type),
descri varchar (15) NOT NULL,
enabled int NOT NULL DEFAULT 1
);
select * from entity__Prov_Types;
insert into entity__Prov_Types
( descri )
VALUES
('Provedor 1'), ('Provedor 2'), ('Provedor 3'), ('Provedor 4');

create table entity__Providers(
id_Provider int AUTO_INCREMENT, PRIMARY KEY (id_Provider),
id_Prov_Type int NULL,
ext varchar(30) NULL,
type_ int NOT NULL,
enabled int NOT NULL DEFAULT 1
);
-- Agregar una tabla de mucho a muchos para poder seleccionar varios tipos (multiples) de tipos providers.
-- alter table entity__Providers add enabled int NOT NULL DEFAULT 1;

alter table entity__Providers 
add constraint fk_Providers_Prov_Type
foreign key(id_Prov_Type)
references entity__Prov_Types(id_Prov_Type);

insert into entity__Providers (id_Prov_Type, ext, type_) VALUES
(1, 'categoria 1', 12),
(1, 'categoria 1', 43),
(2, 'categoria 2', 43),
(3, 'categoria 3', 1);
select * from entity__Providers;
select * from person__Persons;
insert into person__Persons (id_Provider, buss_Name)
VALUES
(1, 'Provedor 1'),
(2, 'Provedor 2'),
(3, 'Provedor 3'),
(4, 'Provedor 4');





 -- ALTER TABLE providers DROP FOREIGN KEY fk_Providers_Prov_Type;
rename table users to entity__Users; 



-- CUSTOMERS --
-- customer_Type (customer)
create table entity__Customer_Types(
id_Customer_Type int AUTO_INCREMENT, PRIMARY KEY (id_Customer_Type),
descri varchar (15) NOT NULL,
enabled int NOT NULL DEFAULT 1
);

rename table operation__types to operation__Pay_Conds;
alter table operation__Pay_Conds modify id_Pay_Cond int NOT NULL AUTO_INCREMENT;
desc operation__Pay_Conds;

drop table entity__Customer_Type;
ALTER TABLE operation__Proj_Finans_Set DROP FOREIGN KEY fk_Proj_Finans_Set_Type;
ALTER TABLE operation__Proj_Finans_Set change id_Type id_Pay_Cond int NOT NULL;


create table entity__Customers(
id_Customer int AUTO_INCREMENT, PRIMARY KEY (id_Customer),
b_Office varchar(50), --  default= null -- es null cuando el usuario no tiene acceso pero es empleado de la empresa y esta tomando en cuenta para funciones escenciales del software.
post varchar(50) null,
enabled int not null DEFAULT 1,
id_Customer_Type int NULL,
zone int NULL,
status_ int NOT NULL DEFAULT 0,
last_Log timestamp DEFAULT CURRENT_TIMESTAMP
);

alter table entity__Customers 
add constraint fk_Customers_Customer_Type
foreign key(id_Customer_Type)
references entity__Customer_Types(id_Customer_Type);



-- INVOICES --

drop table sales__Invoices;
create table sales__Invoices(
id_Invoice int AUTO_INCREMENT, PRIMARY KEY (id_Invoice),
id_User int NOT NULL,
id_Customer int NOT NULL,
expirated date NOT NULL,
sales_Type int NOT NULL DEFAULT 1,
inv_Number varchar(24) NOT NULL UNIQUE,
place varchar(15) NOT NULL,
id_Request int NULL,
id_Quote int NULL,
note varchar(100) NULL,
pay_Cond varchar(10) NOT NULL,
date_ timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- poner default 
canc_Concpt varchar(50) NULL,
canc_Date date NULL,
status_ int NOT NULL DEFAULT 1);

alter table sales__Invoices
add constraint fk_Invoices_id_Quote
foreign key(id_Quote)
references sales__Quotes(id_Quote);

select * from sales__Quotes;
select * from sales__invoices;
insert into sales__Quotes ( id_User, id_Proj_finans, id_Sales_Type, id_Pay_Conds, tax, total, id_How_Did_Quote, currency, start_Date ) VALUES 
( 1,0,2, 5, 16,4441,1, 'MX', curdate()),
( 2,0,2, 6, 16,4442,2, 'MX', curdate()),
( 2,0,2, 5, 16,4443,2, 'MX', curdate()),
( 3,0,1, 2, 16,4444,1, 'MX', curdate()),
( 3,3,1, 3, 16,4445,1, 'MX', curdate()),
( 4,4,1, 4, 16,4446,4, 'MX', curdate()
);

alter table sales__Invoices
add constraint fk_Invoices_id_User
foreign key(id_User)
references Entity__Users(id_User);

alter table Sales__Invoices
add constraint fk_Invoices_id_Customer
foreign key(id_Customer)
references Entity__Customers(id_Customer);

-- falta la tabla
alter table Sales__Requests
add constraint fk_Invoices_id_Request
foreign key(id_Request)
references sales__Resquest(id_Request);



drop table Sales__Invoices_Det;
create table invoices_Det(
id_Invoice_Det int AUTO_INCREMENT, PRIMARY KEY (id_Invoice_Det),
id_Invoice int NOT NULL, -- no puede haber un registro sin relacion con una factura.
tax_Prop decimal (4,2) NOT NULL default 0,
price decimal (18,2) NOT NULL default 0, 
id_Coti_Det int NOT NULL,
id_Request_Det int NULL,
descri varchar(200) NOT NULL default '',
quantity decimal(18, 2) NOT NULL default 0,
art_Code varchar(50) NOT NULL,
maq_Code varchar(50) NOT NULL default '',
id_Web int NOT NULL default 0,
last_Log timestamp DEFAULT CURRENT_TIMESTAMP,
status_ int NOT NULL default 1
);

alter table sales__Invoices_Det 
add constraint fk_Invoices_Invoices_Det
foreign key(id_Invoice)
references sales__Invoices(id_Invoice);

alter table sales__Invoices_Det 
add constraint fk_Invoices_Det_id_Coti
foreign key(id_Coti_Det)
references sales__Cotis_Det(id_Coti_Det);
 



insert into sales__Invoices ( id_Invoice, id_user, id_Customer, expirated, sales_Type, inv_Number, place, id_Request, 
id_Coti, note, pay_Cond, date_, canc_Concpt, canc_Date, status_  )
VALUES 
('1','1','2','2021-12-21','1','0002','Bue',NULL,NULL,NULL,'Contado','2021-12-21 08:06:36',NULL,NULL,'1'),
('2','1','1','2021-12-21','1','0001','Bue',NULL,NULL,NULL,'Contado','2021-12-21 08:06:55',NULL,NULL,'1'),
('4','1','1','2021-12-21','1','0003','Bue',NULL,NULL,NULL,'Credito','2021-12-21 08:07:19',NULL,NULL,'1'),
('5','1','1','2021-12-21','1','0004','Bue',NULL,NULL,NULL,'Cred M','2021-12-21 08:07:32',NULL,NULL,'1'),
('6','1','1','2021-12-21','1','0005','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:07:42',NULL,NULL,'1'),
('8','1','2','2021-12-21','1','0006','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:08:27',NULL,NULL,'1'),
('9','1','2','2021-12-21','1','0007','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:08:39',NULL,NULL,'1'),
('10','1','2','2021-12-21','1','0008','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:08:43',NULL,NULL,'1'),
('11','1','2','2021-12-21','1','0009','Bue',NULL,NULL,NULL,'Contado','2021-12-21 08:08:53',NULL,NULL,'1'),
('12','1','2','2021-12-21','1','0010','Bue',NULL,NULL,NULL,'Credito','2021-12-21 08:09:00',NULL,NULL,'1'),
('13','1','2','2021-12-21','1','0011','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:09:24',NULL,NULL,'1'),
('14','1','3','2021-12-21','1','0012','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:09:48',NULL,NULL,'1'),
('15','1','3','2021-12-21','1','0013','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:09:56',NULL,NULL,'1'),
('16','1','3','2021-12-21','1','0014','Bue',NULL,NULL,NULL,'Contado','2021-12-21 08:10:06',NULL,NULL,'1'),
('17','1','3','2021-12-21','1','0015','Bue',NULL,NULL,NULL,'Cred A','2021-12-21 08:10:24',NULL,NULL,'1'),
('18','1','3','2021-12-21','1','0016','Bue',NULL,NULL,NULL,'Contado','2021-12-21 08:10:36',NULL,NULL,'1'),
('19','1','3','2021-12-21','1','0017','Bue',NULL,NULL,NULL,'Contado','2021-12-21 08:11:01',NULL,NULL,'1'),
('20','1','3','2021-12-21','1','0018','Bue',NULL,NULL,NULL,'Cred B','2021-12-21 08:11:33',NULL,NULL,'1')
;


delete from sales__Invoices_Det;
select * from invoices_Det;
select * from invoices;
insert into sales__Invoices_Det
( id_Invoice, price, descri, quantity, art_Code )
VALUES 
( 1, 123.42, 'art 1', 2, 423 ),
( 1, 223.43, 'art 2', 2, 424 ),
( 1, 323.44, 'art 4', 2, 425 ),
( 1, 423.45, 'art 5', 2, 426 ),
( 1, 523.46, 'art 6', 2, 427 ),
( 1, 623.47, 'art 7', 2, 428 ),
( 2, 723.48, 'art 2', 3, 421 ),
( 2, 823.49, 'art 6', 3, 427 ),
( 2, 923.50, 'art 7', 3, 428 ),
( 4, 1023.51, 'art 6', 13, 427 ),
( 5, 1123.52, 'art 7', 3, 428 ),
( 5, 1223.53, 'art 6', 3, 427 ),
( 5, 1323.54, 'art 5', 3, 426 ),
( 6, 1423.55, 'art 5', 3, 426 ),
( 6, 1423.56, 'art 6', 3, 427 ),
( 8, 1523.57, 'art 1', 3, 423 ),
( 8, 23.58, 'art 2', 3, 424 ),
( 8, 123.59, 'art 5', 3, 426 ),
( 9, 223.60, 'art 5', 3, 426 ),
( 10, 333.61, 'art 5', 3, 426 ),
( 11, 433.62, 'art 5', 3, 426 ),
( 12, 533.63, 'art 6', 3, 427 ),
( 13, 633.64, 'art 5', 3, 426 ),
( 14, 733.65, 'art 6', 3, 427 ),
( 15, 833.66, 'art 5', 3, 426 ),
( 16, 933.67, 'art 6', 3, 427 ),
( 17, 23.68, 'art 1', 3, 423 ),
( 18, 33.69, 'art 3', 3, 428 ),
( 19, 34.70, 'art 3', 3, 428 ),
( 20, 35.71, 'art 5', 3, 426 )
;
select * from invoices;


-- QUOTES --
CREATE TABLE sales__Quotes(
	id_Quote int AUTO_INCREMENT, PRIMARY KEY (id_Quote),
	id_User int NOT NULL,
	id_Proj_Finans int NULL,
	id_Sales_Type int NOT NULL,
	id_Pay_Conds int NOT NULL,
	currency varchar(20) NOT NULL,
	date_ TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    start_Date datetime NOT NULL,
	end_Date datetime NULL,
	status_ int NOT NULL DEFAULT 0,
	tax decimal(18.2) NOT NULL,
	discount decimal(18.2) NULL,
	id_Team int NULL,
	notes varchar(250) NULL,
	currency_Exchange decimal(4.2) NULL,
	currency_Exchange_Date datetime NULL,
	discount_Rate decimal(4.2) NULL,
	total decimal (18.2) NULL,
	id_Invoice int NULL,
	id_Cont varchar(50) NULL,
	id_Request int NULL,
	id_How_Did_Quote int NOT NULL,
	wich_Discount int NULL,
	autoDescu decimal(4.2) NULL,
	ok_Discount int NULL,
	id_SWO int NULL,
	comp_Requi int NULL,
	id_Quote_Div int NULL,
	ivaPorc decimal(4.2) NULL
);
alter table sales__Quotes 
add constraint fk_sales__Quotes_Users
foreign key(id_User)
references entity__Users(id_User);
alter table sales__Quotes 
add constraint fk_sales__Quotes_Proj_Finans
foreign key(id_Proj_Finan)
references operation__Proj_Finans(id_Proj_Finan);
alter table sales__Quotes 
add constraint fk_sales__Quotes_Sales_Types
foreign key(id_Sales_Type)
references sales__Sales_Types(id_Sales_Type);
alter table sales__Quotes 
add constraint fk_sales__Quotes_Pay_Conds
foreign key(id_Pay_Cond)
references operation__Pay_Conds(id_Pay_Cond);

-- alter table operation__Proj_Finans change id_Proj_Finans id_Proj_Finan int NOT NULL AUTO_INCREMENT ;
select * from sales__quotes;
select * from operation__Proj_Finans;
select * from operation__Pay_Conds;


create table sales__Quotes_Det(
id_Quote_Det int AUTO_INCREMENT, PRIMARY KEY (id_Quote_Det),
id_Quote int NOT NULL,
id_Product int NOT NULL,
quantity decimal(10, 2) NOT NULL,
price decimal(18, 2) NOT NULL,
prod_Code varchar(50) NOT NULL,
currency varchar(50) NOT NULL,
charact varchar(250) NULL,
descri varchar(100) NULL,
branch varchar(20) NULL,
model varchar(25) NULL,
discount decimal(18,6) NULL
);
-- alter table production__Products change prod_Number prod_Code varchar(20);
alter table sales__Quotes_Det 
add constraint fk_sales__Quotes_Det_Quotes
foreign key(id_Quote)
references sales__Quotes(id_Quote);

insert into sales__Quotes_Det (id_Quote, id_Product, quantity, price, prod_Code, currency, descri, branch, model ) VALUES
( 11, 43, 8, 131.03, '0003', 'USD', 'refaccion 5, grupo 3, sub grupo', 'marca', 'model' ),
( 12, 44, 5, 131.03, '0004', 'USD', 'refaccion 6, grupo 3, sub grupo', 'marca', 'model' );

select * from cotis__Det;



-- OPERATION --
create table operation__Pay_Conds(
id_Pay_Cond int AUTO_INCREMENT, PRIMARY KEY (id_Pay_Cond),
descri varchar(35) NOT NULL,
id_Sales_Type int NULL,
id_Po_Type int NULL,
has_Finans_Proj int NOT NULL DEFAULT 0,
enabled int NOT NULL DEFAULT 1
);

-- For Sales.
insert into operation__Pay_Conds( descri, id_Sales_Type) VALUES
('Contado s', 1,0),
('Credito 30 dias', 1,0),
('Credito plazo normal', 1,1),
('Credito renta c/opc compra', 1,1);
insert into operation__Pay_Conds( descri, id_Sales_Type) VALUES
('Contado s', 2),
('Credito 30 dias', 2);
insert into operation__Pay_Conds( descri, id_Sales_Type) VALUES
('Contado s', 3),
('Credito 30 dias', 3);
insert into operation__Pay_Conds( descri, id_Sales_Type) VALUES
('Contado s', 4);
select * from operation__Pay_Conds;

-- FOR POs
select * from production__po_types;
insert into operation__Pay_Conds( descri, id_Po_Type) VALUES
('Contado s (po)', 1),
('Credito 30 dias (po)', 1),
('Credito plazo normal (po)', 1,1),
('Credito renta c/opc compra (po)', 1,1);
insert into operation__Pay_Conds( descri, id_Po_Type) VALUES
('Contado s (po)', 2),
('Credito 30 dias (po)', 2);
insert into operation__Pay_Conds( descri, id_Po_Type) VALUES
('Contado s (po)', 3),
('Credito 30 dias (po)', 3);
insert into operation__Pay_Conds( descri, id_Po_Type) VALUES
('Contado s (po)', 4);
select * from operation__Pay_Conds;

alter table operation__Pay_Conds 
add constraint fk_operation__Pay_Conds_Sales_Type
foreign key(id_Sales_Type)
references sales__Sales_Pay_Conds(id_Sales_Type);
alter table operation__Pay_Conds
add constraint fk_operation__Pay_Conds_Po_Type
foreign key(id_Po_Type)
references production__Po_Types(id_Po_Type);



select * from sales__sales_Types;


-- PRODUCTION -- po_Types
create table production__Po_Types(
id_Po_Type int AUTO_INCREMENT, PRIMARY KEY (id_Po_Type),
descri varchar (40) NOT NULL,
enabled int NOT NULL DEFAULT 1
);
alter table production__Po_Types add descri varchar(40) NOT NULL;
insert into production__Po_Types(descri)values 
('Maquinaria PO'),
('Refaccione PO'),
('Servicio PO'),
('Flete PO');
select * from production__Po_Types;

-- Table sales_Types
create table sales__Sales_Types(
id_sales_Type int AUTO_INCREMENT, PRIMARY KEY (id_Sales_Type),
descri varchar (40) NOT NULL,
enabled int NOT NULL DEFAULT 1
);
insert into sales__Sales_Types(descri)values 
('Maquinaria Sl'),
('Refaccione Sl'),
('Servicio Sl'),
('Flete Sl');
select * from sales__Sales_Types;
alter table operation__Proj_Finans_Set add id_Type INT NOT NULL;


-- Table SETING pay_Conditions (corridas financieras)
create table operation__Proj_Finans_Set(
id_Proj_Finans_Set int AUTO_INCREMENT, PRIMARY KEY (id_Proj_Finan),
id_Type int NOT NULL,
incl_Firs_Pay int NOT NULL DEFAULT 0,
type_ int NOT NULL DEFAULT 0,
but_Options int NOT NULL DEFAULT 0,
more int NOT NULL DEFAULT 0,
assegurance int NOT NULL DEFAULT 0,
enabled int NOT NULL DEFAULT 1
);
alter table operation__Proj_Finans_Set 
add constraint fk_Proj_Finans_Set_Type
foreign key(id_Type)
references operation__Types (id_Type);


-- Table pay_Conditions (corridas financieras with data)






alter table operation__Proj_Finans_Set add id_Operation_Type int NOT NULL;
alter table operation__Proj_Finans_Set change id_Proj_Finan id_Proj_Finans_Set int NOT NULL auto_increment;
desc operation__Pay_Conditions;

rename table operation__Proj_Finans to operation__Proj_Finans_Set;
 
 
drop table production__Products;
ALTER TABLE production__Sub_Flia DROP FOREIGN KEY fk_Production__Flia_Sub_Flia;

-- PRODUCTS --
create table production__Lines(
id_line int AUTO_INCREMENT, PRIMARY KEY (id_line),
descri varchar (35) NOT NULL,
enabled int NOT NULL DEFAULT 1
);
create table production__Flias(
id_Flia int AUTO_INCREMENT, PRIMARY KEY (id_Flia),
id_Line int NULL,
descri varchar (35) NOT NULL,
enabled int NOT NULL DEFAULT 1
);
alter table production__Flias 
add constraint fk_Production__Flia_Line
foreign key(id_Line)
references production__Lines(id_Line);
create table production__Sub_Flias(
id_Sub_Flia int AUTO_INCREMENT, PRIMARY KEY (id_Sub_Flia),
id_Flia int NULL,
descri varchar (35) NOT NULL,
prod_Number varchar(25) NOT NULL,
enabled int NOT NULL DEFAULT 1
);
alter table production__Sub_Flias
add constraint fk_Production__Flia_Sub_Flia
foreign key(id_Flia)
references production__Flias(id_Flia);


-- PRODUCTS --
create table production__Products(
id_Products int AUTO_INCREMENT, PRIMARY KEY (id_Products),
id_Line int NULL,
id_Flia int NULL,
id_Sub_Flia int NULL,
descri varchar (35) NOT NULL,
descri_L varchar (100) NULL,
prod_Number varchar(25) NOT NULL UNIQUE,
branch varchar(40) NULL, 
model  varchar(40) NULL, 
year int NULL
no_Inventory int NULL,
active_ int NULL,
id_Ensamblem int NULL,
is_Our_Art int NULL,
repos_Price decimal (12.2) NULL,
Note varchar(200) NULL,
serials varchar(40) NULL,
prov_Price varchar(18.2) NULL,
currency varchar(3) NULL DEFAULT 'USD',
chkProv int NULL,
unique_Product int NULL,
status_ int NULL,
enabled int NOT NULL DEFAULT 1
);
alter table production__Products modify repos_Price decimal (12,2) NULL;
alter table production__Products
add constraint fk_Production__Line_Products
foreign key(id_Line)
references production__Lines(id_Line);
alter table production__Products
add constraint fk_Production__Flias_Products
foreign key(id_Flia)
references production__Flias(id_Flia);
alter table production__Products
add constraint fk_Production__Sub_Flias_Products
foreign key(id_Sub_Flia)
references production__Sub_Flias(id_Sub_Flia);



select * from sales__Invoices;
select * from production__Sub_Flias;
select * from production__Flias;
select * from production__Lines;
insert into production__Sub_Flias
(descri, id_Flia) VALUES
('Servicios Sub Grp6-1',9),
('Servicios Sub Grp6-2',9),
('Servicios Sub Grp6-3',9)
;

select * from production__Products;

insert into production__Products ( id_line, id_flia, id_sub_flia, descri, prod_Number, repos_Price ) VALUES 
(3, 7, 19, 'Servicios 1, grupo 1, sub grupo 1', 's0001', 32.56 ),
(3, 7, 19, 'Servicios 2, grupo 1, sub grupo 1', 's0002', 12344.43),
(3, 8, 20, 'Servicios 3, grupo 2, sub grupo 2', 's0003', 19031.53 ),
(3, 8, 20, 'Servicios 4, grupo 2, sub grupo 2', 's0004', 851.29 ),
(3, 9, 21, 'Servicios 5, grupo 3, sub grupo 3', 's0005', 87031.1 ),
(3, 9, 21, 'Servicios 6, grupo 3, sub grupo 3', 's0006', 76.45 )
; 

 desc production__Products;

-- OPERACION PROJ_FINANS (CORRIDA FINANCIERA)
CREATE TABLE operation__Proj_Finans(
	id_Proj_Finans int AUTO_INCREMENT, PRIMARY KEY (opening, id_Proj_Finans),
	opening int NULL,
	share_ int NULL,
	assurance int NULL,
	date_ datetime NULL,
	tax_Share int NULL,
	tax_Assurance int NULL,
	tax_Opening decimal(4.2) NULL,
    interest decimal(4,2) NULL,
	time_Limit int NULL,
	assurance_Finances int NULL,
	opening_Prop decimal(4,2) NULL,
    share_Proc decimal(4,2) NULL,
	assurance_Porc decimal(4,2) NULL,
	tax_Interest decimal(4,2) NULL
);
insert into operation__Proj_Finans( tax_Share, tax_Assurance, tax_Opening, interest, time_Limit, assurance_Finances, opening_Prop, share_Proc, assurance_Porc ) VALUES
( 15, 15, 0,  12, 36, 1, 18, 33, 1),
( 15, 15, 0,  12, 24, 1, 18, 30, 1),
( 15, 15, 15, 11, 24, 1, 18, 30, 1),
( 15, 15, 0,  14, 12, 1, 18, 40, 0);

 
-- Sales_Types_Restg -  
create table sales__sales_Types_Restg (
id_Sales_Types_Restg int AUTO_INCREMENT, PRIMARY KEY (id_Sales_Types_Restg),
id_Sales_Types_Father int NOT NULL,
id_Sales_Types_Father int NOT NULL,
type_ int NOT NULL DEFAULT 1
);


-- ------------------- QUERYS ----------------------
select * from person__Persons;
-- Clientes --
select p.id_person, c.id_Customer, t.descri as Tipo,
IF( p.buss_Name is NULL, concat(p.f_Name , p.m_Name,',',p.l_Name, p.o_Name), p.buss_Name) as Clientes
from entity__Customers c
left join entity__Customer_Types t on t.id_Customer_Type = c.id_Customer_Type
inner join person__Persons p on p.id_customer = c.id_customer ;

-- Users --
select p.id_person, c.id_User, c.post,
IF( p.buss_Name is NULL, concat(p.f_Name , p.m_Name,',',p.l_Name, p.o_Name), p.buss_Name) as Usuarios
from entity__users c
inner join person__Persons p on p.id_User = c.id_User ;

-- Provedores --
select p.id_person, r.id_Provider, r.ext, r.type_, t.descri as Tipo,
IF( p.buss_Name is NULL, concat(p.f_Name , p.m_Name,',',p.l_Name, p.o_Name), p.buss_Name) as Provedores
from entity__Providers r
left join entity__Prov_Types t on t.id_Prov_Type = r.id_Prov_Type
inner join person__Persons p on p.id_Provider = r.id_Provider ;

-- Vendedores --
select p.id_person, s.id_User, s.type_, 
CASE WHEN s.type_= 1 then 'UNO'
	 WHEN s.type_= 2 then 'DOS'
ELSE 'OTRO'
END as Types_,
s.comition, s.id_Territory,
IF ( p.buss_Name is NULL, concat(p.f_Name , p.m_Name,',' , p.l_Name, p.o_Name), p.buss_Name ) as Usuarios
from entity__Sales_Persons s
inner join person__Persons p on p.id_User = s.id_User;

-- Permisos por User --
select d.value_, p.name_, p.descri
from confg__permis_Det d
left join confg__permis p on p.id_Permis = d.id_Permis
where d.id_User= 5 and p.enabled= 1;

-- Addresses --
select * from person__addresses; 
select p.id_Person, a.addressLine1, a.loc, a.postalCode, c.descri as Ciudad, s.descri Estado, o.descri as Pais, t.descri as Estatus
from person__persons p
left join person__addresses a on a.id_Person = p.id_person
left join person__Addresses_Types t on t.id_addresses_Type = a.id_addresses_Type
left join person__Cities c on a.id_city = c.id_city
left join person__State_Provinces s on s.id_State_Province = c.id_State_Province 
left join person__Countries o on o.id_Country = s.id_Country
where p.id_person < 3;

-- Products --
select * from production__Products;
select p.id_Products, p.descri, p.prod_Code, p.repos_Price, p.currency, l.descri as Linea, f.descri as Familia, s.descri as SubFlia
from production__Products p
left join production__Lines l on l.id_line = p.id_Line
left join production__Flias f on f.id_flia = p.id_Flia
left join production__Sub_Flias s on s.id_sub_Flia = p.id_Sub_Flia;

-- Sales_Types --
select * from sales__sales_Types;
-- Para una restriccion del tipo de venta creamos dos registros uno con la venta a comparar y otro con el id que se trata de restringir.
-- Busco por id_Sales_Types en id_Sales_Types_Father sino esta lo creo. 
-- Busco todas las trestricciones que haya en id_Sales_Types_Father= id_Sales_Types AND type_= 1 (venta) type_= 0 cuando la venta es del provedor, o sea, una compra.alter


-- Tipos disponibles para los distintos tipos de venta configurados
select * from sales__sales_Types;
select t.type_, t.descri as Tipo, o.descri as modo_de_pago
from sales__sales_Types t
inner join operation__Pay_Conds o on o.id_Sales_Type = t.id_Sales_Type;

-- Tipos disponibles para los distintos tipos de Compra configurados
select * from production__Po_Types;
select t.descri as Tipo, o.descri as modo_de_pago
from production__Po_Types t
inner join operation__Pay_Conds o on o.id_Po_Type = t.id_Po_Type;

-- Los que tiene registros de configuracion es porque llevan corrida.
-- operation__Proj_Finans_Set;


-- Tipos de Compra que tienen opcion de compra credito a meses.
select o.id_Pay_Cond, t.descri as Tipo, o.descri as modo_de_pago, s.*
from production__Po_Types t
inner join operation__Pay_Conds o on o.id_Po_Type = t.id_Po_Type
inner join operation__Proj_Finans_Set s on s.id_Pay_Cond = o.id_Pay_Cond
where o.has_finans_Proj= 1;



-- Tipos de venta que tienen opcion de venta a credito a meses.
select * from sales__sales_Types;
select o.id_Pay_Cond, t.type_, t.descri as Tipo, o.descri as modo_de_pago, s.*
from sales__sales_Types t
inner join operation__Pay_Conds o on o.id_Sales_Type = t.id_Sales_Type
inner join operation__Proj_Finans_Set s on s.id_Pay_Cond = o.id_Pay_Cond
where o.has_Finans_Proj= 1;

-- Configurations of credit with Proj_Finans para un tipo de venta y seleccion de condicion de pago (a credito en este caso)
select * from operation__Proj_Finans_Set where id_Pay_Cond= 3;

-- Listado de la corrida financiera por credito a plazos
select * from operation__Proj_Finans;

-- Partidas que sean mayores al promedio.
select * from sales__Invoices_Det where price > (select avg(price) from sales__Invoices_Det);

-- Factura con el maximo precio
select max(price) from sales__Invoices_Det;


-- QUOTES with Payment Conditions --
select q.id_quote, q.status_, q.total, q.currency, q.start_Date, concat (q.tax,'%') as IVA, concat(s.comition, '%') as 'Comition(%)', 
concat(p.f_name,' ',p.m_name,', ',p.l_name, ' ',p.o_name) as SalesPerson,
id_how_Did_quote, y.descri as 'Pay Conditions', t.descri as 'Sales Type', q.id_Proj_Finan as Plazo
from sales__quotes q
left join entity__Sales_Persons s on s.id_SalesPerson = q.id_User
left join person__Persons p on p.id_SalesPerson = q.id_User
left join entity__Users u on u.id_User = q.id_how_Did_quote
left join operation__Pay_Conds y on y.id_Pay_Cond = q.id_Pay_Cond
left join sales__Sales_types t on t.id_Sales_Type = y.id_Sales_Type;

select * from sales__Quotes_Det;
-- Listado de los detalles de las Quotes --
select q.id_Quote_Det, q.id_Quote, q.prod_Code, q.id_Product, q.quantity, q.price, 
round(q.quantity * q.price, 2) as 'Sub Total', 
q.currency, q.descri, q.branch, q.model
from sales__Quotes_Det q
where q.id_Quote= 13 ;

select * from sales__quotes;
select * from production__Products;


-- Select que interactuan con cada uno de los resultadors de la subconsulta.
-- Que articulos se utilizado para cotizar --
select * from production__Products;
select prod_Code from sales__Quotes_det;
select p.id_Products, p.descri, p.prod_Code, p.repos_Price, p.currency, l.descri as Linea, f.descri as Familia, s.descri as SubFlia
from production__Products p 
left join production__Lines l on l.id_line = p.id_Line
left join production__Flias f on f.id_flia = p.id_Flia
left join production__Sub_Flias s on s.id_sub_Flia = p.id_Sub_Flia
where p.prod_Code IN (select prod_Code from sales__Quotes_det);


-- Select que interactual con un solo resultado escalar.
-- Partidas que sean mayores al promedio.
select * from sales__Invoices_Det where price > (select avg(price) from sales__Invoices_Det);


-- Select que interactuan con cada uno de los resultadors de la subconsulta.
-- Que articulos se utilizado para cotizar pero que el precio sea mayor a 500 --
select * from production__Products;
select prod_Code from sales__Quotes_det;
select p.id_Products, p.descri, p.prod_Code, p.repos_Price, p.currency, l.descri as Linea, f.descri as Familia, s.descri as SubFlia
from production__Products p 
left join production__Lines l on l.id_line = p.id_Line
left join production__Flias f on f.id_flia = p.id_Flia
left join production__Sub_Flias s on s.id_sub_Flia = p.id_Sub_Flia
where p.prod_Code IN 
(select prod_Code from sales__Quotes_det where (price * quantity) between 200 AND 501);


/* (comentario multilinea)  */
select id_Pay_Cond, descri,
CASE 
WHEN descri like '%credito%' then 'CREDITO'
WHEN descri like '%contado%' then 'CONTADO'
ELSE 'OTRO' 
END as 'Pay Condition'
from operation__Pay_Conds;




