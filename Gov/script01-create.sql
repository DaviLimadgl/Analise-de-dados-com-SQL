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

# Carregue o dataset1.csv via MySQL Workbench

# Tratamento de valor ausente

select distinct resolution
from cap08.tb_incidentes;

select resolution, count(*) as total
from cap08.tb_incidentes
group by resolution;

select count(*) 
from cap08.tb_incidentes
where resolution is null;

select count(*) 
from cap08.tb_incidentes
where resolution = ' ';

# null é o tipo unknown no banco de dados e empty (vazio) é o nulo em uma coluna do tipo string.
# o empty também é chamado de blank.

# a principal diferença entre nulo e vazio é que o nulo é usado para se referir a nada, enquanto o vazio é usado para 
# se referir a uma string única com comprimento zero.

select count(*) 
from cap08.tb_incidentes
where resolution = '';

select count(*) 
from cap08.tb_incidentes
where nullif(resolution, '') is null;

select count(*) 
from cap08.tb_incidentes
where trim(coalesce(resolution, '')) = '';

select count(*) 
from cap08.tb_incidentes 
where length(rtrim(ltrim(resolution))) = 0;

select isnull(nullif(resolution,''))  
from cap08.tb_incidentes;

select 
    case 
     when resolution = '' then 'other'
     else resolution
    end as resolution
from cap08.tb_incidentes;

set sql_safe_updates = 0;

update cap08.tb_incidentes
set resolution = 'other'
where resolution = '';

set sql_safe_updates = 1;




