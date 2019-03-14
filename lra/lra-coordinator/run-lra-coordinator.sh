#!/bin/sh

# settings taken from redhat-jdk/redhat-jdk image
export JAVA_OPTS=${JAVA_OPTS:-"-XX:+UseParallelOldGC -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=20 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MaxMetaspaceSize=100m -XX:+ExitOnOutOfMemoryError"}

# showing the java settings at the start of the lra coordinator
EXEC="java $JAVA_OPTS -Dswarm.logging=$LOG_LEVEL -Dswarm.transactions.object-store-path="$OBJECT_STORE_PATH" -jar"
echo "Starting: $EXEC $@"

exec $EXEC "$@"
