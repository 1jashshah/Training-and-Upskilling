#!/bin/bash

DATE=$(date '+%Y-%m-%d')

for LIST in $(ls *.jpg)
do
	mv $LIST "${DATE}-${LIST}"
	echo "Renaming ${LIST} as ${DATE}-${LIST}"
done
