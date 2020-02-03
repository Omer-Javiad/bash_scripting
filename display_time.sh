#!/bin/sh

# display current time in HH:MM:SS format

while true
do
	printf '%s\r' "$(date +%H:%M:%S)"
	sleep 1
done

