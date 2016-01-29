include Makefile.variable

print-%: ; @echo $*=$($*)

all: ubuntu1404 total

ubuntu1404:
	mkdir -p target/docker-offline-ubuntu14.04
	echo 'ubuntu1404'

total:
	echo 'total'

clean:
	rm -rf target