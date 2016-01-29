#!/bin/bash

if [[ -n $2 ]]; then
    echo "generate centos by $1 at all."
else
    echo "generate centos by $1 at $2"
fi

NAME="docker-build-centos-$1"

if [[ docker inspect "$NAME" 2>&1 > /dev/null ]]; then
    docker rm -f "$NAME"
fi

docker run \
  --name="$NAME" \
  --entrypoint="/usr/bin/build-inner" \
  "centos:$1" $2

docker cp build-inner "$NAME":/usr/bin/build-inner
docker start -a $NAME
