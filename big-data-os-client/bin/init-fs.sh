#!/bin/sh

# ----- YARN -----

echo "creating folders for timeline service..."
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tmp
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tmp/entity-file-history
${HADOOP_HOME}/bin/hdfs dfs -mkdir /tmp/entity-file-history/active
${HADOOP_HOME}/bin/hdfs dfs -chown yarn:hadoop /tmp/entity-file-history/active
${HADOOP_HOME}/bin/hdfs dfs -chmod 777 /tmp

echo "creating folders for apps and app logs..."
${HADOOP_HOME}/bin/hdfs dfs -mkdir /apps
${HADOOP_HOME}/bin/hdfs dfs -mkdir /apps/spark
${HADOOP_HOME}/bin/hdfs dfs -chmod -R 755 /apps
${HADOOP_HOME}/bin/hdfs dfs -mkdir /app-logs
${HADOOP_HOME}/bin/hdfs dfs -chmod 777 /app-logs
${HADOOP_HOME}/bin/hdfs dfs -chown yarn:hadoop /app-logs

# ----- User Management -----

echo "creating folders for users..."
${HADOOP_HOME}/bin/hdfs dfs -mkdir /user
${HADOOP_HOME}/bin/hdfs dfs -mkdir /user/hdfs
${HADOOP_HOME}/bin/hdfs dfs -mkdir /user/spark
${HADOOP_HOME}/bin/hdfs dfs -chown spark:hdfs /user/spark

# ----- SPARK -----

echo "creating folders for spark history..."
${HADOOP_HOME}/bin/hdfs dfs -mkdir /spark-history
${HADOOP_HOME}/bin/hdfs dfs -chmod 777 /spark-history
${HADOOP_HOME}/bin/hdfs dfs -chown spark:hadoop /spark-history

echo "creating folders for spark/hive warehouse..."
${HADOOP_HOME}/bin/hdfs dfs -mkdir /warehouse
${HADOOP_HOME}/bin/hdfs dfs -chmod 775 /warehouse
${HADOOP_HOME}/bin/hdfs dfs -chown spark:hdfs /warehouse

echo "finished initializing file system"