#!/bin/bash
# Dumps latest ZK log file for CM/CDH-based Hadoop Distributions

# Parcel-based install (Default)
JARPATH1=/opt/cloudera/parcels/CDH/lib/zookeeper/lib

# Comment out the above and uncomment below for package-based installs
# Package-based install
#JARPATH1=/usr/lib/zookeeper/lib

# Set ZK Path
ZKPATH1=$JARPATH1/..

# Set path to ZK working folder
ZKLIB1=/var/lib/zookeeper/version-2

# Set path to required CDH jars
CLPATH1=$(ls -f $ZKPATH1/zookeeper-*cdh*.jar $JARPATH1/log4j-*.jar $JARPATH1/slf4j-log4j*.jar $JARPATH1/slf4j-api-*.jar | tr '\n' ':')

# Set path to Java.  Needs 1.7 or higher
JHOME=/usr/java/jdk1.7.*/bin

# Detect latest ZK log file
FILE1=$(ls -tr $ZKLIB1/log* | tail -1)

# Call SnapshotFormatter
echo "Running LogFormatter..."

$JHOME/java -cp $CLPATH1 org.apache.zookeeper.server.LogFormatter $FILE1

exit