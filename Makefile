include Makefile.variable

print-%: ; @echo $*=$($*)

all: ubuntu1404 total

github-release: ubuntu1404-github

ubuntu1404src:
	echo 'building ubuntu 14.04'
	mkdir -p target/ubuntu14.04
	bash ubuntu/build.sh $(DOCKER_VERSION) 14.04 target/ubuntu14.04

ubuntu1404: ubuntu1404src
	rm -rf target/docker-$(DOCKER_VERSION)-ubuntu14.04
	mkdir -p target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp install.sh target/docker-$(DOCKER_VERSION)-ubuntu14.04
	tar -zcvf target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -C target docker-$(DOCKER_VERSION)-ubuntu14.04

ubuntu1404-github: ubuntu1404
	github-release release -u DaoCloud -r docker-offline -t $(DOCKER_VERSION)
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -f target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz


total: ubuntu1404src
	rm -rf target/docker-$(DOCKER_VERSION)-all
	mkdir -p target/docker-$(DOCKER_VERSION)-all
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-all
	cp install.sh target/docker-$(DOCKER_VERSION)-all
	tar -zcvf target/docker-$(DOCKER_VERSION)-all.tar.gz -C target docker-$(DOCKER_VERSION)-all

total-github: total
	github-release release -u DaoCloud -r docker-offline -t $(DOCKER_VERSION)
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-all.tar.gz -f target/docker-$(DOCKER_VERSION)-all.tar.gz


clean:
	rm -rf target

