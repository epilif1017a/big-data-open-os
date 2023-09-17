FROM fedora:36

ENV SPARK_VERSION=3.4.1
ENV HADOOP_VERSION_SPARK=3
ENV SPARK_HOME=/spark
ENV JAVA_VERSION=1.8.0
ENV JAVA_HOME=/etc/alternatives/jre

WORKDIR $SPARK_HOME

RUN yum update -y && \
    yum install -y java-${JAVA_VERSION}-openjdk wget zip && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_SPARK}.tgz && \
    tar --strip-components 1 -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_SPARK}.tgz && \
    rm -f spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_SPARK}.tgz
    
COPY spark/bin/ $SPARK_HOME/cbin/
RUN chmod -R 700 $SPARK_HOME/cbin

RUN groupadd -r hdfs && \
    useradd -r -g hdfs spark && \
    chown -R spark:hdfs $SPARK_HOME

USER spark

COPY hadoop/conf ${SPARK_HOME}/conf/hadoop
COPY spark/conf/*  ${SPARK_HOME}/conf/

# spark.history.ui.port 
EXPOSE 18080

ENTRYPOINT $SPARK_HOME/cbin/start-spark-hs.sh
