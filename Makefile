include Makefile.variable

print-%: ; @echo $*=$($*)

all: ubuntu1404 total

ubuntu1404:
	echo 'building ubuntu 14.04'
	mkdir -p target/docker-offline-ubuntu14.04
	bash ubuntu/build.sh $(DOCKER_VERSION) 14.04 target/docker-offline-ubuntu14.04


total:
	echo 'total'

clean:
	rm -rf target