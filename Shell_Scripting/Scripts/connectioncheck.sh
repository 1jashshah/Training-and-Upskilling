#!/bin/bash

code=$(sudo ping -c 3 www.google.com)

if [ $? -eq 0 ]
then
  echo "COnnection is active"
else
 echo "WARNING : INTERNET ISSUE"
fi