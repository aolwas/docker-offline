#!/bin/sh

echo "generate docker $3 in ubuntu $1 at $2"

NAME="docker-build-ubuntu-$1"

if docker inspect "$NAME" 2>&1 > /dev/null; then
	docker kill "$NAME"
	docker rm "$NAME"
fi

docker run \
  --name="$NAME" \
  --entrypoint="/usr/bin/build-inner" \
  "ubuntu:$1"  $3

docker cp build-inner "$NAME":/usr/bin/build-inner

docker start -a $NAME

docker cp "$NAME":/var/cache/apt/archives $2
