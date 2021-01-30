#!/bin/sh
${HADOOP_HOME}/bin/hdfs --daemon start datanode

tail -F ${HADOOP_HOME}/logs/hadoop-$(whoami)-datanode-$(hostname).log | awk '{print} /FATAL/{exit}'