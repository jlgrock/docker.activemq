#!/bin/sh

# load the versions
. ./loadenv.sh

echo "Processing for ActiveMQ Version $ACTIVEMQ" 

# Build the image
docker build -q --rm -t jlgrock/activemq:$ACTIVEMQ .
