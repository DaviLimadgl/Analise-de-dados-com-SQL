## binarização 0/1

## seleçoes
SELECT * FROM cap03.tb_dados;
SELECT count(*) FROM cap03.tb_dados2;
SELECT * FROM cap03.tb_dados2;
SELECT * FROM cap03.tb_dados3;
select distinct classe from cap03.tb_dados;
SELECT distinct menopausa FROM cap03.tb_dados2;
SELECT distinct deg_malig FROM cap03.tb_dados4;
SELECT * FROM cap03.tb_dados5;

## updates nos registros
update cap03.tb_dados2 set  menopausa =  ( 
select 
	case
		when menopausa = 'premeno' then 0
        when menopausa = 'ge40' then 1
        when menopausa = 'lt40' then 2
        
        end as menopausa
        from cap03.tb_dados2);

## binarizando os dados
create table cap03.tb_dados2 as
select 
	case
		when classe = 'no-recurrence-events' then 0
        when classe = 'recurrence-events' then 1
        
        end as classe,
        idade,
        menopausa,
        case
		when tamanho_tumor = '0-4'  or tamanho_tumor = '5-9' then 'Muito Pequeno'
		when tamanho_tumor = '10-14'  or tamanho_tumor = '15-19' then 'pequeno'
		when tamanho_tumor = '20-24'  or tamanho_tumor = '25-29' then 'Medio'
		when tamanho_tumor = '30-34'  or tamanho_tumor = '35-39' then 'Grande'
		when tamanho_tumor = '40-44'  or tamanho_tumor = '45-49' then 'Muito GRande'
		when tamanho_tumor = '50-54'  or tamanho_tumor = '55-59' then 'Tratamento Urgente'

        
        end as tamanho_tumor,
        inv_nodes,
        	case
		when node_caps = 'no' then 0
        when node_caps = 'yes' then 1
        else 2
        end as node_caps,
        deg_malig,
case
		when seio = 'left' then 'E'
        when seio = 'right' then 'D'
        
        end as seio,
        case
		when quadrante = 'left_low'   then 1
		when quadrante = 'right_up' then 2
		when quadrante = 'left_up' then 3
		when quadrante = 'right_low' then 4
		when quadrante = 'central' then 5
        else 0
	
        
        end as quadrante,
	case
		when irradiando = 'no' then 0
        when irradiando = 'yes' then 1
        
        end as irradiando
 from cap03.tb_dados;



## exercicio 1
create table cap03.tb_dados3 as select
classe,
idade  ,
 
	case
		when menopausa = 'premeno' then 1
        when menopausa = 'ge40' then 2
        when menopausa = 'lt40' then 3
        
        end as menopausa
        , 
tamanho_tumor , 
inv_nodes ,
node_caps , 
deg_malig  ,
seio  ,
quadrante ,
irradiando
	
 from cap03.tb_dados2;

## exercício 2
create table cap03.tb_dados4 as select
classe,
idade  ,
menopausa, 
tamanho_tumor , 
concat(inv_nodes, '-', quadrante) as posicao_tumor,
node_caps , 
deg_malig  ,
seio  ,
irradiando
from cap03.tb_dados3;

## exercício 3
create table cap03.tb_dados5 as select
classe,
idade  ,
menopausa, 
tamanho_tumor , 
posicao_tumor,
node_caps , 
case when deg_malig = 1 then 1 else 0 end as  deg_malig_cat1,
case when deg_malig = 2 then 1 else 0 end as deg_malig_cat2,
case when deg_malig = 3 then 1 else 0 end as deg_malig_cat3,
seio  ,
irradiando
from cap03.tb_dados4;

	

