include Makefile.variable

print-%: ; @echo $*=$($*)

all: target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz target/docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz target/docker-$(DOCKER_VERSION)-all.tar.gz

ubuntu: target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz target/docker-$(DOCKER_VERSION)-ubuntu12.04.tar.gz

centos: target/docker-$(DOCKER_VERSION)-centos7.2.tar.gz target/docker-$(DOCKER_VERSION)-centos7.1.tar.gz

github-release: ubuntu1404-github ubuntu1204-github

target/ubuntu14.04:
	echo 'building ubuntu 14.04'
	mkdir -p target/ubuntu14.04
	bash ubuntu/build.sh $(DOCKER_VERSION) 14.04 target/ubuntu14.04

target/centos7.2:
	echo 'building centos7.2'
	mkdir -p target/centos7.2
	bash centos/build.sh $(DOCKER_VERSION) 7.2.1511 target/centos7.2

target/centos7.1:
	echo 'building centos7.1'
	mkdir -p target/centos7.1
	bash centos/build.sh $(DOCKER_VERSION) 7.1.1503 target/centos7.1

target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz: target/ubuntu14.04
	rm -rf target/docker-$(DOCKER_VERSION)-ubuntu14.04
	mkdir -p target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-ubuntu14.04
	cp install.sh target/docker-$(DOCKER_VERSION)-ubuntu14.04
	tar -zcvf target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -C target docker-$(DOCKER_VERSION)-ubuntu14.04

target/docker-$(DOCKER_VERSION)-centos7.2.tar.gz: target/centos7.2
	rm -rf target/docker-$(DOCKER_VERSION)-centos7.2
	mkdir -p target/docker-$(DOCKER_VERSION)-centos7.2
	cp -r target/centos7.2 target/docker-$(DOCKER_VERSION)-centos7.2
	cp install.sh target/docker-$(DOCKER_VERSION)-centos7.2
	tar -zcvf target/docker-$(DOCKER_VERSION)-centos7.2.tar.gz -C target docker-$(DOCKER_VERSION)-centos7.2

target/docker-$(DOCKER_VERSION)-centos7.1.tar.gz: target/centos7.1
	rm -rf target/docker-$(DOCKER_VERSION)-centos7.1
	mkdir -p target/docker-$(DOCKER_VERSION)-centos7.1
	cp -r target/centos7.1 target/docker-$(DOCKER_VERSION)-centos7.1
	cp install.sh target/docker-$(DOCKER_VERSION)-centos7.1
	tar -zcvf target/docker-$(DOCKER_VERSION)-centos7.1.tar.gz -C target docker-$(DOCKER_VERSION)-centos7.1


ubuntu1404-github: target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz github-tag
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz -f target/docker-$(DOCKER_VERSION)-ubuntu14.04.tar.gz 2>/dev/null; true

centos72-github: target/docker-$(DOCKER_VERSION)-centos7.2.tar.gz github-tag
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-centos7.2.tar.gz -f target/docker-$(DOCKER_VERSION)-centos7.2.tar.gz 2>/dev/null; true

centos71-github: target/docker-$(DOCKER_VERSION)-centos7.1.tar.gz github-tag
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-centos7.1.tar.gz -f target/docker-$(DOCKER_VERSION)-centos7.1.tar.gz 2>/dev/null; true


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

target/docker-$(DOCKER_VERSION)-all.tar.gz: target/ubuntu14.04 target/centos7.2 target/centos7.1
	rm -rf target/docker-$(DOCKER_VERSION)-all
	mkdir -p target/docker-$(DOCKER_VERSION)-all
	cp -r target/ubuntu14.04 target/docker-$(DOCKER_VERSION)-all
	cp -r target/centos7.2 target/docker-$(DOCKER_VERSION)-all
	cp -r target/centos7.1 target/docker-$(DOCKER_VERSION)-all
	cp install.sh target/docker-$(DOCKER_VERSION)-all
	tar -zcvf target/docker-$(DOCKER_VERSION)-all.tar.gz -C target docker-$(DOCKER_VERSION)-all

total-github: target/docker-$(DOCKER_VERSION)-all.tar.gz github-tag
	github-release upload -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) -n docker-$(DOCKER_VERSION)-all.tar.gz -f target/docker-$(DOCKER_VERSION)-all.tar.gz 2>/dev/null; true

github-tag:
	github-release release -u DaoCloud -r docker-offline -t $(DOCKER_VERSION) 2>/dev/null; true


clean:
	rm -rf target

