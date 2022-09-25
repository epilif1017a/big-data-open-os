FROM hadoop-base:latest

COPY hadoop/bin/start-yarn-ts.sh $HADOOP_HOME/cbin/
RUN chmod 700 $HADOOP_HOME/cbin/start-yarn-ts.sh
RUN chown -R yarn:hadoop $HADOOP_HOME

RUN mkdir /yarn
RUN chown -R yarn:hadoop /yarn

# yarn.timeline-service.webapp.address
EXPOSE 8188
# yarn.timeline-service.webapp.https.address
EXPOSE 8190

USER yarn

ENTRYPOINT ${HADOOP_HOME}/cbin/start-yarn-ts.sh