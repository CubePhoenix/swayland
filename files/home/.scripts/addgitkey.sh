#!/bin/bash

# if gitssh was added
if [ssh-add -L | grep gitssh]
then
	echo "Using gitssh key."
	exit 0
else
	if [ssh-add ~/.ssh/gitssh]
	then
		echo "Authentication succeeded."
		exit 0
	else
		echo "Error: Could not add key ~/.ssh/gitssh"
		exit 1
	fi
fi

exit 1
