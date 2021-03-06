#!/bin/bash
# Dumps latest ZK snapshot for CM/CDH-based Hadoop Distributions
# Running 'DumpZKSnapshot.sh -all' will dump all contents read from snapshot file
# Running without the '-all' arg will just report znodes

# Check for typical homes of ZK
# TODO: Detect tarball install
if [ -d /usr/local/zookeeper/ ]; then
   # Non-CM package-based install
   JARPATH1=/usr/local/zookeeper/lib
elif [ -d /usr/lib/zookeeper/ ]; then
   # CM Package-based install
   JARPATH1=/usr/lib/zookeeper/lib
else
   # CM Parcel install
   JARPATH1=/opt/cloudera/parcels/CDH/lib/zookeeper/lib
fi

# Set ZK Path
ZKPATH1=$JARPATH1/..

# Set path to ZK working folder
ZKLIB1=$(grep dataDir $JARPATH1/../conf/zoo.cfg | cut -d '=' -f2)/version-2

# Set path to required CDH jars
CLPATH1=$(ls -f $ZKPATH1/zookeeper-*cdh*.jar $JARPATH1/log4j-*.jar $JARPATH1/slf4j-log4j*.jar $JARPATH1/slf4j-api-*.jar | tr '\n' ':')

# Set path to Java.  Uses JAVA_HOME if detected, otherwise, assumes CM Default
if [ -e $JAVA_HOME/bin/java ]; then
   JHOME=$JAVA_HOME/bin
else
   JHOME=/usr/java/default/bin
fi

# Detect latest snapshot file
FILE1=$(ls -tr $ZKLIB1/snapshot* | tail -1)

# Assemble runtime command
EXEC1="$JHOME/java -cp $CLPATH1 org.apache.zookeeper.server.SnapshotFormatter $FILE1 "

# Call SnapshotFormatter
echo "Running SnapshotFormatter..."

if [ "$1" = "--all" ]; then
   $EXEC1
else
   $EXEC1 | grep '/'
fi

exit