#!/bin/sh

echo "uploading spark yarn archive"
cd ${SPARK_HOME}
tar -czvf spark-yarn-archive.tar.gz -C jars/ .
${HADOOP_HOME}/bin/hdfs dfs -put -f spark-yarn-archive.tar.gz /apps/spark/spark-yarn-archive.tar.gz
echo "finished uploading spark yarn archive"