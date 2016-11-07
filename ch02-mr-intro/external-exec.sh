#!/bin/bash


# Checks if hadoop instance is started
MESSAGE=$( { hdfs dfsadmin -report ;} 2>&1 )
if [[ $MESSAGE == *"java.net.ConnectException"* ]]
then
    echo "HADOOP is stopped! Start hadoop ..."
    /opt/hadoop-2.7.2/sbin/start-dfs.sh
else
    echo "HADOOP is running"
fi


echo "Delete output & output folder"
hadoop fs -rmr /user/cristiano/ncdc/input
hadoop fs -rmr /user/cristiano/ncdc/output
hadoop fs -rmr /user/cristiano/ncdc


echo "Create input folder on hadoop fs"
hadoop fs -mkdir /user/cristiano/ncdc
hadoop fs -mkdir /user/cristiano/ncdc/input
#hadoop fs -mkdir /user/cristiano/ncdc/output

echo "Copy input file on hadhoop fs"
hadoop fs -copyFromLocal ././../input/ncdc/sample.txt /user/cristiano/ncdc/input

echo "Execute jar ..."
hadoop jar ././target/ch02-mr-intro-4.0.jar MaxTemperature /user/cristiano/ncdc/input/sample.txt ncdc/output
