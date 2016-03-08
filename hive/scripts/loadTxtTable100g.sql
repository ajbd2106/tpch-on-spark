-- load local data to the tables on hdfs as text format
-- you should change local path stored table data
load data local inpath '/path/to/lineitem.tbl' into table tpch100g.lineitem;
load data local inpath '/path/to/part.tbl' into table tpch100g.part;
load data local inpath '/path/to/supplier.tbl' into table tpch100g.supplier;
load data local inpath '/path/to/partsupp.tbl' into table tpch100g.partsupp;
load data local inpath '/path/to/nation.tbl' into table tpch100g.nation;
load data local inpath '/path/to/region.tbl' into table tpch100g.region;
load data local inpath '/path/to/orders.tbl' into table tpch100g.orders;
load data local inpath '/path/to/customer.tbl' into table tpch100g.customer;

