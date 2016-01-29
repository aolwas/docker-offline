#!/bin/bash

if [[ -n $1 ]]; then
    dist_version=$1
else
    dist_version=7
fi

if [[ -n $2 ]]; then
    docker_version=$2
else
    docker_version=all
fi

echo "generate centos by $dist_version at $docker_version."

NAME="docker-build-centos-$docker_version"
if docker inspect "$NAME" 2>&1 > /dev/null; then
    docker rm -f "$NAME"
fi

docker run -it \
  --name="$NAME" \
  --volume=`pwd`/data:/data \
  --volume=`pwd`/build-inner:/usr/bin/build-inner \
  --entrypoint="/usr/bin/build-inner" \
  "centos:$1" $docker_version
