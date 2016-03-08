use tpch100g_parquet;

select nation, o_year, sum(amount) as sum_profit
from (
  select n_name as nation, substr(o_orderdate, 1, 4) as o_year,
         l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
  from (
    select l_extendedprice, l_discount, l_quantity, l_orderkey, n_name, ps_supplycost
    from ( 
      select l_extendedprice, l_discount, l_quantity, l_partkey, l_orderkey, n_name, ps_supplycost
      from (
        select ps_suppkey, ps_partkey, ps_supplycost, n_name
        from (
          select s_suppkey, n_name
          from nation n join supplier s on n.n_nationkey = s.s_nationkey
        ) s1 join partsupp ps on s1.s_suppkey = ps.ps_suppkey
      ) s2 join lineitem l on s2.ps_suppkey = l.l_suppkey and s2.ps_partkey = l.l_partkey   
    ) l2 join part p on p.p_name like '%green%' and p.p_partkey = l2.l_partkey
  ) l3 join orders o on o.o_orderkey = l3.l_orderkey
) profilt
group by nation, o_year
order by nation, o_year desc;
