SELECT nome_navio, classificacao_risco, pontuacao_risco,indice_conformidade,temporada 
FROM cap02.tb_navios
where  classificacao_risco in ('A', 'B') and  indice_conformidade > 90
order by pontuacao_risco ;

SELECT nome_navio, classificacao_risco, pontuacao_risco,indice_conformidade,temporada 
FROM cap02.tb_navios
where  indice_conformidade > 90 and pontuacao_risco = 0 and mes_ano = '04/2018'
order by indice_conformidade 
limit 10;

## menor performance 
SELECT nome_navio, classificacao_risco, pontuacao_risco,indice_conformidade,temporada 
FROM cap02.tb_navios
where  indice_conformidade in ( SELECT indice_conformidade
				FROM cap02.tb_navios
				where  indice_conformidade > 90 )
                                and pontuacao_risco = 0 
                                and mes_ano = '04/2018' 
order by indice_conformidade ;

/**
1-Quaisembarcações possuem pontuação de riscoigual a 310?
2-Quais embarcações têmclassificação de riscoA e índice de conformidade maior ouigual a 95%?
3-Quais embarcações têmclassificação de riscoCou De índice de conformidade menorouigual a 95%?
4-Quais embarcações têmclassificação de riscoA oupontuação de risco igual a 0?
5-[DESAFIO]Quais embarcações foram inspecionadas em Dezembro de 2016?

**/
## 1
SELECT nome_navio, pontuacao_risco FROM cap02.tb_navios
where  pontuacao_risco = 310;

## 2
SELECT nome_navio, classificacao_risco, indice_conformidade  FROM cap02.tb_navios
where  classificacao_risco = 'A' 
and indice_conformidade >= 95;

## 3
SELECT nome_navio, classificacao_risco, indice_conformidade  FROM cap02.tb_navios
where  classificacao_risco in ('C', 'D') 
and indice_conformidade <= 95;

## 4

SELECT nome_navio, classificacao_risco, indice_conformidade  FROM cap02.tb_navios
where  classificacao_risco = 'A'  
or pontuacao_risco = 0;

## 5 

SELECT nome_navio, mes_ano  FROM cap02.tb_navios
where temporada like '%Dezembro 2016';

