FROM centos:centos8

ENV CLUSTER_NAME=big-data-os
ENV HADOOP_VERSION=3.2.2
ENV HADOOP_HOME=/hadoop
ENV HADOOP_MAPRED_HOME=/hadoop
ENV JAVA_VERSION=1.8.0
ENV JAVA_HOME=/etc/alternatives/jre

WORKDIR $HADOOP_HOME

RUN yum update -y && \
    yum install -y java-${JAVA_VERSION}-openjdk wget && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar --strip-components 1 -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    rm -f hadoop-${HADOOP_VERSION}.tar.gz

COPY hadoop/conf/ $HADOOP_HOME/etc/hadoop/

RUN groupadd -r hadoop && \
    groupadd -r hdfs && \
    useradd -r -g hadoop -G hdfs hdfs && \
    useradd -r -g hadoop yarn && \
    useradd -r -g hadoop mapred && \
    useradd -r -g hadoop -G hdfs spark && \
    useradd -r -g hadoop -G hdfs hive