#!/bin/bash

function logging() {
	local NUM=$@
	echo "random num : $NUM"
	logger -i -t "randomly" -p user.info "random num : $NUM"
}

N=1
while [ $N -le "3" ]
do
	logging $RANDOM
	((N++))
done
