#!/bin/bash
read -p "Please enter a file extension: " EXT

DATE=$(date '+%Y-%m-%d')

read -p "Please enter a file prefix (enter date) : " PREFIX
if [ -z "$PREFIX" ]
then
	for LIST in $(ls *.${EXT})
	do
		mv $LIST "${DATE}-${LIST}"
		echo "Renaming ${LIST} as ${DATE}-${LIST}"
	done

else
	for LIST in $(ls *.${EXT})
	do
		mv $LIST "${PREFIX}-${LIST}"
		echo "Renaming ${LIST} as ${PREFIX}-${LIST}"
	done
fi
