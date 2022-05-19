select * from cap09.tb_global_qualidade_ar;

# 1- Quais poluentes foram considerados na pesquisa?

select distinct 
pollutant from 
cap09.tb_global_qualidade_ar; 


# 2- Qual foi a média de poluição ao longo do tempo provocada pelo poluente ground-level ozone (o3)?

select 
country as pais,
pollutant as poluente,
cast(timestamp as date) as data_coleta,
round(avg(value) over( partition by country order by cast(timestamp as date)),2) as media_movel
from cap09.tb_global_qualidade_ar
where pollutant = "o3"
order by 1,3;

# 3- Qual foi a média de poluição causada pelo poluente ground-level ozone (o3) por país medida em µg/m³ (microgramas por metro cúbico)?


select 
country as pais,
pollutant as poluente,
unit as unidade,
round(avg(value),2) as media
from cap09.tb_global_qualidade_ar
where unit = "µg/m³"
and pollutant = "o3"
group by 1,2
order by 1;


# 4- Considerando o resultado anterior, qual país teve maior índice de poluição geral por o3, Itália (IT) ou Espanha (ES)? Por quê?

select 
country as pais,
pollutant as poluente,
unit as unidade,
round(avg(value),2) as media,
round(stddev(value),3) as desvio_padrao,
max(value) as valor_maximo,
min(value) as valor_minimo,
(stddev(value) / round(avg(value),2))* 100 as CV 
from cap09.tb_global_qualidade_ar
where unit = "µg/m³"
and pollutant = "o3"
and country in('IT', 'ES')
group by 1,2
order by 1;

# 5- Quais localidades e países tiveram média de poluição em 2020 superior a 100 µg/m³ para o poluente fine particulate matter (pm25)?


