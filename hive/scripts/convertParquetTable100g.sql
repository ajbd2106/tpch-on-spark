-- various settings for Hive and MR
-- for snappy compression codec
SET hive.exec.compress.intermediate=true;
SET hive.exec.compress.output=true;
SET mapred.map.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;
SET mapred.output.compression.codec=org.apache.hadoop.io.compress.SnappyCodec;
SET mapred.output.compression.type=BLOCK;
-- for hdfs
--SET dfs.replication=5;
-- 128MB
SET dfs.blocksize=134217728;
-- exec mr jobs (convert text table to parquet table)
insert overwrite table tpch100g_parquet.lineitem select * from tpch100g.lineitem;
insert overwrite table tpch100g_parquet.part select * from tpch100g.part;
insert overwrite table tpch100g_parquet.supplier select * from tpch100g.supplier;
insert overwrite table tpch100g_parquet.partsupp select * from tpch100g.partsupp;
insert overwrite table tpch100g_parquet.nation select * from tpch100g.nation;
insert overwrite table tpch100g_parquet.region select * from tpch100g.region;
insert overwrite table tpch100g_parquet.orders select * from tpch100g.orders;
insert overwrite table tpch100g_parquet.customer select * from tpch100g.customer;
