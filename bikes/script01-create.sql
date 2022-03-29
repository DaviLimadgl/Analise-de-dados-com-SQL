# Cria a tabela
CREATE TABLE cap06.TB_BIKES (
  `duracao_segundos` int DEFAULT NULL,
  `data_inicio` text,
  `data_fim` text,
  `numero_estacao_inicio` int DEFAULT NULL,
  `estacao_inicio` text,
  `numero_estacao_fim` int DEFAULT NULL,
  `estacao_fim` text,
  `numero_bike` text,
  `tipo_membro` text);
  
  
 # Carga de dados via linha de comando

# Conecte no MySQL via linha de comando
 mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;


# Carrega os dados
LOAD DATA LOCAL INFILE 'D:/DSA/SQL/11-Scripts-Cap06/2012-capitalbikeshare-tripdata/2012Q1-capitalbikeshare-tripdata.csv' INTO TABLE `cap06`.`TB_BIKES` CHARACTER SET UTF8 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
