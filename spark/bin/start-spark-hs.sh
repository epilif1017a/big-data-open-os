#!/bin/sh

${SPARK_HOME}/sbin/start-history-server.sh

tail -F ${SPARK_HOME}/logs/spark--org.apache.spark.deploy.history.HistoryServer-1-$(hostname).out | awk '{print} /FATAL/{exit}'