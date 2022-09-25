#!/bin/sh
${HADOOP_HOME}/bin/hdfs --daemon start namenode

tail -F ${HADOOP_HOME}/logs/hadoop-$(whoami)-namenode-$(hostname).log | awk '{print} /FATAL/{exit}'