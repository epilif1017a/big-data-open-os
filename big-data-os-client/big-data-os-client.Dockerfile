FROM hadoop-base

ENV USER=hdfs
ENV SPARK_VERSION=3.4.1
ENV HADOOP_VERSION_SPARK=3
ENV HADOOP_VERSION=3.3.6
ENV HIVE_VERSION=3.1.3
ENV SPARK_HOME=/spark
ENV HIVE_HOME=/hive
ENV JAVA_VERSION=1.8.0
ENV JAVA_HOME=/etc/alternatives/jre

WORKDIR $HIVE_HOME

RUN wget https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar --strip-components 1 -xzf apache-hive-${HIVE_VERSION}-bin.tar.gz

WORKDIR $SPARK_HOME

RUN yum update -y && \
    yum install -y java-${JAVA_VERSION}-openjdk wget && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_SPARK}.tgz && \
    tar --strip-components 1 -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_SPARK}.tgz && \
    rm -f spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION_SPARK}.tgz

RUN chown -R ${USER}:hdfs $SPARK_HOME && \
    chown -R ${USER}:hdfs $HIVE_HOME && \
    chown -R ${USER}:hdfs $HADOOP_HOME

RUN mkdir /home/${USER}

COPY big-data-os-client/bin/ /home/${USER}/bin/
COPY hadoop/conf ${SPARK_HOME}/conf/hadoop
COPY spark/conf/*  ${SPARK_HOME}/conf/

RUN chown -R ${USER}:hdfs /home/${USER} && \
    chmod -R 700 /home/${USER}

USER $USER

# Spark Web UI
EXPOSE 4040

CMD /bin/bash
# You can create more images based on this one and change CMD to something suitable to your use case. E.g.:
# CMD ${SPARK_HOME}/bin/spark-submit --class org.apache.spark.examples.SparkPi ${SPARK_HOME}/examples/jars/spark-examples_2.12-3.0.1.jar
