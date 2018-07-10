#!/bin/sh

set -e

[ -z "$JACORB_NAME_SERVER_IP" ] && export JACORB_NAME_SERVER_IP=$(grep 'jacorb-name-server' /etc/hosts | head -n 1 | awk '{print $1}')
[ -z "$JACORB_NAME_SERVER_URL" ] && export JACORB_NAME_SERVER_URL="corbaloc::${JACORB_NAME_SERVER_IP}:${JACORB_NAME_SERVER_ENV_NAME_SERVER_PORT}/StandardNS/NameServer-POA/_root"
[ -z "$NARAYANA_OPTS" ] && export NARAYANA_OPTS=""
[ "x$PROXY_IP" != "x" ] && sed -i "s/#jacorb.ior_proxy_host=1.2.3.4/jacorb.ior_proxy_host=${PROXY_IP}/g" $NARAYANA_HOME/jacorb/etc/jacorb.properties

echo "NARAYANA_OPTS=$NARAYANA_OPTS"

for i in /opt/jboss/lib/*.jar
do
    export EXT_CLASSPATH="$EXT_CLASSPATH:$i"
done

exec "$@"
