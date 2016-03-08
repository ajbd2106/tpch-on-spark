use tpch100g_parquet;

select o_orderpriority, count(1) as order_count
from orders o join (
 select distinct l_orderkey
 from lineitem where l_commitdate < l_receiptdate
) t on o.o_orderkey = t.l_orderkey and o.o_orderdate >= '1993-07-01'
       and o.o_orderdate < '1993-10-01'
group by o_orderpriority
order by o_orderpriority;
