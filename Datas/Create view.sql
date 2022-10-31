## Criando a view

CREATE OR REPLACE VIEW db_datas.vw_rotas_mes_atual AS
    SELECT 
		## A função CONCAT ira concatenar os dados da coluna col_datas com o resultado da função weekday()
        ## A função date_format() converte o formato datetime, como está neste banco, para o tipo string em um formato especifico, nesta view
        ## Está convertendo o formato de data YYYY-mm-dd para dd-mm, onde o mês estará abreviado, exemplo outubro (out), e essa abreviação está sendo definida
        ## pelo caractere %b
        CONCAT(DATE_FORMAT(tb_rotas.col_datas, '%d-%b'),
                ' - ',
                ## Aqui usamos a expressão CASE para definir os nomes dos dias da semana
                CASE
					## Quando a função Weeday() na coluna col_datas for igual a zero então será segunda-feira e por diante
                    ## A função weekday() retorna o número da semana para uma determinada data, indo de 0 (segunda-feira) a 6 (domingo)
                    WHEN WEEKDAY(tb_rotas.col_datas) = 0 THEN 'Segunda-feira'
                    WHEN WEEKDAY(tb_rotas.col_datas) = 1 THEN 'Terça-feira'
                    WHEN WEEKDAY(tb_rotas.col_datas) = 2 THEN 'Quarta-feira'
                    WHEN WEEKDAY(tb_rotas.col_datas) = 3 THEN 'Quinta-feira'
                    WHEN WEEKDAY(tb_rotas.col_datas) = 4 THEN 'Sexta-feira'
                    WHEN WEEKDAY(tb_rotas.col_datas) = 5 THEN 'Sabado'
                    WHEN WEEKDAY(tb_rotas.col_datas) = 6 THEN 'Domingo'
                END) AS Data,
                ## o group_concat() concatenará dados da mesma coluna, neste caso a coluna col_tecnicos
                ## Esse agrupamento será separado por vírgula e haverá uma quebra de linha logo após a concatenação
                ## Isso é definido pelo SEPARATOR ',' e a quebra de linha pelo '\n', o mesmo acontecerá na coluna Lojas
        GROUP_CONCAT(DISTINCT tb_rotas.col_tecnicos SEPARATOR ', \n') AS 'Técnico Responsavel',
        GROUP_CONCAT(DISTINCT tb_rotas.col_lojas SEPARATOR ', \n') AS Lojas,
        tb_rotas.col_obs AS Observações
    FROM db_datas.tb_rotas
    ## Essa filtragem define que os resultados a serem exibidos serão deste ano, para isso foi usado a função YEAR() na coluna col_datas 
    ## E o ano ser recuperado, o atual, com a função CURDATE()
    WHERE YEAR(tb_rotas.col_datas) = YEAR(CURDATE())
			## Também precisa atender outra condição, que deve ser a do mes atual, onde definimos que o mês será definido pela função month() na coluna col_Datas
            ## E o mês atual a ser recuperado, com a função CURDATE()
            AND MONTH(tb_rotas.col_datas) = MONTH(CURDATE())
    ## aqui definimos que o agrupamento será por meio da coluna 1, neste caso a coluna concatenada que recebe o nome de Data e a ordenação do resultado também será por meio dela        
    GROUP BY 1
    ORDER BY 1;
    
    
    select * from db_datas.vw_rotas_mes_atual;
    
        
    ## Pivot se trata, a grosso modo, de inverter linhas para colunas, ou seja, dados que estão na horizontal serem passados para vertical
    ## Essa view faz um pivot na tabela rotas entre outras coisas
    CREATE OR REPLACE VIEW db_datas.vw_rota_semanal as
		SELECT 
			## Nesse agrupamento será concatenado os nomes distintos de técnicos
			GROUP_CONCAT(DISTINCT tb_rotas.col_tecnicos SEPARATOR ', \n') AS 'Técnicos',
			## Aqui começa o processo de pivot na tabela
            ## cada CASE se tornará uma coluna contendo o nome do dia da semana 
            ## A função weekday() retorna o número da semana para uma determinada data, indo de 0 (segunda-feira) a 6 (domingo)
			CASE WHEN WEEKDAY(tb_rotas.col_datas) = 0 THEN tb_rotas.col_lojas ELSE '' END AS 'Segunda-feira',
			CASE WHEN WEEKDAY(tb_rotas.col_datas) = 1 THEN tb_rotas.col_lojas ELSE '' END AS 'Terça-feira',
			CASE WHEN WEEKDAY(tb_rotas.col_datas) = 2 THEN tb_rotas.col_lojas ELSE '' END AS 'Quarta-feira',
			CASE WHEN WEEKDAY(tb_rotas.col_datas) = 3 THEN tb_rotas.col_lojas ELSE '' END AS 'Quinta-feira',
			CASE WHEN WEEKDAY(tb_rotas.col_datas) = 4 THEN tb_rotas.col_lojas ELSE '' END AS 'Sexta-feira',
			CASE WHEN WEEKDAY(tb_rotas.col_datas) = 5 THEN tb_rotas.col_lojas ELSE '' END AS 'Sabado',
			CASE WHEN WEEKDAY(tb_rotas.col_datas) = 6 THEN tb_rotas.col_lojas ELSE '' END AS 'Domingo'
		FROM db_datas.tb_rotas
        ## Essa filtragem define que os resultados a serem exibidos serão deste ano, para isso foi usado a função YEAR() na coluna col_datas 
		## E o ano ser recuperado, o atual, com a função CURDATE()
		WHERE YEAR(col_datas) = YEAR(CURDATE())
        ## O Agrupamento é feito da coluna 2 a 8 (segunda a domingo) e a ordenação pela coluna 1 (Tecnicos)
		GROUP BY 2,3,4,5,6,7,8
        ORDER BY 1;
        
        
        select * from db_datas.vw_rota_semanal;
        
        ## Função WEEKDAY(): Retorna o valor da semana para uma data. Ex.: 0 = segunda-feira;
        ## Função MONTH(): Retorna o valor do mês a partir de uma data. Ex.: 1 = janeiro;
        ## Função YEAR(): Retorna o ano a partir de uma data