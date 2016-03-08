-- create database
create database if not exists tpch100g;
create database if not exists tpch100g_parquet;

-- various settings for Hive and MR
-- for snappy compression codec
SET hive.exec.compress.intermediate=true;
SET hive.exec.compress.output=true;
SET mapred.map.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;
SET mapred.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;
SET mapred.output.compression.type=BLOCK;
-- for hdfs
-- SET dfs.replication=5;
-- 128MB
SET dfs.blocksize=134217728;

-- create all 8 tables in tpch100g
-- lineitem.tbl
create external table if not exists tpch100g.lineitem (L_ORDERKEY INT, L_PARTKEY INT, L_SUPPKEY INT, L_LINENUMBER INT, L_QUANTITY DOUBLE, L_EXTENDEDPRICE DOUBLE, L_DISCOUNT DOUBLE, L_TAX DOUBLE, L_RETURNFLAG STRING, L_LINESTATUS STRING, L_SHIPDATE STRING, L_COMMITDATE STRING, L_RECEIPTDATE STRING, L_SHIPINSTRUCT STRING, L_SHIPMODE STRING, L_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

-- part.tbl
create external table if not exists tpch100g.part (P_PARTKEY INT, P_NAME STRING, P_MFGR STRING, P_BRAND STRING, P_TYPE STRING, P_SIZE INT, P_CONTAINER STRING, P_RETAILPRICE DOUBLE, P_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

-- supplier.tbl
create external table if not exists tpch100g.supplier (S_SUPPKEY INT, S_NAME STRING, S_ADDRESS STRING, S_NATIONKEY INT, S_PHONE STRING, S_ACCTBAL DOUBLE, S_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

-- partsupp.tbl
create external table if not exists tpch100g.partsupp (PS_PARTKEY INT, PS_SUPPKEY INT, PS_AVAILQTY INT, PS_SUPPLYCOST DOUBLE, PS_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

-- nation.tbl
create external table if not exists tpch100g.nation (N_NATIONKEY INT, N_NAME STRING, N_REGIONKEY INT, N_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

-- region.tbl
create external table if not exists tpch100g.region (R_REGIONKEY INT, R_NAME STRING, R_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

-- orders.tbl
create external table if not exists tpch100g.orders (O_ORDERKEY INT, O_CUSTKEY INT, O_ORDERSTATUS STRING, O_TOTALPRICE DOUBLE, O_ORDERDATE STRING, O_ORDERPRIORITY STRING, O_CLERK STRING, O_SHIPPRIORITY INT, O_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

-- customer.tbl
create external table if not exists tpch100g.customer (C_CUSTKEY INT, C_NAME STRING, C_ADDRESS STRING, C_NATIONKEY INT, C_PHONE STRING, C_ACCTBAL DOUBLE, C_MKTSEGMENT STRING, C_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;


-- create all 8 tables in tpch100g as parquet format
-- lineitem.tbl
create external table if not exists tpch100g_parquet.lineitem (L_ORDERKEY INT, L_PARTKEY INT, L_SUPPKEY INT, L_LINENUMBER INT, L_QUANTITY DOUBLE, L_EXTENDEDPRICE DOUBLE, L_DISCOUNT DOUBLE, L_TAX DOUBLE, L_RETURNFLAG STRING, L_LINESTATUS STRING, L_SHIPDATE STRING, L_COMMITDATE STRING, L_RECEIPTDATE STRING, L_SHIPINSTRUCT STRING, L_SHIPMODE STRING, L_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- part.tbl
create external table if not exists tpch100g_parquet.part (P_PARTKEY INT, P_NAME STRING, P_MFGR STRING, P_BRAND STRING, P_TYPE STRING, P_SIZE INT, P_CONTAINER STRING, P_RETAILPRICE DOUBLE, P_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- supplier.tbl
create external table if not exists tpch100g_parquet.supplier (S_SUPPKEY INT, S_NAME STRING, S_ADDRESS STRING, S_NATIONKEY INT, S_PHONE STRING, S_ACCTBAL DOUBLE, S_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- partsupp.tbl
create external table if not exists tpch100g_parquet.partsupp (PS_PARTKEY INT, PS_SUPPKEY INT, PS_AVAILQTY INT, PS_SUPPLYCOST DOUBLE, PS_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- nation.tbl
create external table if not exists tpch100g_parquet.nation (N_NATIONKEY INT, N_NAME STRING, N_REGIONKEY INT, N_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- region.tbl
create external table if not exists tpch100g_parquet.region (R_REGIONKEY INT, R_NAME STRING, R_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- orders.tbl
create external table if not exists tpch100g_parquet.orders (O_ORDERKEY INT, O_CUSTKEY INT, O_ORDERSTATUS STRING, O_TOTALPRICE DOUBLE, O_ORDERDATE STRING, O_ORDERPRIORITY STRING, O_CLERK STRING, O_SHIPPRIORITY INT, O_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- customer.tbl
create external table if not exists tpch100g_parquet.customer (C_CUSTKEY INT, C_NAME STRING, C_ADDRESS STRING, C_NATIONKEY INT, C_PHONE STRING, C_ACCTBAL DOUBLE, C_MKTSEGMENT STRING, C_COMMENT STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- create all of tmp tables
-- q2
create table if not exists tpch100g.q2_minimum_cost_supplier_tmp1 (s_acctbal double, s_name string, n_name string, p_partkey int, ps_supplycost double, p_mfgr string, s_address string, s_phone string, s_comment string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q2_minimum_cost_supplier_tmp2 (p_partkey int, ps_min_supplycost double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.q2_minimum_cost_supplier_tmp1 (s_acctbal double, s_name string, n_name string, p_partkey int, ps_supplycost double, p_mfgr string, s_address string, s_phone string, s_comment string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q2_minimum_cost_supplier_tmp2 (p_partkey int, ps_min_supplycost double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- q4
create table if not exists tpch100g.q4_order_priority_tmp (o_orderkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g_parquet.q4_order_priority_tmp (o_orderkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- q7
create table if not exists tpch100g.q7_volume_shipping_tmp (supp_nation string, cust_nation string, s_nationkey int, c_nationkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g_parquet.q7_volume_shipping_tmp (supp_nation string, cust_nation string, s_nationkey int, c_nationkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- q11
create table if not exists tpch100g.q11_part_tmp (ps_partkey int, part_value double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q11_sum_tmp (total_value double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.q11_part_tmp (ps_partkey int, part_value double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q11_sum_tmp (total_value double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;


-- q15
create table if not exists tpch100g.revenue (supplier_no int, total_revenue double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.max_revenue (max_revenue double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.revenue (supplier_no int, total_revenue double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.max_revenue (max_revenue double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;


-- q16
create table if not exists tpch100g.q16_parts_supplier_relationship(p_brand string, p_type string, p_size int, supplier_cnt int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q16_tmp(p_brand string, p_type string, p_size int, ps_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.supplier_tmp(s_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.q16_parts_supplier_relationship(p_brand string, p_type string, p_size int, supplier_cnt int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q16_tmp(p_brand string, p_type string, p_size int, ps_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.supplier_tmp(s_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;


-- q17
create table if not exists tpch100g.q17_small_quantity_order_revenue (avg_yearly double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.lineitem_tmp (t_partkey int, t_avg_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.q17_small_quantity_order_revenue (avg_yearly double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.lineitem_tmp (t_partkey int, t_avg_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- q18
create table if not exists tpch100g.q18_tmp(l_orderkey int, t_sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q18_large_volume_customer(c_name string, c_custkey int, o_orderkey int, o_orderdate string, o_totalprice double, sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.q18_tmp(l_orderkey int, t_sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q18_large_volume_customer(c_name string, c_custkey int, o_orderkey int, o_orderdate string, o_totalprice double, sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- q19
create table if not exists tpch100g.q19_discounted_revenue(revenue double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g_parquet.q19_discounted_revenue(revenue double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- q20
create table if not exists tpch100g.q20_tmp1(p_partkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q20_tmp2(l_partkey int, l_suppkey int, sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q20_tmp3(ps_suppkey int, ps_availqty int, sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q20_tmp4(ps_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q20_potential_part_promotion(s_name string, s_address string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.q20_tmp1(p_partkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q20_tmp2(l_partkey int, l_suppkey int, sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q20_tmp3(ps_suppkey int, ps_availqty int, sum_quantity double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q20_tmp4(ps_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q20_potential_part_promotion(s_name string, s_address string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

-- q21
create table if not exists tpch100g.q21_tmp1(l_orderkey int, count_suppkey int, max_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q21_tmp2(l_orderkey int, count_suppkey int, max_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q21_suppliers_who_kept_orders_waiting(s_name string, numwait int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;

create table if not exists tpch100g_parquet.q21_tmp1(l_orderkey int, count_suppkey int, max_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q21_tmp2(l_orderkey int, count_suppkey int, max_suppkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q21_suppliers_who_kept_orders_waiting(s_name string, numwait int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;


-- q22
create table if not exists tpch100g.q22_customer_tmp(c_acctbal double, c_custkey int, cntrycode string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q22_customer_tmp1(avg_acctbal double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q22_orders_tmp(o_custkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;
create table if not exists tpch100g.q22_global_sales_opportunity(cntrycode string, numcust int, totacctbal double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS textfile;


create table if not exists tpch100g_parquet.q22_customer_tmp(c_acctbal double, c_custkey int, cntrycode string) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q22_customer_tmp1(avg_acctbal double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q22_orders_tmp(o_custkey int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;
create table if not exists tpch100g_parquet.q22_global_sales_opportunity(cntrycode string, numcust int, totacctbal double) ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS parquet;

