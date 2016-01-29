include Makefile.variable

print-%: ; @echo $*=$($*)

all: target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz target/docker-$(DOCKER_VERSION)-all.tar.gz

github-release: ubuntu1404-github total-github

target/ubuntu14.04:
	echo 'building ubuntu 14.04'
	mkdir -p target/ubuntu14.04
	bash ubuntu/build.sh $(DOCKER_VERSION) 14.04 target/ubuntu14.04

target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz: target/ubuntu14.04
	rm -rf target/docker-$(DOCKER_VERSION)-ubuntu14.04
	mkdir -p target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp install.sh target/docker-$(DOCKER_VERSION)-ubuntu14.04
	tar -zcvf target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -C target docker-$(DOCKER_VERSION)-ubuntu14.04

ubuntu1404-github: target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz github-tag
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -f target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz 2>/dev/null; true


target/docker-$(DOCKER_VERSION)-all.tar.gz: target/ubuntu14.04
	rm -rf target/docker-$(DOCKER_VERSION)-all
	mkdir -p target/docker-$(DOCKER_VERSION)-all
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-all
	cp install.sh target/docker-$(DOCKER_VERSION)-all
	tar -zcvf target/docker-$(DOCKER_VERSION)-all.tar.gz -C target docker-$(DOCKER_VERSION)-all

total-github: target/docker-$(DOCKER_VERSION)-all.tar.gz github-tag
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-all.tar.gz -f target/docker-$(DOCKER_VERSION)-all.tar.gz 2>/dev/null; true

github-tag:
	github-release release -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) 2>/dev/null; true


clean:
	rm -rf target

