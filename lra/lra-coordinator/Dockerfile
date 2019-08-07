FROM jboss/base-jdk:8
MAINTAINER Ondrej Chaloupka <ochaloup@redhat.com>
EXPOSE 8080

# using jboss user as one java jar is started under
USER root
RUN mkdir /data \
  && chown -R jboss /data \
  && usermod -g root -G `id -g jboss` jboss \
  && chmod -R "g+rwX" /data \
  && chown -R jboss:root /data
RUN mkdir /deployments \
  && chown -R jboss /deployments \
  && chmod -R "g+rwX" /deployments \
  && chown -R jboss:root /deployments
USER jboss

ARG NARAYANA_VERSION=5.9.3.Final
RUN curl -LOk https://www.jboss.org/jbosstm/downloads/${NARAYANA_VERSION}/binary/narayana-full-${NARAYANA_VERSION}-bin.zip \
    && unzip -j narayana-full-${NARAYANA_VERSION}-bin.zip narayana-full-${NARAYANA_VERSION}/rts/lra/lra-coordinator-thorntail.jar -d /deployments/ \
    && rm narayana-full-$NARAYANA_VERSION-bin.zip

COPY run-lra-coordinator.sh /deployments

# expected values INFO, DEBUG, TRACE...
ENV LOG_LEVEL="INFO"
# path to the data directory (persistent volume)
ENV OBJECT_STORE_PATH="/data"

ENTRYPOINT ["/bin/sh", "/deployments/run-lra-coordinator.sh"]
CMD [ "/deployments/lra-coordinator-thorntail.jar" ]
