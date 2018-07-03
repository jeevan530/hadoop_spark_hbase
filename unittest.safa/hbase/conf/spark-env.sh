#!/usr/bin/env bash
export SPARK_MASTER_IP=127.0.0.1
export SPARK_MASTER_PORT=7077

export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
export SPARK_CLASSPATH=/opt/hbase/lib/*

export STANDALONE_SPARK_MASTER_HOST=`hostname`
export SPARK_MASTER_IP=$STANDALONE_SPARK_MASTER_HOST
export SPARK_LAUNCH_WITH_SCALA=0
export SPARK_LIBRARY_PATH=/opt/spark/lib
export SPARK_MASTER_WEBUI_PORT=18080

export SPARK_WORKER_PORT=7078
export SPARK_WORKER_WEBUI_PORT=18081
export SPARK_WORKER_DIR=/var/run/spark/work
export SPARK_LOG_DIR=/var/log/spark
export SPARK_PID_DIR='/var/run/spark/'
if [ -n "$HADOOP_HOME" ]; then
  export LD_LIBRARY_PATH=:/opt/hadoop/lib/native
fi

if [[ -d $SPARK_HOME/python ]]
then
    for i in 
    do
        SPARK_DIST_CLASSPATH=${SPARK_DIST_CLASSPATH}:$i
    done
fi

