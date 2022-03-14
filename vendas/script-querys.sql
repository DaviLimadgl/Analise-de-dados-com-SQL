SELECT * FROM cap05.tb_clientes;

SELECT COUNT(id_cliente), cidade_cliente
FROM cap05.TB_CLIENTES
GROUP BY cidade_cliente;

select sum(p.valor_pedido * 0.10) as comissao, v.nome_vendedor as nome_vendedor, c.estado_cliente as estado
from tb_pedidos p
join tb_clientes c
on p.id_cliente= c.id_cliente
and c.estado_cliente ='CE'
join tb_vendedor v
on p.id_vendedor = v.id_vendedor
group by nome_vendedor, estado
order by nome_vendedor;


select 
case
when sum(p.valor_pedido * 0.10)   is null then 0
else sum(p.valor_pedido * 0.10)
end as comissao,
v.nome_vendedor as nome_vendedor, c.estado_cliente as estado
from tb_pedidos p
join tb_clientes c
on p.id_cliente= c.id_cliente
and c.estado_cliente ='CE'
join tb_vendedor v
on p.id_vendedor = v.id_vendedor
group by nome_vendedor, estado
order by nome_vendedor;

select p.valor_pedido  as comissao, v.nome_vendedor as nome_vendedor, c.estado_cliente as estado
from tb_pedidos p
join tb_clientes c
on p.id_cliente= c.id_cliente
right join tb_vendedor v
on p.id_vendedor = v.id_vendedor
order by nome_vendedor;


select 
case
when p.valor_pedido is null then 'Sem resultado'
else p.valor_pedido
end as pedido ,
v.nome_vendedor as nome_vendedor,
case
when c.estado_cliente is null then 'Sem resultado'
else c.estado_cliente
end as estado
from tb_pedidos p
join tb_clientes c
on p.id_cliente= c.id_cliente
and c.estado_cliente ='SP'
right join tb_vendedor v
on p.id_vendedor = v.id_vendedor
and p.valor_pedido > 600
group by nome_vendedor, estado
order by nome_vendedor;


select count(p.id_cliente) as total, c.estado_cliente
from tb_pedidos p, tb_clientes c
where p.id_cliente = c.id_cliente
group by c.estado_cliente
having total > 5;


select if(grouping(ano), 'total por ano', ano) as ano, sum(faturamento) as faturamento
from cap05.tb_vendas
group by ano with rollup ;
