## Cria um novo schema(banco de dados)
CREATE SCHEMA `db_datas` ;


## Define linguagem para portugês Brasil
SET lc_time_names = 'pt_Br';





## Criando a tabela rotas
CREATE TABLE db_datas.tb_rotas (
  col_id int(11) NOT NULL AUTO_INCREMENT,
  col_tecnicos varchar(45) DEFAULT NULL,
  col_lojas varchar(45) NOT NULL,
  col_datas datetime NOT NULL,
  col_alteradopor varchar(45) DEFAULT NULL,
  col_obs text DEFAULT NULL,
  PRIMARY KEY (col_id)
) ;

## Recupera todos os dados da tabela rotas
select * from db_datas.tb_rotas;