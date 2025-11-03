#!/bin/bash

read -p "How many lines u want to display? " NUMBER

NUM=1
while read LINE
do
	echo "${NUM}: $LINE "
	((NUM++))
done < /etc/passwd | head -${NUMBER}
