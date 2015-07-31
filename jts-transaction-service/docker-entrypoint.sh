#!/bin/sh

set -e

export HOST_IP=$(grep "${HOSTNAME}" /etc/hosts | awk '{print $1}')
[ -z "$JACORB_NAME_SERVER_IP" ] && export JACORB_NAME_SERVER_IP=$(grep 'name-server' /etc/hosts | awk '{print $1}')
[ -z "$JACORB_NAME_SERVER_URL" ] && export JACORB_NAME_SERVER_URL="corbaloc::${JACORB_NAME_SERVER_IP}:${JACORB_NAME_SERVER_ENV_NAME_SERVER_PORT}/StandardNS/NameServer-POA/_root"
[ -z "$NARAYANA_OPTS" ] && export NARAYANA_OPTS=""

echo "Starting Narayana Transaction Service container on ${HOST_IP}:${NARAYANA_PORT}"
echo "NARAYANA_OPTS=$NARAYANA_OPTS"
echo "JACORB_NAME_SERVER_URL=$JACORB_NAME_SERVER_URL"

for i in /opt/jboss/lib/*.jar
do
    export EXT_CLASSPATH="$EXT_CLASSPATH:$i"
done

exec "$@"
