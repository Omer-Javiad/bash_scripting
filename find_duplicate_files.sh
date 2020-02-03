#!/bin/bash

# find all files in the specified directory and calculate their md5sum
find $1 -type f -exec md5sum {} \; | sort > file_data

prev_file_md5=0
prev_file_name=0

# go through collected data line by line
while read line
do
	# get the current file's md5sum
	file_md5=$( echo $line | awk '{print $1}')

	# get the current file's name
	file_name=$( echo $line | awk '{print $2}')
	
	# check if the md5sums match
	if [ $file_md5 != $prev_file_md5 ]; then
		#update the previous stored file name
		prev_file_name=$file_name
	else
		# same md5sums found, print file info
		if [ ${prev_file_name} != '0' ]; then
			echo "---------------------"
			echo "found duplicate files"
			echo $prev_file_name
			prev_file_name=0
		fi
		echo $file_name
	fi

	# update the previous stored md5
	prev_file_md5=$file_md5

done < file_data

rm -rf file_data
