## contents
- [Overview](#overview)
- [Software Requirement](#software)
- [Setup](#setup)

---
## Overview
This instruction guides you to run Hive TPC-H queries on Spark.

## Software Requirement except Spark
- TPC-H (dbgen)
- Hadoop (HDFS)
- Hive
- RDBMS for Hive metastore (e.g. mysql, postgresql, etc.)
- JDBC driver for your Hive metastore

## Setup
### TPC-H dataset
1. Download

 You can download TPC-H tools from [here](http://www.tpc.org/tpc_documents_current_versions/download_programs/tools-download-request.asp?BM=TPC-H&mode=CURRENT-ONLY)

1. build ```dbgen```

1. run ```dbgen``` for generating TPC-H dataset

### Hadoop & Hive
1. setup Hadoop (HDFS)

1. prepare Hive metastore

 The following example shows how to setup mysql as hive metastore.
 ```
> mysql -u root -p
db> create database hivemetastore;
db> use hivemetastore;
db> source /path/to/hive/scripts/metastore/upgrade/mysql/hive-schema-0.13.0.mysql.sql
db> create user hive@localhost identified by 'hive';
db> grant all privileges on hivemetastore.* to hive@localhost;
db> flush privileges;
db> quit;
 ```

3. download jdbc driver

4. setup Hive
 - edit ```conf/hive-site.xml``` to connect hive metastore, and then copy it to ```$HIVE_HOME/conf```
 - copy jdbc-driver.jar to ```$HIVE_HOME/lib```
 - check whether Hive command works well  
 ```
 > $HIVE_HOME/bin/hive
 hive> ....
 hive> show databases;
 ```

 if 'default' daabase is shown, Hive setup is complete.


## Spark
1. copy ```hive-site.xml``` to ```$SPARK_HOME/conf```
1. launch spark master and slave
 ```
 > $SPARK_HOME/sbin/start-all.sh
 ```

1. launch thrift server
 ```
 > $SPARK_HOME/sbin/start-thriftserver.sh --driver-class-path /path/to/jdbc-driver.jar
 ```
1. check thriftserver runs without any exceptions.

### setup TPC-H dataset on Hive table
there are three steps, 1). creating tables, 2). loading txt data into tables, and 3). converting them into Parquet.

1. create TPC-H table on Hive
 ```
 > hive -f ./scripts/createTable10g.sql
 > hive -f ./scripts/createTable100g.sql
 ```

1. load TPC-H dataset to hive table as txt format
 ```
 > hive -f ./scripts/loadTxtTable10g.sql
 > hive -f ./scripts/loadTxtTable100g.sql
 ```

1. convert txt format table to parquet format table
 ```
 > $SPARK_HOME/bin/beeline -u jdbc:hive2://localhost:10000 -n hive -p hive -f ./scripts/convertParquetTable10g.sql
 > $SPARK_HOME/bin/beeline -u jdbc:hive2://localhost:10000 -n hive -p hive -f ./scripts/convertParquetTable100g.sql
 ```

## Run TPC-H queries through ThriftServer
 ```
 > SPARK_HOME/bin/beeline -u jdbc:hive2://localhost:10000 -n hive -p hive -f 100g/q1.sql
 ```
