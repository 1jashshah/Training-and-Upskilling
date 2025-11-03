#!/bin/bash

for file in *.sh
do 
   if [ -e "$file" ]; then
   mv "$file" shell
   else
    echo " does not exist"
   fi
done

