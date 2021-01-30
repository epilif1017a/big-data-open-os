FROM hadoop-base:latest

COPY hadoop/bin/start-yarn-nm.sh $HADOOP_HOME/cbin/
RUN chmod 700 $HADOOP_HOME/cbin/start-yarn-nm.sh
RUN chown -R yarn:hadoop $HADOOP_HOME

RUN mkdir /yarn
RUN chown -R yarn:hadoop /yarn

# yarn.nodemanager.webapp.address
EXPOSE 8042
# yarn.nodemanager.webapp.https.address
EXPOSE 8044

USER yarn

ENTRYPOINT ${HADOOP_HOME}/cbin/start-yarn-nm.sh