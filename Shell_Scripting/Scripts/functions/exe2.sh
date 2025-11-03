#!/bin/bash

function file_count() {
        NUM=$(ls -l $DIR | grep "^-" | wc -l)
        echo "$DIR : "
	echo "	$NUM"
}

for DIR in $@
do
	file_count
done
