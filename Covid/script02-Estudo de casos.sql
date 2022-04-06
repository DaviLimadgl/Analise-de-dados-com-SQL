
# Total de Linhas das tabelas
select 
count(iso_code) 
from 
cap07.covid_mortes;

select 
count(iso_code) 
from 
cap07.covid_vacinacao;

# ordernar por nome da coluna ou numero da coluna

select * 
from
cap07.covid_mortes
order by 
location, date;

select * 
from
cap07.covid_mortes
order by 
3,4;

# remover segurança do mysql para updates sem filtros
set sql_safe_updates= 0;

# atualiza o formato de data de toda a tabela 
update cap07.covid_mortes
set date = str_to_date(date, '%d/%m/%y');

update cap07.covid_vacinacao
set date = str_to_date(date, '%d/%m/%y');

# analise univariada

#media de mortos por localização
select location,
avg(total_deaths) as media_mortos
from cap07.covid_mortes
group by location
order by 2 desc;

select location,
avg(total_deaths) as media_mortos,
avg(new_cases) as media_novos_casos
from cap07.covid_mortes
group by location
order by 2 desc;

#analise multvariada
# proporção de mortes em relação ao toltal no brasil
select date,
location,
total_cases,
total_deaths,
(total_deaths / total_cases) * 100 as  percentual
from cap07.covid_mortes
where location = 'Brazil'
order by 2,1;


#--------

# paises com maior numero de mortes

# query nao retorna o resultado correto, pois a coluna e do tipo texto
select
location,
max(total_deaths) as Maior_numero_de_mortes
from cap07.covid_mortes
where continent is not null
group by location
order by 2 desc;

# frunciona mas é gambiarra
select
location,
max(total_deaths * 1) as Maior_numero_de_mortes
from cap07.covid_mortes
where continent is not null
group by location
order by 2 desc;

# forma correta
select
location,
max(cast(total_deaths as unsigned)) as Maior_numero_de_mortes
from cap07.covid_mortes
where continent is not null
group by location
order by 2 desc;

# continentes com maior numero de mortes

select
continent,
max(cast(total_deaths as unsigned)) as Maior_numero_de_mortes
from cap07.covid_mortes
where continent is not null
group by continent
order by 2 desc;


#percentual de mortes por dia

select date,
sum(cast(new_cases as unsigned)) as total_casos,
sum(cast(new_deaths as unsigned)) as total_mortes,
(sum(cast(new_deaths as unsigned)) / sum(new_cases)) * 100 as percentual_mortes
from cap07.covid_mortes
where continent is not null
group by date
order by 1,2; 

