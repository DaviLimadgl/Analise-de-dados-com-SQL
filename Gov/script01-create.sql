# Script 01
create schema cap08;
use cap08;
# Cria a tabela
CREATE TABLE cap08.TB_INCIDENTES (
  `PdId` bigint DEFAULT NULL,
  `IncidntNum` text,
  `Incident Code` text,
  `Category` text,
  `Descript` text,
  `DayOfWeek` text,
  `Date` text,
  `Time` text,
  `PdDistrict` text,
  `Resolution` text,
  `Address` text,
  `X` double DEFAULT NULL,
  `Y` double DEFAULT NULL,
  `location` text,
  `SF Find Neighborhoods 2 2` text,
  `Current Police Districts 2 2` text,
  `Current Supervisor Districts 2 2` text,
  `Analysis Neighborhoods 2 2` text,
  `DELETE - Fire Prevention Districts 2 2` text,
  `DELETE - Police Districts 2 2` text,
  `DELETE - Supervisor Districts 2 2` text,
  `DELETE - Zip Codes 2 2` text,
  `DELETE - Neighborhoods 2 2` text,
  `DELETE - 2017 Fix It Zones 2 2` text,
  `Civic Center Harm Reduction Project Boundary 2 2` text,
  `Fix It Zones as of 2017-11-06  2 2` text,
  `DELETE - HSOC Zones 2 2` text,
  `Fix It Zones as of 2018-02-07 2 2` text,
  `CBD, BID and GBD Boundaries as of 2017 2 2` text,
  `Areas of Vulnerability, 2016 2 2` text,
  `Central Market/Tenderloin Boundary 2 2` text,
  `Central Market/Tenderloin Boundary Polygon - Updated 2 2` text,
  `HSOC Zones as of 2018-06-05 2 2` text,
  `OWED Public Spaces 2 2` text,
  `Neighborhoods 2` text
);


# Cria a tabela
CREATE TABLE cap08.TB_CRIANCAS(nome varchar(20), idade int, peso float);

# Insere os dados
INSERT INTO cap08.TB_CRIANCAS 
VALUES ('Bob', 3, 15), ('Maria', 42, 98), ('Julia', 3, 16), ('Maximiliano', 2, 12), ('Roberto', 1, 11), ('Jamil', 2, 14), ('Alberto', 3, 17);

# Script 03

# Cria a tabela
CREATE TABLE cap08.TB_INCIDENTES_DUP (
  `PdId` bigint DEFAULT NULL,
  `IncidntNum` text,
  `Incident Code` text,
  `Category` text,
  `Descript` text,
  `DayOfWeek` text,
  `Date` text,
  `Time` text,
  `PdDistrict` text,
  `Resolution` text,
  `Address` text,
  `X` double DEFAULT NULL,
  `Y` double DEFAULT NULL,
  `location` text,
  `SF Find Neighborhoods 2 2` text,
  `Current Police Districts 2 2` text,
  `Current Supervisor Districts 2 2` text,
  `Analysis Neighborhoods 2 2` text,
  `DELETE - Fire Prevention Districts 2 2` text,
  `DELETE - Police Districts 2 2` text,
  `DELETE - Supervisor Districts 2 2` text,
  `DELETE - Zip Codes 2 2` text,
  `DELETE - Neighborhoods 2 2` text,
  `DELETE - 2017 Fix It Zones 2 2` text,
  `Civic Center Harm Reduction Project Boundary 2 2` text,
  `Fix It Zones as of 2017-11-06  2 2` text,
  `DELETE - HSOC Zones 2 2` text,
  `Fix It Zones as of 2018-02-07 2 2` text,
  `CBD, BID and GBD Boundaries as of 2017 2 2` text,
  `Areas of Vulnerability, 2016 2 2` text,
  `Central Market/Tenderloin Boundary 2 2` text,
  `Central Market/Tenderloin Boundary Polygon - Updated 2 2` text,
  `HSOC Zones as of 2018-06-05 2 2` text,
  `OWED Public Spaces 2 2` text,
  `Neighborhoods 2` text
);

# Carregue o dataset2.csv via MySQL Workbench

# Cria a tabela
CREATE TABLE cap08.TB_ALUNOS (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL
);

# Insere os dados
INSERT INTO cap08.TB_ALUNOS (nome, sobrenome, email) 
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net'),
       ('Jean','King','jean.king@me.com'),
       ('Peter','Ferguson','peter.ferguson@google.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com'),
       ('Julie','Murphy','julie.murphy@yahoo.com'),
       ('Kwai','Lee','kwai.lee@google.com'),
       ('Jean','King','jean.king@me.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com');





