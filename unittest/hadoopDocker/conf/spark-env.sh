export SPARK_WORKER_MEMORY=1g
export SPARK_WORKER_INSTANCES=1
export SPARK_MASTER_IP=127.0.0.1
export SPARK_MASTER_PORT=7077
export SPARK_WORKER_DIR=/app/spark/tmp

# Options read in YARN client mode

export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
export SPARK_EXECUTOR_INSTANCES=1
export SPARK_EXECUTOR_CORES=1
export SPARK_EXECUTOR_MEMORY=1G
export SPARK_DRIVER_MEMORY=1G
export SPARK_YARN_APP_NAME=Spark
export SPARK_CLASSPATH=/opt/hbase/lib/*
