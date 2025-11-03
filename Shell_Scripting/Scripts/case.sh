#!/bin/bash
DEBUG=true

echo "Enter a number (1,2,3):"

read num

case $num in
   1) 
    echo "You selected Option 1 - Display date"
    date
    ;;
   2)
    echo "You selected Option 2 - Current Directory"
    pwd
    ;;
    3)
    echo "3rd option - List files"
    ls
    ;;
    *) echo "Invalid Option"
    ;;
esac