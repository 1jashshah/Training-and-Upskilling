#!/bin/bash

function file_count() {
	NUM=$(ls -l | grep "^-" | wc -l)
	echo "Current directory has : $NUM files"
}

file_count
