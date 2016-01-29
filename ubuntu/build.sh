#!/bin/sh

echo "generate docker $1 in ubuntu $2 at $3"

NAME="docker-build-ubuntu-$2"

if docker inspect "$NAME" 2>&1 > /dev/null; then
	docker kill "$NAME"
	docker rm "$NAME"
fi

docker run \
  --name="$NAME" \
  --entrypoint="/usr/bin/build-inner" \
  "ubuntu:$2"  $1

docker cp build-inner "$NAME":/usr/bin/build-inner

docker start -a $NAME

rm -rf /tmp/$NAME
docker cp "$NAME":/var/cache/apt/archives/ /tmp/$NAME
cp /tmp/$NAME/*.deb $3
 
