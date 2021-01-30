#!/bin/sh
${HADOOP_HOME}/bin/yarn --daemon start timelineserver

tail -F ${HADOOP_HOME}/logs/hadoop-$(whoami)-timelineserver-$(hostname).log | awk '{print} /FATAL/{exit}'