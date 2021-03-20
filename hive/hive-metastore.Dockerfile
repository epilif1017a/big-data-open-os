FROM centos:centos8

ENV HIVE_VERSION=3.1.2
ENV HIVE_MAJOR_VERSION=3.1
ENV HIVE_HOME=/home/hive
ENV HADOOP_VERSION=3.2.2
ENV HADOOP_HOME=/hadoop
ENV JAVA_VERSION=1.8.0
ENV JAVA_HOME=/etc/alternatives/jre
ENV MYSQL_CONNECTOR_VERSION=8.0.21

WORKDIR $HADOOP_HOME

RUN yum update -y && \
    yum install -y java-${JAVA_VERSION}-openjdk wget && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar --strip-components 1 -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    rm -f hadoop-${HADOOP_VERSION}.tar.gz

WORKDIR $HIVE_HOME

RUN wget https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar --strip-components 1 -xzf apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    # avoid conflicting dependencies with hadoop disribution
    rm -f $HIVE_HOME/lib/guava* && \
    cp ${HADOOP_HOME}/share/hadoop/common/lib/guava* $HIVE_HOME/lib/ && \
    rm -f ${HADOOP_HOME}/share/hadoop/common/lib/slf4j-log4j* && \
    # avoid log-poluting mysql warnings while initiating the metastore
    sed -i 's/utf8/utf8mb4/g' $HIVE_HOME/scripts/metastore/upgrade/mysql/hive-schema-${HIVE_MAJOR_VERSION}*.mysql.sql

WORKDIR /tmp/mysql

RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz && \
    tar --strip-components 1 -xzf mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz && \
    cp ./mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar $HIVE_HOME/lib/ && \
    rm -rf /tmp/mysql

WORKDIR $HIVE_HOME
    
RUN groupadd -r hdfs && \
    useradd -r -g hdfs hive && \
    chown -R hive:hdfs $HIVE_HOME

COPY hive/bin/start-metastore.sh $HIVE_HOME/cbin/start-metastore.sh
RUN chmod 700 $HIVE_HOME/cbin/start-metastore.sh
RUN chown -R hive:hdfs $HIVE_HOME

COPY hive/conf/ $HIVE_HOME/conf/
COPY hadoop/conf/ $HADOOP_HOME/etc/hadoop/

USER hive

# Hive Metastore (thrift)
EXPOSE 9083

ENTRYPOINT $HIVE_HOME/cbin/start-metastore.sh