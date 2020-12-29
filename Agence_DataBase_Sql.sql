create database AGENCE
use AGENCE

-- la creation du table voiture

create table voiture(
num_v int check(Num_v>0) primary key, 
maticule varchar(10),
tarif_h money check(tarif_h>=250 and tarif_h<=500),
marque varchar(15) check(marque in ('Toyota','Volkswangen','Mercesdes','Ford')),
disponible bit 
)

--la creation du table Client
create table client(
num_c varchar(10) primary key,
adress_c varchar(50),
tel_c varchar(15),
nat_c varchar(15) default('Marocaine')
)

--la creation du table Location
create table [location](
num_c varchar(10),
num_v int,
dat_l date default(getDate()),
nb_j int check(nb_j >0)
constraint fk_num_c_client foreign key(num_c) references client(num_c),
constraint fk_num_v_voiture foreign key(num_v) references voiture(num_v),
constraint pk_location primary key(num_c,num_v,dat_l)
)

