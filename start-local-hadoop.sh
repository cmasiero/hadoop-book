#!/usr/bin/env bash



echo "HADOOP_HOME      :" $HADOOP_HOME
echo "HADOOP_CLASSPATH :" $HADOOP_CLASSPATH
# Checks if hadoop instance is started
MESSAGE=$( { hdfs dfsadmin -report ;} 2>&1 )
if [[ $MESSAGE == *"java.net.ConnectException"* ]]
then
    echo "HADOOP is stopped! Start hadoop ... "
    $HADOOP_HOME/sbin/start-dfs.sh
else
    echo "HADOOP is running..."
fi