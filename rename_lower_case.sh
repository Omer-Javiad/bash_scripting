#!/bin/bash

# find all files in the specified directory
find $1 -type f  -print0 > all_files

# go through collected data line by line
while read -d '' file
do
	# get th current file name
	curr_file_name=$(basename $file)
	
	# get the directory path for the file
	dir_name=$(dirname $file)
	
	# create potential new name in lower case 
	new_name=$(basename "$file" | awk "{print tolower(\$0)}")


	# check if the current and new file names are different
	if [ "$curr_file_name" != "$new_name" ]; then
		
		# complete the new file name by appending the dir path
		new_file_name=$dir_name/$new_name
		echo "renaming $file to $new_file_name"
	
		# move the file to lower case name	
		mv -f $file $dir_name/temp_file
		mv -f $dir_name/temp_file $new_file_name
	fi

done < all_files

rm -f all_files
