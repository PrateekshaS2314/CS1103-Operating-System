#!/bin/bash

#display the parent process ID (PID)
echo "Parent Process ID: $$"

#function to create a child process
create_child_process(){
	echo "starting child process..."
	sleep 3 #stimulate some work
	echo "child process ID: $PPID, Parent Process ID: $$"
}
#create first child
create_child_process &

#create second child process
create_child_process &

#wait for all child processes to complete
wait

#display the parent process ID again after child processes complete
echo "all child process have completed. Back to Parent Process ID: $$"
