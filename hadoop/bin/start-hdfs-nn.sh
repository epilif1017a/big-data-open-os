#!/bin/sh
if [[ $1 == "--format" ]] || [[ $1 == "-f" ]]; then
    echo "formating namenode..."
    $HADOOP_HOME/bin/hdfs namenode -format $CLUSTER_NAME
fi

${HADOOP_HOME}/bin/hdfs --daemon start namenode

tail -F ${HADOOP_HOME}/logs/hadoop-$(whoami)-namenode-$(hostname).log | awk '{print} /FATAL/{exit}'