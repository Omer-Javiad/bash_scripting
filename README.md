# This repo contains the following scripts.

-- display_time.sh
	inputs: none
	outputs: displays current time on terminal.

-- find_duplicate_files.sh
	inputs: directory containing duplicate files
	outputs: searches the input directory for duplicate files recursively. groups the duplicate files together.
	sample output: 
		find_duplicate_files.sh /mnt/c/Temp/dir1/
		---------------------
		found duplicate files
		/mnt/c/Temp/dir1/dir11/file1
		/mnt/c/Temp/dir1/dir12/file1
		/mnt/c/Temp/dir1/file1

-- get_process_info.sh
	inputs: none
	outputs: checks for new processes started since script was executed. checks for new processes every 5 seconds.
			 outputs process information in pid_info.log file, saved in the same directory as the script.
	TODO: improve data output in the log file (remove duplicates)
	sample output:
		get_process_info.sh
		new process 25453 started, logging details in pid_info.log
		new process 25460 started, logging details in pid_info.log
		
-- rename_lower_case
	inputs: directory where files are to be renamed to lower case.
	outputs: searches the input directory recursively files with capital letters in their name. renames all the 
			 identified files to substitute capital letters with lower case equivalents.
	sample output:
		rename_lower_case.sh /mnt/c/Temp/dir1
		renaming /mnt/c/Temp/dir1/dir11/FILE1 to /mnt/c/Temp/dir1/dir11/file1
		renaming /mnt/c/Temp/dir1/dir12/FILE1 to /mnt/c/Temp/dir1/dir12/file1
		renaming /mnt/c/Temp/dir1/FILE1 to /mnt/c/Temp/dir1/file1

-- suspend_resume_data_copy.sh
	inputs: <source_directory> <destination_directory>
	assumptions: erroneous disk can handle continuous data transfer for 30 seconds before complaining
	outputs: starts rsync process for copying source directory in to destination directory. interrupts the rsync
			 process after 25 seconds. rsync remains suspended for 10 seconds before resuming.
	TODO: add second layer of interruption to continuously suspend after every 25 seconds of execution.
	sample output:
		suspend_resume_data_copy.sh  /mnt/c/Temp/t1 /mnt/c/Temp/t88999
		rsync pid = 19741

		[6]+  Stopped                 ./suspend_resume_data_copy.sh /mnt/c/Temp/t1 /mnt/c/Temp/t88999
		ps auxfww | grep -i rsyn
		ojavaid  19742 84.0  0.0  14432  1656 tty1     R    11:11   0:04      |   \_ rsync --partial --recursive /mnt/c/Temp/t1 /mnt/c/Temp/t88999
		ojavaid  19744  0.0  0.0  14012   712 tty1     S    11:11   0:00      |   |   \_ rsync --partial --recursive /mnt/c/Temp/t1 /mnt/c/Temp/t88999
		ojavaid  19745  100  0.0  14432   952 tty1     R    11:11   0:05      |   |       \_ rsync --partial --recursive /mnt/c/Temp/t1 /mnt/c/Temp/t88999
		ojavaid  19965  0.0  0.0  14804  1212 tty1     S    11:11   0:00      \_ grep --color=auto -i rsyn