use tpch100g_parquet;

select c_name,c_custkey,o_orderkey,o_orderdate,o_totalprice,sum(l_quantity)
 from (
    select c_name,c_custkey,o_orderkey,o_orderdate,o_totalprice
      from
        customer c join orders o 
        on c.c_custkey = o.o_custkey
        join (
          select l_orderkey, t_sum_quantity from (
            select l_orderkey, sum(l_quantity) as t_sum_quantity
              from lineitem where l_orderkey <= 200000000 group by l_orderkey
            UNION ALL
            select l_orderkey, sum(l_quantity) as t_sum_quantity
              from lineitem where l_orderkey > 200000000 AND l_orderkey <= 400000000 group by l_orderkey
            UNION ALL
            select l_orderkey, sum(l_quantity) as t_sum_quantity
              from lineitem where l_orderkey > 400000000 group by l_orderkey
          ) b
        ) t 
          on o.o_orderkey = t.l_orderkey and t.t_sum_quantity > 300
    limit 7000
 ) aa join lineitem l 
   on aa.o_orderkey = l.l_orderkey
 group by aa.c_name,aa.c_custkey,aa.o_orderkey,aa.o_orderdate,aa.o_totalprice
 order by aa.o_totalprice desc, aa.o_orderdate
 limit 100;

