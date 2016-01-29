include Makefile.variable

print-%: ; @echo $*=$($*)

all: ubuntu1404 total

ubuntu1404:
	echo 'building ubuntu 14.04'
	mkdir -p target/ubuntu14.04
	bash ubuntu/build.sh $(DOCKER_VERSION) 14.04 target/ubuntu14.04
	mkdir -p target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp install.sh target/docker-$(DOCKER_VERSION)-ubuntu14.04
	tar -cxvf docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz target/docker-$(DOCKER_VERSION)-ubuntu14.04

total:
	echo 'total'

clean:
	rm -rf target