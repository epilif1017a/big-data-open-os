FROM hadoop-base:latest

COPY hadoop/bin/start-yarn-rm.sh $HADOOP_HOME/cbin/
RUN chmod 700 $HADOOP_HOME/cbin/start-yarn-rm.sh
RUN chown -R yarn:hadoop $HADOOP_HOME

RUN mkdir /yarn
RUN chown -R yarn:hadoop /yarn

# yarn.resourcemanager.scheduler.address
EXPOSE 8030
# yarn.resourcemanager.resource-tracker.address
EXPOSE 8031
# yarn.resourcemanager.address
EXPOSE 8032
# yarn.resourcemanager.webapp.address
EXPOSE 8088
# yarn.resourcemanager.webapp.https.address
EXPOSE 8090

USER yarn

ENTRYPOINT ${HADOOP_HOME}/cbin/start-yarn-rm.sh