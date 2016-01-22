#!/bin/sh

# load the versions
. ./loadenv.sh

echo "Processing for ActiveMQ Version $ACTIVEMQ" 

# Build the image
docker pull jlgrock/centos-oraclejdk:6.6-8u45
docker build -q --rm -t jlgrock/activemq:$ACTIVEMQ .
