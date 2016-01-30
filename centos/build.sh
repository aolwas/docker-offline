#!/bin/bash

set -ex

if [[ -n $1 ]]; then
    docker_version=$1
else
    docker_version=all
fi

if [[ -n $2 ]]; then
    dist_version=$2
else
    dist_version=7
fi

if [[ -n $3 ]]; then
  target_dir=$3
else
  target_dir=target/centos7
fi

echo "generate centos by $dist_version at $docker_version."

NAME="docker-build-centos-$dist_version"
if docker inspect "$NAME" 2>&1 > /dev/null; then
    docker rm -f "$NAME"
fi

volume=`pwd`/centos/$NAME
rm -rf $volume
docker run -it \
  --name="$NAME" \
  --volume=$volume:/data \
  --volume=`pwd`/centos/build-inner:/usr/bin/build-inner \
  --entrypoint="/usr/bin/build-inner" \
  "centos:$dist_version" $docker_version $dist_version

cp $volume/$NAME-$docker_version/*.rpm $target_dir