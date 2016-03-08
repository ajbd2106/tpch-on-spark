use tpch100g_parquet;

select c_count, count(1) as custdist
from (
   select c_custkey, count(o_orderkey) as c_count
     from
     customer c left outer join (
        select o_custkey, o_orderkey
        from orders where not o_comment like '%special%requests%'
     ) o on c.c_custkey = o.o_custkey     
   group by c_custkey
) c_orders
group by c_count
order by custdist desc, c_count desc;
