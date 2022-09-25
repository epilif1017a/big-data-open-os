FROM hadoop-base:latest

COPY hadoop/bin/start-hdfs-dn.sh $HADOOP_HOME/cbin/
RUN chmod 700 $HADOOP_HOME/cbin/start-hdfs-dn.sh
RUN chown -R hdfs:hadoop $HADOOP_HOME

RUN mkdir /hdfs
RUN chown -R hdfs:hadoop /hdfs

# dfs.datanode.http.address
EXPOSE 9864
# dfs.datanode.https.address
EXPOSE 9865
# dfs.datanode.address
EXPOSE 9866
# dfs.datanode.ipc.address
EXPOSE 9867

USER hdfs

ENTRYPOINT ${HADOOP_HOME}/cbin/start-hdfs-dn.sh