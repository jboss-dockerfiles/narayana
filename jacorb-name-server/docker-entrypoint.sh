#!/bin/sh

set -e

echo "Starting JacORB Name Server container on $(grep "${HOSTNAME}" /etc/hosts | awk '{print $1}'):${NAME_SERVER_PORT}"

exec "$@"
