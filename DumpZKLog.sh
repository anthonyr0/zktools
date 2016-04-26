#!/bin/bash
# Dumps latest ZK log file for CM/CDH-based Hadoop Distributions

# If path exists assume package install, otherwise assume parcel install
if [ -d /usr/lib/zookeeper/ ]; then
   JARPATH1=/usr/lib/zookeeper/lib
else
   JARPATH1=/opt/cloudera/parcels/CDH/lib/zookeeper/lib
fi

# Set ZK Path
ZKPATH1=$JARPATH1/..

# Set path to ZK working folder
ZKLIB1=/var/lib/zookeeper/version-2

# Set path to required CDH jars
CLPATH1=$(ls -f $ZKPATH1/zookeeper-*cdh*.jar $JARPATH1/log4j-*.jar $JARPATH1/slf4j-log4j*.jar $JARPATH1/slf4j-api-*.jar | tr '\n' ':')

# Set path to Java.  Uses JAVA_HOME if detected, otherwise, assumes CM Default
if [ -e $JAVA_HOME/bin/java ]; then
   JHOME=$JAVA_HOME/bin
else
   JHOME=/usr/java/default/bin
fi

# Detect latest ZK log file
FILE1=$(ls -tr $ZKLIB1/log* | tail -1)

# Call SnapshotFormatter
echo "Running LogFormatter..."

$JHOME/java -cp $CLPATH1 org.apache.zookeeper.server.LogFormatter $FILE1

exit