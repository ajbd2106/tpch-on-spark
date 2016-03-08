use tpch100g_parquet;

select sum(l_extendedprice) / 7.0 as avg_yearly
from (
  select l_quantity, l_extendedprice, t_avg_quantity
   from (
     select b.tt_partkey as t_partkey, b.tt_avg_quantity as t_avg_quantity
     from (
       select l_partkey as tt_partkey, 0.2 * avg(l_quantity) as tt_avg_quantity
       from lineitem where l_partkey <= 5000000 group by l_partkey
     UNION ALL
       select l_partkey as tt_partkey, 0.2 * avg(l_quantity) as tt_avg_quantity
       from lineitem where l_partkey > 5000000 AND l_partkey <= 10000000 group by l_partkey
     UNION ALL
       select l_partkey as tt_partkey, 0.2 * avg(l_quantity) as tt_avg_quantity
       from lineitem where l_partkey > 10000000 AND l_partkey <= 15000000 group by l_partkey
     UNION ALL
       select l_partkey as tt_partkey, 0.2 * avg(l_quantity) as tt_avg_quantity
       from lineitem where l_partkey > 15000000 group by l_partkey
     ) b
   ) t join (
       select l_quantity, l_partkey, l_extendedprice
       from (
	select p_partkey, p_brand, p_container
        from part p
          where p.p_brand = 'Brand#23'
          and p.p_container = 'MED BOX'
	limit 20100
       ) pp, lineitem l where pp.p_partkey = l.l_partkey
   ) l1 on l1.l_partkey = t.t_partkey
) a where l_quantity < t_avg_quantity;

