#!/bin/bash
# Dumps latest ZK snapshot for CM/CDH-based Hadoop Distributions
# Running 'DumpZKSnapshot.sh -all' will dump all contents read from snapshot file
# Running without the '-all' arg will just report znodes

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