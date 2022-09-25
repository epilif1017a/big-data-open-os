#!/bin/sh
${HADOOP_HOME}/bin/yarn --daemon start resourcemanager

tail -F ${HADOOP_HOME}/logs/hadoop-$(whoami)-resourcemanager-$(hostname).log | awk '{print} /FATAL/{exit}'