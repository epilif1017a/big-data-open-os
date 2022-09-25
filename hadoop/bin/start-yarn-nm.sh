#!/bin/sh
${HADOOP_HOME}/bin/yarn --daemon start nodemanager

tail -F ${HADOOP_HOME}/logs/hadoop-$(whoami)-nodemanager-$(hostname).log | awk '{print} /FATAL/{exit}'