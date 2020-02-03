#!/bin/bash

# Assumptions:
# erroneous disk can handle continuous data transfer for 30 seconds before complaining
# data transfer will be "suspended" for 10 seconds before resuming
# inputs: <source_dir> <dest_dir>

source_dir=$1
dest_dir=$2

# use rsync in partial mode for transfering data so that the data on the receiving end 
# does disappear when the sending side suspends.. launch the process in the background
rsync --partial --recursive $source_dir $dest_dir & 
echo "$$" > rsync.pid

rsync_time=0
rsync_pid=$(cat rsync.pid)
echo "rsync pid = $rsync_pid"

while true
do
	rsync_time=$(ps -o etimes -p $rsync_pid | awk 'NR > 1')
	if [ $rsync_time \> 1  ]; then
		break;
	fi
done


# suspend the rsync process
kill -STOP $rsync_pid &

# wait for 10 seconds before resuming
sleep 20

kill -CONT $rsync_pid &

ls -al $dest_dir
