FROM hadoop-base:latest

COPY hadoop/bin/start-hdfs-nn.sh $HADOOP_HOME/cbin/
RUN chmod 700 $HADOOP_HOME/cbin/start-hdfs-nn.sh
RUN chown -R hdfs:hadoop $HADOOP_HOME

RUN mkdir /hdfs
RUN mkdir /hdfs/nn
RUN chown -R hdfs:hadoop /hdfs

# dfs.namenode.http-address
EXPOSE 9870
# dfs.namenode.https-address
EXPOSE 9871
# dfs.namenode.rpc-address
EXPOSE 9000

USER hdfs

RUN $HADOOP_HOME/bin/hdfs namenode -format $CLUSTER_NAME

ENTRYPOINT ${HADOOP_HOME}/cbin/start-hdfs-nn.sh