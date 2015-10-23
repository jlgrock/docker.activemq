#!/bin/sh

# Load the version from the VERSION file
for line in $(< VERSION)
do
  case $line in
    ACTIVEMQ=*)  eval $line ;; # beware! eval!
    *) ;;
   esac
done

/bin/sh ./build.sh

# Build the image
docker push jlgrock/activemq:$ACTIVEMQ

if [ $? -eq 0 ]; then
    echo "Image Successfully Published with tag $CENTOS-$JDK"
else
    echo "Error: Unable to Publish Image"
fi
