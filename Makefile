include Makefile.variable

print-%: ; @echo $*=$($*)

all: target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz target/docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz target/docker-$(DOCKER_VERSION)-centos7.tar.gz target/docker-$(DOCKER_VERSION)-all.tar.gz

github-release: ubuntu1404-github ubuntu1204-github centos7-github total-github

target/ubuntu14.04:
	echo 'building ubuntu 14.04'
	mkdir -p target/ubuntu14.04
	bash ubuntu/build.sh $(DOCKER_VERSION) 14.04 target/ubuntu14.04

target/centos7:
	echo 'building centos7'
	mkdir -p target/centos7
	bash centos/build.sh $(DOCKER_VERSION) 7 target/centos7

target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz: target/ubuntu14.04
	rm -rf target/docker-$(DOCKER_VERSION)-ubuntu14.04
	mkdir -p target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp install.sh target/docker-$(DOCKER_VERSION)-ubuntu14.04
	tar -zcvf target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -C target docker-$(DOCKER_VERSION)-ubuntu14.04

target/docker-$(DOCKER_VERSION)-centos7.tar.gz: target/centos7
	rm -rf target/docker-$(DOCKER_VERSION)-centos7
	mkdir -p target/docker-$(DOCKER_VERSION)-centos7
	cp -r target/centos7 target/docker-$(DOCKER_VERSION)-centos7
	cp install.sh target/docker-$(DOCKER_VERSION)-centos7
	tar -zcvf target/docker-$(DOCKER_VERSION)-centos7.tar.gz -C target docker-$(DOCKER_VERSION)-centos7

ubuntu1404-github: target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz github-tag
	github-release upload -u xamoc -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -f target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz 2>/dev/null; true

centos7-github: target/docker-$(DOCKER_VERSION)-centos7.tar.gz github-tag
	github-release upload -u xamoc -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-centos7.tar.gz -f target/docker-$(DOCKER_VERSION)-centos7.tar.gz 2>/dev/null; true

target/ubuntu12.04:
	echo 'building ubuntu 12.04'
	mkdir -p target/ubuntu12.04
	bash ubuntu/build.sh $(DOCKER_VERSION) 12.04 target/ubuntu12.04

target/docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz: target/ubuntu12.04
	rm -rf target/docker-$(DOCKER_VERSION)-ubuntu12.04
	mkdir -p target/docker-$(DOCKER_VERSION)-ubuntu12.04
	cp -r target/ubuntu12.04 target/docker-$(DOCKER_VERSION)-ubuntu12.04
	cp install.sh target/docker-$(DOCKER_VERSION)-ubuntu12.04
	tar -zcvf target/docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz -C target docker-$(DOCKER_VERSION)-ubuntu12.04

ubuntu1204-github: target/docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz github-tag
	github-release upload -u xamoc -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz -f target/docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz 2>/dev/null; true

target/docker-$(DOCKER_VERSION)-all.tar.gz: target/ubuntu14.04 target/centos7
	rm -rf target/docker-$(DOCKER_VERSION)-all
	mkdir -p target/docker-$(DOCKER_VERSION)-all
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-all
	cp -r target/centos7 target/docker-$(DOCKER_VERSION)-all
	cp install.sh target/docker-$(DOCKER_VERSION)-all
	tar -zcvf target/docker-$(DOCKER_VERSION)-all.tar.gz -C target docker-$(DOCKER_VERSION)-all

total-github: target/docker-$(DOCKER_VERSION)-all.tar.gz github-tag
	github-release upload -u xamoc -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-all.tar.gz -f target/docker-$(DOCKER_VERSION)-all.tar.gz 2>/dev/null; true

github-tag:
	github-release release -u xamoc -r docker-offline -t $(DOCKER_VERSION) 2>/dev/null; true


clean:
	rm -rf target

