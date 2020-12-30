create database AGENCE
on primary(
name=agence_data,
filename='C:\Users\bouti\OneDrive\سطح المكتب\Base De donne\Tp\Tp 4\Application\agence.mdf',
size=10MB
)
log on(
name=agence_log,
filename='C:\Users\bouti\OneDrive\سطح المكتب\Base De donne\Tp\Tp 4\Application\agence.ldf',
size=10MB
)
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
tel_c char(10) check(tel_c like '06%'),
nat_c varchar(15) default('Marocaine')
)

--la creation du table Location
create table [location](
num_c varchar(10),
num_v int,
dat_l date default getDate(),
nb_j int not null check(nb_j >0)
constraint fk_num_c_client foreign key(num_c) references client(num_c),
constraint fk_num_v_voiture foreign key(num_v) references voiture(num_v),
constraint pk_location primary key(num_c,num_v,dat_l)
)

-- 2 -	Insérer des jeux d’essai.
--          remplir la table voiture
insert into voiture values(2,'23k34',400,'Toyota',1)
insert into voiture values(3,'dcsv4',350,'Volkswangen',0)
insert into voiture values(4,'62k36',440,'Toyota',0)
insert into voiture values(5,'s53ky',270,'Mercesdes',1)
insert into voiture values(6,'3gkd4',420,'Volkswangen',1)
insert into voiture values(7,'532d7',440,'Ford',0)
insert into voiture values(8,'8s9d7',280,'Ford',0)
insert into voiture values(9,'555d7',300,'Ford',1)

--           remplir la table client
insert into client(num_c,adress_c,tel_c) values('C1','tidili msfioua imintghryist','0600004733')
insert into client(num_c,adress_c,tel_c) values('C2','tidili msfioua imintghryist','0600004734')
insert into client(num_c,adress_c,tel_c) values('C3','tidili msfioua tamgonsi','0600343774')
insert into client(num_c,adress_c,tel_c) values('C4','tidili msfioua agadir','0636004540')
insert into client(num_c,adress_c,tel_c) values('C5','tidili msfioua ighir nsbt','0603404743')

--           remplir la table location
insert into [location](num_c,num_v,nb_j) values('C1',4,3)
insert into [location](num_c,num_v,nb_j) values('C4',6,3)
insert into [location](num_c,num_v,nb_j) values('C1',2,5)
insert into [location](num_c,num_v,nb_j) values('C5',4,3)
insert into [location](num_c,num_v,nb_j) values('C4',6,3)
insert into [location](num_c,num_v,nb_j) values('C1',6,1)
insert into [location] values('C1',6,'2014-12-10',1)
insert into [location] values('C1',6,'2014-03-30',1)

-- 3 -	Afficher la liste des clients en ordre décroissant selon leur numéro.
select * from client order by num_c desc

-- 4 -	 Afficher la liste des locations effectuées pendant les 3 premières mois de l’année 2014.
select * from [location] where dat_l>='2014-01-01' and dat_l<='2016-12-30'

-- 5 -	 Quelle est la marque de voiture la plus louée en 2014 ? 
--               Les Etapes 
-- Etape 1 (Trouver le nombre des jours loue par chaque voiture)             table_1
select marque,sum(nb_j) as total_j from [location] l join voiture v
on v.num_v=l.num_v
where dat_l between '2014-01-01' and '2014-12-30'
group by marque

-- Etap 2 (Trouver le maximum de total_j dans la table precedent [table_1])         table_2
select max(loc.total_j) as maximum from (select marque,sum(nb_j) as total_j 
from [location] l join voiture v
on v.num_v=l.num_v
where dat_l between '2014-01-01' and '2014-12-30'
group by marque) loc

-- Etap 3 (Trouver les marque qui ont la meme sum(nb_j) que le maximum dans la table precedent [table_2])

select marque from [location] l join voiture v
on l.num_v=v.num_v
where dat_l between '2014-01-01' and '2014-12-30'
group by marque
having sum(nb_j)=(select max(loc.total_j) as maximum from (select marque,sum(nb_j) as total_j 
from [location] l join voiture v
on v.num_v=l.num_v
where dat_l between '2014-01-01' and '2014-12-30'
group by marque) loc)

-- 6 -	 Calculer le montant à payer pour une location.
select marque,(nb_j*tarif_h) as montant from [location] l join voiture v
on l.num_v=v.num_v

-- 7 -	Quel est le mois qui a marqué un maximum de location pendant l’année 2014 ?
select datepart(month,dat_l)as mois,sum(nb_j) from [location] 
group by datepart(month,dat_l)













SELECT DATEPART(Year, dat_l) Year, DATEPART(Month,dat_l ) Month, SUM(nb_j) nb
FROM [location]
GROUP BY DATEPART(Year, dat_l), DATEPART(Month, dat_l)
ORDER BY Year, Month



