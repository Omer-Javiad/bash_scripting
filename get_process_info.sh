#!/bin/bash

# get the current time at the start of script execution
current_time=$(date +%s)
last_diff=0

# delete the log file if it already exists
rm -f pid_info.log

while true
do
	# get the list of processes
	ps -e -o pid --sort=start_time > pids
	
	# remove the header line
	sed -i 1d pids  

	# iterate through the processes one by one
	while read process
	do
		# get the start time for the process
		proc_start=$(date -d "$(ps -o lstart= -p $process)" +%s)

		diff=$(( $proc_start-$current_time ))
		# echo "diff = $diff"

		# check if the process started before script execution
		if [ $diff \> 0 ]; then
			if [ $last_diff != $diff  ]; then
				echo "new process $process started, logging details in pid_info.log"

				# write process details in the log file
				ps -p $process -o pid,ppid,user,%cpu,%mem,vsz,rss,tty,stat,start,time,command,etime >> pid_info.log
				last_diff=$diff
			fi
		fi
	done < pids

	# wait for 5 seconds before checking for new processes again	
	sleep 5
done


