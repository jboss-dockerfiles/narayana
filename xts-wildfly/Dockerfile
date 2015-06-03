# Use latest jboss/wildfly image as the base
FROM jboss/wildfly:8.2.0.Final

# Make standalone-xts.xml configuration default
RUN cp $JBOSS_HOME/docs/examples/configs/standalone-xts.xml $JBOSS_HOME/standalone/configuration/standalone.xml
