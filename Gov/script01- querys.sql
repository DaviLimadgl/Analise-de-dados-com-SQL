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


#analisando tabela crianças

select * from cap08.tb_criancas;

#verificando o desvio padrão
select avg(idade) as media_idade, stddev(idade) as desvio_padrao_idade
from cap08.tb_criancas;

select avg(idade) as media_idade, stddev(idade) as desvio_padrao_idade 
from cap08.tb_criancas 
where idade < 5;

select avg(peso) as media_peso, stddev(peso) as desvio_padrao_peso
from cap08.tb_criancas;

select avg(peso) as media_peso, stddev(peso) as desvio_padrao_peso 
from cap08.tb_criancas 
where idade < 5;

select * from cap08.tb_criancas order by idade;

# calcula a mediana da variável idade
# a tabela precisa estar ordenada
set @rowindex := -1;
 
select
   avg(idade) as mediana 
from
   (select @rowindex:=@rowindex + 1 as rowindex, cap08.tb_criancas.idade as idade
    from cap08.tb_criancas
    order by cap08.tb_criancas.idade) as d
where d.rowindex in (floor(@rowindex / 2), ceil(@rowindex / 2));

select * from cap08.tb_criancas order by peso;

# calcula a mediana da variável peso
set @rowindex := -1;
 
select
   avg(peso) as mediana 
from
   (select @rowindex:=@rowindex + 1 as rowindex, cap08.tb_criancas.peso as peso
    from cap08.tb_criancas
    order by cap08.tb_criancas.peso) as d
where d.rowindex in (floor(@rowindex / 2), ceil(@rowindex / 2));

# resolve o problema do outlier com imputação da mediana
set sql_safe_updates = 0;

update cap08.tb_criancas
set idade = 3
where idade = 42;

update cap08.tb_criancas
set peso = 15
where peso = 98;

set sql_safe_updates = 1;

select avg(idade) as media_idade, stddev(idade) as desvio_padrao_idade
from cap08.tb_criancas;

select avg(peso) as media_peso, stddev(peso) as desvio_padrao_peso
from cap08.tb_criancas;


select pdid, category
from cap08.tb_incidentes_dup
group by pdid, category;

select pdid, category, count(*)
from cap08.tb_incidentes_dup
group by pdid, category;

select *
from cap08.tb_incidentes_dup
where pdid = 11082415274000;

# identificando os registros duplicados (e retornando uma linha para duplicidade)
select pdid, category, count(*) as numero
from cap08.tb_incidentes_dup
group by pdid, category
having numero > 1;

# identificando os registros duplicados (e retornando cada linha em duplicidade)
select pdid, category
from cap08.tb_incidentes_dup
where pdid in (select pdid from cap08.tb_incidentes_dup group by pdid having count(*) > 1)
order by pdid;

# identificando os registros duplicados (e retornando uma linha para duplicidade) com função window
select *
from (
 select primeiro_resultado.*,      
        row_number() over (partition by pdid, category order by pdid) as numero
 from cap08.tb_incidentes_dup as primeiro_resultado) as segundo_resultado
where numero > 1;

# identificando os registros duplicados com cte (tabela temporária)
with cte_table
as
(
 select pdid, category, row_number() over(partition by pdid, category order by pdid) as contagem 
 from cap08.tb_incidentes_dup
)
select * from cte_table where contagem > 1;

# deletando os registros duplicados com cte
set sql_safe_updates = 0;

with cte_table
as
(
 select pdid, category, row_number() over(partition by pdid, category order by pdid) as contagem 
 from cap08.tb_incidentes_dup
)
delete from cap08.tb_incidentes_dup 
using cap08.tb_incidentes_dup 
join cte_table on cap08.tb_incidentes_dup.pdid = cte_table.pdid
where cte_table.contagem > 1; 

set sql_safe_updates = 1;

# deletando os registros duplicados com subquery
set sql_safe_updates = 0;

delete from cap08.tb_incidentes_dup
where 
    pdid in (
    select pdid 
    from (
        select                         
            pdid, row_number() over (partition by pdid, category order by pdid) as row_num
        from cap08.tb_incidentes_dup) alias
    where row_num > 1
);

select * from cap08.tb_alunos
order by email;

select email, count(email) as contagem
from cap08.tb_alunos
group by email
having contagem > 1;
    
set sql_safe_updates = 0;

# selfie join, junção na mesma tabela com alias diferentes para excluir registros duplicados sem deletar todos os registros duplicados

use cap08;
delete n1 
from tb_alunos n1, tb_alunos n2 
where n1.id > n2.id 
and n1.email = n2.email;

set sql_safe_updates = 1;

select email, count(email) as contagem
from cap08.tb_alunos
group by email
having contagem > 1;


