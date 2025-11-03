#!/bin/bash

NUM=1
while read LINE
do
	echo "${NUM}: $LINE "
	((NUM++))
done < /etc/passwd
