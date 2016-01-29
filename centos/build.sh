#!/bin/bash

if [[ -n $2 ]]; then
    echo "generate centos by $1 at $2"
else
    echo "generate centos by $1 at all."
fi

NAME="docker-build-centos-$1"

if docker inspect "$NAME" 2>&1 > /dev/null; then
    docker rm -f "$NAME"
fi

docker run -it \
  --name="$NAME" \
  --volume=`pwd`/data:/data \
  --volume=`pwd`/build-inner:/usr/bin/build-inner \
  --entrypoint="/usr/bin/build-inner" \
  "centos:$1" $2
