# duração total de aluguel das bikes

select round(sum(duracao_segundos /60/60),2) as Duracao_horas
from cap06.tb_bikes;

# duração total ao longo do tempo
select duracao_segundos,
sum(duracao_segundos /60/60) over (order by data_inicio) as Duracao_total_horas
from cap06.tb_bikes;

# duração total do aluguel por estação, com data de inicio menor q 2012-01-08
select  estacao_inicio,
		duracao_segundos,
		sum(duracao_segundos /60/60) 
        over (partition by estacao_inicio order by data_inicio) as Duracao_total_horas
from cap06.tb_bikes
where data_inicio < '2012-01-08';

# Estatísticas

# Qual a média de tempo (em horas) de aluguel de bike da estação de início 31017?
select estacao_inicio,
avg(duracao_segundos/60/60) as media_tempo
from cap06.tb_bikes
where numero_estacao_inicio = 31017
group by estacao_inicio;

# Qual a média de tempo (em horas) de aluguel da estação de início 31017, ao longo do tempo (média móvel)?
select estacao_inicio,
avg(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as  media_tempo
from cap06.tb_bikes
where numero_estacao_inicio = 31017;

# Exercícios
# Retornar:
# Estação de início, data de início e duração de cada aluguel de bike em segundos
# Duração total de aluguel das bikes ao longo do tempo por estação de início
# Duração média do aluguel de bikes ao longo do tempo por estação de início
# Número de aluguéis de bikes por estação ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'


select 
estacao_inicio, 
data_inicio,
duracao_segundos,
sum(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as duracao_total_aluguel,
avg(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as media_aluguel,
count(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as total_aluguel
from cap06.tb_bikes
where data_inicio < '2012-01-08';



# Retornar:
# Estação de início, data de início de cada aluguel de bike e duração de cada aluguel em segundos
# Número de aluguéis de bikes (independente da estação) ao longo do tempo 
# Somente os registros quando a data de início for inferior a '2012-01-08'


select 
estacao_inicio,
data_inicio,
duracao_segundos,
row_number() over (order by data_inicio) as numero_de_alugueis
from cap06.tb_bikes
where data_inicio < '2012-01-08';

