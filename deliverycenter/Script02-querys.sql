
## select nas tabelas
SELECT * FROM deliverybr.stores;
SELECT * FROM deliverybr.payments;
SELECT * FROM deliverybr.orders;
SELECT * FROM deliverybr.drivers;
SELECT * FROM deliverybr.deliveries;
SELECT * FROM deliverybr.tb_canais;
SELECT * FROM deliverybr.tb_hubs;

## total de registro em cada tabela
SELECT count(store_id) FROM deliverybr.stores;
SELECT count(payment_id) FROM deliverybr.payments;
SELECT count(order_id) FROM deliverybr.orders;
SELECT count(driver_id) FROM deliverybr.drivers;
SELECT count(delivery_id) FROM deliverybr.deliveries;
SELECT count(channel_id) FROM deliverybr.tb_canais;
SELECT count(hub_id) FROM deliverybr.tb_hubs;


## Exercicios

# 1- Qual o número de hubs por cidade?
# 2- Qual o número de pedidos (orders) por status?
# 3- Qual o número de lojas (stores) por cidade dos hubs?
# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?
# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?
# 6- Qual a distância média das entregas por tipo de driver (driver_modal)?
# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
# 10- Quantos pagamentos foram cancelados (chargeback)?
# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?
# 12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
# 13- Quais métodos de pagamento tiveram valor médio superior a 100?
# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?
# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)? Demonstre os totais intermediários e formate o resultado.
# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
# 19- Em que data houve a maior média de valor do pedido (order_amount)? Dica: Pesquise e use a função SUBSTRING().
# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)? Dica: Use a função SUBSTRING().

## Solução

# 1- Qual o número de hubs por cidade?

select hub_city, count(hub_name) as contagem
from deliverybr.tb_hubs
group by hub_city
order by contagem desc;




# 2- Qual o número de pedidos (orders) por status?

select order_status as situacao, count(order_id) as numero_pedidos
from deliverybr.orders
group by order_status;



# 3- Qual o número de lojas (stores) por cidade dos hubs?

select hub_city as cidades, count(store_id) as numero_lojas
from deliverybr.tb_hubs h, deliverybr.stores s 
where h.hub_id = s.hub_id
group by hub_city
order by numero_lojas desc;

# 4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?

select max(payment_amount) as pagamento from deliverybr.payments;
select min(payment_amount) as pagamento from deliverybr.payments;

# 5- Qual tipo de driver (driver_type) fez o maior número de entregas?

select driver_type, count(delivery_id) as numero_entregas
from deliverybr.deliveries d, deliverybr.drivers dr
where dr.driver_id = d.driver_id
group by driver_type
order by numero_entregas desc;

# 6- Qual a distância média das entregas por tipo de driver (driver_modal)?

select driver_modal, round(avg(delivery_distance_meters),2) as distancia_media
from deliverybr.deliveries d, deliverybr.drivers dr
where dr.driver_id = d.driver_id
group by driver_modal;

# 7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?

select store_name, round(avg(order_amount),2) as media_pedido
from deliverybr.orders o, deliverybr.stores s 
where s.store_id = o.store_id
group by store_name
order by media_pedido desc;

# 8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?

select coalesce(store_name, "Sem Loja") as loja, count(order_id) as contagem
from deliverybr.orders o 
left join deliverybr.stores s 
on s.store_id = o.store_id
group by store_name
order by contagem desc;

# 9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?

select round(sum(order_amount),2) as total
from deliverybr.orders o, deliverybr.tb_canais c
where c.channel_id = o.channel_id
and channel_name = 'FOOD PLACE';

# 10- Quantos pagamentos foram cancelados (chargeback)?

select count(payment_status) as total, payment_status as situacao
from deliverybr.payments
where payment_status = 'chargeback';

# 11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?

select round(avg(payment_amount),2) as media, payment_status as situacao
from deliverybr.payments
where payment_status = 'chargeback'
order by payment_status;


# 12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?


select round(avg(payment_amount),2) as media, payment_method as metodo_pagamento
from deliverybr.payments
group by metodo_pagamento
order by media desc;

# 13- Quais métodos de pagamento tiveram valor médio superior a 100?
select round(avg(payment_amount),2) as media, payment_method as metodo_pagamento
from deliverybr.payments
group by metodo_pagamento
having media > 100
order by media desc;

# 14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
select hub_state, store_segment, channel_type, round(avg(order_amount),2) as media
from deliverybr.orders o, deliverybr.stores s, deliverybr.tb_canais c, deliverybr.tb_hubs h
where s.store_id = o.store_id
and c.channel_id = o.channel_id
and h.hub_id = s.hub_id
group by hub_state, store_segment, channel_type
order by hub_state;


# 15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?

select hub_state, store_segment, channel_type, round(avg(order_amount),2) as media
from deliverybr.orders o, deliverybr.stores s, deliverybr.tb_canais c, deliverybr.tb_hubs h
where s.store_id = o.store_id
and c.channel_id = o.channel_id
and h.hub_id = s.hub_id
group by hub_state, store_segment, channel_type
having media > 450
order by hub_state;

# 16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)? Demonstre os totais intermediários e formate o resultado.

select 
	if(grouping(hub_state), 'Total HUB State', hub_state) as hub_state,
    if(grouping(store_segment), 'Total Segmento', store_segment) as store_segment,
    if(grouping(channel_type), 'Total tipo Canal', channel_type) as channel_type, 
    round(sum(order_amount),2) as total
from deliverybr.orders o, deliverybr.stores s, deliverybr.tb_canais c, deliverybr.tb_hubs h
where s.store_id = o.store_id
and c.channel_id = o.channel_id
and h.hub_id = s.hub_id
group by hub_state, store_segment, channel_type with rollup;


# 17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?

select hub_state, store_segment, channel_type, round(avg(order_amount),2) as media
from deliverybr.orders o, deliverybr.stores s, deliverybr.tb_canais c, deliverybr.tb_hubs h
where s.store_id = o.store_id
and c.channel_id = o.channel_id
and h.hub_id = s.hub_id
and order_status = 'CANCELED'
and channel_type = 'MARKETPLACE'
and store_segment = 'FOOD' 
and hub_state = 'RJ'
group by hub_state, store_segment, channel_type;



# 18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?

select hub_state, store_segment, channel_type, round(sum(order_amount),2) as soma
from deliverybr.orders o, deliverybr.stores s, deliverybr.tb_canais c, deliverybr.tb_hubs h
where s.store_id = o.store_id
and c.channel_id = o.channel_id
and h.hub_id = s.hub_id
and order_status = 'CANCELED'
and channel_type = 'MARKETPLACE'
and store_segment = 'GOOD' 
group by hub_state, store_segment, channel_type
having soma > 100000;

# 19- Em que data houve a maior média de valor do pedido (order_amount)? Dica: Pesquise e use a função SUBSTRING().

select substring(order_moment_created, 1, 9) as data_pedido,
round(avg(order_amount),2) as media
from deliverybr.orders o 
group by data_pedido
order by media desc;

# 20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)? Dica: Use a função SUBSTRING().

select substring(order_moment_created, 1, 9) as data_pedido,
min(order_amount) as minimo
from deliverybr.orders o 
group by data_pedido
having minimo = 0
order by data_pedido asc;

