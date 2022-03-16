SELECT * FROM deliverybr.tb_hubs;


## mysql --local-infile=1 -u root -p

# Execute:
SET GLOBAL local_infile = true;
# Carrega os dados


CREATE TABLE `tb_canais` (
  `channel_id` int DEFAULT NULL,
  `channel_name` text COLLATE utf8mb4_unicode_ci,
  `channel_type` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


## onde o /D:/DSA/SQL/2-Scripts-Cap05/archive (1)/channels.csv deve ser mudado para o endereço do arquivo em seu computador

LOAD DATA LOCAL INFILE '/D:/DSA/SQL/2-Scripts-Cap05/archive (1)/channels.csv' INTO TABLE `deliverybr`.`tb_canais` CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE `tb_hubs` (
  `hub_id` int DEFAULT NULL,
  `hub_name` text COLLATE utf8mb4_unicode_ci,
  `hub_city` text COLLATE utf8mb4_unicode_ci,
  `hub_state` text COLLATE utf8mb4_unicode_ci,
  `hub_latitude` double DEFAULT NULL,
  `hub_longitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOAD DATA LOCAL INFILE '/D:/DSA/SQL/2-Scripts-Cap05/archive (1)/hubs.csv' INTO TABLE `deliverybr`.`tb_hubs` CHARACTER SET utf8mb4 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


# Cria a tabela
CREATE TABLE `deliverybr`.`stores` (
  `store_id` int DEFAULT NULL,
  `hub_id` int DEFAULT NULL,
  `store_name` text,
  `store_segment` text,
  `store_plan_price` int DEFAULT NULL,
  `store_latitude` text,
  `store_longitude` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE 'D:/DSA/SQL/2-Scripts-Cap05/archive (1)/stores.csv' INTO TABLE `deliverybr`.`stores` CHARACTER SET UTF8 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `deliverybr`.`drivers` (
  `driver_id` int DEFAULT NULL,
  `driver_modal` text,
  `driver_type` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE 'D:/DSA/SQL/2-Scripts-Cap05/archive (1)/drivers.csv' INTO TABLE `deliverybr`.`drivers` CHARACTER SET UTF8 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `deliverybr`.`deliveries` (
  `delivery_id` int DEFAULT NULL,
  `delivery_order_id` int DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `delivery_distance_meters` int DEFAULT NULL,
  `delivery_status` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE 'D:/DSA/SQL/2-Scripts-Cap05/archive (1)/deliveries.csv' INTO TABLE `deliverybr`.`deliveries` CHARACTER SET UTF8 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `deliverybr`.`payments` (
  `payment_id` int DEFAULT NULL,
  `payment_order_id` int DEFAULT NULL,
  `payment_amount` double DEFAULT NULL,
  `payment_fee` double DEFAULT NULL,
  `payment_method` text,
  `payment_status` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE 'D:/DSA/SQL/2-Scripts-Cap05/archive (1)/payments.csv' INTO TABLE `deliverybr`.`payments` CHARACTER SET UTF8 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria a tabela
CREATE TABLE `deliverybr`.`orders` (
  `order_id` int DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `payment_order_id` int DEFAULT NULL,
  `delivery_order_id` int DEFAULT NULL,
  `order_status` text,
  `order_amount` double DEFAULT NULL,
  `order_delivery_fee` int DEFAULT NULL,
  `order_delivery_cost` text,
  `order_created_hour` int DEFAULT NULL,
  `order_created_minute` int DEFAULT NULL,
  `order_created_day` int DEFAULT NULL,
  `order_created_month` int DEFAULT NULL,
  `order_created_year` int DEFAULT NULL,
  `order_moment_created` text,
  `order_moment_accepted` text,
  `order_moment_ready` text,
  `order_moment_collected` text,
  `order_moment_in_expedition` text,
  `order_moment_delivering` text,
  `order_moment_delivered` text,
  `order_moment_finished` text,
  `order_metric_collected_time` text,
  `order_metric_paused_time` text,
  `order_metric_production_time` text,
  `order_metric_walking_time` text,
  `order_metric_expediton_speed_time` text,
  `order_metric_transit_time` text,
  `order_metric_cycle_time` text);

# Carrega os dados
LOAD DATA LOCAL INFILE 'D:/DSA/SQL/2-Scripts-Cap05/archive (1)/orders.csv' INTO TABLE `deliverybr`.`orders` CHARACTER SET UTF8 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;