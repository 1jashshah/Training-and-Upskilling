#!/bin/bash
while :
do
	echo ""
	echo "1. Show disk usage."
	echo "2. Show system uptime."
	echo "3. Show the users logged into the system"
	read -p "What would you like to do? (Enter q to quit.) : " ENT
	case "$ENT" in
		1)
			du
			;;
		2)
			uptime
			;;
		3)
			who
			;;
		q|Q)
			echo "Goodbye!"
			exit 0
			;;
		*)
			echo "Invalid option"
			;;
	esac
done
