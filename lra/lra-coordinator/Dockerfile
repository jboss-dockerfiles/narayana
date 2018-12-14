#FROM redhat-openjdk-18/openjdk18-openshift
FROM jboss/base-jdk:8
MAINTAINER Ondrej Chaloupka <ochaloup@redhat.com>
EXPOSE 8080

# using jboss user as one java jar is started under
USER root
RUN mkdir /data
RUN chown -R jboss /data \
  && usermod -g root -G `id -g jboss` jboss \
  && chmod -R "g+rwX" /data \
  && chown -R jboss:root /data
RUN mkdir /deployments
RUN chown -R jboss /deployments \
  && chmod -R "g+rwX" /deployments \
  && chown -R jboss:root /deployments
USER jboss

RUN curl -LOk https://www.jboss.org/jbosstm/downloads/5.9.3.Final-SNAPSHOT/binary/narayana-full-5.9.3.Final-SNAPSHOT-bin.zip 
RUN unzip -j narayana-full-5.9.3.Final-SNAPSHOT-bin.zip narayana-full-5.9.3.Final-SNAPSHOT/rts/lra/lra-coordinator-swarm.jar -d /deployments/
RUN rm narayana-full-5.9.3.Final-SNAPSHOT-bin.zip

# expected values INFO, DEBUG, TRACE...
ENV LOG_LEVEL="INFO"
# path to the data directory (persistent volume)
ENV OBJECT_STORE_PATH="../../data"
ADD run-java-options /opt/

ENV AB_JOLOKIA_OFF true
ENV JAVA_APP_JAR lra-coordinator-swarm.jar
