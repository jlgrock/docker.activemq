#!/bin/sh

# Load the version from the VERSION file
for line in $(< VERSION)
do
  case $line in
    ACTIVEMQ=*)  eval $line ;; # beware! eval!
    *) ;;
   esac
done
echo "Processing for ActiveMQ Version $ACTIVEMQ" 

# Build the image
docker build -q --rm -t jlgrock/activemq:$ACTIVEMQ .
