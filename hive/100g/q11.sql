use tpch100g_parquet;

insert overwrite table q11_part_tmp
select ps_partkey, sum(ps_supplycost * ps_availqty) as part_value
from 
 nation n join supplier s on s.s_nationkey = n.n_nationkey and n.n_name = 'GERMANY'
 join partsupp ps on ps.ps_suppkey = s.s_suppkey
 group by ps_partkey;

select ps_partkey, part_value
from (
  select ps_partkey, part_value, total_value
  from (
    select sum(part_value) as total_value
    from q11_part_tmp
  ) st, q11_part_tmp
) a
where part_value > total_value * 0.000001
order by part_value desc;
