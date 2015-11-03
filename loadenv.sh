#!/bin/sh

# Load the version from the VERSION file
for line in $(cat VERSION)
do
  case $line in
    ACTIVEMQ=*)  eval $line ;; # beware! eval!
    *) ;;
   esac
done